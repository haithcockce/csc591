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

    /* Indexing in CUDA is hard. Due to the grid-like nature, getting the i-th
     * thread means calculating the amount of threads/row times the row the i-th
     * thread is on, add this to the amount of threads in the row until you 
     * reach the block the i-th thread is in, then adding this to the amount of
     * threads until you reach the i-th thread */
    global_index = (gridDim.x * blockDim.x * blockIdx.y) + 
                   (blockDim.x * blockIdx.x) + threadIdx.x;

    /* i-th thread works on i-th and i-th + 1 subarrays, so don't do anything 
     * when i-th subarray is more than total subarrays */
    left_lower = global_index * subarr_size;
    if(left_lower >= num_of_elements) {
        return;
    }

    /* Mergesort works on A[p..q] and A[q+1..r], so calculate p == left_lower,
     * q = mid, q+1 = mid + 1 = right_lower, and r = right_upper. Last subarray
     * may end up being shorter due to being the remaining amount of the data.*/
    right_upper = (left_lower + subarr_size - 1) >= (num_of_elements - 1) ? 
        (num_of_elements - 1) : (left_lower + subarr_size - 1) ;
    mid = (left_lower + right_upper) / 2;
    right_lower = mid + 1;
    index = left_lower;

    /* Begin merging. While we still have elements to merge with... */
    while(left_lower <= mid || right_lower <= right_upper) {

        /* if left subarray is parsed, grab from the right subarray */
        if(left_lower > mid) {
            temp[index++] = data[right_lower++];
        }

        /* if right subarray is parsed, grab from the left subarray */
        else if(right_lower > right_upper) {
            temp[index++] = data[left_lower++];
        }

        /* if next smallest element is in right subarray, grab it */
        else if(data[right_lower] < data[left_lower]) {
            temp[index++] = data[right_lower++];
        }

        /* if next smallest element is in left subarray, grab it */
        else if(data[left_lower] <= data[right_lower]) {
            temp[index++] = data[left_lower++];
        }
    }

    /* Copy the semi-sorted temp content back to the original data set */
    for(index = global_index * subarr_size; index <= right_upper; index++) {
        data[index] = temp[index];
    }
}


int cuda_sort(int num_of_elements, float *data)
{
    float *cuda_data;  /* gpu-side storage for data parameter */
    float *cuda_temp;  /* gpu-side storage for temp work buffer */
    float *temp;       /* temporary storage that acts like a workspace */
    int subarr_size;   /* amount of elements in subarrays when merging */

    unsigned long size_in_bytes = num_of_elements * sizeof(float);

    /* Create buffers for initial data and temp buffer */
    temp = (float *) malloc(size_in_bytes);
    memset(temp, 0, size_in_bytes);
    cudaMalloc((void **) &cuda_data, size_in_bytes);
    cudaMalloc((void **) &cuda_temp, size_in_bytes);

    /* Merge sort is recursive, but OpenCL doesn't allow recursion (janky)
     * so instead mergesort is then iterative. Each loop iteration is the 
     * next up recursion level starting with the leaf nodes of the recursion
     * tree. NOTE this implementation requires the data to be a power of 2 and
     * _will not work_ otherwise. If it does, it's coincidental and I didn't
     * make it happen :) */
    for(subarr_size = 2; subarr_size <= num_of_elements; 
            subarr_size = subarr_size * 2) {

        /* Final data size is 16777216 so problem space needs to hold this. 256
         * x 256 x 512 (or more precisely a 256 x 256 grid each with 512 x 1 
         * blocks) should suffice. */
        dim3 dimGrid(256, 256);

        /* Copy stuff to cuda buffers */
        cudaMemcpy(cuda_data, data, size_in_bytes, cudaMemcpyHostToDevice);
        cudaMemcpy(cuda_temp, temp, size_in_bytes, cudaMemcpyHostToDevice);

        /* Execute kernel, 2D grid, (256, 256), with 1D blocks, (512, 1) */
        cudasort<<<dimGrid, 512>>>(cuda_data, cuda_temp, num_of_elements, 
                subarr_size);

        /* Read data from GPU (either partially or fully sorted) */
        cudaMemcpy(data, cuda_data, size_in_bytes, cudaMemcpyDeviceToHost);
    }

    /* Clean up */
    free(temp);
    cudaFree(cuda_data);
    cudaFree(cuda_temp);
    return 0;
}

#ifdef __cplusplus
}
#endif
