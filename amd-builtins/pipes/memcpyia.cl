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

__attribute__((always_inline, weak)) void 
__memcpy_internal_aligned(void *d, const void *s, size_t size, size_t align)
{
    if (align == 2) {
	short *d2 = (short *)d;
	short *s2 = (short *)s;
	short *e2 = s2 + size/2;

	while (s2 < e2)
	    *d2++ = *s2++;
    } else if (align == 4) {
	int *d4 = (int *)d;
	int *s4 = (int *)s;
	int *e4 = s4 + size/4;

	while (s4 < e4)
	    *d4++ = *s4++;
    } else if (align == 8) {
	long *d8 = (long *)d;
	long *s8 = (long *)s;
	long *e8 = s8 + size/8;

	while (s8 < e8)
	    *d8++ = *s8++;
    } else if (align == 16) {
	long2 *d16 = (long2 *)d;
	long2 *s16 = (long2 *)s;
	long2 *e16 = s16 + size/16;

	while (s16 < e16)
	    *d16++ = *s16++;
    } else if (align == 32 || align == 64 || align == 128) {
	long4 *d32 = (long4 *)d;
	long4 *s32 = (long4 *)s;
	long4 *e32 = s32 + size/32;

	while (s32 < e32)
	    *d32++ = *s32++;
    } else {
	char *d1 = (char *)d;
	char *s1 = (char *)s;
	char *e1 = s1 + size;

	while (s1 < e1)
	    *d1++ = *s1++;
    }
}

