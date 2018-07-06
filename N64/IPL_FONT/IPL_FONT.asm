arch n64.cpu
endian msb
fill 1052672

define SHOW_EXCEPTIONS(1)

origin $00000000
base $80000000 
	include "../LIB/N64.INC" 
	include "../LIB/N64_GFX.INC"
	include "../LIB/COLORS16.INC"
	include "../LIB/N64_IPL_FONT.INC"
	include "../LIB/N64_EXCEPTION.INC"
	include "./N64_HEADER.ASM" // Include 64 Byte Header & Vector Table
	insert "../LIB/N64_BOOTCODE.BIN" // Include 4032 Byte Boot Code
force_pc($80001000)
Start:
	align(8)
variable video_buffer($A0100000)
	N64_INIT()
	ScreenNTSC(640, 480, BPP16, video_buffer) // Screen NTSC: 640x480, 16BPP, DRAM Origin $A0100000
	nop
	nop
	exception_load_handler()
	//DMA(libn64_tlb_exception_handler, libn64_tlb_exception_handler_end, $80000000)
	nop
	nop
	variable font_good($8008'A000)
	font_init16(WHITE, SEA_GREEN, font_good)
	
variable font_fail($8008'F000)
	font_init16(WHITE, RED, font_fail)

variable font_white($8008'0000)
	font_init16(WHITE, 0x01, font_white)
	
variable font_blue($8008'5000)
	font_init16(STEEL_BLUE, 0x01, font_blue)
	
	nop
	nop
	font_print_line16(font_white, video_buffer, 10, 10, testtext, 31)
	font_print_line16(font_blue, video_buffer, 100, 30, myname, 20)
	
	font_print_line16(font_good, video_buffer, 50, 50, pass, 4)
	font_print_line16(font_fail, video_buffer, 75, 70, fail, 4)
Loop:
	
	j Loop
	nop // Delay Slot

include "../LIB/N64_IPL_FONT.S"
include "../LIB/N64_EXCEPTION.S"
	
map 'A',0,26	// A-Z	
map 'a',0,26	// a-z	
map '0',26,10	// 0-9	
map '!',36,3	// ! " #	
//map '\'', 39, 1	// '	
map '*', 40, 6	// * + , - . /	
map ':', 46, 1	// : 	
map '=', 47, 1	// = 	
map '?',48, 2	// ? @
map ' ',51, 1	// space
testtext:
db "the quick brown fox jumped over"
myname:
db "my name is fraser125"
pass:
db "pass"
fail:
db "fail"
map 0, 0, 256