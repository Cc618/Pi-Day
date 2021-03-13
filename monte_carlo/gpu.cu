#include <curand.h>

#include "gpu.h"

#define SEED 1234567ull

#define simpleRand(seed) \
    { seed = (1103515245ull * seed + 12345ull) % (1ull << 31); }

__global__ void computePi(size_t t, size_t resolution, num radius, size_t *results) {
    num threadid = blockIdx.x * blockDim.x + threadIdx.x;
    num seed = SEED + threadid + t * (10'000'000);

    for (size_t i = 0; i < resolution; ++i) {
        // Draw random x and y
        simpleRand(seed);
        num x = seed % radius;
        simpleRand(seed);
        num y = seed % radius;

        // If the point is within the circle (top right quarter)
        if (x * x + y * y <= RADIUS * RADIUS) ++results[threadid];
    }
}

size_t gpuPi(size_t times, size_t resolution, num radius, size_t blocks,
             size_t threads) {
    size_t cpupi = 0;
    size_t nparallel = blocks * threads;

    size_t *results;
    cudaMallocManaged(&results, nparallel * sizeof(size_t));

    // Multiply pi by 4
    times *= 4;

    for (size_t t = 0; t < times; ++t) {
        for (size_t i = 0; i < nparallel; ++i) results[i] = 0;

        computePi<<<blocks, threads>>>(t, resolution, radius, results);
        cudaDeviceSynchronize();

        for (size_t i = 0; i < nparallel; ++i) cpupi += results[i];
    }

    cudaFree(results);

    return cpupi;
}
