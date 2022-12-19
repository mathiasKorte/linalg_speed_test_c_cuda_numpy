#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <cuda.h>

__global__ void matmul(float *A, float *B, float *C, int n)
{
    int i = blockIdx.x;
    int j = threadIdx.x;

    C[i * n + j] = 0;
    for (int k = 0; k < n; k++)
    {
        C[i * n + j] += A[i * n + k] * B[k * n + j];
    }
}

int main()
{
    srand(time(NULL));

    int n = 1000;
    size_t size = sizeof(float) * n * n;

    float *A = (float *)malloc(size);
    float *B = (float *)malloc(size);
    float *C = (float *)malloc(size);

    float *d_A;
    float *d_B;
    float *d_C;

    cudaMalloc((void **)&d_A, size);
    cudaMalloc((void **)&d_B, size);
    cudaMalloc((void **)&d_C, size);

    for (int i = 0; i < n * n; i++)
    {
        A[i] = (float)rand() / (float)(RAND_MAX);
        B[i] = (float)rand() / (float)(RAND_MAX);
    }

    cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice);

    clock_t t;
    t = clock();

    matmul<<<n, n>>>(d_A, d_B, d_C, n);

    t = clock() - t;
    double time_taken = ((double)t) / CLOCKS_PER_SEC; // in seconds
    printf("\nC=A@B took %f seconds to execute \n", time_taken);

    cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost);

    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(A);
    free(B);
    free(C);
}
