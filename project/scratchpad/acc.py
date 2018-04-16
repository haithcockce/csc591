#!/usr/bin/python3
import numpy
from numpy import random
from numba import vectorize, guvectorize, int64, float64, jit
import time


def main():
    n = 1000000000
    data = numpy.random.randint(10, size=(n))
    print("Starting regular accumulation")
    start = time.time()
    print(acc(data))
    print("{} seconds for regular accumulation".format(time.time() - start))

    start = time.time()
    print(acc_jit(data))
    print("{} seconds for jit accumulation".format(time.time() - start))
    #print(accumulator)
    #a = numpy.arange(1.0, 10.0)
    #b = numpy.arange(1.0, 10.0)
    # Calls compiled version of my_ufunc for each element of a and b
    #print(my_ufunc(a, b))


#@guvectorize(['int64(int64[:], int64)'], '(n),()->()')
#def acc(source, accumulator):
#    for i in range(source.shape[0]):
#        accumulator = accumulator + source[i]

@jit('int64(int64[:])')
def acc_jit(source):
    a = 0
    for i in range(source.shape[0]):
        a = a + source[i]
    return a

def acc(source):
    a = 0
    for i in range(source.shape[0]):
        a = a + source[i]
    return a



if __name__ == '__main__':
    main()
