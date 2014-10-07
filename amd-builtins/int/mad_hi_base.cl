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
mad_hi(char a, char b, char c)
{
    return (char)(((int)a * (int)b) >> 8) + c;
}

// ----- uchar -----

__attribute__((overloadable, always_inline)) uchar
mad_hi(uchar a, uchar b, uchar c)
{
    return (uchar)(((uint)a * (uint)b) >> 8) + c;
}

// ----- short -----

__attribute__((overloadable, always_inline)) short
mad_hi(short a, short b, short c)
{
    return (short)(((int)a * (int)b) >> 16) + c;
}

// ----- ushort -----

__attribute__((overloadable, always_inline)) ushort
mad_hi(ushort a, ushort b, ushort c)
{
    return (ushort)(((uint)a * (uint)b) >> 16) + c;
}

// ----- int -----

__attribute__((overloadable, always_inline)) int
mad_hi(int a, int b, int c)
{
    return (int)(((long)a * (long)b) >> 32) + c;
}

// ----- uint -----

__attribute__((overloadable, always_inline)) uint
mad_hi(uint a, uint b, uint c)
{
    return (uint)(((ulong)a * (ulong)b) >> 32) + c;
}


// ----- long -----

__attribute__((overloadable, always_inline)) long
mad_hi(long a, long b, long c)
{
    return _gpu_mul_hi_i64(a, b) + c;
}

// ----- ulong -----

__attribute__((overloadable, always_inline)) ulong
mad_hi(ulong a, ulong b, ulong c)
{
    return _gpu_mul_hi_u64(a, b) + c;
}

