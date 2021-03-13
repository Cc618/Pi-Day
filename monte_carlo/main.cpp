#include <iostream>
#include <random>
#include "pi.h"
#include "gpu.h"

using namespace std;

size_t cpuPi() {
    default_random_engine gen;
    uniform_int_distribution<num> dis(0, RADIUS);

    size_t pi = 0;
    for (size_t i = 0; i < RESOLUTION; ++i) {
        num x = dis(gen);
        num y = dis(gen);

        if (x * x + y * y <= RADIUS * RADIUS) ++pi;
    }

    // Multiply by 4 since only 1/4th of the circle is used
    pi *= 4;

    return pi;
}

int main() {
    cout << "CPU : " << cpuPi() << endl;
    cout << "GPU" << endl;
    size_t resolution = RESOLUTION;
    size_t blocks = 100;
    size_t threads = 100;
    size_t times = 10;

    cout << "Number of samples : " << (4 * times * blocks * threads / 1000) *
        (RESOLUTION / 1000) << " millions" << endl;

    auto pi = gpuPi(times, resolution, RADIUS, blocks, threads);

    cout << "Pi : " << pi << endl;

    return 0;
}
