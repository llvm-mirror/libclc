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

// ----- char -----

__attribute__((overloadable, always_inline)) char
hadd(char x, char y)
{
    // compiler automatically casts larger
    return (x + y) >> 1;
}

// ----- uchar -----

__attribute__((overloadable, always_inline)) uchar
hadd(uchar x, uchar y)
{
    // compiler automatically casts larger
    return (x + y) >> 1;
}

// ----- short -----

__attribute__((overloadable, always_inline)) short
hadd(short x, short y)
{
    // compiler automatically casts larger
    return (x + y) >> 1;
}

// ----- ushort -----

__attribute__((overloadable, always_inline)) ushort
hadd(ushort x, ushort y)
{
    // compiler automatically casts larger
    return (x + y) >> 1;
}

// ----- int -----

__attribute__((overloadable, always_inline)) int
hadd(int x, int y)
{
    int cin = (x & 1) & y;
    return (x >> 1) + (y >> 1) + cin;
}

// ----- uint -----

__attribute__((overloadable, always_inline)) uint
hadd(uint x, uint y)
{
    uint cin = (x & 1U) & y;
    return (x >> 1) + (y >> 1) + cin;
}

// ----- long -----

__attribute__((overloadable, always_inline)) long
hadd(long x, long y)
{
    long cin = (x & 1) & y;
    return (x >> 1) + (y >> 1) + cin;
}

// ----- ulong -----

__attribute__((overloadable, always_inline)) ulong
hadd(ulong x, ulong y)
{
    ulong cin = (x & 1) & y;
    return (x >> 1) + (y >> 1) + cin;
}

