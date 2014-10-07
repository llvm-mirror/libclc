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



static inline  double float_uint_to_double(uint x)
{
    double d;
    float f = as_float(x);

	// Fix up subnormal, if necessary
	uint fmant = x & 0x007fffff;
	float temp = as_float(fmant | 0x3f800000);
	temp -= 1.0;
	d = (float)temp;
	ulong ld = as_ulong(d);
	ld -= 0x07e0000000000000;
	d = as_double(ld);
	d = fmant ? d : 0.0;
	d = x & 0x80000000 ? -d : d;
	d = (f != 0.0) ? (double)f : d;

	return d;

}

static inline uint double_to_float_uint(double d)
{
	uint dlow, dhigh, dsign;
	float f = (float)d;
	uint uf;

	double dabs = (d < 0.) ? -d : d;

	// Fix up subnormal
	ulong ld;
	ld = as_ulong(d);
	dlow = ld;
	dhigh = ld >> 32;
	dsign = dhigh & 0x80000000;

	int dexp = (dhigh >> 20) & 0x7ff;
	int shiftcount = 0x381 - dexp;
	dhigh &= 0x000fffff;
	dhigh |= 0x00100000;
	dhigh = (dhigh << 3) | (dlow >> 29);
	dlow <<= 3;
	uint extrabits = dlow << (32 - shiftcount);
	dlow = (dlow >> shiftcount) | (dhigh << (32 - shiftcount));
	dhigh >>= shiftcount;
	dhigh = ((dlow > 0x80000000u) ||
	((dlow == 0x80000000u) && ((dhigh & 1) | extrabits))) ?
	   dhigh + 1 : dhigh;
	uf = dhigh | dsign;
	uf =  dabs >= 7.0064923216240869000000e-046 ? uf : 0;


	uf = f != 0. ? as_uint(f) : uf;
    return uf;
}