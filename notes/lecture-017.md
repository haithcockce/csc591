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
