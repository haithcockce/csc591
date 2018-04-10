# Lecture 022 - Modern Microprocessor Architecture IV

## Review

- Dynamic/OoO instruction execution requires multiple instruction fetching, dependency resolution, and multiple funcitonal units being available 
- Dependency resolution is hard. Let's rename registers by leveraging the differences between architectural and physical registers
- Difficulty with handling exceptions and interrupts as some instructions may be interrupted/fail so several other instructions in the issues may fail as well. 
- _Reorder Buffer_ will store interim results of executions to allow for _speculative execution_. Allows saving for interrupts. 
  - Instruction retiring occurs only when all prior instructions are retired/committed in order. 
  - Exceptions or mispredictions will simply require a flush of instructions and reorder buffer
  - Front end of pipeline includes prediction, fetching, decode, renaming, queue and schedule instructions. 
  - Backline is execution (ALU, memory access, function units) and reorder buffering 
  - May still have wasted cycles due to dependencies (wherein nothing is executed)
- Most modern processors have 3-6 issues (width) 

## Simultaneous Multithreading

- is filling wasted cycles with instructions from other threads of execution 
  - Requires multiple changes to PC, Register Files, Reorder Buffer, but all other superscalar hardware is shared
  - Can increase cache miss rate due to evictions so decrease per-thread throughput, but deeper pipelines are more tolerable to mispredicted branches, allows better hardware utilization
- However, with Chip Multiprocessor, you get more functional units and ALU than SMT. 
  - CMP has better peak instruction throughput when both CMP and SMT running at same clock rate, A single thread on SMT has access to far more functional units and ALU, CMP is more power efficient though due to having fewer cores on at a time, and coherence misses increases for CMP when two threads share same cache area
  
## Branch Prediciton 

- Review: local 2-bit predictor, each line has 2 bits to represent predicted or unpredicted
- The 2-bit predictors may end up creating a pattern in terms of predictions. Can maybe detect patterns? 

### Two-Level Global Predictor

- Pattern of branches is used as index into global predictor vector filled with prediction counters. 
  - Taken is 1, not taken is 0.
  - Pattern could be Taken, Not Taken, Taken so index is then 101. 
  - _Global History Register_ is then indexed with 101 (so `GHR[101]`). 
  - Result therein is prediction (EG: `GHR[101] == 11` so taken) 
  - First level is history and second level is counter
  - Used in Pentium Pro
- GHR tends to work better when branches have correlations or a pattern will inherently occur. 
- Example: 

```c
for(i = 0; i < 4096; i++)
    for(j = 0; j < 2; j++) 
        a[i, j]++;
```

Above the natural pattern of Not Taken, Taken, Taken will show up. 

- Example:

```c
for(i = 0; i < 4096; i++) {
    if(!(i % 2)) evens++;
    else odds++;
    if(!(i % 4)) fours++;
}
```

Above the odds incrementer is corrolated to the evens incrementer (if not one then the other) and the fours incrementer is correlated to the evens incrementer wherein if fours is incremented, then events was also incremented. 

```
