arch n64.cpu
endian msb
output "Lesson2.N64", create
fill 1052672

origin $00000000
base $80000000 
include "../LIB/N64.INC" 
include "N64_HEADER.ASM" 
insert "../LIB/N64_BOOTCODE.BIN" 

Start:  
  lui t0,$BFC0 
  addi t1,r0,8
  sw t1,$7FC(t0)

Loop:
  j Loop
  nop // Delay Slot