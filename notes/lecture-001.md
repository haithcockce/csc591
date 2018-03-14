# Lecture 001 - Intro

- Introductions and dreams of students

- __Computer Architecture__ The manner in which the components of a computer or computer system are organized and integrated

### What are inside computers? Review of Architecture

- All computers have extremely similar builds. Memory, CPU, and storage reside in all systems regardless of desktop, mobile, or server builds
- __Von Neumann Architecture__
  - computers are built of an arithmetic logic unit, has a spot of temporary storage, and an area from secondary storage.
  - Static data (programs) are loaded from secondary storage to main memory. Then that is loaded to CPU for execution and main memory is used to store intermediary results.
  - _Reprogrammable_ A computer can do completely different operations based on loading programs rather than being hard coded to do one thing (like a microwave kinda)

- __Memory__
  - An array of circuits that can store only 0's and 1's

- __Two's Compliment__
  - Used to represent negative numbers and allows nearly equal coverage of all numbers without reimplementation for a second set of numbers

- __Floating Point Numbers__
  - from left to right: sign bit, exponent, mantissa (actual integer)

- __ALU__ arithmetic logic unit to perform math operations
- __Register File__ Cache! Well kinda.
- __Clock__ Synchronization method of ALU, Memory, etc

#### CPU

- Stages: _Instruction fetch_, _decode_, _execute_, _memory access_, _write back_, _determine next PC_
- Know where you are executing by _PC_ or program counter. `%rip` in x86
- __Moore's Law__ we can double the amount of transistors into the same area every year.  
  - Performance improvement occurs because we can increase clock speed since things are closer together
  - Limited in actual speed increase due to physical limitations and heat dissapation
  - _Active Power_ transitioning between states (0/1)
  - _Static Power_ Power used to refill things due to leakage (electrons die off and things need to be refilled for example in RAM). The smaller the space between transistors, the more power is consumed for static power.

#### Heterogeneous Architecture

- Simply architecture where multiple bits of hardware operate to process instructions. For example, GPUs being used to offload some computations to another processing unit
