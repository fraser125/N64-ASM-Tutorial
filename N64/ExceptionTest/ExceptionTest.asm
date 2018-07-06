arch n64.cpu
endian msb
fill 1052672

origin $00000000
base $80000000 
	include "../LIB/N64.INC" 
	include "../LIB/N64_GFX.INC" 
	include "./N64_HEADER.ASM" // Include 64 Byte Header & Vector Table
	insert "../LIB/N64_BOOTCODE.BIN" // Include 4032 Byte Boot Code
constant Status_All_Exceptions(0xFF10)
// CU   RP FR RE DS          IM        KX SX UX KSU ERL EXL IE
// 0011 0  1  0  000'000'000 0000'0000 0  0  0  00  0   0   0
// 0000 0  0  0  000'000'000 1111'1111 0  0  0  10  0   0   1

force_pc($80001000)
Start:
	align(8)
	N64_INIT()
	ScreenNTSC(320, 240, BPP32, $A0100000) // Screen NTSC: 320x240, 32BPP, DRAM Origin $A0100000
	// Insert Initialization Code

	mfc0 s0, SR
	// Copy Exception Handler code
	la t0, $8000'0000
	la t1, ExceptionHandlerBlock
	la t2, ExceptionHandlerBlockEnd	
repeat_load_exception:
	lw t3, 0(t1)
	lw t4, 4(t1)
	lw t5, 8(t1)
	lw t6, 12(t1)
	sw t3, 0(t0)
	sw t4, 4(t0)
	sw t5, 8(t0)
	sw t6, 12(t0)
	addi t1, t1, 16
	bne t1, t2, repeat_load_exception
	addi t0, t0, 16
	nop
	nop
	// Copy Exception Handler code to Cache area
	la t0, $A000'0000
	la t1, ExceptionHandlerBlock
	la t2, ExceptionHandlerBlockEnd	
repeat_load_exception_cache:
	lw t3, 0(t1)
	lw t4, 4(t1)
	lw t5, 8(t1)
	lw t6, 12(t1)
	sw t3, 0(t0)
	sw t4, 4(t0)
	sw t5, 8(t0)
	sw t6, 12(t0)
	addi t1, t1, 16
	bne t1, t2, repeat_load_exception_cache
	addi t0, t0, 16
	nop
	nop
	
	la t8, savedCP0
	jal save_cop0
	nop
	// Throws TLB Exception
	lui t2, r0;
	sw t3, 0(t2) 
	nop
	nop
	nop



	
	// Throw XTLB Exception
	mfc0 t7, SR
	li t8, 0x20
	not t8, t8
	and t7, t7, t8
	mtc0 t7, SR	
	ori t7, t7, 1
	mtc0 t7, SR
	// Try to access Memory above 4 GB
	addi t2, r0, -1;	
	sw t3, 0(t2)  // TODO: Doesn't work yet
	nop
	nop
	nop
	
	// Throw Cache Exception - Not Applicable on VR4300
	
	// Break Instruction
	break // TODO: Doesn't work yet
	
	// Syscall Instruction
//	syscall // TODO: Doesn't work yet
	
	// CP0 Disable - Control Processor
	mfc0 t7, SR
	li t8, 0x10000000 
	not t8, t8
	and t7, t7, t8
	ori t7, t7, 0x10
	mtc0 t7, SR	
	ori t7, t7, 1
	mtc0 t7, SR
	nop
	// Try to use CP0
	mtc0 t7, SR // TODO: Doesn't work yet
	nop
	nop
	nop
	
	// Set CP1 Disable - Floating Point Unit
	mfc0 t7, SR
	li t8, 0x20000000 
	not t8, t8
	and t7, t7, t8
	mtc0 t7, SR	
	ori t7, t7, 1
	mtc0 t7, SR
	nop
	// Try to use Floating Point Unit	
	la t0, VALUEDOUBLEA
	ldc1 f0, 0(t0)
	nop
	nop
	nop

	
	
Loop:
	// Insert Looping Code Here
	j Loop
	nop // Delay Slot
	
