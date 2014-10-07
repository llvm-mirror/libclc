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

#pragma OPENCL EXTENSION cl_amd_media_ops2 : enable
#define CLK_ENQUEUE_FAILURE -1

// XXX This was copied from runtime/device/gpu/gpuschedcl.cpp

//! AmdAqlWrap slot state
enum AqlWrapState {
    AQL_WRAP_FREE = 0,
    AQL_WRAP_RESERVED,
    AQL_WRAP_READY,
    AQL_WRAP_MARKER,
    AQL_WRAP_BUSY,
    AQL_WRAP_DONE
};

//! Profiling states
enum ProfilingState {
    PROFILING_COMMAND_START = 0,
    PROFILING_COMMAND_END,
    PROFILING_COMMAND_COMPLETE
};

//! OCL dispatch condition flags
// --- this is unused in the library and I've asked German to remove
//     it in favor of the clang enum
enum ClFlags {
    NO_WAIT = 0,
    WAIT_PARENT,
    WAIT_WORK_GROUP
};

typedef struct _HsaAqlDispatchPacket {
    uint    mix;
    ushort  workgroup_size[3];
    ushort  reserved2;
    uint    grid_size[3];
    uint    private_segment_size_bytes;
    uint    group_segment_size_bytes;
    ulong   kernel_object_address;
    ulong   kernel_arg_address;
    ulong   reserved3;
    ulong   completion_signal;
} HsaAqlDispatchPacket;

typedef struct _AmdVQueueHeader {
    uint    aql_slot_num;       //!< [LRO/SRO] The total number of the AQL slots (multiple of 64).
    uint    event_slot_num;     //!< [LRO] The number of kernel events in the events buffer
    ulong   event_slot_mask;    //!< [LRO] A pointer to the allocation bitmask array for the events
    ulong   event_slots;        //!< [LRO] Pointer to a buffer for the events.
                                // Array of event_slot_num entries of AmdEvent
    ulong   aql_slot_mask;      //!< [LRO/SRO]A pointer to the allocation bitmask for aql_warp slots
    uint    command_counter;    //!< [LRW] The global counter for the submitted commands into the queue
    uint    wait_size;          //!< [LRO] The wait list size (in clk_event_t)
    uint    arg_size;           //!< [LRO] The size of argument buffer (in bytes)
    uint    reserved0;          //!< For the future usage
    ulong   kernel_table;       //!< [LRO] Pointer to an array with all kernel objects (ulong for each entry)
    uint    reserved[2];        //!< For the future usage
} AmdVQueueHeader;

typedef struct _AmdAqlWrap {
    uint state;             //!< [LRW/SRW] The current state of the AQL wrapper:  FREE, RESERVED, READY,
                            // MARKER, BUSY and DONE. The block could be returned back to a free state.
    uint enqueue_flags;     //!< [LWO/SRO] Contains the flags for the kernel execution start -
                            //  (KERNEL_ENQUEUE_FLAGS_T)
                            // NO_WAIT - we just start processing
                            // WAIT_PARENT - check if parent_wrap->state is done and then start processing
                            // WAIT_WORK_GROUP currently == WAIT_PARENT
    uint command_id;        //!< [LWO/SRO] The unique command ID
    uint child_counter;     //!< [LRW/SRW] Counter that determine the launches of child kernels.
                            // It's incremented on the
                            // start and decremented on the finish. The parent kernel can be considered as
                            // done when the value is 0 and the state is DONE
    ulong completion;       //!< [LWO/SRO] CL event for the current execution (clk_event_t)
    ulong parent_wrap;      //!< [LWO/SRO] Pointer to the parent AQL wrapper (AmdAqlWrap*)
    ulong wait_list;        //!< [LRO/SRO] Pointer to an array of clk_event_t objects (64 bytes default)
    uint wait_num;          //!<  [LWO/SRO] The number of cl_event_wait objects 
    uint reserved[5];       //!< For the future usage
    HsaAqlDispatchPacket aql;  //!< [LWO/SRO] AQL packet - 64 bytes AQL packet
} AmdAqlWrap;

typedef struct _AmdEvent {
    uint state;             //!< [LRO/SRW] Event state: START, END, COMPLETE
    uint counter;           //!< [LRW] Event retain/release counter. 0 means the event is free
    ulong timer[3];         //!< [LRO/SWO] Timer values for profiling for each state
} AmdEvent;

// XXX This is adapted from hsa.h

// This is an OpenCLized hsa_control_directives_t
typedef struct _HsaControlDirectives {
  ulong enabled_control_directives;
  ushort enable_break_exceptions;
  ushort enable_detect_exceptions;
  uint max_dynamic_group_size;
  uint max_flat_grid_size;
  uint max_flat_workgroup_size;
  uint requested_workgroups_per_cu;
  uint required_grid_size[3];
  uint required_workgroup_size[3];
  uchar required_dim;
  uchar reserved[75];
} HsaControlDirectives;

