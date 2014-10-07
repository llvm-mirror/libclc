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
rhadd(char x, char y)
{
    // compiler automatically casts larger
    return (x + y + 1) >> 1;
}

// ----- uchar -----

__attribute__((overloadable, always_inline)) uchar
rhadd(uchar x, uchar y)
{
    // compiler automatically casts larger
    return (x + y + 1U) >> 1;
}

// ----- short -----

__attribute__((overloadable, always_inline)) short
rhadd(short x, short y)
{
    // compiler automatically casts larger
    return (x + y + 1) >> 1;
}

// ----- ushort -----

__attribute__((overloadable, always_inline)) ushort
rhadd(ushort x, ushort y)
{
    // compiler automatically casts larger
    return (x + y + 1U) >> 1;
}

// ----- int -----

__attribute__((overloadable, always_inline)) int
rhadd(int x, int y)
{
    int cin = (x | y) & 1;
    return (x >> 1) + (y >> 1) + cin;
}

// ----- uint -----
__attribute__((overloadable, always_inline)) uint
rhadd(uint x, uint y)
{
    uint cin = (x | y) & 1;
    return (x >> 1) + (y >> 1) + cin;
}

// ----- long -----
__attribute__((overloadable, always_inline)) long
rhadd(long x, long y)
{
    long cin = (x | y) & 1;
    return (x >> 1) + (y >> 1) + cin;
}

// ----- ulong -----

__attribute__((overloadable, always_inline)) ulong
rhadd(ulong x, ulong y)
{
    ulong cin = (x | y) & 1;
    return (x >> 1) + (y >> 1) + cin;
}

