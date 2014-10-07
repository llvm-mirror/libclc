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

// Vector expansions for HSAIL relationals

#define UnaryRelationalVector(oty, ity, fun, mgl) \
__attribute__((weak,always_inline)) \
oty##16 __##fun##_16##mgl(ity##16 a) \
{ \
	oty##16 c; \
  c.lo = fun(a.lo); \
	c.hi = fun(a.hi); \
	return c; \
} \
__attribute__((weak,always_inline)) \
oty##8 __##fun##_8##mgl(ity##8 a) \
{ \
	oty##8 c; \
	c.lo = fun(a.lo); \
	c.hi = fun(a.hi); \
	return c; \
} \
__attribute__((weak,always_inline)) \
oty##4 __##fun##_4##mgl(ity##4 a) \
{ \
	oty##4 c; \
	c.lo = fun(a.lo); \
	c.hi = fun(a.hi); \
	return c; \
} \
__attribute__((weak,always_inline)) \
oty##3 __##fun##_3##mgl(ity##3 a) \
{ \
	oty##3 c; \
	c.xy = fun(a.xy); \
	c.z = fun(a.z); \
	return c; \
} \
__attribute__((weak,always_inline)) \
oty##2 __##fun##_2##mgl(ity##2 a) \
{ \
	oty##2 c; \
	c.lo = fun(a.lo); \
	c.hi = fun(a.hi); \
	return c; \
}

UnaryRelationalVector(int, float, isfinite, f32)
UnaryRelationalVector(long, double, isfinite, f64)

UnaryRelationalVector(int, float, isinf, f32)
UnaryRelationalVector(long, double, isinf, f64)

UnaryRelationalVector(int, float, isnan, f32)
UnaryRelationalVector(long, double, isnan, f64)

UnaryRelationalVector(int, float, isnormal, f32)
UnaryRelationalVector(long, double, isnormal, f64)

