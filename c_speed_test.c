#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main()
{
    setbuf(stdout, NULL);
    srand(time(NULL));

    int n = 1000;

    float *A = malloc(sizeof(float) * n * n);
    float *B = malloc(sizeof(float) * n * n);
    float *C = malloc(sizeof(float) * n * n);

    for (int i = 0; i < n * n; i++)
    {
        A[i] = (float)rand() / (float)(RAND_MAX);
        B[i] = (float)rand() / (float)(RAND_MAX);
    }

    clock_t t;
    t = clock();
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            C[i * n + j] = 0;
            for (int k = 0; k < n; k++)
            {
                C[i * n + j] += A[i * n + k] * B[k * n + j];
            }
        }
    }
    t = clock() - t;
    double time_taken = ((double)t) / CLOCKS_PER_SEC; // in seconds
    printf("C=A@B took %f seconds to execute \n", time_taken);
}
