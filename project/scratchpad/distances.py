#!/usr/bin/python3
import numpy
from numpy import random
import time
from numba import vectorize, guvectorize, int64


def main():
    n = 10000000  # 10 Million vectors
    p = 20        # 20  entries per vector
    A = random.randint(0, 100, (n, p))
    v = random.randint(0, 100, p)
    A_norm = numpy.zeros(n)
    A_normv = numpy.zeros(n)

    start = time.time()
    A_norm = naive_distance(A, v, A_norm)
    naive_total_time = time.time() - start
    print("naive_distance: %f secs" % naive_total_time)

    start = time.time()
    A_normv = vectorized_distance(A, v, A_normv)
    vectorized_total_time = time.time() - start
    print("vectorized_distance: %f secs" % vectorized_total_time)

    compare_vectors(A_norm, A_normv)

    start = time.time()
    A_norm = naive_nonp_distance(A, v, A_norm)
    naive_total_time = time.time() - start
    print("naive_nonp_distance: %f secs" % naive_total_time)

    start = time.time()
    A_normv = vectorized_nonp_distance(A, v, A_normv)
    vectorized_total_time = time.time() - start
    print("vectorized_nonp_distance: %f secs" % vectorized_total_time)

    compare_vectors(A_norm, A_normv, False)



def naive_distance(A, v, A_norm):
    for i in range(A.shape[0]):
        A_norm[i] = numpy.linalg.norm(A[i] - v)
    return A_norm



@guvectorize([(int64[:,:], int64[:], int64[:])], '(n,p),(p)->(n)')
def vectorized_distance(A, v, A_normv):
    for i in range(A.shape[0]):
        A_normv[i] = numpy.linalg.norm(A[i] - v)



def naive_nonp_distance(A, v, A_norm):
    for i in range(A.shape[0]): 
        A_norm[i] = 0;
        for j in range(A.shape[1]):
            A_norm[i] += (A[i][j] - v[j]) ** 2
        A_norm[i] = A_norm[i] ** 0.5
    return A_norm



@guvectorize([(int64[:,:], int64[:], int64[:])], '(n,p),(p)->(n)')
def vectorized_nonp_distance(A, v, A_normv):
    for i in range(A.shape[0]):
        A_normv[i] = 0
        for j in range(A.shape[1]):
            A_normv[i] += (A[i][j] - v[j]) ** 2
        A_normv[i] = A_normv[i] ** 0.5



def compare_vectors(u, v, np=True):
    for i in range(u.shape[0]):
        if int(u[i]) != int(v[i]):
            if np:
                print("Numpy normed vectors do not match. u[{}] = {}, v[{}] = {}"
                        .format(i, int(u[i]), i, int(v[i])))
            else: 
                print("Manually normed vectors do not match. u[{}] = {}, v[{}] = {}"
                        .format(i, int(u[i]), i, int(v[i])))



if __name__ == '__main__':
    main()
