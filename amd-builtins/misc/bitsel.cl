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

extern __attribute__((pure)) uint __amdil_bfi_u32(uint, uint, uint);

// [u]int

__attribute__((always_inline)) static uint
__BSELI4(uint a, uint b, uint c)
{
    return __amdil_bfi_u32(c, b, a);
}

extern __attribute__((overloadable, alias("__BSELI4"))) uint bitselect(uint, uint, uint);
extern __attribute__((overloadable, alias("__BSELI4"))) int bitselect(int, int, int);

// float

__attribute__((overloadable, always_inline)) float
bitselect(float a, float b, float c)
{
    return as_float(__amdil_bfi_u32(as_uint(c), as_uint(b), as_uint(a)));
}

// [u]long

// No __amdil equivalent, so use __hsail intrinsic here
extern __attribute__((const)) ulong __hsail_bitselect_u64(ulong, ulong, ulong);

__attribute__((always_inline)) static ulong
__BSELI8(ulong a, ulong b, ulong c)
{
    return __hsail_bitselect_u64(c, b, a);
}

extern __attribute__((overloadable, alias("__BSELI8"))) ulong bitselect(ulong, ulong, ulong);
extern __attribute__((overloadable, alias("__BSELI8"))) long bitselect(long, long, long);

// double

__attribute__((overloadable, always_inline)) double
bitselect(double a, double b, double c)
{
    return as_double(__hsail_bitselect_u64(as_ulong(c), as_ulong(b), as_ulong(a)));
}

