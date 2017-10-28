arch n64.cpu
endian msb
fill 1052672

origin $00000000
base $80000000 
	include "../LIB/N64.INC" 
	include "../LIB/N64_GFX.INC"
	include "../LIB/N64_INTERRUPT.INC"
	include "./N64_HEADER.ASM" // Include 64 Byte Header & Vector Table
	insert "../LIB/N64_BOOTCODE.BIN" // Include 4032 Byte Boot Code
force_pc($80001000)
Start:
	align(8)
	//N64_INIT()
	interrupt_init()
	interrupt_set_default(ExceptionHandler) // Interrupts Active by Default
	ScreenNTSC(320, 240, BPP32, $A0100000) // Screen NTSC: 320x240, 32BPP, DRAM Origin $A0100000
	// Insert Initialization Code
	nop // Marker NOP's 
	nop // Marker NOP's 

	// TLB Exception - Handled by the Handler, no developer action
	la t0, 0x00000000
	lw t0, 0(t0)
	nop // Marker NOP's 
	nop // Marker NOP's 
	
	// BREAK Instruction
	interrupt_set_break(ExceptionHandler)
	break
	nop // Marker NOP's 
	nop // Marker NOP's 
	
	// SYSCALL Instruction
	interrupt_set_syscall(syscall_mars)
	//lui a0, r0
	//ori a0, 10
	//syscall
	
	// Timer Exception - Just before Inifinite loop
	interrupt_set_timer(ExceptionHandler)
	nop
	mfc0 t0, Count
	li t1, 0x1FFFFF // 2 Million
	add t0, t1, t0
	mtc0 t0, Compare	
	interrupt_timer_enable()
Loop:
	// Insert Looping Code Here
	j Loop
	nop // Delay Slot

	nop // Marker NOP's 
	nop // Marker NOP's 
	
ExceptionHandler:
	// interrupt_register_* macros allow the use of any register
	// Otherwise only k0, k1, ra can be used.
    interrupt_register_save() 
	//
    // Your Code Here
	//
	interrupt_register_restore()	
	
	jr ra
	nop
	
// Shared Function Libraries
include "../LIB/N64_SYS.S"
include "../LIB/N64_INTERRUPT.S"
include "../LIB/N64_INTERRUPT_HANDLER.S"
include "../LIB/N64_SYSCALL_MARS.S"