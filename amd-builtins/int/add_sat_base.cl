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
add_sat(char x, char y)
{
    int s = (int)x + (int) y;
    return max(-128, min(127, s));
}

// ----- uchar -----

__attribute__((overloadable, always_inline)) uchar
add_sat(uchar x, uchar y)
{
    uint s = (uint)x + (uint)y;
    return min(255U, s);
}


// ----- short -----

__attribute__((overloadable, always_inline)) short
add_sat(short x, short y)
{
    int s = (int)x + (int) y;
    return max(-32768, min(32767, s));
}

// ----- ushort -----

__attribute__((overloadable, always_inline)) ushort
add_sat(ushort x, ushort y)
{
    uint s = (uint)x + (uint)y;
    return min(65535U, s);
}

// ----- int -----

__attribute__((overloadable, always_inline)) int
add_sat(int x, int y)
{
    int s = x + y;
    s = y < 1 & (int)0x80000000 - y > x ? (int)0x80000000 : s;
    s = y > 0 & 0x7fffffff - y < x ? 0x7fffffff : s;
    return s;
}

// ----- uint -----

__attribute__((overloadable, always_inline)) uint
add_sat(uint x, uint y)
{
    uint s = x + y;
    s = 0xffffffffU - y < x ? 0xffffffffU : s;
    return s;
}

// ----- long -----

__attribute__((overloadable, always_inline)) long
add_sat(long x, long y)
{
    long s = x + y;
    s = y < 1 & (long)0x8000000000000000 - y > x ? (long)0x8000000000000000 : s;
    s = y > 0 & 0x7fffffffffffffffL - y < x ? 0x7fffffffffffffffL : s;
    return s;
}

// ----- ulong -----

__attribute__((overloadable, always_inline)) ulong
add_sat(ulong x, ulong y)
{
    ulong s = x + y;
    s = 0xffffffffffffffffUL - y < x ? 0xffffffffffffffffUL : s;
    return s;
}

