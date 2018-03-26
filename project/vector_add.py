#!/usr/bin/python3
import numpy
from numpy import random
import time
from numba import vectorize


def main():
    n = 100000000  # 100 Million 
    A = random.random(n)
    B = random.random(n)
    C = numpy.zeros(n)

    start = time.time()
    naive_vector_add(A, B, C)
    naive_total_time = time.time() - start

    start = time.time()
    vectorized_vector_add(A, B)
    vectorized_total_time = time.time() - start

    print("naive_vector_add: %f secs" % naive_total_time)
    print("vectorized_vector_add: %f secs" % vectorized_total_time)


def naive_vector_add(a, b, c):
    for i in range(a.size):
        c[i] = a[i] + b[i]

@vectorize
def vectorized_vector_add(a, b):
    return a + b

if __name__ == '__main__':
    main()
