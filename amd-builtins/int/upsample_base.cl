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

// ----- (u)char -----

__attribute__((overloadable, always_inline)) ushort
upsample(uchar hi, uchar lo)
{
    return ((ushort)hi << 8) | lo;
}

__attribute__((overloadable, always_inline)) short
upsample(char hi, uchar lo)
{
    return ((short)hi << 8) | lo;
}

// ----- (u)short -----

__attribute__((overloadable, always_inline)) uint
upsample(ushort hi, ushort lo)
{
    return ((uint)hi << 16) | lo;
}

__attribute__((overloadable, always_inline)) int
upsample(short hi, ushort lo)
{
    return ((int)hi << 16) | lo;
}

// ----- (u)int -----

__attribute__((overloadable, always_inline)) ulong
upsample(uint hi, uint lo)
{
    return ((ulong)hi << 32) | lo;
}

__attribute__((overloadable, always_inline)) long
upsample(int hi, uint lo)
{
    return ((long)hi << 32) | lo;
}

