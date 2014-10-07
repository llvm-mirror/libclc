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

#if __OPENCL_C_VERSION__ >= 200

#include "devenq.h"

// 1D variants

__attribute__((overloadable, always_inline)) ndrange_t
ndrange_1D(size_t gws)
{
    ndrange_t ret;
    __private NdRange *rp = (__private NdRange *)&ret;
    rp->dim = 1;
    rp->goff[0] = 0;
    rp->goff[1] = 0;
    rp->goff[2] = 0;
    rp->gws[0] = gws;
    rp->gws[1] = 1;
    rp->gws[2] = 1;
    rp->lws[0] = min(gws, (size_t)64);
    rp->lws[1] = 1;
    rp->lws[2] = 1;
    return ret;
}

__attribute__((overloadable, always_inline)) ndrange_t
ndrange_1D(size_t gws, size_t lws)
{
    ndrange_t ret;
    __private NdRange *rp = (__private NdRange *)&ret;
    rp->dim = 1;
    rp->goff[0] = 0;
    rp->goff[1] = 0;
    rp->goff[2] = 0;
    rp->gws[0] = gws;
    rp->gws[1] = 1;
    rp->gws[2] = 1;
    rp->lws[0] = lws;
    rp->lws[1] = 1;
    rp->lws[2] = 1;
    return ret;
}

__attribute__((overloadable, always_inline)) ndrange_t
ndrange_1D(size_t goff, size_t gws, size_t lws)
{
    ndrange_t ret;
    __private NdRange *rp = (__private NdRange *)&ret;
    rp->dim = 1;
    rp->goff[0] = goff;
    rp->goff[1] = 0;
    rp->goff[2] = 0;
    rp->gws[0] = gws;
    rp->gws[1] = 1;
    rp->gws[2] = 1;
    rp->lws[0] = lws;
    rp->lws[1] = 1;
    rp->lws[2] = 1;
    return ret;
}

// 2D variants

__attribute__((overloadable, always_inline)) ndrange_t
ndrange_2D(size_t gws[2])
{
    ndrange_t ret;
    __private NdRange *rp = (__private NdRange *)&ret;
    rp->dim = 2;
    rp->goff[0] = 0;
    rp->goff[1] = 0;
    rp->goff[2] = 0;
    rp->gws[0] = gws[0];
    rp->gws[1] = gws[1];
    rp->gws[2] = 1;
    rp->lws[0] = min(gws[0], (size_t)8);
    rp->lws[1] = min(gws[1], (size_t)8);
    rp->lws[2] = 1;
    return ret;
}

__attribute__((overloadable, always_inline)) ndrange_t
ndrange_2D(size_t gws[2], size_t lws[2])
{
    ndrange_t ret;
    __private NdRange *rp = (__private NdRange *)&ret;
    rp->dim = 2;
    rp->goff[0] = 0;
    rp->goff[1] = 0;
    rp->goff[2] = 0;
    rp->gws[0] = gws[0];
    rp->gws[1] = gws[1];
    rp->gws[2] = 1;
    rp->lws[0] = lws[0];
    rp->lws[1] = lws[1];
    rp->lws[2] = 1;
    return ret;
}

__attribute__((overloadable, always_inline)) ndrange_t
ndrange_2D(size_t goff[2], size_t gws[2], size_t lws[2])
{
    ndrange_t ret;
    __private NdRange *rp = (__private NdRange *)&ret;
    rp->dim = 2;
    rp->goff[0] = goff[0];
    rp->goff[1] = goff[1];
    rp->goff[2] = 0;
    rp->gws[0] = gws[0];
    rp->gws[1] = gws[1];
    rp->gws[2] = 1;
    rp->lws[0] = lws[0];
    rp->lws[1] = lws[1];
    rp->lws[2] = 1;
    return ret;
}

// 3D variants

__attribute__((overloadable, always_inline)) ndrange_t
ndrange_3D(size_t gws[3])
{
    ndrange_t ret;
    __private NdRange *rp = (__private NdRange *)&ret;
    rp->dim = 3;
    rp->goff[0] = 0;
    rp->goff[1] = 0;
    rp->goff[2] = 0;
    rp->gws[0] = gws[0];
    rp->gws[1] = gws[1];
    rp->gws[2] = gws[2];
    rp->lws[0] = min(gws[0], (size_t)4);
    rp->lws[1] = min(gws[1], (size_t)4);
    rp->lws[2] = min(gws[2], (size_t)4);
    return ret;
}

__attribute__((overloadable, always_inline)) ndrange_t
ndrange_3D(size_t gws[3], size_t lws[3])
{
    ndrange_t ret;
    __private NdRange *rp = (__private NdRange *)&ret;
    rp->dim = 3;
    rp->goff[0] = 0;
    rp->goff[1] = 0;
    rp->goff[2] = 0;
    rp->gws[0] = gws[0];
    rp->gws[1] = gws[1];
    rp->gws[2] = gws[2];
    rp->lws[0] = lws[0];
    rp->lws[1] = lws[1];
    rp->lws[2] = lws[2];
    return ret;
}

__attribute__((overloadable, always_inline)) ndrange_t
ndrange_3D(size_t goff[3], size_t gws[3], size_t lws[3])
{
    ndrange_t ret;
    __private NdRange *rp = (__private NdRange *)&ret;
    rp->dim = 3;
    rp->goff[0] = goff[0];
    rp->goff[1] = goff[1];
    rp->goff[2] = goff[2];
    rp->gws[0] = gws[0];
    rp->gws[1] = gws[1];
    rp->gws[2] = gws[2];
    rp->lws[0] = lws[0];
    rp->lws[1] = lws[1];
    rp->lws[2] = lws[2];
    return ret;
}

#endif

