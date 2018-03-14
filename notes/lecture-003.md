# Lecture 003 - Performance

### Recap

- Basic execution model is Von Neumann model (static data is in secondary storage and loaded to main memory where it is executed by the alu)
- Von Neumann allows a computer to be reprogrammable
- Instruction steps: _Fetch, Decode, Execute, Memory access, Write back_
- ISA: Contract between hardware and software so software produces code hardware can execute

### Performance

##### Execution Time

- The time required to execute a program depends on the count of instructions, cycles per instruction, and time required per cycle
- `__ET = IC * CPI * CT__`
  - __I__ nstruction count: Instruction / program
  - __C__ ycles __P__ er __I__ nstruction: Cycles / Instruciton
  - __C__ ycle __T__ ime: Seconds / Cycle

__Example__ 500000 instruction, 20% of them are load/store with an average __CPI__ of 6 cycles, while all other instructions are __CPI__ of 1. Processor is 2 GHz. How long is instruction time?

    500000 * (0.8 + 0.2*6) * 0.5 ns = 500000 ns

##### Speedup

- Compare the relative performance of the baseline system and the improved system:
- `execution time baseline/ execution time improved`

__Example__ Same as above example, but CPU clock rate is increased to 4 GHz and CPI for load/store is 12.

    500000 * (0.8 + 0.2*12) * 0.25 ns = 400000 ns
    Speed up = Time old / Time new = 500000 / 400000 = 1.25

- __Amdahl's Law__ `speedup = 1 / ((x/s) + (1-x))` where x is fraction of execution time that we can speed up in target app while S is how many times we can speed up x

__Example__ In the above examples, we can calculate the amount of time taken for load/store and for other operations. 

    500000 * (0.2 * 6) * 0.5 ns = 300000 ns (60%)
    500000 * *0.8 * 1) * 0.5 ns = 200000 ns (40%) 
    speedup = 1 / ((0.4 / 2) + (1-0.4)) = 1.25 (we doubled execution speed to 4GHz and 

__Example__ A map on a game loads in 10 minutes and spends 20% of this time on integer (1 cycle) instructions. How much faster must the integer unit be to make the map loading 1 minute faster? 

    10/9 is the speed up we want 
    10/9 = 1 / ((0.2 / s) + (1 - 0.2)), s = 2

