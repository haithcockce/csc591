# Lecture 017 - Heterogeneous Computing Using GPUs

## Review

### OpenCL programming model

- CPU and RAM is host computer
- Load host program from host memory to device memory of target device
- Launch host program within device
- Then migrate results from device to host system

#### Problem Breakdown

- Single execution is a work item
- Work items are grouped into work groups
- Work groups have local memory and it's shared across work items
- The work groups combine together to create the global area with global memory
- `get_global_id(n)` gets the coordinate of the current work item in the `n`-th dimension (like x,y)

## GPU Programming

### Overview

- Flow: Input Assembler -> vertex shader -> geometry shader -> setup and rasterizer -> pixel shader -> raster ops/output merger
- GPUs don't have low latency memory busses because you are rendering frames in 5-8ms. That's super
  slow.
- ALUs are doing largely just basic arithmetic operations on vectors. So ALUs don't need to do
  complex things. Likewise, no need for high performance branch predictors.

### NVIDIA GPU Arch

- PCIe interface
- A group of processors is a streaming multiprocessors
- Thread scheduler between PCIe bus and streaming multiprocessors
- L2 Cache is global memory 
- And high bandwidth memory controller 
- Each streaming multiprocessor has several register files with tons of cores (example, 192 cores)

### CPU vs GPU 

- GPU is tolerable to memory latencies due to massive throughput. Prefer data level parallelism and _not_ thread-level parallelism. 

### Accelerated Processing Unit 

- Effectively embedded GPU in CPU (but can be dedicated hardware as well). 
- APU and CPU/GPU are all connected via DRAM but the RAM is optimized for latency and not bandwidth. 
