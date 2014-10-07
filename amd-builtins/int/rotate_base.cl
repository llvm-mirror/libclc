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

// ----- [u]char -----

__attribute__((always_inline)) static uchar
__ROTI1(uchar x, uchar y) 
{
    y &= 0x7;
    return (x << y) | (x >> (8-y));
}

extern __attribute__((overloadable, alias("__ROTI1"))) uchar rotate(uchar, uchar);
extern __attribute__((overloadable, alias("__ROTI1"))) char rotate(char, char);

// ----- [u]short -----

__attribute__((always_inline)) static ushort
__ROTI2(ushort x, ushort y) 
{
    y &= 0xf;
    return (x << y) | (x >> (16-y));
}

extern __attribute__((overloadable, alias("__ROTI2"))) ushort rotate(ushort, ushort);
extern __attribute__((overloadable, alias("__ROTI2"))) short rotate(short, short);

// ----- [u]int -----
extern __attribute__((const)) uint __hsail_bitalign_b32(uint, uint, uint);

__attribute__((always_inline)) static uint
__ROTI4(uint x, uint y) 
{
    return __hsail_bitalign_b32(x, x, (-y) & 0x1f);
}

extern __attribute__((overloadable, alias("__ROTI4"))) uint rotate(uint, uint);
extern __attribute__((overloadable, alias("__ROTI4"))) int rotate(int, int);

// ----- [u]long -----

__attribute__((always_inline)) static ulong
__ROTI8(ulong x, ulong y) 
{
    y &= 0x3f;
    return (x << y) | (x >> (64-y));
}

extern __attribute__((overloadable, alias("__ROTI8"))) ulong rotate(ulong, ulong);
extern __attribute__((overloadable, alias("__ROTI8"))) long rotate(long, long);

