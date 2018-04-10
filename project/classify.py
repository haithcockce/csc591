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

def main():
    args = parse_args()
    if args.debug:
        ipdb.set_trace()
    setup_data(args.data_filename, args.name_filename)



def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--data', dest='data_filename', 
            default='data/iris.data', help='Defaults to iris')
    parser.add_argument('-n', '--names', dest='name_filename',
            default='data/iris.names', help='Defaults to iris')
    parser.add_argument('-k', '--means', dest='k', required=True,
            help='Centroid count. Must be equal to classes')
    parser.add_argument('--debug', dest='debug', action='store_true',
            help='Start tracing')
    return parser.parse_args()


def setup_data(data_filename, name_filename):
    """
    """

    # Check if files exists
    if not os.path.exists(data_filename):
        print("File '{}' does not exist".format(data_filename))
        sys.exit(1)
    elif not os.path.exists(name_filename):
        print("File '{}' does not exist".format(name_filename))
        sys.exit(1)

    # Open files
    data = numpy.loadtxt(data_filename, delimiter=',')  # This doesn't work :C







if __name__== "__main__":
    main()
