// COP0 Config - EP Register
// COP0 Status FR bit to enable 64-bit Floating point Registers?
// 		Might be 16 x 64 bit or 32 x 32 bit
// COP0 Status DS Self Diagnostic Status Area
// COP0 Status DS is 8 bits
//		ITS - Instruction Trace Support
//		BEV - TLB & General Exception Vector
//		TS - TLB shutd down
//		SR - Soft Reset Exception
// 		CH - Condition bit of the CP0
//		CE - Cache Check bit use ECC register (Not used always 0)
//		DE - Cache Parity Error (Not used always 1)
// Packet Size: 448 + Overhead = 512?
//  General Purpose Registers: 128
// 	Miscellaneous Registers: 64
// 	Floating Point Registers: 256 
align(4)
gdb_receive_buffer:
fixed_gap(gdb_receive_buffer, 0x200)

gdb_transmit_buffer:
fixed_gap(gdb_transmit_buffer, 0x200)

// 0xFFFF'FFFF = Error
// 0x0 = Untested
// 0x1 = Exists
gdb_serial_status:
	dw 0x0
	
// Code
align(8)
gdb_interrupt_handler:
	la t0, gdb_serial_status
	lw t0, 0(t0)
	nop
	blez t0, _gdb_display_HUD
	nop
	bgtz t0, _gdb_serial_rxtx
	nop
_gdb_serial_rxtx:
_gdb_display_HUD:
_gdb_exit:
	jr ra
	nop
gdb_serial_test:
	// Save current TLB handler
	la t0, tlb_handler_ptr
	lw t1, 0(t0) // Save old pointer to t1
	// Insert our own Handler
	la t2, gdb_serial_tlb_handler
	sw t2, 0(t0)
	// Run our Test and Initialization
	//
	
	// Restore the original Handler
	la t0, tlb_handler_ptr
	sw t1, 0(t0)
	jr ra
	nop
gdb_serial_tlb_handler:
	la k0, gdb_serial_status
	addi k1, r0, -1
	sw k1, 0(k0)
	jr ra
	nop