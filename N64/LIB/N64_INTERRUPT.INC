macro interrupt_init() {
	jal _interrupt_init
	nop
}

macro interrupt_set_tlb(functionPointer) {
	la t0, tlb_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_set_xtlb(functionPointer) {
	if ({functionPointer} > 0)
		error "XTLB only used in 64 bit mode"
}

//macro interrupt_set_cache(functionPointer) {
//	la t0, cache_handler_ptr
//	la t1, {functionPointer}
//	sw t1, 0(t0)	
//}

macro interrupt_set_default(functionPointer) {
	la t0, default_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_set_vblank(line, functionPointer) {	 
	lui t0,VI_BASE
	lli t1,{line}
	sw t1,VI_V_INTR(t0)
	
	la t0, vblank_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
	jal interrupt_vi_enable
	nop
}

macro interrupt_set_syscall(functionPointer) {
	la t0, exc8_Sys_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_set_break(functionPointer) {
	la t0, exc9_Bp_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_set_watch(functionPointer) {
	la t0, exc23_WATCH_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_watch(address, read, write) {
	la t0, {address}
	li t1, {read}
	li t2, {write}
	sll t1, t1, 1
	and t0, t0, t1
	and t0, t0, t2
	mtc0 t0, WatchLo
}

// Sets all "blank" 0x00 handlers to the Debug Handler
macro interrupt_set_debug(functionPointer) {
	la a0, {functionPointer}
	jal interrupt_set_debug
	nop
}

macro interrupt_set_timer(functionPointer) {
	la t0, int7_handler_ptr
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_register_save() {
	la k1, interrupt_saved_registers_std
	// Save Registers
	sw at, at*4(k1)
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
	// 'ra' saved in the Handler code itself.
	//sw ra, ra*4(k1)

	// sw k0, *4(k1) Already wiped and re-used
	// sw k1, *4(k1) Already wiped and re-used
	
	mfhi t0	
	sw t0, 128(k1)
	mflo t1
	sw t1, 132(k1)	
	// TODO: Save off the Floating Point Registers
}

macro interrupt_register_restore() {
	nop
	nop
}

macro interrupt_activate() {
	jal interrupt_activate
	nop
}

macro interrupt_deactivate() {
	jal interrupt_deactivate
	nop
}

macro interrupt_timer_enable() {
	mfc0 t0, Status
	nop
	ori t0, 0x8000
	mtc0 t0, Status
}

macro interrupt_timer_disable() {
	mfc0 t0, Status
	ori t0, 1
	mtc0 t0, Status
}

macro interrupt_timer_reset() {
	jal interrupt_timer_reset
	nop
}

macro interrupt_sp_enable() {
	jal interrupt_sp_enable
	nop
}

macro interrupt_sp_reset() {
	jal interrupt_sp_reset
	nop
}

macro interrupt_sp_disable() {
	jal interrupt_sp_disable
	nop
}


macro interrupt_si_enable() {
	jal interrupt_si_enable
	nop
}

macro interrupt_si_reset() {
	jal interrupt_si_reset
	nop
}

macro interrupt_si_disable() {
	jal interrupt_si_disable
	nop
}


macro interrupt_ai_enable() {
	jal interrupt_ai_enable
	nop
}

macro interrupt_ai_reset() {
	jal interrupt_ai_reset
	nop
}

macro interrupt_ai_disable() {
	jal interrupt_ai_disable
	nop
}


macro interrupt_vi_enable() {
	jal interrupt_vi_enable
	nop
}

macro interrupt_vi_reset() {
	jal interrupt_vi_reset
	nop
}

macro interrupt_vi_disable() {
	jal interrupt_vi_disable
	nop
}


macro interrupt_pi_enable() {
	jal interrupt_pi_enable
	nop
}

macro interrupt_pi_reset() {
	jal interrupt_pi_reset
	nop
}

macro interrupt_pi_disable() {
	jal interrupt_pi_disable
	nop
}


macro interrupt_dp_enable() {
	jal interrupt_dp_enable
	nop
}

macro interrupt_dp_reset() {
	jal interrupt_dp_reset
	nop
}

macro interrupt_dp_disable() {
	jal interrupt_dp_disable
	nop
}
