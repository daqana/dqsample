/*
 * A C++ implementation methods and benchmarks for random numbers in a range
 * 32-bit version: https://github.com/imneme/bounded-rands/bounded32.cpp
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2018 Melissa E. O'Neill
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
#ifndef DQSAMPLE_H
#define DQSAMPLE_H 1

#include <cstdint>

inline uint32_t bounded_rand32(uint32_t (*random32)(void), uint32_t range) {
    uint32_t x = random32();
    uint64_t m = uint64_t(x) * uint64_t(range);
    uint32_t l = uint32_t(m);
    if (l < range) {
	uint32_t t = -range;
	if (t >= range) {
	    t -= range;
	    if (t >= range)
		t %= range;
	}
	while (l < t) {
	    x = random32();
	    m = uint64_t(x) * uint64_t(range);
	    l = uint32_t(m);
	}
    }
    return m >> 32;
}

#endif // DQSAMPLE_H
