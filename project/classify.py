#!/usr/bin/env python3

#TODO 
# - check pathlib for path creation
# - actually read in stuff
# - redo name files to be CSV of column names

import argparse 
import ipdb
import os
import sys
import numpy
import csv

def main():
    args = parse_args()
    if args.debug:
        ipdb.set_trace()
    setup_data(args.data_filename)



def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--data', dest='data_filename', 
            default='data/iris.data', help='Defaults to iris')
    parser.add_argument('-k', '--means', dest='k', required=True,
            help='Centroid count. Must be equal to classes')
    parser.add_argument('--debug', dest='debug', action='store_true',
            help='Start tracing')
    return parser.parse_args()


def setup_data(data_filename):
    """
    """

    # Check if data file exists
    if not os.path.exists(data_filename):
        print("File '{}' does not exist".format(data_filename))
        sys.exit(1)

    mappings = _setup_mappings(open(data_filename))
    data, mappings, labels = _fill_in_data(open(data_filename), mappings)
    data, mappings, labels = _clean_data(data, mappings, labels)

################################################################################
#                               HELPER FUNCTIONS                               #
################################################################################

def _setup_mappings(csvfile):
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
        csvfile (File): The file pointer to the csv data file

    Returns:
        list: n-th item is either an empty list or set
    """

    mappings = []

    row = next(csv.reader(csvfile)))
    for i in range(len(row) - 1):    # ignore the last column (label)
        if row[i].isdigit():
            mappings.append([])
        else: 
            try:
                float(row[i])        # isdecimal() always returns false, but 
                mappings.append([])  # this works so whatever
            except:
                mappings.append(set())
    return mappings


def _fill_in_data(csvfile, mappings):
    """Helper Function: Read data from csv and setup mappings

    While reading in the data, parse it and track unique values of
    strings and classifications. The unique values are later used in a 
    list and the indeces of the entries replace the actual values. 

    Args:
        csvfile (File): Open file pointer to the csv data file
        mappings (list): 2D list with either empty sets or lists

    Returns:
        data (list): 2D list of data from csv
        mappings (list): 2D list with empty lists (place holders) or
                         sets of unique values from columns
        labels (list): Unique classifications the data can have
    """

    data = []
    labels = set()
    reader = csv.reader(csvfile)

    for row in reader:
	if len(row) == 0:  # Skip potentially empty rows
	    continue
	for i in range(len(row) - 1):    # -1 because we'll grab classes later
	    if type(mappings[i]) == set: 
		mappings[i].add(row[i])  # add the unique value 
	labels.add(row[-1])  # grab the label now
	del row[-1]          # Remove classification 
	data.append(row)
    return data, mappings, labels



def _clean_data(data, mappings, labels):
    """Helper Function: Convert data from strings to int/floats

    csv's reader reads csvs as strings but the actual values can vary in
    type. Convert the sets in mappings[] to lists to we can translate 
    the string values to numbers in the data via the indeces of the
    strings in mappings[]. Same with labels (used later). However, the
    data is simply converted if already an int/float in string form. The
    values need to be int/float in order to be used in L1 norm in 
    clustering.

    Args:
        data (list): mixed data from csv data file
        mappings (list): lists of unique values of strings from data
        labels (set): unique classifications of the data

    Returns:
        data (list): converted data. Should be lists of ints/floats
        mappings (list): converted mappings. Should be lists of strings
        labels (list): classifications in a list.
    """

    # Convert everything to lists so we have indeces
    for i in range(len(mappings)):
        mappings[i] = list(mappings[i])
    labels = list(labels)

    # Clean data, so convert strings to int, float, or mapping
    for i in range(len(data)):
        for j in range(len(data[i])):

            # convert to int if int
            if data[i][j].isdigit():
                data[i][j] = int(data[i][j])
            else:
                # convert to float if float
                try:
                    data[i][j] = float(data[i][j])
                # use index as int replacement
                except:
                    data[i][j] = mappings[j].index(data[i][j])
    return data, mappings, labels

if __name__== "__main__":
    main()
