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
max(char x, char y)
{
    return __amdil_imax_i32(x, y);
}

// ----- uchar -----

__attribute__((overloadable, always_inline)) uchar
max(uchar x, uchar y)
{
    return __amdil_umax_u32(x, y);
}

// ----- short -----

__attribute__((overloadable, always_inline)) short
max(short x, short y)
{
    return __amdil_imax_i32(x, y);
}

// ----- ushort -----

__attribute__((overloadable, always_inline)) ushort
max(ushort x, ushort y)
{
    return __amdil_umax_u32(x, y);
}

// ----- int -----

__attribute__((overloadable, always_inline)) int
max(int x, int y)
{
    return __amdil_imax_i32(x, y);
}

// ----- uint -----

__attribute__((overloadable, always_inline)) uint
max(uint x, uint y)
{
    return __amdil_umax_u32(x, y);
}

// ----- long -----

// __hsail_ intrinsics which has no __amdil_ equivalents.
extern __attribute__((pure)) long  __hsail_max_s64(long,  long);
extern __attribute__((pure)) ulong  __hsail_max_u64(ulong,  ulong);

__attribute__((overloadable, always_inline)) long
max(long x, long y)
{
    return __hsail_max_s64(x, y);
}

// ----- ulong -----

__attribute__((overloadable, always_inline)) ulong
max(ulong x, ulong y)
{
    return __hsail_max_u64(x, y);
}

