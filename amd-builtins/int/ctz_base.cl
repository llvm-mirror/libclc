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

#include "ibuiltins.h"

#if __OPENCL_C_VERSION__ >= 200

// ----- [u]char -----

__attribute__((overloadable, always_inline)) char
ctz(char x)
{
    uint z = __hsail_lastbit_u32((uint)x & 0xffU);
    return x == 0 ? 8U : z;
}

__attribute__((overloadable, always_inline)) uchar
ctz(uchar x)
{
    uint z = __hsail_lastbit_u32((uint)x);
    return x == 0 ? 8U : z;
}

// ----- [u]short -----

__attribute__((overloadable, always_inline)) short
ctz(short x)
{
    uint z = __hsail_lastbit_u32((uint)x & 0xffffU);
    return x == 0 ? 16U : z;
}

__attribute__((overloadable, always_inline)) ushort
ctz(ushort x)
{
    uint z = __hsail_lastbit_u32((uint)x);
    return x == 0 ? 16U : z;
}

// ----- [u]int -----

__attribute__((always_inline)) static uint
myctz4(uint x)
{
    uint z = __hsail_lastbit_u32(x);
    return x == 0U ? 32 : z;
}

extern __attribute__((overloadable, alias("myctz4"))) uint ctz(uint);
extern __attribute__((overloadable, alias("myctz4"))) int ctz(int);

// ----- [u]long -----

__attribute__((always_inline)) static ulong
myctz8(ulong x)
{
    uint xhi = x >> 32;
    uint xlo = (uint)x;
    uint zhi = __hsail_lastbit_u32(xhi);
    uint zlo = __hsail_lastbit_u32(xlo);
    uint chi = (xhi == 0 ? 32 : zhi) + 32;
    return xlo == 0 ? chi : zlo;
}

extern __attribute__((overloadable, alias("myctz8"))) ulong ctz(ulong);
extern __attribute__((overloadable, alias("myctz8"))) long ctz(long);

#endif
