arch n64.cpu
endian msb
fill 1052672

origin $00000000
base $80000000 
include "../LIB/N64.INC" 
include "../LIB/COLORS16.INC" 
include "../LIB/N64_INTERRUPT.INC"
include "N64_HEADER.ASM" 
insert "../LIB/N64_BOOTCODE.BIN" 

Start:  
	include "../LIB/N64_GFX.INC"
	N64_INIT()
	ScreenNTSC(320, 240, BPP32, $A0100000) // Screen NTSC: 320x240, 32BPP, DRAM $A0100000
	nop // Marker NOP's 
	nop // Marker NOP's 
	
	nop // Marker NOP's 
	nop // Marker NOP's 
	interrupt_init()
	//interrupt_tlb(interrupt_tlb_handler)
	//interrupt_xtlb(interrupt_xtlb_handler)
	//interrupt_cache(interrupt_cache_handler)
	interrupt_default(gdb_interrupt_handler)
	//interrupt_vblank($200,interrupt_vblank_handler)
	nop // Marker NOP's 
	nop // Marker NOP's 
	
	// Force Default Handler
	interrupt_sync()

	// Force TLB Interrupt
	lui v0,$7000
	lw v1,0000 (v0)
	nop // Marker NOP's 
	nop // Marker NOP's 
Loop:
  j Loop
  nop // Delay Slot
  
interrupt_tlb_handler:
	jr ra
	nop
interrupt_xtlb_handler:
	jr ra
	nop
interrupt_cache_handler:
	jr ra
	nop
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