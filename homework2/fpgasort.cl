//__kernel void fpgasort(__global const float *x, 
//                        __global const float *y, 
//                        __global float *restrict z)

__kernel void fpgasort(__global float* restrict data, 
                       __global float* restrict temp, 
                       int num_of_elements,
                       int subarr_size)
{
    unsigned long index;          // index of work item
    unsigned long left_lower;     // start of left subarray
    unsigned long mid;            // end of left subarray
    unsigned long right_upper;    // end of right subarray
    unsigned long right_lower;    // start orf right subarray (aka mid + 1)
    unsigned long temp_index;     // Index into semi-sorted interim result buffer
    
    // ith work item works on ith and ith + 1 subarrays, 
    // so don't do anything when ith subarray is more than
    // total subarrays
    index = get_global_id(0);
    left_lower = index * subarr_size;
    if(left_lower >= num_of_elements) {
        return;
    }

    right_upper = left_lower + subarr_size - 1;
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
    
    // Copy the semi-sorted temp content back to the original data set
    for(index = get_global_id(0) * subarr_size; index <= right_upper; index++) {
        data[index] = temp[index];
    }
    
    // Check in on notes 
}

