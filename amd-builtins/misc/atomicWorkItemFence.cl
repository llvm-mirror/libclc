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
extern void __atomic_memfence(uint flags, uint mo, uint msc);
enum BrigMemoryFenceSegments {
  BRIG_MEMORY_FENCE_NONE   = 0,
  BRIG_MEMORY_FENCE_GROUP  = 1,
  BRIG_MEMORY_FENCE_GLOBAL = 2,
  BRIG_MEMORY_FENCE_BOTH   = 3,
  BRIG_MEMORY_FENCE_IMAGE  = 4
};

enum BrigMemoryOrder {
  BRIG_MEMORY_ORDER_NONE = 0,
  BRIG_MEMORY_ORDER_RELAXED = 1,
  BRIG_MEMORY_ORDER_ACQUIRE = 2,
  BRIG_MEMORY_ORDER_RELEASE = 3,
  BRIG_MEMORY_ORDER_ACQUIRE_RELEASE = 4
};

enum BrigMemoryScope {
  BRIG_MEMORY_SCOPE_NONE = 0,
  BRIG_MEMORY_SCOPE_WAVEFRONT = 1,
  BRIG_MEMORY_SCOPE_WORKGROUP = 2,
  BRIG_MEMORY_SCOPE_COMPONENT = 3,
  BRIG_MEMORY_SCOPE_SYSTEM = 4,
  BRIG_MEMORY_SCOPE_WORKITEM = 5
};

static inline uint getBrigMemoryOrder(memory_order mo) {
  switch(mo) {
    default : return BRIG_MEMORY_ORDER_NONE;
    case memory_order_relaxed : return BRIG_MEMORY_ORDER_RELAXED;
    case memory_order_release : return BRIG_MEMORY_ORDER_RELEASE;
    case memory_order_acquire : return BRIG_MEMORY_ORDER_ACQUIRE;
    case memory_order_acq_rel :
    case memory_order_seq_cst : return BRIG_MEMORY_ORDER_ACQUIRE_RELEASE;
  }
}

static inline uint getBrigMemoryScope(memory_scope msc) {
  switch(msc) {
    default :  return BRIG_MEMORY_SCOPE_NONE;
    case memory_scope_work_group : return BRIG_MEMORY_SCOPE_WORKGROUP;
    case memory_scope_device : return BRIG_MEMORY_SCOPE_COMPONENT;
    case memory_scope_all_svm_devices : return BRIG_MEMORY_SCOPE_SYSTEM;
    case memory_scope_sub_group : return BRIG_MEMORY_SCOPE_WAVEFRONT;
    case memory_scope_work_item : return BRIG_MEMORY_SCOPE_WORKITEM;
  }
}

#ifdef __clang__
__attribute__((overloadable))
#endif
__attribute__((always_inline)) void
atomic_work_item_fence(/*cl_mem_fence_flags*/ unsigned flag, memory_order mo, memory_scope msc) {
  uint brigSegment = 0;
  uint brigMemoryOrder = getBrigMemoryOrder(mo);
  uint brigMemoryScope = BRIG_MEMORY_SCOPE_WORKGROUP;
  // relaxed fence has no effect
  if (mo == memory_order_relaxed) return;
  if ((flag & CLK_GLOBAL_MEM_FENCE) && (flag & CLK_LOCAL_MEM_FENCE)) {
    brigSegment = BRIG_MEMORY_FENCE_BOTH;
    brigMemoryScope = getBrigMemoryScope(msc);
  }
  else if (flag & CLK_GLOBAL_MEM_FENCE) {
    brigSegment = BRIG_MEMORY_FENCE_GLOBAL;
    brigMemoryScope = getBrigMemoryScope(msc);
  }
  else if (flag & CLK_LOCAL_MEM_FENCE) {
    brigSegment = BRIG_MEMORY_FENCE_GROUP;
  }
  if (brigSegment != 0) {
    __atomic_memfence(brigSegment, brigMemoryOrder, brigMemoryScope);
  }
  if (flag & CLK_IMAGE_MEM_FENCE) {
    brigMemoryScope = getBrigMemoryScope(msc);
    __atomic_memfence(BRIG_MEMORY_FENCE_IMAGE, BRIG_MEMORY_ORDER_ACQUIRE_RELEASE, brigMemoryScope);
  }
}
#endif // __OPENCL_C_VERSION__ >= 200
