#!/usr/bin/python3
import numpy
from numpy import random
from numba import int64, jit
import ipdb


class Clustering:
    def __init__(self):
        self.a = 0


def main():
    clu = Clustering()
    cj = Clustering()
    clu = increment(clu)
    cj = jincrement(cj)  # this will fail
    #cj.a = jincrement_a(cj.a)
    print(clu.a)
    print(cj.a)

def increment(clu):
    clu.a += 1
    return clu

@jit
def jincrement(clu):
    clu.a += 1
    return clu

@jit
def jincrement_a(a):
    a += 1
    return a

if __name__ == '__main__':
    main()
