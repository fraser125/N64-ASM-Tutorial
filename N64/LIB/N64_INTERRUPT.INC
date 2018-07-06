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

macro interrupt_set_audio(functionPointer) {
	la t0, _interrupt_AI
	la t1, {functionPointer}
	sw t1, 0(t0)	
}

macro interrupt_register_scalar_load() {
	la k1, interrupt_saved_registers_std
	// Save Registers
	lw at, at*4(k1)
	lw v0, v0*4(k1)
	lw v1, v1*4(k1)
	
	lw a0, a0*4(k1)
	lw a1, a1*4(k1)
	lw a2, a2*4(k1)
	lw a3, a3*4(k1)
	
	lw s0, s0*4(k1)
	lw s1, s1*4(k1)
	lw s2, s2*4(k1)
	lw s3, s3*4(k1)
	lw s4, s4*4(k1)
	lw s5, s5*4(k1)
	lw s6, s6*4(k1)
	lw s7, s7*4(k1)
	lw s8, s8*4(k1)

	lw gp, gp*4(k1)
	lw sp, sp*4(k1)
	
	lw t0, t0*4(k1)
	lw t1, t1*4(k1)
	lw t2, t2*4(k1)
	lw t3, t3*4(k1)
	lw t4, t4*4(k1)
	lw t5, t5*4(k1)
	lw t6, t6*4(k1)
	lw t7, t7*4(k1)
	lw t8, t8*4(k1)
	lw t9, t9*4(k1)
}

macro interrupt_register_scalar_store() {
	la k1, interrupt_saved_registers_std
	// Save Registers
	sw at, at*4(k1)
	sw v0, v0*4(k1)
	sw v1, v1*4(k1)
	
	sw a0, a0*4(k1)
	sw a1, a1*4(k1)
	sw a2, a2*4(k1)
	sw a3, a3*4(k1)
	
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
}

macro interrupt_register_float_load() {
	la k1, interrupt_saved_registers_float
	ldc1 f0, f0*8(k1)
	ldc1 f1, f1*8(k1)
	ldc1 f2, f2*8(k1)
	ldc1 f3, f3*8(k1)
	ldc1 f4, f4*8(k1)
	ldc1 f5, f5*8(k1)
	ldc1 f6, f6*8(k1)
	ldc1 f7, f7*8(k1)
	ldc1 f8, f8*8(k1)
	ldc1 f9, f9*8(k1)
	ldc1 f10, f10*8(k1)
	ldc1 f11, f11*8(k1)
	ldc1 f12, f12*8(k1)
	ldc1 f13, f13*8(k1)
	ldc1 f14, f14*8(k1)
	ldc1 f15, f15*8(k1)
	ldc1 f16, f16*8(k1)
	ldc1 f17, f17*8(k1)
	ldc1 f18, f18*8(k1)
	ldc1 f19, f19*8(k1)
	ldc1 f20, f20*8(k1)
	ldc1 f21, f21*8(k1)
	ldc1 f22, f22*8(k1)
	ldc1 f23, f23*8(k1)
	ldc1 f24, f24*8(k1)
	ldc1 f25, f25*8(k1)
	ldc1 f26, f26*8(k1)
	ldc1 f27, f27*8(k1)
	ldc1 f28, f28*8(k1)
	ldc1 f29, f29*8(k1)
	ldc1 f30, f30*8(k1)
	ldc1 f31, f31*8(k1)
}
macro interrupt_register_float_store() {
	la k1, interrupt_saved_registers_float
	swc1 f0, f0*8(k1)
	swc1 f1, f1*8(k1)
	swc1 f2, f2*8(k1)
	swc1 f3, f3*8(k1)
	swc1 f4, f4*8(k1)
	swc1 f5, f5*8(k1)
	swc1 f6, f6*8(k1)
	swc1 f7, f7*8(k1)
	swc1 f8, f8*8(k1)
	swc1 f9, f9*8(k1)
	swc1 f10, f10*8(k1)
	swc1 f11, f11*8(k1)
	swc1 f12, f12*8(k1)
	swc1 f13, f13*8(k1)
	swc1 f14, f14*8(k1)
	swc1 f15, f15*8(k1)
	swc1 f16, f16*8(k1)
	swc1 f17, f17*8(k1)
	swc1 f18, f18*8(k1)
	swc1 f19, f19*8(k1)
	swc1 f20, f20*8(k1)
	swc1 f21, f21*8(k1)
	swc1 f22, f22*8(k1)
	swc1 f23, f23*8(k1)
	swc1 f24, f24*8(k1)
	swc1 f25, f25*8(k1)
	swc1 f26, f26*8(k1)
	swc1 f27, f27*8(k1)
	swc1 f28, f28*8(k1)
	swc1 f29, f29*8(k1)
	swc1 f30, f30*8(k1)
	swc1 f31, f31*8(k1)
}

