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

__attribute__((overloadable, always_inline)) uchar
abs_diff(char x, char y)
{
    int ix = x;
    int iy = y;
    int d = max(ix,iy) - min(ix,iy);
    return (uchar)d;
}

// ----- uchar -----

__attribute__((overloadable, always_inline)) uchar
abs_diff(uchar x, uchar y)
{
    uint ux = x;
    uint uy = y;
    uint d = max(ux,uy) - min(ux,uy);
    return (uchar)d;
}

// ----- short -----

__attribute__((overloadable, always_inline)) ushort
abs_diff(short x, short y)
{
    int ix = x;
    int iy = y;
    int d = max(ix,iy) - min(ix,iy);
    return (ushort)d;
}

// ----- ushort -----

__attribute__((overloadable, always_inline)) ushort
abs_diff(ushort x, ushort y)
{
    uint ux = x;
    uint uy = y;
    uint d = max(ux,uy) - min(ux,uy);
    return (ushort)d;
}

// ----- int -----

__attribute__((overloadable, always_inline)) uint
abs_diff(int x, int y)
{
    return (uint)(max(x,y) - min(x,y));
}

// ----- uint -----

__attribute__((overloadable, always_inline)) uint
abs_diff(uint x, uint y)
{
    return max(x,y) - min(x,y);
}

// ----- long -----

__attribute__((overloadable, always_inline)) ulong
abs_diff(long x, long y)
{
    long xmy = x - y;
    long ymx = y - x;
    return (ulong)(x > y ? xmy : ymx);
}

// ----- ulong -----

__attribute__((overloadable, always_inline)) ulong
abs_diff(ulong x, ulong y)
{
    ulong xmy = x - y;
    ulong ymx = y - x;
    return x > y ? xmy : ymx;
}

