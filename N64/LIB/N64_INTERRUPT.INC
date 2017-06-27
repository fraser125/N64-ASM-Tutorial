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
	jal interrupt_vi_enable
	nop
}

// Sets all "blank" 0x00 handlers to the Debug Handler
macro interrupt_set_debug(functionPointer) {
	la a0, {functionPointer}
	jal interrupt_set_debug
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

macro sys_interrupt_dp_disable() {
	jal interrupt_dp_disable
	nop
}
