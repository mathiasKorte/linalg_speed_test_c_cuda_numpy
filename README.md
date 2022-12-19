# linalg_speed_test_c_cuda_numpy
measure matmul speed in different languagues: C, Cuda, Python/Numpy

measure compute time for matrix-matrix-multiplication (2 1000x1000 matricies at default)

requirements: gcc, nvcc (cuda compiler), numpy

execute:
```
gcc -o c_speed_test c_speed_test.c
./c_speed_test

gcc -o c_speed_test_optimized c_speed_test.c -O3 -funroll-loops
./c_speed_test_optimized

nvcc -o cuda_speed_test cuda_speed_test.c
./cuda_speed_test

python numpy_speed_test.py
```
