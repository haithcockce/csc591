# CSC 571-604: Computer Architectures and Multiprocessors

### Contents 

- notes
- projects
- assignments

### CUDA 9.1 CHANGES

1. 
 - `/usr/local/cuda/include/crt/host_config.h:121`
 - comment out `#error -- unsupported GNU version! gcc versions later than 6 are not supported!`

2.  
 - `/usr/include/bits/floatn.h` around line 37, added the following

```c
#ifdef __CUDACC__
#define __HAVE_FLOAT128 0
#endif
```
