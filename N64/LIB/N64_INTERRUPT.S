constant exception_destination($80000000)
align(8)
_interrupt_init:
	la t0, _inthandler_overlay
	li t1, exception_destination
	addi t2, r0, 512
_interrupt_init_loop:
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
	bnel t2, r0, _interrupt_init_loop
	addi t1, t1, 16
	
	// V4300i Interrupt_Init
	mfc0 t0, Status
	ori t0, 0x401
	mtc0 t0, Status
	// RCP Interrupt_Init
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	li a1, mi_mask_clear_all
	sw a1, 0(a0)

	jr ra
	nop	
	nop
	
align(8)
interrupt_set_debug:
	// Set all empty Jump Table Entries to the debug handler.	
	li t0, 52
	la t1,InterruptHandlers
	add t3, t1, t0
_interrupt_set_debug_int_loop:
	lw t2, 0(t1)
	nop
	nop
	beql t2, r0, _interrupt_set_debug_int_next
	add t2, r0, a0
	sw t2, 0(t1)
_interrupt_set_debug_int_next:
	bnel t1, t3, _interrupt_set_debug_int_loop
	add t1, t1, 4
	
_interrupt_set_debug_exceptions:
	li t0, 64
	la t1,ExceptionHandlers
	add t3, t1, t0

	
	jr ra
	nop	
	
interrupt_activate:
	mfc0 t0, Status
	ori t0, 1
	mtc0 t0, Status
	jr ra
	nop
	
interrupt_deactivate:
	mfc0 t0, Status
	la t1, ~1
	and t0, t1
	mtc0 t0, Status
	jr ra
	nop

interrupt_timer_reset:
	jr ra
	nop
	
interrupt_sp_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_sp
	sw a1, 0(a0)
	jr ra
	nop
interrupt_sp_reset:
	la a0, (SP_BASE << 16) | SP_STATUS
	lw a1, 0(a0)
	nop
	ori a1, a1, sp_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
interrupt_sp_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_sp
	sw a1, 0(a0)
	jr ra
	nop

interrupt_si_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_si
	sw a1, 0(a0)
	jr ra
	nop
interrupt_si_reset:
	la a0, (SI_BASE << 16) | SI_STATUS
	lw a1, 0(a0)
	nop
	ori a1, a1, si_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
interrupt_si_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_si
	sw a1, 0(a0)
	jr ra
	nop
	
interrupt_ai_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_ai
	sw a1, 0(a0)
	jr ra
	nop
interrupt_ai_reset:
	la a0, (AI_BASE << 16) | AI_STATUS
	lw a1, 0(a0)
	nop
	ori a1, a1, ai_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
interrupt_ai_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_ai
	sw a1, 0(a0)
	jr ra
	nop

interrupt_vi_enable:
	beq a0, r0, _interrupt_vi_enable2 // Trashes t0 if true
	la t0, (VI_BASE << 16) | VI_V_INTR
	sw a0, 0(t0)
_interrupt_vi_enable2:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_vi
	sw a1, 0(a0)
	jr ra
	nop
interrupt_vi_reset:
	la a0, (VI_BASE << 16) | VI_V_CURRENT_LINE
	lw a1, 0(a0)
	nop
	nop
	sw a1, 0(a0) // Write same value back to reset Interrupt
	jr ra
	nop
interrupt_vi_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_vi
	sw a1, 0(a0)
	jr ra
	nop

interrupt_pi_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_pi
	sw a1, 0(a0)
	jr ra
	nop
interrupt_pi_reset:
	la a0, (PI_BASE << 16) | PI_STATUS
	lw a1, 0(a0)
	nop
	ori a1, a1, pi_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
interrupt_pi_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_pi
	sw a1, 0(a0)
	jr ra
	nop

interrupt_dp_enable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_set_dp
	sw a1, 0(a0)
	jr ra
	nop
interrupt_dp_reset:
	la a0, (MI_BASE << 16) | MI_INIT_MODE
	lw a1, 0(a0)
	nop
	ori a1, a1, dp_clear_interrupt
	sw a1, 0(a0)
	jr ra
	nop
interrupt_dp_disable:
	la a0, (MI_BASE << 16) | MI_INTR_MASK
	lw a1, 0(a0)
	nop
	ori a1, a1, mi_mask_clear_dp
	sw a1, 0(a0)
	jr ra
	nop
align(8)
interrupt_saved_registers_std:
// Standard 32 Registers r0 - ra
dw $0, $0, $0, $0, $0, $0, $0, $0
dw $0, $0, $0, $0, $0, $0, $0, $0
dw $0, $0, $0, $0, $0, $0, $0, $0
dw $0, $0, $0, $0, $0, $0, $0, $0
// Additional Hi, Lo, etc
interrupt_saved_registers_misc:
dw $0, $0, $0, $0, $0, $0, $0, $0
// Floating Point Registers
interrupt_saved_registers_float:
dl $0, $0, $0, $0, $0, $0, $0, $0
dl $0, $0, $0, $0, $0, $0, $0, $0
dl $0, $0, $0, $0, $0, $0, $0, $0
dl $0, $0, $0, $0, $0, $0, $0, $0