arch n64.cpu
endian msb
fill 1052672

origin $00000000
base $80000000 
// Useful for identifying where a value is in the output ROM file
// Commented = Zeros in Gaps + Interrupt Zeros
// Defined(1) = Filled Gaps + Interrupt Names
// Defined(0) = Filled Gaps + Interrupt Names
define DEBUG_SHOW_STATIC_VALUE(comment_out)
include "../LIB/COLORS16.INC" 
include "../LIB/N64.INC" 
include "../LIB/N64_DRIVE.INC"
include "../LIB/N64_GDB.INC"
include "../LIB/N64_GFX.INC"
include "../LIB/N64_INTERRUPT.INC"
include "N64_HEADER.ASM" 
insert "../LIB/N64_BOOTCODE.BIN" 

Start:  
	N64_INIT()
	ScreenNTSC(320, 240, BPP32, $A0100000) // Screen NTSC: 320x240, 32BPP, DRAM $A0100000
	nop // Marker NOP's 
	nop // Marker NOP's 
	interrupt_init()
	nop // Marker NOP's 
	nop // Marker NOP's 
	interrupt_tlb(gdb_serial_tlb_handler)
	nop // Marker NOP's 
	nop // Marker NOP's 
	gdb_communication_test()
	// Clear tlb handler so the debug handler will assign
	interrupt_tlb(0x00) 
	nop // Marker NOP's 
	nop // Marker NOP's 
	interrupt_set_debug(gdb_interrupt_handler)
	nop // Marker NOP's 
	nop // Marker NOP's 
	interrupt_vblank($200,interrupt_vblank_handler)
	nop // Marker NOP's 
	nop // Marker NOP's 
	
	// Force GDB Sync
	gdb_sync()

	nop // Marker NOP's 
	nop // Marker NOP's 
	// Force TLB Interrupt
	lui v0,$7000
	lw v1,0000 (v0)
	nop // Marker NOP's 
	nop // Marker NOP's 
Loop:
  j Loop
  nop // Delay Slot
  
interrupt_default_handler:
	jr ra
	nop
interrupt_vblank_handler:
	jr ra
	nop

include "../LIB/N64_INTERRUPT.S"
include "../LIB/N64_SYS.S"
include "../LIB/N64_GDB.S"
include "../LIB/N64_INTERRUPT_TEMPLATE.S"