// This is an OpenCLized amd_kernel_code_t
typedef struct _AmdKernelCode {
  uint amd_code_version_major;
  uint amd_code_version_minor;
  uint struct_byte_size;
  uint target_chip;
  ulong kernel_code_entry_byte_offset;
  ulong kernel_code_prefetch_byte_offset;
  ulong kernel_code_prefetch_byte_size;
  ulong max_scratch_backing_memory_byte_size;
  ulong compute_pgm_resource_registers;
  uint enables_and_flags;
  uint gds_segment_byte_size;
  ushort debug_wavefront_private_segment_offset_sgpr;
  ushort debug_private_segment_buffer_sgpr;
  ushort wavefront_sgpr_count;
  ushort workitem_vgpr_count;
  ulong kernarg_segment_byte_size;
  uint workitem_private_segment_byte_size;
  uint workgroup_group_segment_byte_size;
  uint workgroup_fbarrier_count;
  uchar kernarg_segment_alignment;
  uchar group_segment_alignment;
  uchar private_segment_alignment;
  uchar code_alignment;
  uint code_type;
  uint code_properties;
  uchar wavefront_size;
  uchar optimization_level;
  uchar hsail_profile;
  uchar hsail_machine_model;
  uint hsail_version_major;
  uint hsail_version_minor;
  ushort hsail_target_options;
  ushort reserved3;
  HsaControlDirectives control_directive;
} AmdKernelCode;


// Library only from here

// XXX this needs to match workgroup/wg.h MAX_WAVES_PER_SIMD
#define CL_DEVICE_MAX_WORK_GROUP_SIZE 256

// ABI has 6 special leading arguments:
//  global_offset[3], printf_buf, default vqueue pointer, and self AqlWrap pointer
#define NUM_SPECIAL_ARGS 6
extern __attribute__((const)) uint  __hsail_ld_kernarg_u32(uint);
extern __attribute__((const)) ulong __hsail_ld_kernarg_u64(uint);

static inline __global AmdVQueueHeader *
get_vqueue(void)
{
    size_t vq;

    if (sizeof(size_t) == 4)
	vq = __hsail_ld_kernarg_u32(4*4);
    else
	vq = __hsail_ld_kernarg_u64(4*8);

    return (__global AmdVQueueHeader *)vq;
}

static inline __global AmdAqlWrap *
get_aql_wrap(void)
{
    size_t aw;

    if (sizeof(size_t) == 4)
	aw = __hsail_ld_kernarg_u32(5*4);
    else
	aw = __hsail_ld_kernarg_u64(5*8);

    return (__global AmdAqlWrap *)aw;
}

static inline __global void *
get_printf_ptr(void)
{
    size_t pb;

    if (sizeof(size_t) == 4)
        pb = __hsail_ld_kernarg_u32(3*4);
    else
        pb = __hsail_ld_kernarg_u64(3*8);

    return (__global void *)pb;
}

typedef struct _NdRange {
    uint dim;
    size_t goff[3];
    size_t gws[3];
    size_t lws[3];
} NdRange;

// reserve a slot in a bitmask controlled resource
// n is the number of slots
static inline int
reserve_slot(__global uint * restrict mask, uint n)
{
    n >>= 5;
    uint i, j, k, v, vv, z;

    /* Spread the starting points */
    i = get_sub_group_local_id() % n;

    /* Allow only one pass */
    for (j=0,k=i;j<n;++j) {
        __global atomic_uint *p = (__global atomic_uint *)(mask + k);
        v = atomic_load_explicit(p, memory_order_acquire, memory_scope_device);
        for (;;) {
            z = ctz(~v);
            if (z == 32U)
                break;
            vv = v | (1U << z);
            if (atomic_compare_exchange_strong_explicit(p, &v, vv, memory_order_acq_rel, memory_order_acquire, memory_scope_device))
                break;
        }
        if (z < 32U)
            break;
        k = k == n-1 ? 0 : k+1;
    }

    k = (k << 5) + z;
    return z < 32U ? (int)k : -1;
}

// release slot in a bitmask controlled resource
// i is the slot number
static inline void
release_slot(__global uint * restrict mask, uint i)
{
    /* uint b = ~(1UL << (i & 0x1f)); */
    uint b = ~amd_bfm(1U, i);
    __global atomic_uint *p = (__global atomic_uint *)(mask + (i >> 5));
    uint v, vv;

    v = atomic_load_explicit(p, memory_order_acquire, memory_scope_device);
    for (;;) {
        vv = v & b;
        if (atomic_compare_exchange_strong_explicit(p, &v, vv, memory_order_acq_rel, memory_order_acquire, memory_scope_device))
            break;
    }
}

static inline uint
align_up(uint start, uint align)
{
    return (start + align - 1U) & -align;
}

