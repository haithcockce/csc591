#!/usr/bin/env python3

#TODO 
# - k-means clustering
# - Cross validation 

import argparse 
import ipdb
import os
import sys
import numpy
import csv
from numba import vectorize, guvectorize, int64, float64, jit
import copy
import time


def main():
    args = parse_args()
    if args.debug:
        ipdb.set_trace()
    clustering = setup_data(Clustering(args))
    clustering = k_means_clustering(clustering)



class Clustering:
    def __init__(self, args):
        self.mappings = []
        self.data = []
        self.labels = set()
        self.k = args.k
        self.predicted = []
        self.actual = []
        self.data_filename = args.data_filename
        self.centroids = []
        self.offload = args.offload
        self.delta = sys.maxsize
        self.max_iterations = 300  # borrowed from scikit.learn's kmeans       
        self.curr_iteration = 0

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--data', dest='data_filename', 
            default='data/iris.data', help='Defaults to iris')
    parser.add_argument('-k', '--means', dest='k', required=True,
            help='Centroid count. Must be equal to classes', type=int)
    parser.add_argument('--debug', dest='debug', action='store_true',
            help='Start tracing')
    parser.add_argument('--g', '--gpu', dest='offload',
            action='store_true', help='Offload to GPU')
    return parser.parse_args()


def setup_data(clustering):
    """
    """

    # Check if data file exists
    if not os.path.exists(clustering.data_filename):
        print("File '{}' does not exist".format(clustering.data_filename))
        sys.exit(1)

    clustering = _setup_mappings(clustering)
    clustering = _fill_in_data(clustering)
    clustering = _clean_data(clustering)
    clustering = _initialize_centroids(clustering)
    return clustering

def k_means_clustering(clustering):
    optimized_c = copy.deepcopy(clustering)
    threshold = int(len(clustering.data) * 0.05)

    # Begin naive clustering
    start_time = time.time()
    clustering = naive_assignment(clustering)
    clustering = naive_update_centroids(clustering)
    while clustering.delta > threshold and (
            clustering.curr_iteration < clustering.max_iterations):
        clustering = naive_assignment(clustering)
        clustering = _calc_delta(clustering)
        clustering = naive_update_centroids(clustering)
        clustering.curr_iteration += 1
    # TODO
    # - time both
    # - loop naive and gpu until delta < % of total records 
    #   (or 300 max like scikit)
    # - need to loop assignment and update clustering
    
################################################################################
#                               HELPER FUNCTIONS                               #
################################################################################

def _setup_mappings(clustering):
    """Helper Function: Setup an empty mappings list

    The csv data files can be mixed data types (string, float, int), 
    but naive k-means clustering requires only digits due to using the
    Euclidean Distance (L1 Norm). Here, we create a mappings list where
    each entry is either a set or list at each index. The indeces map
    to column indeces in the csv data file. The n-th entry in mappings
    will contain either an empty list if the n-th column in the csv data
    is numeric or an empty set if the n-th column is strings.

    The classifications/labels are disregarded here as they are later 
    discarded to prevent skewing clustering. 

    Args:
        clustering (Clustering): See class Clustering. Mappings is not
            yet filled in 

    Returns:
        clustering (Clustering): The parameter's mappings attribute is
            now initialized
    """

    row = next(csv.reader(open(clustering.data_filename)))
    for i in range(len(row) - 1):    # ignore the last column (label)
        if row[i].isdigit():
            clustering.mappings.append([])
        else: 
            try:
                float(row[i])        # isdecimal() always returns false, but 
                clustering.mappings.append([])  # this works so whatever
            except:
                clustering.mappings.append(set())
    return clustering



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

    reader = csv.reader(open(clustering.data_filename))

    for row in reader:
        if len(row) == 0:  # Skip potentially empty rows
            continue
        for i in range(len(row) - 1):    # -1 because we'll grab classes later
            if type(clustering.mappings[i]) == set: 
                clustering.mappings[i].add(row[i])  # add the unique value 
        clustering.labels.add(row[-1])     # grab the label now
        clustering.actual.append(row[-1])  # and record actual classification
        del row[-1]          # Remove classification 
        clustering.data.append(row)
    clustering.predicted = [len(clustering.data)] * len(clustering.data)
    return clustering


