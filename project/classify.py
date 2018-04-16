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
    return clustering

def k_means_clustering(clustering):
    
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
    clustering.predicted = [-1] * len(clustering.data)
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

    # Clean data, so convert strings to int, float, or mapping
    for i in range(len(clustering.data)):
        for j in range(len(clustering.data[i])):

            # convert to int if int
            if clustering.data[i][j].isdigit():
                clustering.data[i][j] = int(clustering.data[i][j])
            else:
                # convert to float if float
                try:
                    clustering.data[i][j] = float(clustering.data[i][j])
                # use index as int replacement
                except:
                    clustering.data[i][j] = clustering.mappings[j].index(data[i][j])
    return clustering



def naive_distance(data, centroids, classes):
    """
    """
    min_dist = sys.maxsize
    min_class = -1
    dist = 0 
    for i in range(data.shape[0]):
        for j in range(centroids.shape[0]):
            dist = 0 
            for k in range(centroids.shape[1]):
                dist += (data[i][k] - centroids[j][k]) ** 2
            dist = dist ** 0.5 
            if dist < min_dist:
                min_dist = dist
                min_class = j 
        classes[i] = min_class
        min_dist = sys.maxsize
    return classes



@guvectorize([(int64[:,:], int64[:,:], int64, int64[:])], '(n,p),(q,p),()->(n)')
def vectorized_distance(data, centroids, maxsize, classes):
    """
    """
    min_dist = maxsize
    min_class = -1
    dist = 0
    for i in range(data.shape[0]):
        for j in range(centroids.shape[0]):
            dist = 0
            for k in range(centroids.shape[1]):
                dist += (data[i][k] - centroids[j][k]) ** 2
            dist = dist ** 0.5
            if dist < min_dist:
                min_dist = dist
                min_class = j
        classes[i] = min_class
        min_dist = maxsize


if __name__== "__main__":
    main()
