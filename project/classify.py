#!/usr/bin/env python3

#TODO 
# - k-means clustering
# - Cross validation 

import argparse 
import ipdb
import os
import sys
import numpy as np
import csv
from numba import vectorize, guvectorize, int64, float64, jit
import copy
import time


def main():
    args = parse_args()
    if args.debug:
        ipdb.set_trace()
    if not args.offload and not args.naive:
        print("Either '--gpu' or '--naive' (or both) must be supplied")
        sys.exit(1)

    clustering = setup_data(Clustering(args))
    if args.offload:
        optimized_c = copy.deepcopy(clustering)

        start_time = time.time()
        optimized_c = optimized_k_means_clustering(optimized_c)
        print("Time required for optimized K-Means Clustering: {}".format(
            time.time() - start_time))
    if args.naive:
        start_time = time.time()
        clustering = naive_k_means_clustering(clustering)
        print("Time required for naive K-Means Clustering: {}".format(
            time.time() - start_time))



class Clustering:
    """Maintains state of k-means clustering algorithm

    Clustering manages several structures including mappings between
    classifications and numbers (in order to perform distance
    calculations), the data itself, predicted classes, count of
    class changes between iterations of assignment and updates, etc. 
    """

    def __init__(self, args):
        self.mappings = []
        self.data = []
        self.labels = set()
        self.k = args.k
        self.predicted = []
        self.actual = []
        self.data_filename = args.data_filename
        self.centroids = []
        self.delta = sys.maxsize
        self.max_iterations = 300  # borrowed from scikit.learn's kmeans       
        self.curr_iteration = 0
        self.offload = args.offload
        self.naive = args.naive
            



def parse_args():
    """Pulls arguments passed to program into an argparse object for use

    Args:
        -

    Returns:
        argparse object: object with attributes holding the values of 
                         the passed in parameters
    """

    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--data', dest='data_filename', 
            default='data/iris.data', help='Defaults to iris')
    parser.add_argument('-k', '--means', dest='k', default=3,
            help='Centroid count. Must be equal to classes', type=int)
    parser.add_argument('--debug', dest='debug', action='store_true',
            help='Start tracing')
    parser.add_argument('-g', '--gpu', dest='offload', action='store_true', 
            help='Offload to GPU')
    parser.add_argument('-n', '--naive', dest='naive', action='store_true', 
            help='Run on CPUs')

    return parser.parse_args()


def setup_data(clustering):
    """Initializes and prepares data for clustering algorithms

    Relies on helper function to read data from a csv file, clean the
    data to something usable for clustering, and choose initial means.

    Args:
        clustering (Clustering): nearly empty object maintaining state 
                                 of clustering algorithm. Has some 
                                 fields filled from parameters
    Returns:
        Clustering object: object ready to fully perform kmeans on
    """

    # Check if data file exists
    if not os.path.exists(clustering.data_filename):
        print("File '{}' does not exist".format(clustering.data_filename))
        sys.exit(1)

    clustering = _fill_in_data(clustering)
    clustering = _clean_data(clustering)
    clustering = _initialize_centroids(clustering)
    return clustering



def naive_k_means_clustering(clustering):
    """Performs K-Means clustering 

    The core of the k-means clustering algorithm with no offloading. 
    Effectively a do-while loop is emulated by first assigning data to
    centroids and then update the centroids (means). This is repeated
    until either the means converge to a stable value or 300 iterations
    complete. Though unlikely, centroids can continually migrate so a 
    hard limit is imposed on amount of iterations. 

    Args:
        clustering (Clustering): Object maintaining state of
                                 clustering algorithm to be performed on
    Returns:
        Clustering object: after k-means clustering is performed on it 
    """

    # Begin naive clustering
    clustering = naive_assignment(clustering)
    clustering = naive_update_centroids(clustering)
    while (clustering.delta > 0 and 
            clustering.curr_iteration < clustering.max_iterations):
        clustering = naive_assignment(clustering)
        clustering = _calc_delta(clustering)
        clustering = naive_update_centroids(clustering)
        clustering.curr_iteration += 1
    return clustering 



