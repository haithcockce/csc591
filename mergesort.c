#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <pthread.h>

#define USAGE "./merge-sort <# ELEMENTS TO SORT>\n"

void setup(int argc, char **argv);
void mergesort();
void* __mergesort(void *args);
void merge(int lower, int mid, int upper);
void checker();
void* tester(void* str);
void threadwork();
int compare(const void* p1, const void* p2);
void threaded_mergesort();

float* numbers;
float* orig_numbers;
int length;
float* temp = NULL;
struct thread_args {
    int lower;
    int upper;
} thread_args;

pthread_t thread_1;
pthread_t thread_2; 
struct thread_args args_1;
struct thread_args args_2;

int main(int argc, char **argv) {
    setup(argc, argv);
//    mergesort();
    threaded_mergesort();
    checker();
//    threadwork();
}

void mergesort() {
//    __mergesort(0, length - 1);
}

void threaded_mergesort() {
    args_1.lower = 0; 
    args_1.upper = (length / 2) - 1;
    args_2.lower = (length / 2); 
    args_2.upper = length - 1;

    if(pthread_create(&thread_1, NULL, __mergesort, &args_1)) {
        printf("Error creating thread1\n");
        exit(2);
    }
    if(pthread_create(&thread_2, NULL, __mergesort, &args_2)) {
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
    // Need one last merge
    merge(0, (length / 2), length - 1);
}

void* __mergesort(void* args) {
    struct thread_args * a = (struct thread_args *) args;
    int upper = a->upper;
    int lower = a->lower;
    /* Subarray of length 1 */
    if((upper - lower) < 1) {
        return NULL;
    }

    int mid =  ((upper - lower) / 2) + lower;

    struct thread_args* left_child_args = (struct thread_args*) malloc(sizeof(thread_args));
    struct thread_args* right_child_args = (struct thread_args*) malloc(sizeof(thread_args));
    left_child_args->lower = lower;
    left_child_args->upper = mid;
    right_child_args->lower = mid + 1;
    right_child_args->upper = upper;
    /* left subarray [p..q] */
    __mergesort(left_child_args);
    /* right subarray [q+1..r] */
    __mergesort(right_child_args);
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

void setup(int argc, char **argv) {
    if(argc != 2) {
        printf(USAGE);
        printf("Need exactly one argument\n");
        exit(1);
    }

    char* arg = argv[1];
    int len = strnlen(argv[1], 32);
    int i;
    for(i = 0; i < len; i++) {
        if(!isdigit(arg[i])) {
            printf(USAGE);
            printf("Argument was not a digit\n");
            exit(1);
        }
    }

    length = strtol(arg, NULL, 10);
    numbers = (float*) malloc(sizeof(float) * length);
    temp = (float*) malloc(sizeof(float) * length);
    orig_numbers = (float*) malloc(sizeof(float) * length);
    srand(time(NULL));
    for(i = 0; i < length; i++) {
        numbers[i] = (float) rand();
        orig_numbers[i] = numbers[i];
    }
    qsort(orig_numbers, length, sizeof(float), compare);
}

void checker() {
    int i;
    for(i = 0; i < length - 1; i++) {
        if(numbers[0] > numbers[1]) {
            printf("OUT OF ORDER\n");
            exit(1);
        }
        if(numbers[i] != orig_numbers[i]) {
            printf("EXPECTED %f BUT FOUND %f\n", orig_numbers[i], numbers[i]);
            exit(1);
        }
    }
    printf("SUCCESS\n");
}

int compare(const void* x, const void* y) {
    if( *(float*) x < *(float*) y) return -1;
    if( *(float*) x == *(float*) y) return 0;
    if( *(float*) x > *(float*) y) return 1;
}
void threadwork() {
    pthread_t thread; 
    if(pthread_create(&thread, NULL, tester, "This is a threan\n")) {
        printf("Error creating thread\n");
        exit(2);
    }
    if(pthread_join(thread, NULL)) {
        printf("Error joining thread\n");
        exit(2);
    }
}

void* tester(void* str) {
    printf("%s\n", (char*) str);
}
