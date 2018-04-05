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
