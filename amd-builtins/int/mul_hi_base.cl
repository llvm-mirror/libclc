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

// ----- char -----

__attribute__((overloadable, always_inline)) char
mul_hi(char x, char y)
{
    return (char)(((int)x * (int)y) >> 8);
}

// ----- uchar -----

__attribute__((overloadable, always_inline)) uchar
mul_hi(uchar x, uchar y)
{
    return (uchar)(((uint)x * (uint)y) >> 8);
}

// ----- short -----

__attribute__((overloadable, always_inline)) short
mul_hi(short x, short y)
{
    return (short)(((int)x * (int)y) >> 16);
}

// ----- ushort -----

__attribute__((overloadable, always_inline)) ushort
mul_hi(ushort x, ushort y)
{
    return (ushort)(((uint)x * (uint)y) >> 16);
}

// ----- int -----

__attribute__((overloadable, always_inline)) int
mul_hi(int x, int y)
{
    return __amdil_imul_high_i32(x, y);
}

// ----- uint -----

__attribute__((overloadable, always_inline)) uint
mul_hi(uint x, uint y)
{
    return __amdil_umul_high_u32(x, y);
}

extern __attribute__((pure)) long  __hsail_mulhi_s64(long, long);
extern __attribute__((pure)) ulong __hsail_mulhi_u64(ulong, ulong);

// ----- long -----

__attribute__((overloadable, always_inline)) long
mul_hi(long x, long y)
{
    return __hsail_mulhi_s64(x, y);
}

// ----- ulong -----

__attribute__((overloadable, always_inline)) ulong
mul_hi(ulong x, ulong y)
{
    return __hsail_mulhi_u64(x, y);
}

