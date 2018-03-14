  // CSC456: Name -- Charles Haithcock
  // CSC456: Student ID #000955738
  // CSC456: I am implementing -- Mergesort
  // CSC456: Feel free to modify any of the following. You can only turnin this file.

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <float.h>
#include <sys/time.h>
#include <pthread.h>
#include "mysort.h"


/* Function definitions */
void *mergesort(void *args);
void merge(int lower, int mid, int upper);
void threaded_mergesort();

/* Internal holding variables because I am too lazy to properly convert from 
 * my mergesort.c "scratchpad" to this  :) */
float* numbers;
int length;
float* temp = NULL;

/* Thread-specific structures 
 * These must be allocated outside the stack otherwise dereferencing them
 * within the threads may cause segfaults (apparently) */
pthread_t thread_1;
pthread_t thread_2;
struct thread_args {
    int lower;
    int upper;
} thread_args;
struct thread_args args_1;
struct thread_args args_2;

int pthread_sort(int num_of_elements, float *data)
{
    numbers = data;
    length = num_of_elements;
    temp = (float*) malloc(sizeof(float) * length);
	threaded_mergesort();
        return 0;
}

void *mergesort(void *args) {
	struct thread_args *t_args = (struct thread_args*) args;
    int upper = t_args->upper;
	int lower = t_args->lower;

    /* Subarray of length 1 */
    if((upper - lower) < 1) {
        return NULL;
    }

    int mid =  ((upper - lower) / 2) + lower;

	/* Constructing upper/lower args to recursive calls of mergesort */
    struct thread_args* left_child_args = (struct thread_args*) malloc(sizeof(thread_args));
    struct thread_args* right_child_args = (struct thread_args*) malloc(sizeof(thread_args));
    left_child_args->lower = lower;
    left_child_args->upper = mid;
    right_child_args->lower = mid + 1;
    right_child_args->upper = upper;

    /* left subarray [p..q] */
    mergesort(left_child_args);
    /* right subarray [q+1..r] */
    mergesort(right_child_args);
	/* Put it all together! */
    merge(lower, mid + 1, upper);

	free(left_child_args);
	free(right_child_args);
}

void merge(int lower, int mid, int upper) {
    float* base_num = numbers + lower;
    float* base_temp = temp + lower;
    int sub_ary_len = upper - lower + 1;
    int i = lower;
    int orig_mid = mid;
    while(lower < orig_mid || mid <= upper) {
        if(mid > upper) {
            temp[i++] = numbers[lower++];
        }
        else if(lower >= orig_mid) {
            temp[i++] = numbers[mid++];
        }
        else if(numbers[lower] < numbers[mid]) {
            temp[i++] = numbers[lower++];
        }
        else if (numbers[lower] >= numbers[mid]) {
            temp[i++] = numbers[mid++];
        }
    }
    memcpy(base_num, base_temp, sizeof(float) * sub_ary_len);
}

void threaded_mergesort() {
    args_1.lower = 0;
    args_1.upper = (length / 2) - 1;
    args_2.lower = (length / 2);
    args_2.upper = length - 1;

    if(pthread_create(&thread_1, NULL, mergesort, &args_1)) {
        printf("Error creating thread1\n");
        exit(2);
    }
    if(pthread_create(&thread_2, NULL, mergesort, &args_2)) {
        printf("Error creating thread2\n");
        exit(2);
    }
    if(pthread_join(thread_1, NULL)) {
        printf("Error joining thread1\n");
        exit(2);
    }
    if(pthread_join(thread_2, NULL)) {
        printf("Error joining thread2\n");
        exit(2);
    }
    /* Need one last merge as the threads will sort only the lower and upper
	 * halves of the original array */
    merge(0, (length / 2), length - 1);
}
