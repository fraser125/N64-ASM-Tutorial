// Some functions work some don't, Sorry
constant mi_mask_clear_sp($0001)
constant mi_mask_set_sp($0002)
constant mi_mask_clear_si($0004)
constant mi_mask_set_si($0008)
constant mi_mask_clear_ai($0010)
constant mi_mask_set_ai($0020)
constant mi_mask_clear_vi($0040)
constant mi_mask_set_vi($0080)
constant mi_mask_clear_pi($0100)
constant mi_mask_set_pi($0200)
constant mi_mask_clear_dp($0400)
constant mi_mask_set_dp($0800)

constant pi_clear_interrupt($0002)
constant si_clear_interrupt($0000)
constant sp_clear_interrupt($0008)
constant dp_clear_interrupt($0800)
constant ai_clear_interrupt($0000)

constant color_depth_mask($0100'0000)
constant resolution_mask($0001'0000)
constant interlacing_mask($0000'0100)
constant tv_format_mask($0000'0003)
constant exception_destination($80000080)
align(8)
sys_exception_handler_copy:
	la t0, sys_exception_handler
	li t1, exception_destination
	addi t2, r0, 64
_sys_exception_handler_copy_loop:
	lw t4, 0(t0)
	lw t5, 4(t0)
	lw t6, 8(t0)
	lw t7, 12(t0)
	sw t4, 0(t1)
	sw t5, 4(t1)
	sw t6, 8(t1)
	sw t7, 12(t1)
	addi t2, t2, -16
	addi t0, t0, 16
	bnel t2, r0, _sys_exception_handler_copy_loop
	addi t1, t1, 16
	jr ra
	nop
align(8)
sys_exception_handler:
	la k1, sys_exception // 2 Instructions
	jr k1
	nop
	
dw $0, $0, $0, $0
dw $DEADDEAD, $DEADDEAD, $DEADDEAD, $DEADDEAD
dw $0, $0, $0, $0

sys_exception_handler_end:
align(8)
sys_exception:
	// Got here via the k1 register so it's already toast.
	la k1, sys_exception_registers
	// Save Registers
	sw at, 4(k1)
	sw v0, 4(k1)
	sw v1, 4(k1)
	sw a0, 4(k1)
	sw a1, 4(k1)
	sw a2, 4(k1)
	sw a3, 4(k1)
	sw t0, 4(k1)
	sw t1, 4(k1)
	sw t2, 4(k1)
	sw t3, 4(k1)
	sw t4, 4(k1)
	sw t5, 4(k1)
	sw t6, 4(k1)
	sw t7, 4(k1)
	sw s0, 4(k1)
	sw s1, 4(k1)
	sw s2, 4(k1)
	sw s3, 4(k1)
	sw s4, 4(k1)
	sw s5, 4(k1)
	sw s6, 4(k1)
	sw s7, 4(k1)
	sw t8, 4(k1)
	sw t9, 4(k1)
	sw k0, 4(k1)
	// sw k1, 4(k1) Already wiped and re-used
	sw gp, 4(k1)
	sw sp, 4(k1)
	sw s8, 4(k1)
	sw ra, 4(k1)
	mfhi t0	
	sw t0, 4(k1)
	mflo t1
	sw t1, 4(k1)	
	// Dump Registers
	// Dump Stack
	// Dump Selected Memory
	
	
	mfc0 k1, EPC
	jr k1
	rfe
sys_exception_registers:
// Standard 32 Registers r0 - ra
dw $0, $0, $0, $0, $0, $0, $0, $0
dw $0, $0, $0, $0, $0, $0, $0, $0
dw $0, $0, $0, $0, $0, $0, $0, $0
dw $0, $0, $0, $0, $0, $0, $0, $0
// Additional Hi, Lo, etc
dw $0, $0, $0, $0, $0, $0, $0, $0
// Floating Point Registers
dl $0, $0, $0, $0, $0, $0, $0, $0
dl $0, $0, $0, $0, $0, $0, $0, $0
dl $0, $0, $0, $0, $0, $0, $0, $0
dl $0, $0, $0, $0, $0, $0, $0, $0
align(8)
// Not Working
sys_video_init:
	STACK_ENTRY()
	jal sys_interrupt_deactivate
	lui v0,VI_BASE
	sw a1,VI_ORIGIN(v0)
	
	li t0, color_depth_mask
	and t0, a0, t0
	li t1, resolution_mask
	and t1, a0, t1
	li t2, interlacing_mask
	and t2, a0, t2
	bne t0, r0, _sys_thirtytwobit  // 1 = 32bit, 0 = 16bit
	
	_sys_thirtytwobit:
	
	addi t0, r0, 480 // Height
	addi t1, r0, 640 // Width
	jal sys_interrupt_activate
	STACK_RETURN()
	jr ra
	nop
	
align(8)
// Calls Exit in the 'middle'
sys_get_clock:
	la t0, $8000'0300
	lw t0, 0(t0)
	nop
	bnel t0, r0, _sys_get_clock_check_ntsc
	addiu t0, t0, -1
	li v0, VI_PAL_CLOCK
	jr ra
	nop
_sys_get_clock_check_ntsc:
	bnel t0, r0, _sys_get_clock_check_mpal
	addiu t0, t0, -1
	li v0, VI_NTSC_CLOCK
	jr ra
	nop
_sys_get_clock_check_mpal:
	li v0, VI_MPAL_CLOCK
	jr ra
	nop

sys_random:
// a0 = r0 ignored for now
// a1 = maximum
// v0 @ return = random number
// t0 System Video Clock
// t1 Current Video Line
// t2 Current Counter Value
	STACK_PUSH(ra)
	jal sys_get_clock
	nop
	sll t0, v0, 5	
	la t1, (VI_BASE << 16) | VI_V_CURRENT_LINE
	lw t1, 0(t1)
	mfc0 t2, Count
	// Make 1 value of our 3 Entropies
	// t0 shifted left is largest
	// quickly add all the others
	// Div by maximum is where it gets random
	addu t0, t0, t1
	addu t0, t0, t2
	//subu a0, a1, a0 // Removes the minimum?
	divu t0, a1
	STACK_POP(ra)
	jr ra
	mfhi v0
// These could incorporate DMA to make all memory moves identical
sys_memcopy:
_sys_memcopy_loop:
	lw t4, 0(a0)
	lw t5, 4(a0)
	lw t6, 8(a0)
	lw t7, 12(a0)
	sw t4, 0(a1)
	sw t5, 4(a1)
	sw t6, 8(a1)
	sw t7, 12(a1)
	addi t2, t2, -16
	addi t0, t0, 16
	bnel t2, r0, _sys_memcopy_loop
	addi t1, t1, 16
	jr ra
	nop
sys_memmove:
	jr ra
	nop
sys_move_bytes:
	jr ra
	nop
sys_mem_parm_check:
	jr ra
	nop
// Call Example
// 	la a0, $8000'0000
//	li a1, 64
//	jal sys_zero_fill
//	nop
// 4 byte aligned
// max 16bit range
sys_zero_fill:
	add t0, r0, r0
	andi a1, a1, $FFFC
	add t1, a0, a1		
	sw t0, 0(a0)
_sys_zero_fill_loop:
	addi a0, a0, 4
	bnel a0, t1, _sys_zero_fill_loop
	sw t0, 0(a0)
	jr ra
	nop
// Call Example
// 	la a0, $8000'0000
//	li a1, 64
//	jal sys_max_fill
//	nop
// 4 byte aligned
// max 16bit range
sys_max_fill:
	addiu t0, r0, -1
	andi a1, a1, $FFFC
	add t1, a0, a1		
	sw t0, 0(a0)
_sys_max_fill_loop:
	addi a0, a0, 4
	bnel a0, t1, _sys_max_fill_loop
	sw t0, 0(a0)
	jr ra
	nop
// Assumed to spin cycles, i.e. nothing else happens
// Example Logo Startup Screens
sys_delay_ms:
	// a0 = ms
	STACK_PUSH(ra)
	jal sys_get_clock
	add t0, r0, v0
	multu a0, t0
	mfc0 t1, Count
	mflo t2
	add t2, t1, t2
_sys_delay_ms_loop:
	mfc0 t1, Count
	// Not working yet
	STACK_POP(ra)
	jr ra
	nop
	
// sys_count_* 
// Takes 187 Clock Cycles
// Timing accuracy is far lower.
// 0x5D = 93 Nothing
// 0x71 = 113 ScreenNTSC Macro
_sys_count_addr_start1:
dw 0x0
_sys_count_addr_end1:
dw 0x0
align(8)
sys_count_start1: // 187 Count
	la v1, _sys_count_addr_start1
	mfc0 v0, Count // 93 Count
	jr ra
	sw v0, 0(v1)

sys_count_end1:
	la v1, _sys_count_addr_end1
	mfc0 v0, Count
	jr ra
	sw v0, 0(v1)
	
sys_count_diff1:
	la v0, _sys_count_addr_start1
	lw v0, 0(v0)
	la v1, _sys_count_addr_end1
	lw v1, 0(v1)
	addiu v0, v0, 93 // Remove 'overhead'
	jr ra
	subu v0, v1, v0

_sys_count_addr_start2:
dw 0x0
_sys_count_addr_end2:
dw 0x0
align(8)
sys_count_start2:
	la v1, _sys_count_addr_start2
	mfc0 v0, Count
	jr ra
	sw v0, 0(v1)

sys_count_end2:
	la v1, _sys_count_addr_end2
	mfc0 v0, Count
	jr ra
	sw v0, 0(v1)
sys_count_diff2:
	la v0, _sys_count_addr_start2
	lw v0, 0(v0)
	la v1, _sys_count_addr_end2
	lw v1, 0(v1)
	addiu v0, v0, 93 // Remove 'overhead'
	jr ra
	subu v0, v1, v0
	
_sys_count_addr_start3:
dw 0x0
_sys_count_addr_end3:
dw 0x0
align(8)
sys_count_start3:
	la v1, _sys_count_addr_start3
	mfc0 v0, Count
	jr ra
	sw v0, 0(v1)

sys_count_end3:
	la v1, _sys_count_addr_end3
	mfc0 v0, Count
	jr ra
	sw v0, 0(v1)
sys_count_diff3:
	la v0, _sys_count_addr_start3
	lw v0, 0(v0)
	la v1, _sys_count_addr_end3
	lw v1, 0(v1)
	addiu v0, v0, 93 // Remove 'overhead'
	jr ra
	subu v0, v1, v0
	
_sys_count_addr_start4:
dw 0x0
_sys_count_addr_end4:
dw 0x0
align(8)
sys_count_start4:
	la v1, _sys_count_addr_start4
	mfc0 v0, Count
	jr ra
	sw v0, 0(v1)

sys_count_end4:
	la v1, _sys_count_addr_end4
	mfc0 v0, Count
	jr ra
	sw v0, 0(v1)
sys_count_diff4:
	la v0, _sys_count_addr_start4
	lw v0, 0(v0)
	la v1, _sys_count_addr_end4
	lw v1, 0(v1)
	addiu v0, v0, 93 // Remove 'overhead'
	jr ra
	subu v0, v1, v0
	
sys_interrupt_depth:
dw 0x0
align(8)
sys_interrupt_activate:
	mfc0 t0, Status
	ori t0, 1
	mtc0 t0, Status
	jr ra
	nop
	
sys_interrupt_deactivate:
	mfc0 t0, Status
	la t1, ~1
	and t0, t1
	mtc0 t0, Status
	jr ra
	nop
	
sys_interrupt_sp_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_sp
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_sp_reset:
	la a0, (SP_BASE << 16) | SP_STATUS
	lw a1, 0(a0)
	nop
	ori a1, a1, sp_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_sp_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_sp
	sw a1, 0(a0)
	jr ra
	nop

sys_interrupt_si_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_si
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_si_reset:
	la a0, (SI_BASE << 16) | SI_STATUS
	lw a1, 0(a0)
	nop
	ori a1, a1, si_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_si_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_si
	sw a1, 0(a0)
	jr ra
	nop
	
sys_interrupt_ai_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_ai
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_ai_reset:
	la a0, (AI_BASE << 16) | AI_STATUS
	lw a1, 0(a0)
	nop
	ori a1, a1, ai_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_ai_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_ai
	sw a1, 0(a0)
	jr ra
	nop

sys_interrupt_vi_enable:
	beq a0, r0, _sys_interrupt_vi_enable2 // Trashes t0 if true
	la t0, (VI_BASE << 16) | VI_V_INTR
	sw a0, 0(t0)
_sys_interrupt_vi_enable2:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_vi
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_vi_reset:
	la a0, (VI_BASE << 16) | VI_V_CURRENT_LINE
	lw a1, 0(a0)
	nop
	nop
	sw a1, 0(a0) // Write same value back to reset Interrupt
	jr ra
	nop
sys_interrupt_vi_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_vi
	sw a1, 0(a0)
	jr ra
	nop

sys_interrupt_pi_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_pi
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_pi_reset:
	la a0, (PI_BASE << 16) | PI_STATUS
	lw a1, 0(a0)
	nop
	ori a1, a1, pi_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_pi_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_pi
	sw a1, 0(a0)
	jr ra
	nop

sys_interrupt_dp_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_dp
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_dp_reset:
	la a0, (MI_BASE << 16) | MI_INIT_MODE
	lw a1, 0(a0)
	nop
	ori a1, a1, dp_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
sys_interrupt_dp_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_dp
	sw a1, 0(a0)
	jr ra
	nop
