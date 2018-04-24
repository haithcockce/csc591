#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include <sys/time.h>

#define THREADS 512
#ifdef __cplusplus
extern "C"
{
#endif

__global__ void cudasort(float *data, float *temp, int num_of_elements, 
        int subarr_size) {
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


    /* Merge sort is recursive, but OpenCL doesn't allow recursion (janky)
     * so instead mergesort is then iterative. Each loop iteration is the 
     * next up recursion level starting with the leaf nodes of the recursion
     * tree. */
    for(subarr_size = 2; subarr_size <= num_of_elements; 
            subarr_size = subarr_size * 2) {
        printf("%d Hidy-ho kids I'm mister Hanky\n", subarr_size); 

        /* Copy stuff to cuda buffers */
        cudaMemcpy(cuda_data, data, size_in_bytes, cudaMemcpyHostToDevice);
        cudaMemcpy(cuda_temp, temp, size_in_bytes, cudaMemcpyHostToDevice);

        /* Execute kernel */
        cudasort<<<num_of_elements, subarr_size>>>(cuda_data, cuda_temp, 
                num_of_elements, subarr_size);

        /* Read data from GPU (either partially or fully sorted) */
        cudaMemcpy(data, cuda_data, size_in_bytes, cudaMemcpyHostToDevice);
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