def optimized_k_means_clustering(clu):
    """Performs K-Means clustering with GPU offloading

    The core of the k-means clustering algorithm with offloading. 
    Effectively a do-while loop is emulated by first assigning data to
    centroids and then update the centroids (means). This is repeated
    until either the means converge to a stable value or 300 iterations
    complete. Though unlikely, centroids can continually migrate so a 
    hard limit is imposed on amount of iterations. 

    Args:
        clustering (Clustering): Object maintaining state of
                                 clustering algorithm to be performed on
    Returns:
        Clustering object: after k-means clustering is performed on it 
    """

    # Begin naive clustering
    vectorized_assignment(clu.data, clu.centroids, 
            sys.maxsize, clu.predicted)
    # First, clear out current centroids. Can't pass in np into jit functions
    clu.centroids = np.zeros((clu.centroids.shape[0], clu.centroids.shape[1]))
    clu = jit_update_centroids(clu)
    while (clu.delta > 0 and 
            clu.curr_iteration < clu.max_iterations):
        vectorized_assignment(clu.data, clu.centroids, 
                sys.maxsize, clu.predicted)
        clu = _jit_calc_delta(clu, sys.maxsize)
        clu.centroids = np.zeros(
                (clu.centroids.shape[0], clu.centroids.shape[1]))
        clu = jit_update_centroids(clu)
        clu.curr_iteration += 1
    return clu



def naive_assignment(clustering):
    """Assigns records to centroids/means

    The assignment step to k-means clustering. For each data point, 
    get the distance to each mean and classify as the "closest" one. 
    Class changes are marked with either the negative of the new class
    or sys.maxsize if the new class is 0. 

    Args:
        clustering (Clustering): Object maintaining state of clustering
                                 algorithm
    Returns:
        clustering object with records having newly assigned centroids
    """

    min_dist = sys.maxsize
    min_class = -1
    dist = 0 

    # For each data point
    for i in range(clustering.data.shape[0]):
        # For each centroid
        for j in range(clustering.centroids.shape[0]):
            # Calculate the distance between ith record and jth centroid
            dist = 0 
            for k in range(clustering.centroids.shape[1]):
                dist += (clustering.data[i][k] 
                        - clustering.centroids[j][k]) ** 2
            dist = dist ** 0.5 
            # and track this centroid and class as min distance
            if dist < min_dist:
                min_dist = dist
                min_class = j

        # Mark a change to the class. Set to maxsize marker value if changed to
        # 0, negative if changed to non-zero, or just assign it if it wasn't
        # assigned anything prior (so size of data)
        if (clustering.predicted[i] != clustering.data.shape[0] and 
                min_class != clustering.predicted[i]):
            if min_class == 0:
                min_class = sys.maxsize
            else:
                min_class *= -1
        clustering.predicted[i] = min_class
        min_dist = sys.maxsize
    return clustering



@guvectorize([(float64[:,:], float64[:,:], int64, int64[:])], 
        '(n,p),(q,p),()->(n)')
def vectorized_assignment(data, centroids, maxsize, predicted):
    """Assigns records to centroids/means with offloading

    The assignment step to k-means clustering. For each data point, 
    get the distance to each mean and classify as the "closest" one. 
    Class changes are marked with either the negative of the new class
    or sys.maxsize if the new class is 0. 

    Args:
        clustering (Clustering): Object maintaining state of clustering
                                 algorithm
    Returns:
        clustering object with records having newly assigned centroids
    """

    min_dist = maxsize
    min_class = -1
    dist = 0
    # For each data point
    for i in range(data.shape[0]):
        # For each centroid
        for j in range(centroids.shape[0]):
            # Calculate the distance between ith record and jth centroid
            dist = 0
            for k in range(centroids.shape[1]):
                dist += (data[i][k] - centroids[j][k]) ** 2
            dist = dist ** 0.5
            # and track this centroid and class as min distance
            if dist < min_dist:
                min_dist = dist
                min_class = j
        
        # Mark a change to the class. Set to maxsize marker value if changed to
        # 0, negative if changed to non-zero, or just assign it if it wasn't
        # assigned anything prior (so size of data)
        if predicted[i] != data.shape[0] and min_class != predicted[i]: 
            if min_class == 0:
                min_class = maxsize
            else:
                min_class *= -1
        predicted[i] = min_class
        min_dist = maxsize



def _calc_delta(clustering):
    """Calculate the amount of class changes for an assignment iteration

    Parses the newly predicted class for an iteration of the kmeans and
    sums changes from prior class via summing negatives or sys.maxint
    as negative represent a change to the new absolutely value of the
    class or 0 if sys.maxint. Changes the class to the real value after
    accounting. 

    Args:
        clustering (Clustering): object keeping track of clustering 
                                 algorithm that need to parse predicted
    Returns:
        clustering object with calculated deltas and converted
        predicted classes 
    """

    clustering.delta = 0
    for i in range(clustering.predicted.shape[0]):
        if clustering.predicted[i] < 0:
            clustering.delta += 1
            clustering.predicted[i] *= -1
        elif clustering.predicted[i] == sys.maxsize:
            clustering.delta += 1
            clustering.predicted[i] = 0
    return clustering



