# Lecture 004 - Performance

Equation 

    Execution Time = IC * CPI * CT 

- __IC__ Instruction count, we can effect this
- __CPI__ Cycles per instruction, we can effect this as well 
- __CT__ Cycle time and can effect this as well
- Compilers can reduce instructions for the same instruction (but never devieate from what to accomplish

__Speedup__ = baseline ET / Improved ET 

    = 1 / ((X/S) + (1-X)); X fraction of ET we can speed up, S how many times we can speed up

__Example__ A game loads a map in 10 minutes and spends 20% of time in integer instructions (single cycle operations). How much fast must the integer unit be to make the loading 5 minutes faster? 

    Speedup is 2 = (10 minutes baseline / 5 minutes desired speedup)
    2 = 1 / ((20% / S) + (1 - 20%))   <--- amdahl's law
    S = -0.66 <--- correct answer but impossible. 

Amdahl's Corollary 1: to maximize S, 1 / (1-x) = S max
Amdahl's Corollary 2: make the common case fast (where you focus on specifically most time consuming)

- Optimizations can negatively impact something. 

__Example__ Some program spends 90% execution time (ET) in A and 10% in B. An optimization accelerates A by 9x but hurts B by 10x

    Time_new = (Time_orig * 0.9) / 9 + Time_orig * 0.1 * 10
             = 1.1 * Time_orig
    Speedup = Time_orig / (1.1 * Time_orig) = 0.91  <--- optimization slows down program and makes execution time longer

Amdahl's Corollary 3: S in amdahl's law can be used to measure affect of using multiple processors and threading with an application. 

    Speedup_parallelized = 1 / ((x/s) + (1-x)); S = # of cores

__Example__ Add cores or features? A key customer can use up to 4 cpus for 40% of their application. Increase number of processors 1 -> 4 or use 2 cores but add features that will allow usage of 2 cores for 80% execution? 

    Speedup_quad = 1 / ((x/s) + (1-x))                      Speedup_dual = 1 / ((x/s) + (1-x))
                 = 1 / ((40%/4) + (1-40%))                               = 1 / ((80%/2) + (1-80%))
                 = 1.43                                                  = 1.67

__Example__ A program has 30% of execution time (ET) in memory access. L1 cache can speed up 80% of memory operations by a factor of 4. L2 cache can speedup 50% of the remaining 20% by a factor of 2. What is the total speed up? 

    Speedup = 1 / ((x/s) + (1-x))
            = 1 / (((30% * 80%)/4 + (30% * 50% * 20%)/2) + (1 - (30% * 80% + 30% * 50% * 20%)))
            = 1 / (24%/4 + 3%/2 + (1 - 27%)) = 1.24

_In general, the `x/s` parts are summed across all instances. Just make sure you are doing proper percentages (80% of the 30% of ET is L1 cache, so 30% * 80% and 30% * 50% * 20%_

### Power and Energy 

- __Myth__ Lowering power consumption helps extend battery life __Facts__ Battery is storing energy. Energy = Power * Execution TIme. 
  - Power is largest contributor to heat and can be divided into static and dynamic power. 
  - _Reminder_ Dynamic power is the power required to transition a transistor between states. Static is the power required to maintain a state. 
  - Voltage is cubically proportionate to the power, (and frequency is linearlly proportionate to voltage), so if you double the frequency, the power consumtion is increased 8-fold. 
