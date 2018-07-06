arch n64.cpu
endian msb
output "Exception.N64", create
fill 1052672

origin $00000000
base $80000000
include "../LIB/N64.INC"
include "N64_HEADER.ASM"
insert "../LIB/N64_BOOTCODE.BIN"

// constant exp_interrupt(0) //Not applicable
constant exp_tlb_modification(1)
constant exp_tlb_miss_misc(2)
constant exp_tlb_miss_store(3)
constant exp_addr_misc(4)
constant exp_addr_store(5)
constant exp_bus_fetch(6)
constant exp_bus_misc(7)
constant exp_syscall(8)
constant exp_breakpoint(9)
constant exp_reserved_instruction(10)
constant exp_coprocessor_unusable(11)
constant exp_arithmetic_overflow(12)
constant exp_trap(13)
//constant unused(14)
constant exp_floating_point(15)
constant int_MI_SP_entry(16)
constant int_MI_SI_entry(17)
constant int_MI_AI_entry(18)
constant int_MI_VI_entry(19)
constant int_MI_PI_entry(20)
constant int_MI_DP_entry(21)
// constant unused(22)
constant exp_watch(23)
constant int_software0_entry(24)
constant int_software1_entry(25)
constant int_RCP_entry(26)
//constant int_unused_entry(27)
constant int_PIF_entry(28)
//constant int_unused_entry(29)
//constant int_unused_entry(30)
constant int_timer_entry(31)

macro setHandler(handler_name, handler_label) {
	nop // Marker NOP's 
	la t0, libn64_exception_jump_table
	li t1, {handler_label}	
	sw t1, {handler_name}<<2(t0)
	nop // Marker NOP's 
}

macro setInterrupt(enable_mask) {
	nop // Marker NOP's 
	mfc0 t0, SR
	ori t0, t0, {enable_mask}
	mtc0 t0, SR
	nop // Marker NOP's 
}

macro fireSoftwareInterrupt0() {
	mfc0 t0, Cause
	ori t0, t0, 0x0100
	mtc0 t0, Cause
}

macro fireSoftwareInterrupt1() {
	mfc0 t0, Cause
	ori t0, t0, 0x0200
	mtc0 t0, Cause
}

Start:
	N64_INIT()

	setInterrupt(0x0)
	
	DMA(libn64_tlb_exception_handler, libn64_tlb_exception_handler_end, 0x8000000)

  	nop // Marker NOP's 
	nop // Marker NOP's 

	lui t1, PI_BASE
dma_incomplete:
	lw t2, PI_STATUS(t1)
	bne t2, r0, dma_incomplete
	nop
  	nop // Marker NOP's 
	nop // Marker NOP's 

	setHandler(exp_tlb_modification, software0)
// Test Cases
// Software Interrupts
	setHandler(int_software0_entry, software0)
	setInterrupt(0x0101)
	fireSoftwareInterrupt0()
	
  	nop // Marker NOP's 
	nop // Marker NOP's 

	setHandler(int_software1_entry, software1)
	setInterrupt(0x0201)
	fireSoftwareInterrupt1()
	
	setInterrupt(0x0)
  	nop // Marker NOP's 
	nop // Marker NOP's 
	
// Timer Interrupts
	setHandler(int_timer_entry, timer)
	mfc0 t0, Compare
	addi t0, t0, 0x1000
	mtc0 t0, Compare
	setInterrupt(0x0801)
	

  	nop // Marker NOP's 
	setInterrupt(0x0)
	nop // Marker NOP's 

Loop:
    j Loop
    nop

software0:
	ori t4, r0, 123
	jr ra
	nop

software1:
	ori t4, r0, 234
	jr ra
	nop
timer:
	ori t4, r0, 345
	jr ra
	nop

include "./Exception.asm"