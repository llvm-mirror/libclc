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
mad_sat(char a, char b, char c)
{
    int s = (int)a * (int)b + (int)c;
    return min(127, max(-128, s));
}

// ----- uchar -----

__attribute__((overloadable, always_inline)) uchar
mad_sat(uchar a, uchar b, uchar c)
{
    uint s = (uint)a * (uint)b + (uint)c;
    return min(255U, s);
}

// ----- short -----

__attribute__((overloadable, always_inline)) short
mad_sat(short a, short b, short c)
{
    int s = (int)a * (int)b + (int)c;
    return min(32767, max(-32768, s));
}

// ----- ushort -----

__attribute__((overloadable, always_inline)) ushort
mad_sat(ushort a, ushort b, ushort c)
{
    uint s = (uint)a * (uint)b + (uint)c;
    return min(65535U, s);
}

// ----- int -----

__attribute__((overloadable, always_inline)) int
mad_sat(int a, int b, int c)
{
    int lo = a * b;
    int hi = __amdil_imul_high_i32(a, b);
    int t = lo + c;
    hi += c > 0 & 0x7fffffff - c < lo;
    hi -= c < 1 & (int)0x80000000 - c > lo;
    lo = t;

    lo = hi < 0 & (hi != -1 | lo >= 0) ? 0x80000000 : lo;
    lo = hi >= 0 & (hi > 0 | lo < 0) ? 0x7fffffff : lo;
    return lo;
}

// ----- uint -----
__attribute__((overloadable, always_inline)) uint
mad_sat(uint a, uint b, uint c)
{
    uint lo = a * b;
    uint hi = __amdil_umul_high_u32(a, b);
    uint t = lo + c;
    hi += 0xffffffff - c < lo;
    lo = t;
    return hi > 0U ? 0xffffffff : lo;
}

// ----- long -----

__attribute__((overloadable, always_inline)) long
mad_sat(long a, long b, long c)
{
    ulong a0 = (ulong)a & 0xffffffffUL;
    long a1 = a >> 32;
    ulong b0 = (ulong)b & 0xffffffffUL;
    long b1 = b >> 32;
    ulong s0 = a0*b0;
    long t = a1*b0 + (s0 >> 32);
    long s1 = t & 0xffffffffL;
    long s2 = t >> 32;
    s1 = a0*b1 + s1;
    long lo = (s1 << 32) | (s0 & 0xffffffffL);
    long hi = a1*b1 + s2 + (s1 >> 32);

    t = lo + c;
    hi += c > 0L & 0x7fffffffffffffffL - c < lo;
    hi -= c < 1L & (long)0x8000000000000000L - c > lo;
    lo = t;

    lo = hi < 0L & (hi != -1L | lo >= 0L) ? 0x8000000000000000L : lo;
    lo = hi >= 0L & (hi > 0L | lo < 0L) ? 0x7fffffffffffffffL : lo;

    return lo;
}

// ----- ulong -----

__attribute__((overloadable, always_inline)) ulong
mad_sat(ulong a, ulong b, ulong c)
{
    ulong a0 = a & 0xffffffffUL;
    ulong a1 = a >> 32;
    ulong b0 = b & 0xffffffffUL;
    ulong b1 = b >> 32;
    ulong s0 = a0*b0;
    ulong t = a1*b0 + (s0 >> 32);
    ulong s1 = t & 0xffffffffUL;
    ulong s2 = t >> 32;
    s1 = a0*b1 + s1;
    ulong lo = (s1 << 32) | (s0 & 0xffffffffUL);
    ulong hi = a1*b1 + s2 + (s1 >> 32);

    t = lo + c;
    hi += 0xffffffffffffffffUL - c < lo;
    lo = t;

    return hi > 0UL ? 0xffffffffffffffffUL : lo;
}

