# Lecture 019 - Modern Processor Architectures

## Programming assignment

- `fpgasort.cl` is the kernel code to be executed on board
- `fpga_sort.cpp` host program to initialize kernel and board 
- May need to rewrite kernel to work on multiple lengths input so will need to invoke the kernel multiple times

## Amdahl's Corollary 3

- `S_parallel = 1 / (1 - x)`
- Parallelism works within instruction-level parallelism (pipelining, branch prediction, etc), data-level (GPUs and Vectorized ALUs), Thread-level (multicore, multi processors, simultaneous multithreading, etc)
- Can't getbetter than CPI = 1. Or can we? 

##  SuperScalar

- Double the amount of function units (ALUs) in the processor's pipeline to execute more than one instruction in each cycle.
  - Must fetch more instructions at each cycle (rather than just one) 
  - Memory units musta ccept multiple requests and not just one
  - Need additional data forwarding/hazard detection rules
  - Don't need more registers (well could use more, but x86 is staying backwards compatibile) 
- If fetching 2 instructions at a time and executing 2 at a time, then CPI = (2 cycles)/(4 instructions) = 0.5 with perfect branching and no hazards (may still need to stall). 
  - Reorder instructions to prevent stalling. Do work instead of stalling

# Limitations of compiler optimizations

- Most branches and cache misses can't be optimized for
- Not all architectures can do the same optimizations and changes in hardware mean changes in optimizations potentially

## Dynamic and Out of Order instruction scheduling 

- When can we execute an instruction, instruction is first decoded and put somewhere. Data dependencies must be resolved and inputs ready upon execution, and target functional unit must be available
- Goal is to reorder instructions dynamically but requires storage for decoded instructions, fetching multiple instructions, and fancy branch prediction for fetching beyond branches
- Instructions can be fetched based on inputs and functional unit availablility
