#!/usr/bin/env python3

import ipdb
import numpy 

def main():
    data = numpy.random.randint(100, size=(10, 5))
    centroids = [data[numpy.random.randint(5)], 
                 data[numpy.random.randint(5, 10)]] 
    delta = 0
    predicted = []
    for i in range(10):
        distances = []





if __name__ == "__main__":
    main()