def _clean_data(clustering):
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
    for i in range(len(clustering.mappings)):
        clustering.mappings[i] = list(clustering.mappings[i])
    clustering.labels = list(clustering.labels)

    # Clean data, so convert strings to float (including ints and mappings)
    for i in range(len(clustering.data)):
        for j in range(len(clustering.data[i])):

            # convert to int if int
            if clustering.data[i][j].isdigit():
                clustering.data[i][j] = float(clustering.data[i][j])
            else:
                # convert to float if float
                try:
                    clustering.data[i][j] = float(clustering.data[i][j])
                # use index as int replacement
                except:
                    clustering.data[i][j] = float(
                            clustering.mappings[j].index(clustering.data[i][j]))
    return clustering



def _initialize_centroids(clustering):
    """
    """
    for i in range(clustering.k):
        lo = i * (len(clustering.data) // clustering.k)  # get the index of the low end
        hi = (i + 1) * (len(clustering.data) // clustering.k) - 1  # index of the hi end
        clustering.centroids.append(clustering.data[numpy.random.randint(
                                    lo, high=hi)])
    return clustering


def naive_update_centroids(clustering):
    # First, clear out current centroids
    for i in range(len(clustering.centroids)):
        clustering.centroids[i] = [0] * len(clustering.data[0])

    # Now sum across all classes
    counts = [0] * len(clustering.centroids)
    for i in range(len(clustering.data)):
        for j in range(len(clustering.data[0])):
            clustering.centroids[clustering.predicted[i]][j] += clustering.data[i][j]
        counts[clustering.predicted[i]] += 1

    # And normalize
    for i in range(len(clustering.centroids)):
        for j in range(len(clustering.centroids[0])):
            clustering.centroids[i][j] /= counts[i]
    return clustering



@jit
def jit_update_centroids(clustering):
    # First, clear out current centroids
    for i in range(len(clustering.centroids)):
        clustering.centroids[i] = [0] * len(clustering.data[0])

    # Now sum across all classes
    counts = [0] * len(clustering.centroids)
    for i in range(len(clustering.data)):
        for j in range(len(clustering.data[0])):
            clustering.centroids[clustering.predicted[i]][j] += clustering.data[i][j]
            counts[clustering.predicted[i]] += 1

    # And normalize
    for i in range(len(clustering.centroids)):
        for j in range(len(clustering.centroids[0])):
            clustering.centroids[i][j] /= counts[i]
    return clustering


def _calc_delta(clustering):
    clustering.delta = 0
    for i in range(len(clustering.predicted)):
        if clustering.predicted[i] < 0:
            clustering.delta += 1
            clustering.predicted[i] *= -1
        elif clustering.predicted[i] == sys.maxsize:
            clustering.delta += 1
            clustering.predicted[i] = 0
    return clustering



@jit
def _jit_calc_delta(clustering):
    clustering.delta = 0
    for i in range(len(clustering.predicted)):
        if clustering.predicted[i] < 0:
            clustering.delta += 1
            clustering.predicted[i] *= -1
        elif clustering.predicted[i] == sys.maxsize:
            clustering.delta += 1
            clustering.predicted[i] = 0
    return clustering



def naive_assignment(clustering):
    """
    """
    min_dist = sys.maxsize
    min_class = -1
    dist = 0 
    for i in range(len(clustering.data)):
        for j in range(len(clustering.centroids)):
            dist = 0 
            for k in range(len(clustering.centroids[0])):
                dist += (clustering.data[i][k] 
                        - clustering.centroids[j][k]) ** 2
            dist = dist ** 0.5 
            if dist < min_dist:
                min_dist = dist
                min_class = j

        # Mark a change to the class. Set to maxsize marker value if changed to
        # 0, negative if changed to non-zero, or just assign it if it wasn't
        # assigned anything prior (so size of data)
        if clustering.predicted[i] != len(clustering.data) and (
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
    """
    """
    min_dist = maxsize
    min_class = -1
    dist = 0
    for i in range(len(data)):
        for j in range(len(centroids)):
            dist = 0
            for k in range(len(centroids[0])):
                dist += (data[i][k] - centroids[j][k]) ** 2
            dist = dist ** 0.5
            if dist < min_dist:
                min_dist = dist
                min_class = j
        
        # Mark a change to the class. Set to maxsize marker value if changed to
        # 0, negative if changed to non-zero, or just assign it if it wasn't
        # assigned anything prior (so size of data)
        if predicted[i] != len(data) and min_class != predicted[i]: 
            if min_class == 0:
                min_class = maxsize
            else:
                min_class *= -1
        predicted[i] = min_class
        min_dist = maxsize



if __name__== "__main__":
    main()