macro interrupt_register_COP0_load() {
	la k1, interrupt_saved_COP0_misc
	lw t0, Index*4(k1)
	lw t1, Random*4(k1)
	lw t2, EntryLo0*4(k1)
	lw t3, EntryLo1*4(k1)
	lw t4, Context*4(k1)
	lw t5, PageMask*4(k1)
	lw t6, Wired*4(k1)
	lw t7, BadVAddr*4(k1)
	lw t8, Count*4(k1)
	lw t9, EntryHi*4(k1)
	mtc0 t0, Index
	mtc0 t1, Random
	mtc0 t2, EntryLo0
	mtc0 t3, EntryLo1
	mtc0 t4, Context
	mtc0 t5, PageMask
	mtc0 t6, Wired
	mtc0 t7, BadVAddr
	mtc0 t8, Count
	mtc0 t9, EntryHi
	
	lw t0, Compare*4(k1)
	lw t1, Status*4(k1)
	lw t2, SR*4(k1)
	lw t3, Cause*4(k1)
	lw t4, EPC*4(k1)
	lw t5, PRevID*4(k1)
	lw t6, Config*4(k1)
	lw t7, LLAddr*4(k1)
	lw t8, WatchLo*4(k1)
	lw t9, WatchHi*4(k1)
	mtc0 t0, Compare
	mtc0 t1, Status
	mtc0 t2, SR
	mtc0 t3, Cause
	mtc0 t4, EPC
	mtc0 t5, PRevID
	mtc0 t6, Config
	mtc0 t7, LLAddr
	mtc0 t8, WatchLo
	mtc0 t9, WatchHi
	
	// PErr is used to store the 'ra' register
	lw t0, XContext*4(k1)
	//lw t1, PErr*4(k1)
	lw t2, CacheErr*4(k1)
	lw t3, TagLo*4(k1)
	lw t4, TagHi*4(k1)
	lw t5, ErrorEPC*4(k1)
	mtc0 t0, XContext
	//mfc0 t1, PErr
	mtc0 t2, CacheErr
	mtc0 t3, TagLo
	mtc0 t4, TagHi
	mtc0 t5, ErrorEPC
}

macro interrupt_register_COP0_store() {
	la k1, interrupt_saved_COP0_misc
	mfc0 t0, Index
	mfc0 t1, Random
	mfc0 t2, EntryLo0
	mfc0 t3, EntryLo1
	mfc0 t4, Context
	mfc0 t5, PageMask
	mfc0 t6, Wired
	mfc0 t7, BadVAddr
	mfc0 t8, Count
	mfc0 t9, EntryHi
	sw t0, Index*4(k1)
	sw t1, Random*4(k1)
	sw t2, EntryLo0*4(k1)
	sw t3, EntryLo1*4(k1)
	sw t4, Context*4(k1)
	sw t5, PageMask*4(k1)
	sw t6, Wired*4(k1)
	sw t7, BadVAddr*4(k1)
	sw t8, Count*4(k1)
	sw t9, EntryHi*4(k1)
	
	mfc0 t0, Compare
	mfc0 t1, Status
	mfc0 t2, SR
	mfc0 t3, Cause
	mfc0 t4, EPC
	mfc0 t5, PRevID
	mfc0 t6, Config
	mfc0 t7, LLAddr
	mfc0 t8, WatchLo
	mfc0 t9, WatchHi
	sw t0, Compare*4(k1)
	sw t1, Status*4(k1)
	sw t2, SR*4(k1)
	sw t3, Cause*4(k1)
	sw t4, EPC*4(k1)
	sw t5, PRevID*4(k1)
	sw t6, Config*4(k1)
	sw t7, LLAddr*4(k1)
	sw t8, WatchLo*4(k1)
	sw t9, WatchHi*4(k1)
	
	// PErr is used to store the 'ra' register
	mfc0 t0, XContext
	//mfc0 t1, PErr
	mfc0 t2, CacheErr
	mfc0 t3, TagLo
	mfc0 t4, TagHi
	mfc0 t5, ErrorEPC
	sw t0, XContext*4(k1)
	//sw t1, PErr*4(k1)
	sw t2, CacheErr*4(k1)
	sw t3, TagLo*4(k1)
	sw t4, TagHi*4(k1)
	sw t5, ErrorEPC*4(k1)
}

