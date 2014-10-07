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
#pragma OPENCL EXTENSION cl_khr_subgroups : enable

extern __attribute__((pure)) uint __hsail_workitemid_flat(void);

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) uint
get_sub_group_size(void)
{
    uint wgs = (uint)get_local_size(0) * (uint)get_local_size(1) * (uint)get_local_size(2);
    uint lid = (uint)get_local_linear_id();
    return min(64U, wgs - (lid & ~63U));
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) uint
get_max_sub_group_size(void)
{
    uint wgs = (uint)get_enqueued_local_size(0) * get_enqueued_local_size(1) * get_enqueued_local_size(2);
    return min(64U, wgs);
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) uint
get_num_sub_groups(void)
{
    uint wgs = (uint)get_local_size(0) * (uint)get_local_size(1) * (uint)get_local_size(2);
    return (wgs + 63U) >> 6U;
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) uint
get_enqueued_num_sub_groups(void)
{
    uint wgs = (uint)get_enqueued_local_size(0) * get_enqueued_local_size(1) * get_enqueued_local_size(2);
    return (wgs + 63U) >> 6U;
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) uint
get_sub_group_id(void)
{
    return __hsail_workitemid_flat() >> 6U;
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) uint
get_sub_group_local_id(void)
{
    return __hsail_workitemid_flat() & 0x3fU;
}