save_cop0:
	dmfc0 t0, Index
	dmfc0 t1, Random
	dmfc0 t2, EntryLo0
	dmfc0 t3, EntryLo1
	dmfc0 t4, Context
	dmfc0 t5, PageMask
	dmfc0 t6, Wired
	sw t0, 0x00(k0)
	sw t1, 0x08(k0)
	sw t2, 0x0F(k0)
	sw t3, 0x17(k0)
	sw t4, 0x1F(k0)
	sw t5, 0x27(k0)
	sw t6, 0x2F(k0)
	
	// dmfc0 t3, EntryLo1
	// sw t3, 0x37(k0)
	
	dmfc0 t0, BadVAddr
	dmfc0 t1, Count
	dmfc0 t2, EntryHi
	dmfc0 t3, Compare
	dmfc0 t4, Status
	dmfc0 t5, Cause
	dmfc0 t6, EPC
	
	sw t0, 0x3F(k0)
	sw t1, 0x47(k0)
	sw t2, 0x4F(k0)
	sw t3, 0x57(k0)
	sw t4, 0x5F(k0)
	sw t5, 0x67(k0)
	sw t6, 0x6F(k0)
	
	dmfc0 t0, PRevID
	dmfc0 t1, Config
	dmfc0 t2, LLAddr
	dmfc0 t3, WatchLo
	dmfc0 t4, WatchHi
	dmfc0 t5, XContext
	
	sw t0, 0x77(k0)
	sw t1, 0x7F(k0)
	sw t2, 0x87(k0)
	sw t3, 0x8F(k0)
	sw t4, 0x97(k0)
	sw t5, 0x9F(k0)
	
	dmfc0 t0, PErr
	dmfc0 t1, CacheErr
	dmfc0 t2, TagLo
	dmfc0 t3, TagHi
	dmfc0 t4, ErrorEPC
	
	sw t0, 0xCF(k0)
	sw t1, 0xD7(k0)
	sw t2, 0xDF(k0)
	sw t3, 0xE7(k0)
	sw t4, 0xEF(k0)
	
align(128)
savedCP0:
fill 256, 0x55
rIndex: // 0
rRandom: // 1
rEntryLo0: // 2
rEntryLo1: // 3
rContext: // 4
rPageMask: // 5
rWired: // 6
// 7
rBadVAddr: // 8
rCount: // 9
rEntryHi: // 10
rCompare: // 11
rStatus: // SR, 12
rCause: // 13
rEPC: // 14
rPRId: // 15
rConfig: // 16
rLLAddr: // 17
rWatchLo: // 18
rWatchHi: // 19
rXContext: // 20
// 21
// 22
// 23
// 24
// 25
rPErr: // 26
rCacheErr: // 27
rTagLo: // 28
rTagHi: // 29
rErrorEPC: // 30
// 31
saved_cp0_end:

align(128)
screen_char:
 // 49 columns 637 of 640 pixels
 // 34 rows 476 of 480 pixels
 // 1,666 total characters on screen
 fill 49, 0x00
 fill 49, 0x01
 fill 49, 0x02
 fill 49, 0x03
 fill 49, 0x04
 fill 49, 0x05
 fill 49, 0x06
 fill 49, 0x07
 fill 49, 0x08
 fill 49, 0x09
 fill 49, 0x0A
 fill 49, 0x0B
 fill 49, 0x0C
 fill 49, 0x0D
 fill 49, 0x0E
 fill 49, 0x0F
 fill 49, 0x10
 fill 49, 0x11
 fill 49, 0x12
 fill 49, 0x13
 fill 49, 0x14
 fill 49, 0x15
 fill 49, 0x16
 fill 49, 0x17
 fill 49, 0x18
 fill 49, 0x19
 fill 49, 0x1A
 fill 49, 0x1B
 fill 49, 0x1C
 fill 49, 0x1D
 fill 49, 0x1E
 fill 49, 0x1F
 fill 49, 0x20
 fill 49, 0x21
 fill 49, 0x22 
screen_char_end:

align(128)
exception_cp0:
fill 256, 0x55
exception_cp0_end:

align(128)
ExceptionHandlerBlock:
// TLB Handler
	la k0, exception_cp0
	jal save_cop0
	nop
	mfc0 k0, EPC
	mtc0 s0, SR
	addi k0, k0, 4
	mtc0 k0, EPC
	nop
	eret
	nop
	fill 100, 0xAA	
align(128)
// XTLB Handler
	mfc0 k0, EPC
	mtc0 s0, SR
	addi k0, k0, 4
	mtc0 k0, EPC
	nop
	eret
	nop
	fill 100, 0xBB
align(128)
// Cache Handler
	mfc0 k0, EPC
	mtc0 s0, SR
	addi k0, k0, 4
	mtc0 k0, EPC
	nop
	eret
	nop
	fill 100, 0xCC
align(128)
// General Handler
	mfc0 k0, EPC
	mtc0 s0, SR
	addi k0, k0, 4
	mtc0 k0, EPC
	nop
	eret
	nop
	fill 100, 0xDD
ExceptionHandlerBlockEnd:
db 0xff
align(8) // Align 64-Bit
VALUEDOUBLEA:
  float64 0.0