macro interrupt_register_misc_store() {
	la k1, interrupt_saved_registers_misc
	mfhi t0
	mflo t1
	sw t0, 0(k1)
	sw t1, 4(k1)
}

macro interrupt_register_misc_load() {
	la k1, interrupt_saved_registers_misc
	lw t0, 0(k1)
	lw t1, 4(k1)
	mthi t0
	mtlo t1
}

macro interrupt_register_store() {
	// 'ra' saved in the Handler code itself.
	// sw ra, ra*4(k1)
	// sw k0, *4(k1) Already wiped and re-used
	// sw k1, *4(k1) Already wiped and re-used

	// Store scaler registers first because they are used
	// for the misc and COP0 store macros
	interrupt_register_scalar_store()
	interrupt_register_misc_store()
	interrupt_register_COP0_store()
	interrupt_register_float_store()	
}

macro interrupt_register_load() {
	// misc & COP0 load's use the t0-t9 registers
	interrupt_register_misc_load()	
	interrupt_register_COP0_load()
	// Load t0-t9 after misc & COP0
	interrupt_register_scalar_load()
	interrupt_register_float_load()	
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
	jal _interrupt_mi_manage
	nop	
}

macro interrupt_sp_reset() {
	jal interrupt_sp_reset
	nop
}

macro interrupt_sp_disable() {
	jal interrupt_sp_disable
	nop
	jal _interrupt_mi_manage
	nop	
}


macro interrupt_si_enable() {
	jal interrupt_si_enable
	nop
	jal _interrupt_mi_manage
	nop	
}

macro interrupt_si_reset() {
	jal interrupt_si_reset
	nop
}

macro interrupt_si_disable() {
	jal interrupt_si_disable
	nop
	jal _interrupt_mi_manage
	nop	
}


macro interrupt_ai_enable() {
	jal interrupt_ai_enable
	nop
	jal _interrupt_mi_manage
	nop	
}

macro interrupt_ai_reset() {
	jal interrupt_ai_reset
	nop
}

macro interrupt_ai_disable() {
	jal interrupt_ai_disable
	nop
	jal _interrupt_mi_manage
	nop	
}


macro interrupt_vi_enable() {
	jal interrupt_vi_enable
	nop
	jal _interrupt_mi_manage
	nop	
}

macro interrupt_vi_reset() {
	jal interrupt_vi_reset
	nop
}

macro interrupt_vi_disable() {
	jal interrupt_vi_disable
	nop
	jal _interrupt_mi_manage
	nop	
}


macro interrupt_pi_enable() {
	jal interrupt_pi_enable
	nop
	jal _interrupt_mi_manage
	nop	
}

macro interrupt_pi_reset() {
	jal interrupt_pi_reset
	nop
}

macro interrupt_pi_disable() {
	jal interrupt_pi_disable
	nop
	jal _interrupt_mi_manage
	nop	
}


macro interrupt_dp_enable() {
	jal interrupt_dp_enable
	nop
	jal _interrupt_mi_manage
	nop	
}

macro interrupt_dp_reset() {
	jal interrupt_dp_reset
	nop
}

macro interrupt_dp_disable() {
	jal interrupt_dp_disable
	nop
	jal _interrupt_mi_manage
	nop	
}
