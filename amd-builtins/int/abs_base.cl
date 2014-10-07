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

__attribute__((overloadable, always_inline)) uchar
abs(char x)
{
    char s = x >> 7;
    return (uchar)((x + s) ^ s);
}


// ----- uchar -----

__attribute__((overloadable, always_inline)) uchar
abs(uchar x)
{
    return x;
}

// ----- short -----

__attribute__((overloadable, always_inline)) ushort
abs(short x)
{
    short s = x >> 15;
    return (ushort)((x + s) ^ s);
}

// ----- ushort -----

__attribute__((overloadable, always_inline)) ushort
abs(ushort x)
{
    return x;
}

// ----- int -----

__attribute__((overloadable, always_inline)) uint
abs(int x)
{
    int s = x >> 31;
    return (uint)((x + s) ^ s);
}

// ----- uint -----

__attribute__((overloadable, always_inline)) uint
abs(uint x)
{
    return x;
}

// ----- long -----

__attribute__((overloadable, always_inline)) ulong
abs(long x)
{
    long s = x >> 63;
    return (ulong)((x + s) ^ s);
}

// ----- ulong -----

__attribute__((overloadable, always_inline)) ulong
abs(ulong x)
{
    return x;
}

