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

__attribute__((overloadable, always_inline, weak)) double
ldexp(double x, int n)
{
	long l = as_ulong(x);
	int e = (l >> 52) & 0x7ff;
	long s = l & 0x8000000000000000;

	ulong ux = as_ulong(x * 0x1.0p+53);
	int de = ((int)(ux >> 52) & 0x7ff) - 53;
	int c = e == 0;
	e = c ? de: e;

	ux = c ? ux : l;

	int v = e + n;
	v = clamp(v, -0x7ff, 0x7ff);

	ux &= ~EXPBITS_DP64;

	double mr = as_double(ux | ((ulong)(v+53) << 52));
	mr = mr * 0x1.0p-53;

	mr = v > 0  ? as_double(ux | ((ulong)v << 52)) : mr;

	mr = v == 0x7ff ? as_double(s | PINFBITPATT_DP64)  : mr;
	mr = v < -53 ? as_double(s) : mr;

	mr  = (n == 0 | isinf(x) | x == 0 ) ? x : mr;
	return mr;
}
