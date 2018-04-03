# NVIDIA GPU Arch

## Review 

- Streaming multiprocessors made up of hundreds of ALUs.
- Each ALU schedules a single thread of work. 
- Bottleneck is in moving data from storage to DRAM and _then_ to the GPU
- APU is meant to have GPU sit within CPU to mitigate latency in added thing to move data through
- APUs are meant for graphics and data-level parallelism (since CPUs are meant for thread-level parallelism). So APU does not need to run at a very high clock rate
- Work is divided into work items (threads), grouped into work groups. These can be parallelised. The work groups are grouped together into the global area. 
- OpenCL is great because same kernel (fundamental code that is executable on GPU) can be pushed to any device 

# OpenCL code can be used on APU on CPU so we can test locally!

## CUDA

- NVIDIA proposed C/C++ extensions
- `__global__` is used to declare a kernel 
- GCC can be used to compile it. 
- Invoking kernel requires something like `mykernel<<<1,1>>>();`
- `mykernel<<<N,2>>>();` means N blocks each with 2 threads
- A thing of work is a _thread_ and groups of them are _blocks_. Work is divided into 1 Dimension
- `threadIdx.x` is the id of the work, similar to OpenCL's `get_global_id(N)`

### CUDA vs OpenCL

- `__global__` is kernel in CUDA, `__global` is global memory in opencl
- `__shared__ == __local` and describes local memory 
- `threadIdx.x == get_global_id(0)` gets the x index
- `threadIdx.y == get_global_id(1)` gets the y index
