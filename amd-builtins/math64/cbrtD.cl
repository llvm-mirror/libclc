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

#include "math64.h"

// Algorithm:
//
// x = (2^m)*A
// x = (2^m)*(G+g) with (1 <= G < 2) and (g <= 2^(-8))
// x = (2^m)*2*(G/2+g/2)
// x = (2^m)*2*(F+f) with (0.5 <= F < 1) and (f <= 2^(-9))
//
// Y = (2^(-1))*(2^(-m))*(2^m)*A
// Now, range of Y is: 0.5 <= Y < 1
//
// F = 0x100 + (first 7 mantissa bits) + (8th mantissa bit)
// Now, range of F is: 128 <= F <= 256
// F = F / 256
// Now, range of F is: 0.5 <= F <= 1
//
// f = (Y-F), with (f <= 2^(-9))
//
// cbrt(x) = cbrt(2^m) * cbrt(2) * cbrt(F+f)
// cbrt(x) = cbrt(2^m) * cbrt(2) * cbrt(F) + cbrt(1+(f/F))
// cbrt(x) = cbrt(2^m) * cbrt(2*F) * cbrt(1+r)
//
// r = (f/F), with (r <= 2^(-8))
// r = f*(1/F) with (1/F) precomputed to avoid division
//
// cbrt(x) = cbrt(2^m) * cbrt(G) * (1+poly)
//
// poly = c1*r + c2*(r^2) + c3*(r^3) + c4*(r^4) + c5*(r^5) + c6*(r^6)


__attribute__((overloadable)) double
cbrt(double x)
{
    USE_TABLE(double, p_inv, CBRT_TBL_INV);
    USE_TABLE(double2, p_cbrt, CBRT_TBL);
    USE_TABLE(double2, p_rem, CBRT_TBL_REM);


    int return_x = isinf(x) | isnan(x) | x == 0.0;
    ulong ux = as_ulong(fabs(x));
    int m = (as_int2(ux).hi >> 20) - 1023;

    // Treat subnormals
    ulong uxs = as_ulong(as_double(0x3ff0000000000000UL | ux) - 1.0);
    int ms = m + (as_int2(uxs).hi >> 20) - 1022;

    int c = m == -1023;
    ux = c ? uxs : ux;
    m = c ? ms : m;

    int mby3 = m / 3;
    int rem = m - 3*mby3;

    double mf = as_double((ulong)(mby3 + 1023) << 52);

    ux &= 0x000fffffffffffffUL;
    double Y = as_double(0x3fe0000000000000UL | ux);

    // nearest integer
    int index = as_int2(ux).hi >> 11;
    index = (0x100 | (index >> 1)) + (index & 1);
    double F = (double)index * 0x1.0p-9;
    
    double f = Y - F;
    double r = f * p_inv[index-256];

    double z = r * fma(r,
                       fma(r,
                           fma(r,
                               fma(r,
                                   fma(r, -0x1.8090d6221a247p-6, 0x1.ee7113506ac13p-6),
                                   -0x1.511e8d2b3183bp-5),
                               0x1.f9add3c0ca458p-5),
                           -0x1.c71c71c71c71cp-4),
                       0x1.5555555555555p-2);

    double2 tv = p_rem[rem+2];
    double Rem_h = tv.s0;
    double Rem_t = tv.s1;

    tv = p_cbrt[index-256];
    double F_h = tv.s0;
    double F_t = tv.s1;

    double b_h = F_h * Rem_h; 
    double b_t = fma(Rem_t, F_h, fma(F_t, Rem_h, F_t*Rem_t));

    double ans = fma(z, b_h, fma(z, b_t, b_t)) + b_h;
    ans = copysign(ans*mf, x);
    return return_x ? x : ans;
}

