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

// ----- int -----

__attribute__((overloadable, always_inline)) int
mul24(int x, int y)
{
    return __amdil_imul24_i32(x, y);
}

__attribute__((overloadable, always_inline)) int
mad24(int a, int b, int c)
{
    return __amdil_imad24_i32(a, b, c);
}

// ----- uint -----

__attribute__((overloadable, always_inline)) uint
mul24(uint x, uint y)
{
    return __amdil_umul24_u32(x, y);
}

__attribute__((overloadable, always_inline)) uint
mad24(uint a, uint b, uint c)
{
    return __amdil_umad24_u32(a, b, c);
}
