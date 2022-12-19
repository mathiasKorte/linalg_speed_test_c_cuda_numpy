import numpy as np
import time

n=1000
A = np.random.rand(n,n)
B = np.random.rand(n,n)

start = time.time()
C = A@B
end = time.time()

print("Numpy:  C=A@B took ", end - start, " seconds to execute")