@jit
def _jit_calc_delta(clustering, maxsize):
    """Calculate the amount of class changes for an assignment iteration

    Parses the newly predicted class for an iteration of the kmeans and
    sums changes from prior class via summing negatives or sys.maxint
    as negative represent a change to the new absolutely value of the
    class or 0 if sys.maxint. Changes the class to the real value after
    accounting. 

    Args:
        clustering (Clustering): object keeping track of clustering 
                                 algorithm that need to parse predicted
    Returns:
        clustering object with calculated deltas and converted
        predicted classes 
    """

    clustering.delta = 0
    for i in range(clustering.predicted.shape[0]):
        if clustering.predicted[i] < 0:
            clustering.delta += 1
            clustering.predicted[i] *= -1
        elif clustering.predicted[i] == maxsize:
            clustering.delta += 1
            clustering.predicted[i] = 0
    return clustering



def naive_update_centroids(clustering):
    # First, clear out current centroids
    clustering.centroids = np.zeros(
            (clustering.centroids.shape[0], clustering.centroids.shape[1]))

    # Now sum across all classes
    counts = np.zeros(clustering.centroids.shape[0])
    for i in range(clustering.data.shape[0]):
        clustering.centroids[clustering.predicted[i]] += clustering.data[i]
        counts[clustering.predicted[i]] += 1

    # And normalize
    for i in range(clustering.centroids.shape[0]):
        clustering.centroids[i] /= counts[i]
    return clustering



@jit
def jit_update_centroids(clustering):

    # Now sum across all classes
    counts = [0] * clustering.centroids.shape[0]
    for i in range(clustering.data.shape[0]):
        clustering.centroids[clustering.predicted[i]] += clustering.data[i]
        counts[clustering.predicted[i]] += 1

    # And normalize
    for i in range(clustering.centroids.shape[0]):
        clustering.centroids[i] /= counts[i]
    return clustering


################################################################################
#                               HELPER FUNCTIONS                               #
################################################################################


def _fill_in_data(clustering):
    """Helper Function: Read data from csv and setup mappings

    While reading in the data, parse it and track unique values of
    strings and classifications. The unique values are later used in a 
    list and the indeces of the entries replace the actual values. 

    Args:
        clustering (Clustering): Initialized but empty clustering object

    Returns:
        clustering (Clustering): .data, .labels, .actual, and .mappings
            now are filled in but not yet usable. 
    """

    clustering.data = np.genfromtxt(clustering.data_filename, 
            dtype='str', delimiter=',')
    clustering.data = np.char.strip(clustering.data)
    clustering.labels = set(clustering.data[:,-1])
    clustering.actual = clustering.data[:,-1]
    clustering.data = np.delete(clustering.data, -1, 1)
    clustering.predicted = np.full(clustering.data.shape[0], 
        clustering.data.shape[0])
    for j in range(clustering.data.shape[1]):
        try:
            float(clustering.data[0,j])
            clustering.mappings.append([])
        except:
            clustering.mappings.append(set(clustering.data[:,j]))

    return clustering


def _clean_data(cl):
    """Helper Function: Convert data from strings to int/floats

    csv's reader reads csvs as strings but the actual values can vary in
    type. Convert the sets in mappings[] to lists to we can translate 
    the string values to numbers in the data via the indeces of the
    strings in mappings[]. Same with labels (used later). However, the
    data is simply converted if already an int/float in string form. The
    values need to be int/float in order to be used in L1 norm in 
    clustering.

    Args:
        clustering (Clustering): clustering attributes are filled in 
            but needto be translated

    Returns:
        clustering (Clustering): attributes have been translated to 
            lists of ints or floats
    """

    # Convert everything to lists so we have indeces
    for i in range(len(cl.mappings)):
        cl.mappings[i] = list(cl.mappings[i])
    cl.labels = list(cl.labels)

    # Clean data, so convert strings to float (including ints and mappings)
    for j in range(cl.data.shape[1]):
        if len(cl.mappings[j]) > 0:
            cl.data[:, j] = np.array([cl.mappings[j].index(cl.data[i][j]) 
                                for i in range(cl.data.shape[0])]).astype(str)
    cl.data = cl.data.astype(float)

    return cl



def _initialize_centroids(clustering):
    """
    """
    for i in range(clustering.k):
        lo = i * (clustering.data.shape[0] // clustering.k)  # get the index of the low end
        hi = (i + 1) * (clustering.data.shape[0] // clustering.k) - 1  # index of the hi end
        clustering.centroids = np.append(clustering.centroids, 
                clustering.data[np.random.randint(lo, high=hi)])
    clustering.centroids = np.reshape(clustering.centroids, 
            (clustering.k, clustering.data.shape[1]))
    return clustering




if __name__== "__main__":
    main()
