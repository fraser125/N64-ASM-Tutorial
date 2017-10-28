arch n64.cpu
endian msb
fill 1052672

origin $00000000
base $80000000 
	include "../LIB/N64.INC" 
	include "./N64_HEADER.ASM" // Include 64 Byte Header & Vector Table
	insert "../LIB/N64_BOOTCODE.BIN" // Include 4032 Byte Boot Code
force_pc($80001000)
Start:
	align(8)
	N64_INIT()
	ScreenNTSC(320, 240, BPP32, $A0100000) // Screen NTSC: 320x240, 32BPP, DRAM Origin $A0100000
	// Insert Initialization Code
Loop:
	// Insert Looping Code Here
	j Loop
	nop // Delay Slot