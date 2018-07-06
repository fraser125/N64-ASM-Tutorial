// Notes:
// There can be only one Exception.
// If the Exception is "Interrupt" then there can be multiple Interrupts.
// Should the Exception handler be able to throw exceptions?
libn64_tlb_exception_handler:
variable old_base(base())
base $80000000
// ra when used correctly is 32bits, COP0$30 is 32 bits
// This frees up ra for anything, including Jumps
	mtc0 ra, $30
	la ra, libn64_tlb_exception_handler
	sw k0, k0(ra)
	mfc0 k0, Cause // Get Cause
	sw k1, k1(ra)
	andi k1, k0, 0x0F // mask 
	beql k1, r0, Interrupt
	nop
	// Process Exceptions
	// TODO Call Individual handler
	j int_x_continue
	nop
align(128)
libn64_xtlb_exception_handler:
	j $80000001
	nop
int_x_continue:
	// TODO More Code HERE
Interrupt:
	mfc0 k1, SR // Get Status
	andi k1, k1, $FF00 // mask 
	and k0, k0, k1
	addi k0, k0, 0x60 // 0x60 = 24 * 4
	li k1, libn64_exception_jump_table
	add k1, k0, k1
	lw k0, 0(k1)
	// FIX: Don't have the right memory address yet. 
	// TODO Call Individual handler
	j int_cache_continue
	nop
align(128)
libn64_cache_exception_handler:
	j $80000002
	nop
int_cache_continue:
	// TODO More Code HERE
	j int_general_continue
	nop
align(128)
libn64_general_exception_handler:
	j $80000003
	nop
int_general_continue:
	mfc0 k0, EPC
	// Restore the 'ra' register
	// TODO: Process Branch Delay Bit, 4 instructions
	mfc0 ra, PErr
	addiu k0, k0, 4
	mtc0 k0, EPC	
	eret
align(128)
libn64_tlb_exception_handler_end:
base old_base
db "JTBL"
libn64_exception_jump_table:
dw 0 // Interrupt type Exception
dw 0 // TLB Modification
dw 0 // TLB Miss (load or fetch)
dw 0 // TLB Miss (store)
dw 0 // Address Error (load or fetch)
dw 0 // Address Error (store)
dw 0 // Bus Error (instruction fetch)
dw 0 // Bus Error (load or store)
dw 0 // Syscall
dw 0 // Breakpoint
dw 0 // Reserved Instruction
dw 0 // Coprocessor Unusable
dw 0 // Arithmetic Overflow
dw 0 // Trap
db "RFU " // Unused - RFU
dw 0 // Floating Point
dw 0 // 16 MI-SP
dw 0 // 17 MI-SI
dw 0 // 18 MI-AI
dw 0 // 19 MI-VI
dw 0 // 20 MI-PI
dw 0 // 21 MI-DP
dw 0 // 22
dw 0 // Watch
dw 0 // 24 INT0 - Software 0
dw 0 // 25 INT1 - Software 1
dw 0 // 26 INT2 (PIN-INT0) - RCP
dw 0 // 27 INT3 (PIN-INT1) - Unused
dw 0 // 28 INT4 (PIN-INT2) - PIF
dw 0 // 29 INT5 (PIN-INT3) - Unused
dw 0 // 30 INT6 (PIN-INT4) - Unused
dw 0 // 31 INT7 - Timer
db "register"
libn64_exception_register_store:
// Scaler Registers
dd 0x0, 0x0, 0x0, 0x0,  0x0, 0x0, 0x0, 0x0
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
db "End of Scaler"
// COP0
dd 0, 0, 0, 0,  0, 0, 0, 0
db "End of Ctrl"
// COP1 Floating Point
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
dd 0, 0, 0, 0,  0, 0, 0, 0
db "End of Float"