align(8)
//B0001500
//10110000000000000001010100000000
//00010000000000000001010100000000
// Additional code outside the Exception Handler
// 
exception_handler_init:
	lui t0, PI_BASE
	// DMA sees DRAM starting @ 0x00000000
	// VR4300 sees it at 0x80000000
	la t1, 0x0 // libn64_tlb_exception_handler - 0x80000000
	sw t1, 0(t0)
	lui t2, 0xE000
	la t1, libn64_tlb_exception_handler - 0x80000000
	//xor t1, t1, t2
	sw t1, 4(t0)
	addiu t1, r0, $300 - 1
	sw t1, 0xC(t0)
	jr ra
	nop
	nop
	nop
exception_handler_show:
	lui k1, VI_BASE
	lw k1, VI_ORIGIN(k1)
	addiu k0, $FFFF -2
_loopFrameBuffer: 
	sw r0, 0(k1)
	addi k1,k1,4
	bne k0,r0,_loopFrameBuffer 
	addi k0, k0, -1	
	li k0,0x3FFFFFF
delay:
	bnel k0, r0, delay
	addi k0, k0, -1
	jr ra
	nop
	

exception_handler_cart:
variable old_base(base())
db "exct"
align(128)
libn64_tlb_exception_handler:
base $80000000
	dmfc0 k1, Context	
	nop
	lw k0, 0(k1)
	lw k1, 8(k1)
	mtc0 k0, EntryLo0
	mtc0 k1, EntryLo1
	nop
	tlbwr
if {defined SHOW_EXCEPTIONS} {	
	jal exception_handler_show
	nop
}
	eret
exception_default_step1:
	
	mtc0 ra, $30
	la ra, N64_SCALER
	sw k0, k0(ra)
	mfc0 k0, Cause // Get Cause
	sw k1, k1(ra)
	mfc0 k1, $30
	sw at, at(ra)
	sw k1, k1(ra)
	mfc0 k1, Status
	and k0, k0, k1
	j exception_default_step2
	nop
align(128)
// N64 can but does not run in User/Supervisor mode
// libn64_xtlb_exception_handler: 
	dmfc0 k1, XContext	
	nop
	lw k0, 0(k1)
	lw k1, 8(k1)
	mtc0 k0, EntryLo0
	mtc0 k1, EntryLo1
	nop
	tlbwr
if {defined SHOW_EXCEPTIONS} {	
	jal exception_handler_show
	nop
}
	eret	
exception_default_step2:
	// TODO: Code Here
	j exception_default_step3
	nop
align(128)
// Not Applicable
//libn64_cache_exception_handler: 
exception_default_step3:
// TODO: Code Here
	j exception_default_step4
	nop
align(128)
libn64_default_exception_handler:
	j exception_default_step1
	nop
exception_default_step4:
// TODO: Code Here

if {defined SHOW_EXCEPTIONS} {	
	jal exception_handler_show
	nop
}
	eret
// Get this less than 0x300 in size
libn64_tlb_exception_handler_end:
base old_base

align(8)
db "Exeption registers"
libn64_exception_register_store:
// Scaler Registers
N64_SCALER:
dd 0x0, 0x0, 0x0, 0x0,  0x0, 0x0, 0x0, 0x0
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
db "End of Scaler"
N64_COP0:
dd 0, 0, 0, 0,  0, 0, 0, 0
db "End of Ctrl"
N64_COP1: // Floating Point
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
db "End of Float"