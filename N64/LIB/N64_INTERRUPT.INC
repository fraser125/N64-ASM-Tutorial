macro interrupt_init() {
	jal _interrupt_init
	nop
}

macro interrupt_tlb(functionPointer) {
	la t0, tlb_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_xtlb(functionPointer) {
	if ({functionPointer} > 0)
		error "XTLB only used in 64 bit mode"
}

macro interrupt_cache(functionPointer) {
	la t0, cache_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_default(functionPointer) {
	la t0, default_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_vblank(line, functionPointer) {	 
	lui t0,VI_BASE
	lli t1,{line}
	sw t1,VI_V_INTR(t0)
	
	la t0, vblank_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
	jal sys_interrupt_vi_enable
	nop
}

macro interrupt_sync() {
	break
}

macro interrupt_save_registers() {
	la k1, interrupt_saved_registers
	// Save Registers
	// at saved in the Handler code itself.
	//sw at, at*4(k1)
	sw v0, v0*4(k1)
	sw v1, v1*4(k1)
	
	sw a0, a0*4(k1)
	sw a1, a1*4(k1)
	sw a2, a2*4(k1)
	sw a3, a3*4(k1)
	
	sw t0, t0*4(k1)
	sw t1, t1*4(k1)
	sw t2, t2*4(k1)
	sw t3, t3*4(k1)
	sw t4, t4*4(k1)
	sw t5, t5*4(k1)
	sw t6, t6*4(k1)
	sw t7, t7*4(k1)
	sw t8, t8*4(k1)
	sw t9, t9*4(k1)

	sw s0, s0*4(k1)
	sw s1, s1*4(k1)
	sw s2, s2*4(k1)
	sw s3, s3*4(k1)
	sw s4, s4*4(k1)
	sw s5, s5*4(k1)
	sw s6, s6*4(k1)
	sw s7, s7*4(k1)
	sw s8, s8*4(k1)

	sw gp, gp*4(k1)
	sw sp, sp*4(k1)
	sw ra, ra*4(k1)

	// sw k0, *4(k1) Already wiped and re-used
	// sw k1, *4(k1) Already wiped and re-used
	
	mfhi t0	
	sw t0, 128(k1)
	mflo t1
	sw t1, 132(k1)	
	// Save off the Floating Point Registers
}

macro sys_interrupt_activate() {
	jal sys_interrupt_activate
	nop
}

macro sys_interrupt_deactivate() {
	jal sys_interrupt_deactivate
	nop
}

macro sys_interrupt_sp_enable() {
	jal sys_interrupt_sp_enable
	nop
}

macro sys_interrupt_sp_reset() {
	jal sys_interrupt_sp_reset
	nop
}

macro sys_interrupt_sp_disable() {
	jal sys_interrupt_sp_disable
	nop
}


macro sys_interrupt_si_enable() {
	jal sys_interrupt_si_enable
	nop
}

macro sys_interrupt_si_reset() {
	jal sys_interrupt_si_reset
	nop
}

macro sys_interrupt_si_disable() {
	jal sys_interrupt_si_disable
	nop
}


macro sys_interrupt_ai_enable() {
	jal sys_interrupt_ai_enable
	nop
}

macro sys_interrupt_ai_reset() {
	jal sys_interrupt_ai_reset
	nop
}

macro sys_interrupt_ai_disable() {
	jal sys_interrupt_ai_disable
	nop
}


macro sys_interrupt_vi_enable() {
	jal sys_interrupt_vi_enable
	nop
}

macro sys_interrupt_vi_reset() {
	jal sys_interrupt_vi_reset
	nop
}

macro sys_interrupt_vi_disable() {
	jal sys_interrupt_vi_disable
	nop
}


macro sys_interrupt_pi_enable() {
	jal sys_interrupt_pi_enable
	nop
}

macro sys_interrupt_pi_reset() {
	jal sys_interrupt_pi_reset
	nop
}

macro sys_interrupt_pi_disable() {
	jal sys_interrupt_pi_disable
	nop
}


macro sys_interrupt_dp_enable() {
	jal sys_interrupt_dp_enable
	nop
}

macro sys_interrupt_dp_reset() {
	jal sys_interrupt_dp_reset
	nop
}

macro sys_interrupt_dp_disable() {
	jal sys_interrupt_dp_disable
	nop
}
