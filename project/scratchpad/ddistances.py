#!/usr/bin/python3
import numpy
from numpy import random
import time
from numba import vectorize, guvectorize, int64
import sys
import ipdb



def main():
    n = 1000000   # 1 Million vectors
    p = 20        # 20  entries per vector
    q = 3         # 3 centroids
    data = random.randint(0, 100, (n, p))
    centroids = random.randint(0, 100, (q, p))
    classes = numpy.zeros(n)
    classes_v = numpy.zeros(n)

    print("Starting naive_ddistance")

    start = time.time()
    classes = naive_ddistance(data, centroids, classes)
    naive_total_time = time.time() - start
    print("naive_distance: {} secs".format(naive_total_time))

    #start = time.time()
    #classes_v = vectorized_ddistance(data, centroids, sys.maxsize, classes_v)
    #vectorized_total_time = time.time() - start
    #print("vectorized_distance: {} secs".format(vectorized_total_time))

    #compare_vectors(classes, classes_v)

    start = time.time()
    classes = naive_nonp_ddistance(data, centroids, classes)
    naive_total_time = time.time() - start
    print("naive_nonp_distance: {} secs".format(naive_total_time))

    start = time.time()
    classes_v = vectorized_nonp_ddistance(data, centroids, sys.maxsize, classes_v)
    vectorized_total_time = time.time() - start
    print("vectorized_nonp_distance: {} secs".format(vectorized_total_time))

    compare_vectors(classes, classes_v)



def naive_ddistance(data, centroids, classes):
    min_dist = sys.maxsize
    min_class = -1
    dist = -1
    for i in range(data.shape[0]):
        for j in range(centroids.shape[0]):
            dist = numpy.linalg.norm(data[i] - centroids[j])
            if dist < min_dist:
                min_dist = dist
                min_class = j
        classes[i] = min_class
        min_dist = sys.maxsize
    return classes

# numpy and other libraries are not available on the GPU (duh) and functions can
# not be passed in either. So we can not use numpy.linalg.norm() here.
#
#@guvectorize([(int64[:,:], int64[:,:], int64, int64[:])], '(n,p),(q,p),()->(n)')
#def vectorized_ddistance(data, centroids, maxsize, classes):
#    min_dist = maxsize
#    min_class = -1
#    dist = -1
#    for i in range(data.shape[0]):
#        for j in range(centroids.shape[0]):
#            dist = numpy.linalg.norm(data[i] - centroids[j])
#            if dist < min_dist:
#                min_dist = dist
#                min_class = j
#        classes[i] = min_class
#        min_dist = maxsize



def naive_nonp_ddistance(data, centroids, classes):
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
def vectorized_nonp_ddistance(data, centroids, maxsize, classes):
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



def compare_vectors(u, v, np=True):
    for i in range(u.shape[0]):
        if u[i] != v[i]:
            if np:
                print("Numpy normed vectors do not match. u[{}] = {}, v[{}] = {}"
                        .format(i, u[i], i, v[i]))
            else: 
                print("Manually normed vectors do not match. u[{}] = {}, v[{}] = {}"
                        .format(i, u[i], i, v[i]))



if __name__ == '__main__':
    main()
