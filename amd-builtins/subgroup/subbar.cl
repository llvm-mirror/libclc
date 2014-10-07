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

extern void __hsail_wavebarrier(void);

__attribute__((overloadable,weak,always_inline)) void
sub_group_barrier(cl_mem_fence_flags flags)
{
    sub_group_barrier(flags, memory_scope_sub_group);
}

__attribute__((overloadable,weak,always_inline)) void
sub_group_barrier(cl_mem_fence_flags flags, memory_scope scope)
{
    // What about CLK_IMAGE_MEM_FENCE
    atomic_work_item_fence(flags, memory_order_release, scope);
    __hsail_wavebarrier();
    atomic_work_item_fence(flags, memory_order_acquire, scope);
}

