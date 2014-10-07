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
//
// Copyright (c) 2014 Advanced Micro Devices, Inc. All rights reserved.
//

#include "pipes.h"

#define __COMMIT_READ_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) void \
__commit_read_pipe_internal_##SIZE(__global struct pipeimp* p, size_t rid) \
{ \
}

DO_PIPE_INTERNAL_SIZE(__COMMIT_READ_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) void
__commit_read_pipe_internal_user(__global struct pipeimp* p, size_t rid, size_t size)
{
}

#define __COMMIT_WRITE_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) void \
__commit_write_pipe_internal_##SIZE(__global struct pipeimp* p, size_t rid) \
{ \
}

DO_PIPE_INTERNAL_SIZE(__COMMIT_WRITE_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) void
__commit_write_pipe_internal_user(__global struct pipeimp* p, size_t rid, size_t size)
{
}

// Work group functions

#define __WORK_GROUP_COMMIT_READ_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) void \
__work_group_commit_read_pipe_internal_##SIZE(__global struct pipeimp* p, size_t rid) \
{ \
}

DO_PIPE_INTERNAL_SIZE(__WORK_GROUP_COMMIT_READ_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) void
__work_group_commit_read_pipe_internal_user(__global struct pipeimp* p, size_t rid, size_t size)
{
}

#define __WORK_GROUP_COMMIT_WRITE_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) void \
__work_group_commit_write_pipe_internal_##SIZE(__global struct pipeimp* p, size_t rid) \
{ \
}

DO_PIPE_INTERNAL_SIZE(__WORK_GROUP_COMMIT_WRITE_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) void
__work_group_commit_write_pipe_internal_user(__global struct pipeimp* p, size_t rid, size_t size)
{
}

// sub group functions

#define __SUB_GROUP_COMMIT_READ_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) void \
__sub_group_commit_read_pipe_internal_##SIZE(__global struct pipeimp* p, size_t rid) \
{ \
}

DO_PIPE_INTERNAL_SIZE(__SUB_GROUP_COMMIT_READ_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) void
__sub_group_commit_read_pipe_internal_user(__global struct pipeimp* p, size_t rid, size_t size)
{
}

#define __SUB_GROUP_COMMIT_WRITE_PIPE_INTERNAL_SIZE(SIZE, STYPE) \
__attribute__((weak, always_inline)) void \
__sub_group_commit_write_pipe_internal_##SIZE(__global struct pipeimp* p, size_t rid) \
{ \
}

DO_PIPE_INTERNAL_SIZE(__SUB_GROUP_COMMIT_WRITE_PIPE_INTERNAL_SIZE)

__attribute__((weak, always_inline)) void
__sub_group_commit_write_pipe_internal_user(__global struct pipeimp* p, size_t rid, size_t size)
{
}

