/*
 * Copyright (c) 2014 Advanced Micro Devices, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#include "math64.h"

__attribute__((overloadable, always_inline)) double
nextafter(double x, double y)
{
    long ix = as_long(x);
    long ax = ix & 0x7fffffffffffffffL;
    long mx = 0x8000000000000000L - ix;
    mx = ix < 0 ? mx : ix;
    long iy = as_long(y);
    long ay = iy & 0x7fffffffffffffffL;
    long my = 0x8000000000000000L - iy;
    my = iy < 0 ? my : iy;
    long t = mx + (mx < my ? 1 : -1);
    long r = 0x8000000000000000L - t;
    r = t < 0 ? r : t;
    r = ax > 0x7ff0000000000000L ? ix : r;
    r = ay > 0x7ff0000000000000L ? iy : r;
    r = (ax|ay) == 0L | ix == iy ? iy : r;
    return as_double(r);
}

