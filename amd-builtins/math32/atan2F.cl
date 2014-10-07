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

#ifndef TABLE_BASED_ATAN2 
__attribute__((overloadable)) float
atan2(float y, float x)
{
    const float pi = 0x1.921fb6p+1f;
    const float piby2 = 0x1.921fb6p+0;
    const float piby4 = 0x1.921fb6p-1f;
    const float threepiby4 = 0x1.2d97c8p+1f;

    float ax = fabs(x);
    float ay = fabs(y);
    float v = min(ax, ay);
    float u = max(ax, ay);

    // Scale since u could be large, as in "regular" divide
    float s = u > 0x1.0p+96f ? 0x1.0p-32 : 1.0f;
    float vbyu = s * MATH_DIVIDE(v, s*u);

    float vbyu2 = vbyu * vbyu;

#define USE_2_2_APPROXIMATION
#if defined USE_2_2_APPROXIMATION
    float p = mad(vbyu2, mad(vbyu2, -0x1.7e1f78p-9f, -0x1.7d1b98p-3f), -0x1.5554d0p-2f) * vbyu2 * vbyu;
    float q = mad(vbyu2, mad(vbyu2, 0x1.1a714cp-2f, 0x1.287c56p+0f), 1.0f);
#else
    float p = mad(vbyu2, mad(vbyu2, -0x1.55cd22p-5f, -0x1.26cf76p-2f), -0x1.55554ep-2f) * vbyu2 * vbyu;
    float q = mad(vbyu2, mad(vbyu2, mad(vbyu2, 0x1.9f1304p-5f, 0x1.2656fap-1f), 0x1.76b4b8p+0f), 1.0f);
#endif

    // Octant 0 result
    float a = mad(p, MATH_RECIP(q), vbyu);

    // Fix up 3 other octants
    float at = piby2 - a;
    a = ay > ax ? at : a;
    at = pi - a;
    a = x < 0.0F ? at : a;

    // y == 0 => 0 for x >= 0, pi for x < 0
    at = as_int(x) < 0 ? pi : 0.0f;
    a = y == 0.0f ? at : a;

    // if (!FINITE_ONLY()) {
        // x and y are +- Inf
        at = x > 0.0f ? piby4 : threepiby4;
        a = ax == INFINITY & ay == INFINITY ? at : a;

	// x or y is NaN
	a = isnan(x) | isnan(y) ? as_float(QNANBITPATT_SP32) : a;
    // }

    // Fixup sign and return
    return copysign(a, y);
}
#else
__attribute__((overloadable)) float
atan2(float y, float x)
{
    USE_TABLE(float, p_tbl, M32_ATAN2_JBY256);

    // Explicitly flush arguments
    x = FTZ(x);
    y = FTZ(y);

    uint uy = as_uint(y);
    uint ux = as_uint(x);
    uint aux = ux & EXSIGNBIT_SP32;
    uint auy = uy & EXSIGNBIT_SP32;

    // General case: take absolute values of arguments
    float u = as_float(aux);
    float v = as_float(auy);

    // Swap u and v if necessary to obtain 0 < v < u
    int swap_vu = u < v;
    float uu = u;
    u = swap_vu ? v : u;
    v = swap_vu ? uu : v;

    // Use full range division here because the reciprocal of u could be subnormal
    float vbyu = v / u;

    // Handle large quotient with table and polynomial approximation
    int big = vbyu > 0.0625f;

    int index = (int) mad(vbyu, 256.0f, 0.5f);
    float findex = (float)index;
    float r = MATH_DIVIDE(mad(vbyu, 256.0f, -findex), mad(vbyu, findex, 256.0f));
    float s = r * r;
    index = clamp(index-16, 0, 240);
    float qbig = mad(r*s, -0.33333333333224095522f, r) + p_tbl[index];

    // Handle small quotient with a series expansion
    s = vbyu * vbyu;
    float q = mad(s, -mad(s, -0.14285713561807169030f, 0.19999999999393223405f), 0.33333333333333170500f);
    q = mad(vbyu*s, -q, vbyu);
    q = big ? qbig : q;

    // Tidy-up according to which quadrant the arguments lie in
    const float piby2 = 1.5707963267948966e+00f;
    float qt = piby2 - q;
    q = swap_vu ? qt : q;

    int xneg = ux != aux;
    const float pi = 3.1415926535897932e+00f;
    qt = pi - q;
    q = xneg ? qt : q;

    uint ysign = uy ^ auy;
    q = as_float(ysign | as_uint(q));

    // Now handle a few special cases
    // Zero y gives +-0 for positive x and +-pi for negative x
    qt = as_float(ysign | as_uint(pi));
    qt = xneg ? qt : y;
    q = y == 0.0f ? qt : q;

    if (!FINITE_ONLY()) {
        // If abs(x) and abs(y) are both infinity return +-pi/4 or +- 3pi/4 according to signs
        const float piby4 = 7.8539816339744831e-01f;
        const float three_piby4 = 2.3561944901923449e+00f;
        qt = xneg ? three_piby4 : piby4;
        qt = as_float(ysign | as_uint(qt));
        q = auy == PINFBITPATT_SP32 & aux == PINFBITPATT_SP32 ? qt : q;
    
        // If either arg was NaN, return it
        q = aux > PINFBITPATT_SP32 ? x : q;
        q = auy > PINFBITPATT_SP32 ? y : q;
    }

    return q;
}
#endif

