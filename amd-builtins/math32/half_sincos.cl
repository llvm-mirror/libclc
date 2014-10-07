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

#include "math32.h"
#include "remainderF_piby2.h"
#include "sincosF_piby4.h"

// Calculate half_sin and half_cos at once

__attribute__((always_inline, weak)) float
__hsa_half_sincos(float x, float *cp)
{
    int ix = as_int(x);
    int ax = ix & 0x7fffffff;
    float dx = as_float(ax);

    float r0, r1;
    int regn = argReductionSmallS(&r0, &r1, dx);

    float ss = sinf_piby4_new(r0, r1);
    float cc = cosf_piby4_new(r0, r1);
    bool reg0 = (regn & 1) != 0;
    float c = reg0 ? -ss : cc;
    float s = reg0 ? cc : ss;
    int xsign = ((regn > 1) << 31);
    c = as_float(as_int(c) ^ xsign);
    s = as_float(as_int(s) ^ xsign);

    bool is_huge = ax > 0x47800000;
    c = is_huge ? 1.0f : c;
    s = is_huge ? 1.0f : s;
    s = as_float(as_int(s) ^ (ix ^ ax));
    s = x == 0.0f ? x : s;
    bool is_inf = ax >= PINFBITPATT_SP32;
    c = is_inf ? as_float(QNANBITPATT_SP32) : c;
    s = is_inf ? as_float(QNANBITPATT_SP32) : s;
    *cp = c;
    return s;
}
