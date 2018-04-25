#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include <sys/time.h>
#include "cuPrintf.cu" /* For debugging */
#include "cuPrintf.cuh" /* For debugging */

#define THREADS 512
#ifdef __cplusplus
extern "C"
{
#endif


__global__ void cudasort(float *data, float *temp, int num_of_elements, 
        int subarr_size) {

    unsigned long index;          /* index when copying between temp and data*/
    unsigned long global_index;   /* index of thread */
    unsigned long left_lower;     /* start of left subarray */
    unsigned long mid;            /* end of left subarray */
    unsigned long right_upper;    /* end of right subarray */
    unsigned long right_lower;    /* start orf right subarray (aka mid + 1) */
    unsigned long temp_index;     /* Index into semi-sorted interim result buffer */

    /* ith work item works on ith and ith + 1 subarrays,
     * so don't do anything when ith subarray is more than
     * total subarrays */
    global_index = (blockIdx.x * gridDim.x) + (blockIdx.y * gridDim.y) + threadIdx.x;
    left_lower = global_index * subarr_size;
    if(left_lower >= num_of_elements) {
        return;
    }

    /* Mergesort works on A[p..q] and A[q+1..r], so calculate p == left_lower,
     * q = mid, q+1 = mid + 1 = right_lower, and r = right_upper
     */
    right_upper = (left_lower + subarr_size - 1) >= (num_of_elements - 1) ? (num_of_elements - 1) : (left_lower + subarr_size - 1) ;
    mid = (left_lower + right_upper) / 2;
    right_lower = mid + 1;

    temp_index = left_lower;
    while(left_lower <= mid || right_lower <= right_upper) {
        if(left_lower > mid) {
            temp[temp_index++] = data[right_lower++];
        }
        else if(right_lower > right_upper) {
            temp[temp_index++] = data[left_lower++];
        }
        else if(data[right_lower] < data[left_lower]) {
            temp[temp_index++] = data[right_lower++];
        }
        else if(data[left_lower] <= data[right_lower]) {
            temp[temp_index++] = data[left_lower++];
        }
    }

    __syncthreads();
    /* Copy the semi-sorted temp content back to the original data set */
    for(index = global_index * subarr_size; index <= right_upper; index++) {
        data[index] = temp[index];
    }

}


int cuda_sort(int num_of_elements, float *data)
{
    float *cuda_data;
    float *cuda_temp;

    float *temp;
    int subarr_size;


    unsigned long size_in_bytes = num_of_elements * sizeof(float);

    /* Create buffers for initial data and temp buffer */
    cudaMalloc((void **) &cuda_data, size_in_bytes);
    cudaMalloc((void **) &cuda_temp, size_in_bytes);
    temp = (float *) malloc(size_in_bytes);
    memset(temp, 0, size_in_bytes);


    cudaPrintfInit ();  /* For debugging */


    /* Merge sort is recursive, but OpenCL doesn't allow recursion (janky)
     * so instead mergesort is then iterative. Each loop iteration is the 
     * next up recursion level starting with the leaf nodes of the recursion
     * tree. */
    //int i;
    for(subarr_size = 2; subarr_size <= num_of_elements; 
            subarr_size = subarr_size * 2) {

        dim3 dimGrid(256, 256);
        //dim3 dimBlock(512, 1);
        /* Copy stuff to cuda buffers */
        cudaMemcpy(cuda_data, data, size_in_bytes, cudaMemcpyHostToDevice);
        cudaMemcpy(cuda_temp, temp, size_in_bytes, cudaMemcpyHostToDevice);

        /* Execute kernel */
        //cudasort<<<1, num_of_elements>>>(cuda_data, cuda_temp, 
        //        num_of_elements, subarr_size);
        cudasort<<<dimGrid, 512>>>(cuda_data, 
                cuda_temp, num_of_elements, subarr_size);
        cudaThreadSynchronize();

        /* Read data from GPU (either partially or fully sorted) */
        cudaMemcpy(data, cuda_data, size_in_bytes, cudaMemcpyDeviceToHost);
        cudaThreadSynchronize();
    }

    /* Clean up */
        cudaPrintfDisplay (stdout, true);  /* For debugging */
    cudaPrintfEnd ();  /* For debugging */ 

    free(temp);
    cudaFree(cuda_data);
    cudaFree(cuda_temp);
    return 0;
}

#ifdef __cplusplus
}
#endif
