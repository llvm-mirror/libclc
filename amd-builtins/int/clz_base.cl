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

__attribute__((always_inline)) static uint
myclz4(uint x)
{
    uint z =  __hsail_firstbit_u32(x);
    return x == 0U ? 32U : z;
}

// ----- [u]char -----

__attribute__((overloadable, always_inline)) char
clz(char x)
{
    return myclz4((uint)x & 0xffU) - 24U;
}

__attribute__((overloadable, always_inline)) uchar
clz(uchar x)
{
    return myclz4((uint)x) - 24U;
}

// ----- [u]short -----

__attribute__((overloadable, always_inline)) short
clz(short x)
{
    return myclz4((uint)x & 0xffffU) - 16U;
}

__attribute__((overloadable, always_inline)) ushort
clz(ushort x)
{
    return myclz4((uint)x) - 16U;
}

// ----- [u]int -----

extern __attribute__((overloadable, alias("myclz4"))) uint clz(uint);
extern __attribute__((overloadable, alias("myclz4"))) int clz(int);

// ----- [u]long -----

__attribute__((always_inline)) static ulong
myclz8(ulong x)
{
    uint xlo = (uint)x;
    uint xhi = (uint)(x >> 32);
    uint zlo = __hsail_firstbit_u32(xlo);
    uint zhi = __hsail_firstbit_u32(xhi);
    uint clo = (xlo == 0 ? 32 : zlo) + 32;
    return xhi == 0 ? clo : zhi;
}

extern __attribute__((overloadable, alias("myclz8"))) ulong clz(ulong);
extern __attribute__((overloadable, alias("myclz8"))) long clz(long);

