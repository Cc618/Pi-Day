#pragma once

#include "pi.h"

size_t gpuPi(size_t times, size_t resolution, num radius, size_t blocks,
             size_t threads);
