# Modern Processor Architecure III

## Review
 
- Out of order scheduling and SuperScaler
  - Need multiple functional units available, all dependencies must be resolved, and multiple instructions loaded
- __False Dependencies__ Not a true data dependency but same register names across instructions may mean writing after a read or write after a write (effectively overwriting the results of another operation)
  - Register renaming means reducing/eliminating false dependencies 
  
## Eh? 

- Can have variable lengths of pipelines as well (some are memory intensivee, others are for ALU, etc)

## Exceptions 

- Exceptions can occur in instruction fetches (page fault and need to map a page in), in instruction decode (illegal opcode), execute stage (divide by zero for example), memory access stage (invalid address or memory protection violation)
  - Can also have other kinds of interrupts or exceptions (such as a softirq)
- When doing exceptions, need to turn off writes, flush instructions, save the PC (to return to where we were), trap into the kernel, 
- Out of order pipelining will make flushing instructions difficult because we are already executing instructions that's after the faulting instructions
- So give a buffer number 

## Speculative Execution 

- Execute an instruction before if we know we need toand put results in a buffer
- Instructions are retired only when they complete executing and prior instructions complete

## Problems with OoO and SuperScalar 

- modern CPUs have 3-6 issue widths and branches are common 
- Speculative execution windows thus require predicting many branches and caching the results in a buffer
- Still may have cycles with nothing to execute due to dependencies. Why not execute other stuff in those gaps? 

## Multicore processors

- Will require multiple PCs, register files, reorder buffers but fine to share cache and ALUs but pull instructions from other threads of execution to perform 
