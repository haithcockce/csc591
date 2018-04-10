#!/usr/bin/env python3

import argparse 
import ipdb


def main():
    ipdb.set_trace()
    args = parse_args()



def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--data', dest='data_filename', 
            default='data/iris.data', help='Defaults to iris')
    parser.add_argument('-n', '--names', dest='name_filename',
            default='data/iris.names', help='Defaults to iris')
    parser.add_argument('-k', '--means', dest='k', required=True,
            help='Centroid count. Must be equal to classes')
    return parser.parse_args()











if __name__== "__main__":
    main()
