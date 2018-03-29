//__kernel void fpgasort(__global const float *x, 
//                        __global const float *y, 
//                        __global float *restrict z)

__kernel void fpgasort(__global float *data, 
                       __global float *temp, 
                       __global int num_of_elements,
                       __global int subarr_size)
{
    // get index of the work item
    int index = get_global_id(0);
    // Check in on notes 
}

