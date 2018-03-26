# Lecture 016 - OpenCL

## Overview

- An FPGA is used to create specialized circuits for dedicated logic to make accelerators

## Programming Model

### Creating a kernel to operate on data

- Host program controls distribution of computation to compute units
  - `getDevices()` and `clCreateContext()` to set up device for computing
- Compute units can be CPUs, GPUs, TPU, FPGA, etc
- Data gets loaded into host memory where opencl can then push data to compute unit's device memory
  - `clCreateBuffer()` to receive data in device memory from host
  - `clEnqueueWriteBuffer()` to move stuff from host memory to device memory
- Device program then is launched with the data in the device memory
  - `clCreateCommandQueue()` to enqueue events to perform actions
- Data is then copied from device memory to host memory
  - `clEnqueueReadBuffer()` to push from device to host

### Conceptualization of execution

- Work is divided up into subsets of the problem and executed
- __Work Item__ is a single entity of execution to solve the problem
- The __global area__ is the whole problem
- A __work group__ is a subset of the overall problem consisting of multiple work items
  - Can share local memory on the cache of the compute unit
  - Each work group uses the same compute unit (being local to each other)
  - local work items must be synced with respect to memory while items in different groups can't be synced
- The dimensionality of the problem can be 1, 2 or 3 dimensions

### OpenCL Memory Model

- work items have private memory
- local memory belongs to a work group
- A compute device's memory is global memory
- Host memory is the DIMM sticks on the mobo

### OpenCL Language Highlights

- Qualifiers
  - `__kernel` declares a function as a kernel (stuff that gets queued)
  - `__global __local __constant __ private` address space qualifiers
