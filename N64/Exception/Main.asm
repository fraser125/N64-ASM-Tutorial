arch n64.cpu
endian msb
output "Exception.N64", create
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

// DMA interrupt handler on top of the vector.
// First, write the DRAM (destination) register.
  lui at, 0xA460
  lui v0, 0x8000
  sw v0, 0(at) // RDRAM Location
  la v1, 0x10000000 + (libn64_tlb_exception_handler - 0x80000000)
  sw v1, 0x4(at) // Cart Location
  addiu v0, r0, 0x300 - 0x1
  sw v0, 0xC(at) // Start DMA from CART -> RDRAM
Loop:
    j Loop
    nop
include "./Exception.asm"