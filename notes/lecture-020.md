# Lecture 020 - Modern Processor Architecures II

## Review

- Instruction level parallelism with pipelining to improve throughput and shrinks cycle time 
- However, we can still only, at best do `CPI = 1` given perfect branch prediction, cache, and data forwarding
- __SuperScalar__ Expand pipeline to have multiple funcitonal units to improve `CPI = 1/n` but tops out at 0.5
- Still end up having stalls due to forwarding and dependencies so may not be able to reach 0.5 CPI, even with loop unrolling
- Limitations of compiler optimizations
  - no idea how to optimize across branches 
  - optimizations are architecture-dependent 
- __Dynamic Instruction__ executing instructions out of orde. Requirements:
  - Need to know PC and have a fancy branch predictor and instructions decoded, all data dependencies are resolved, and when all functional units are available

### WHEN DOING DEPENDENCY CHECKING, MAKE A DIRECTED ACYCLIC GRAPH AND COUNT ARROWS

- With multi-issue pipelines, just put instructions on a per-cycle time line. 
- With unlimited issue width, the cycles required depends only on instruction dependency. 



- We can still have dependencies between instructions even when they are not truly dependent (IE instructions that do not use the same registers but their reordering would change the result of the logic). 
  - _Write after Read_ (WAR) a later instruction overwrites the source of an earlier one
  - _Write after Write_ (WAW) A later instruction overwirtes the output of an earlier one
- Checking for false dependencies, create the DAG and check for arrows. They are true dependencies 

## Register Renaming 

- Upon compilation, change the registers in question used (which increase register usage) so outputs go to a different register than originally intended 
- __Static Single Assignment__ (SSA) 
- Most CPUs have 128 physical registers and map architectural registers to physical registers
