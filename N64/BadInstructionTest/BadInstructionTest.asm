arch n64.cpu
endian msb
fill 1052672

origin $00000000
base $80000000 
	include "../LIB/N64.INC" 
	include "../LIB/N64_GFX.INC"
	include "../LIB/COLORS32.INC" 
	include "./N64_HEADER.ASM" // Include 64 Byte Header & Vector Table
	insert "../LIB/N64_BOOTCODE.BIN" // Include 4032 Byte Boot Code
force_pc($80001000)
Start:
	align(8)
variable vi_buffer(t7)
	li vi_buffer, $A0100000
	N64_INIT()
	ScreenNTSC(320, 240, BPP32, $A0100000) // Screen NTSC: 320x240, 32BPP, DRAM Origin $A0100000
	nop
	nop
variable backColor(s0)
	li backColor, BLUE_VIOLET
variable source(t0)
variable destination(t1)
variable length(t2)
variable count(t3)

	la source, GeneralHandler
	la destination, 0x80000180
	li length, 128
	li count, r0
loop_mem_cpy:
	lw s2, 0x0(source)
	lw s3, 0x4(source)
	lw s4, 0x8(source)
	lw s5, 0xC(source)
	sw s2, 0x0(destination)
	sw s3, 0x4(destination)
	sw s4, 0x8(destination)
	sw s5, 0xC(destination)
	bne length,count, loop_mem_cpy	
	addi count, count, 16
	
	
	nop
	nop
	dw 0x40806800
	nop
	nop
	
Loop:
	// Insert Looping Code Here
	li s6, vi_buffer+0x4B000
loop_color:
	sw backColor, 0x0(source)
	sw backColor, 0x4(source)
	sw backColor, 0x8(source)
	sw backColor, 0xC(source)
	bne source, s6, loop_color
	addi source, source, 16
	j Loop
	nop // Delay Slot
	
GeneralHandler:
	li backColor, DARK_ORANGE
	eret