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

#ifdef USE_POPCNT
#pragma OPENCL EXTENSION cl_amd_popcnt : enable
#endif

// ----- [u]char -----

__attribute__((always_inline)) static char
__POPCI1(char x)
{
    return __amdil_count_bits_i32((int)x & 0xff);
}

#ifdef USE_POPCNT
extern __attribute__((overloadable, alias("__POPCI1"))) char popcnt(char);
#endif

extern __attribute__((overloadable, alias("__POPCI1"))) char popcount(char);

__attribute__((always_inline)) static uchar
__POPCU1(uchar x)
{
    return __amdil_count_bits_i32((int)x);
}

#ifdef USE_POPCNT
extern __attribute__((overloadable, alias("__POPCU1"))) uchar popcnt(uchar);
#endif

extern __attribute__((overloadable, alias("__POPCU1"))) uchar popcount(uchar);


// ----- [u]short -----

__attribute__((always_inline)) static short
__POPCI2(short x)
{
    return __amdil_count_bits_i32((int)x & 0xffff);
}

#ifdef USE_POPCNT
extern __attribute__((overloadable, alias("__POPCI2"))) short popcnt(short);
#endif

extern __attribute__((overloadable, alias("__POPCI2"))) short popcount(short);

__attribute__((always_inline)) static ushort
__POPCU2(ushort x)
{
    return __amdil_count_bits_i32((int)x);
}

#ifdef USE_POPCNT
extern __attribute__((overloadable, alias("__POPCU2"))) ushort popcnt(ushort);
#endif

extern __attribute__((overloadable, alias("__POPCU2"))) ushort popcount(ushort);


// ----- [u]int -----

__attribute__((always_inline)) static int
__POPCI4(int x)
{
    return __amdil_count_bits_i32(x);
}

#ifdef USE_POPCNT
extern __attribute__((overloadable, alias("__POPCI4"))) int popcnt(int);
extern __attribute__((overloadable, alias("__POPCI4"))) uint popcnt(uint);
#endif

extern __attribute__((overloadable, alias("__POPCI4"))) int popcount(int);
extern __attribute__((overloadable, alias("__POPCI4"))) uint popcount(uint);

// ----- [u]long -----

__attribute__((always_inline)) static long
__POPCI8(long x)
{
    int chi = __amdil_count_bits_i32((int)(x >> 32));
    int clo = __amdil_count_bits_i32((int)(x & 0xffffffffL));
    return chi + clo;
}

#ifdef USE_POPCNT
extern __attribute__((overloadable, alias("__POPCI8"))) long popcnt(long);
extern __attribute__((overloadable, alias("__POPCI8"))) ulong popcnt(ulong);
#endif

extern __attribute__((overloadable, alias("__POPCI8"))) long popcount(long);
extern __attribute__((overloadable, alias("__POPCI8"))) ulong popcount(ulong);

