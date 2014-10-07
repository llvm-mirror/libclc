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

__attribute__((overloadable,weak,always_inline)) float
clamp(float x, float minval, float maxval)
{
    return fmin(fmax(x, minval), maxval);
}

__attribute__((overloadable,weak,always_inline)) double
clamp(double x, double minval, double maxval)
{
    // We think there is a bug in section 9.3.3 and match the float version instead
    return fmin(fmax(x, minval), maxval);
}

// Integer clamp functions

#define ICLAMP(TY) \
__attribute__((overloadable,weak,always_inline)) TY \
clamp(TY x, TY minval, TY maxval) \
{ \
    return min(max(x, minval), maxval); \
}

ICLAMP(char)
ICLAMP(uchar)

ICLAMP(short)
ICLAMP(ushort)

ICLAMP(int)
ICLAMP(uint)

ICLAMP(long)
ICLAMP(ulong) 

