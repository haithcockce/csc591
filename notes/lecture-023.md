# Lecture 023 - Advanced Memory Hierarchy

## Review

- 2-bit prediction isn't great and is extremely localized
- _Global History Register_ uses patterns of branches as index into array of 
  next prediction
  - Extremely useful for branches which corrolate
  - Susceptible to interference from other branches
- Local branch prediction (like 2-bit) has less interference from global patterns

## Tournament Predictors

- Local and Global predictors have tradeoffs, so have a predictor-predictor
- Tournament is better than local and global predictors
- Alpha 21264 has 2 -level predictor
  - 2^10 entries, each with 3 bits (rather than 2 bits) 

## Memory Hierarchy and Virtual Memory 

- Why have virtual memory? 
  - Applications may map same physical locations and contend for memory
  - Not all systems have the same amount of memory 

### Address Translation

- Virtual Address is split into virtual page number and offet. 
  - Page number indexes into page tables and offset indexes into page
- With virtual memory, an `LDUR` instruction require? Instruction access,
  then page table for the backing memory, data memory access, and then
  page table again. So four times!
- In `x86_64`, actually have multiple levels (`PGD, PUD, PMD`)
  - Hierarchical page tables offer memory reduction, but offer no performance
    benfits to address translations due to more memory accesses

### Translation Lookaside Buffer

- Cache of page table that is small with high associativity
- Only cache ona miss!
- What if multiple VA from different processes map to the same VA? 
  - Flush the TLB on a context switch? Serious performance penalty
- Use page offset from VA as index and block offset into TLB
