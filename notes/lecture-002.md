# Lecture 002 - Recap on ISA

### Recap

- Nearly all computers have von neumann architecture
- ALU is where computations occur, main memory is for intermediate results, secondary storage is for main storage.
- _Fetch_, _decode_, _Execute_, _Memory access_, _writeback_, _update pc_

### ISA

- __ISA__ Contract between hardware and software? Defines set of operations a computer/processor can execute

### Assembly

- Human readible representation of ISA and has a direct mapping between instructions and code
- Compilers convert this code to assembly either gcc with c/c++ for your x86 system or java creating a .class file for JVM. Also done on the fly with interpreters which still compiles code to assembly whatever that may be

### What should be in ISA

- _Instructions_ arithmetic, execution flow control, data access instructions
- _Architectural States_ Current execution result of a program including Registers, memory, and program counter (PC)

###### CISC vs RISC

- __CISC__ Complex Instruction Set Computer
  - Many powerful and complex instructions and includes x86
  - More cycles to execute the same instruction but can do arithmetic and data access at the same time
- __RISC__ Reduced Instruction Set Computer
  - ARM and MIPS
  - more simple operations per task with fewer cycles per instruction to execute

### ARMv8 ISA

- 32-bits long instructions
- 6 different formats
- 32 64-bit registers
- XZR/X31 should always be 0
- 64-bit address spaces, but addressible only 48 bits
- 4 flags, _N_ negative, _Z_ zero, _V_ overflow, _C_ carryout (9+1 would be 10, so a carryout)
- All objects are aligned with a multiple of 8, but structure objects will never be reordered. Since all addresses must be aligned as a multiple of 8, some structures may have padding between their members!

__Example__

```assembly
1000 SUBS XZR, X3, X1
1004 B.EQ #20000
```

This will increase the PC but register `XZR` _will not_ be loaded. It conceptually works like `/dev/null` and provides a "zero register" and is often used like `/dev/zero` conceptually

__Example__

```assembly
10000 SLDUR X1, [X2, #200]
10004 SBS XZR, X1, XZR
...
60200 80000
```

The PC will be incremented after executing the first instruction, and `X1` should have 80000

__Example__

Translate the following C into ARM ASM

```c
for(int i = 0; i < 100; i++) {
    sum += A[i];  // A[0] is in X0
}  
```

Thinking it through:

1. Initialize everything. Register for `i` needs to be 0, need a `sum` register as well. We do not need to do anything for `A[]` as this will require a load from memory which wipes out the register anyway. Also don't need a comparator register (`i < 100`). And array starting address is already in `X0`
2. Check the looping condition and branch if needed

  2.a If the check failed (IE we are greater than 100 or equal to), branch to beyond the loop body

  2.b Assume the check succeeded otherwise (IE nothing needed further for this)

3. Read from memory at `A[i]`
4. Increment `sum` register by `A[i]` temp register
5. Increment `i` register
6. Branch back _unconditionally_ to the check (3.)

```assembly
AND X1, X1, XZR  // X1 is i
AND X2, X2, XZR  // X2 is sum
LOOP:
SUBS XZR, X1, #100

```
