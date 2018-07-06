arch n64.cpu
endian msb
	include "../LIB/N64.INC" 

// Every Handler can safely assume that k0, k1, ra are usable registers

define DEBUG_SHOW_STATIC_VALUE(yes)
align(8)
_inthandler_overlay:
variable pc_save(pc())

base $80000000 
_tlb_handler:
// Merge from 32 & 64 bit versions in See MIPS Run
	mfc0 k0, Status
	ori k1, r0, 0xE2
	and k0, k0, k1
	beql k0, r0, _tlb_32
	dmfc0 k1, XContext
_tlb_32:
	dmfc0 k1, Context
 // MAME doesnt support Context & XContext
	beq k1, r0, _interrupt_return_handler
	nop
	lw k0, 0(k1)
	lw k1, 8(k1)
	mtc0 k0, EntryLo0
	mtc0 k1, EntryLo1
	nop
	tlbwr
_tlb_end:
	eret

fixed_gap(_tlb_handler, 0x40)
ExceptionHandlers:
	// Interrupt
	exc0_Int_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "EInt")

	// TLB Change Exception
	exc1_Mod_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "EMod")

	// TLB Refill Exception (Load/Fetch)
	exc2_TLBL_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "TLBL")

	// TLB Refill Exception (Store)
	exc3_TLBS_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "TLBS")

	// Address Error (Load/Fetch)
	exc4_AdEL_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "AdEL")

	// Address Error (Store)
	exc5_AdES_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "AdES")

	// Bus Error (Fetch)
	exc6_IBE_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "IBE ")

	// Bus Error (Load/Store)
	exc7_DBE_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "DBE ")

	// System Exception Call
	exc8_Sys_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Sys ")

	// Breakpoint Exception
	exc9_Bp_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Bp  ")

	// Reserved Instruction Exception
	exc10_RI_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "RI  ")

	// Coprocessor Unusable
	exc11_CpU_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "CpU ")

	// Operation Overflow
	exc12_Ov_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Ov  ")

	// Trap Exception
	exc13_Tr_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Tr  ")

	// Reserved
	exc14_reserved_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Rsrv")

	// Floating Point Exception
	exc15_FPE_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "FPE ")


fixed_gap(_tlb_handler, 0x80)
_xtlb_handler:
	j _tlb_handler
	nop
default_handler_ptr:
	static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "DEF ")
fixed_gap(ExceptionHandlers, 0x5C)
	// Watch
	exc23_WATCH_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "WATH")			
		
fixed_gap(exc23_WATCH_handler_ptr, 0x20)
	_interrupt_MI:
	_interrupt_SP:
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db " SP ")
	_interrupt_SI:
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db " SI ")
	_interrupt_AI:
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db " AI ")

	_interrupt_VI:
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db " VI ")
	_interrupt_PI:
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db " PI ")
	_interrupt_DP:
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db " DP ")


fixed_gap(_xtlb_handler, 0x80)
_cache_handler:
	j _interrupt_return_handler
	nop	
	db "LEN "
dw _interrupt_END - _tlb_handler

InterruptHandlers:
	// The interrupt index is confusing! Since INT0 == bit 2, etc.
	// Cause Register -> Interrupt Pending bits are the following
	// 7. Timer
	// 6. Pin Interrupt INT4 Tied to VCC in Schematic
	// 5. Pin Interrupt INT3 Tied to VCC in Schematic
	// 4. Pin Interrupt INT2 Tied to PIF in Schematic Useful
	// 3. Pin Interrupt INT1 Tied to VCC in Schematic
	// 2. Pin Interrupt INT0 Tied to RCP in Schematic Useful
	// 1. Software 1 Interrupt
	// 0. Software 0 Interrupt
	// Software
	int0_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INS0")

	// Software 
	int1_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INS1")

	// Ext: INT0 RCP
	int2_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT0")

	// Ext: INT1 Pulled High in Schematic
	int3_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT1")

	// Ext: INT2 PIF
	int4_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT2")

	// Ext: INT3 Pulled High in Schematic
	int5_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT3")

	// Ext: INT4 Pulled High in Schematic
	int6_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT4")

	// Timer Interrupt
	int7_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INTT")
_interrupt_continue:

	ori k1, k0, $0100 // Software0 Interrupt
	bnel k1, r0, _interrupt_custom_handler
// Compiler Side effect int0_handler_ptr is only the lsb 16bits
	addi k0, ra, int0_handler_ptr

	j _interrupt_return_handler
	nop
			
_interrupt_custom_handler:
	// Only if k0 is not ZERO
    beq k0, r0, _interrupt_return_handler
	nop
    lw k0, 0(k0)
	nop
	jalr k0
	nop	
_interrupt_return_handler:
	mfc0 k0, EPC
	// Restore the 'ra' register
	// TODO: Process Branch Delay Bit, 4 instructions
	mfc0 ra, PErr
	addiu k0, k0, 4
	mtc0 k0, EPC	
	eret

fixed_gap(_cache_handler, 0x80)
// Interrupts & Exception Handlers
// BREAK Instruction
// SYSCALL Instruction
_default_handler:
	
	mfc0 k0, Cause // Happened
// Save ra so it can behave as expected and 
// we then have 2 normal registers to use (k0,k1)
// PErr register is available but unused on R4300i, 
// its for backwards compatibility with R4000/R4200
	mtc0 ra, PErr

// (Ab)using the 'ra' Register!
	lui ra, $8000 

// Register Values
// ra = $8000'0000 '
// k0 starts with the 'Cause' register then 
//		ends up with the function pointer address to 
// 		load from and eventually the user interrupt
//		handler that is called.
// k1 is our 'working' register

// Look for exceptions first, Zero tell us its an interrupt
	andi k1, k0, $007C // Exceptions
	beql k1, r0, _default_interrupt
	mfc0 k1, SR // Watching	

// Load k0 with indexed Exception Handler Address
// Compiler Side effect ExceptionHandlers is only the lsb 16bits
	andi k0, ra, ExceptionHandlers
	j _interrupt_custom_handler
	add k0, k1, k0	
	
_default_interrupt:
	nop // wait for SR register
	and k0, k0, k1 // Happened & Watching = Action to take
	
	ori k1, k0, $4000 // RCP Interrupt   
	beq k1, r0, _interrupt_VR4300i
	// parse MI Interrupts
	lui k1, MI_BASE // wasted on branch but dont care.
	lw k0, MI_INTR(k1) // Happened
	lw k1, MI_INTR_MASK(k1) // Watching
	and k0, k0, k1 // Happened & Watching = Action to take
	sll k0, k0, 2
// Compiler Side effect _interrupt_MI is only the lsb 16bits
	ori k1, ra, _interrupt_MI
	j _interrupt_custom_handler
	add k0, k0, k1
	
_interrupt_VR4300i:	
	ori k1, k0, $8000 // Timer Interrupt 7 
	bnel k1, r0, _interrupt_custom_handler
// Compiler Side effect int7_handler_ptr is only the lsb 16bits
	addi k0, ra, int7_handler_ptr

	ori k1, k0, $1000 // PIF Interrupt   5
	bnel k1, r0, _interrupt_custom_handler
// Compiler Side effect int4_handler_ptr is only the lsb 16bits
	addi k0, ra, int4_handler_ptr
	
	// 	$0800 // Pulled High in Schematic
	ori k1, k0, $0200 // Software1 Interrupt
	bnel k1, r0, _interrupt_custom_handler
// Compiler Side effect int1_handler_ptr is only the lsb 16bits
	addi k0, ra, int1_handler_ptr

	j _interrupt_continue
	nop
	
_interrupt_END:

fixed_gap(_tlb_handler, 0x200)
//base pc_save
//print(pc())
//output_pc(pc())
//putchar(pc_save)
//putchar(pc())
//fixed_gap(_tlb_handler, 0x240)

db "LENC"
_interrupt_handler_length:
dw _interrupt_END - _tlb_handler
db "LEND"
dw _interrupt_continue - _tlb_handler
db "EInt" // Interrupt
dw exc0_Int_handler_ptr
db "EMod" // TLB Change Exception
dw	exc1_Mod_handler_ptr
db "TLBL" // TLB Refill Exception (Load/Fetch)
dw exc2_TLBL_handler_ptr
db "TLBS" // TLB Refill Exception (Store)
dw exc3_TLBS_handler_ptr
db "AdEL" // Address Error (Load/Fetch)
dw	exc4_AdEL_handler_ptr
db "AdES"	// Address Error (Store)
dw	exc5_AdES_handler_ptr
db "IBE " // Bus Error (Fetch)
dw	exc6_IBE_handler_ptr
db "DBE "	// Bus Error (Load/Store)
dw exc7_DBE_handler_ptr
db "Sys " // System Exception Call
dw exc8_Sys_handler_ptr
db "Bp  " // Breakpoint Exception
dw 	exc9_Bp_handler_ptr
db "RI  " // Reserved Instruction Exception
dw exc10_RI_handler_ptr
db "CpU " // Coprocessor Unusable
dw exc11_CpU_handler_ptr
db "Ov  " // Operation Overflow
dw exc12_Ov_handler_ptr
db "Tr  " // Trap Exception
dw 	exc13_Tr_handler_ptr
db "Rsrv" // Reserved
dw 	exc14_reserved_handler_ptr
db "FPE " // Floating Point Exception
dw 	exc15_FPE_handler_ptr
db "WATH" // Debug Watch
dw	exc23_WATCH_handler_ptr
db "DEF " 
dw default_handler_ptr
db " SP "
dw 	_interrupt_SP
db " SI "
dw _interrupt_SI
db " AI "
dw _interrupt_AI
db " VI "
dw _interrupt_VI
db " PI "
dw _interrupt_PI
db " DP "
dw _interrupt_DP
db "INT0" // Software 
dw int0_handler_ptr 	
db "INT1" // Software 
dw int1_handler_ptr
db "INT2" // Ext: INT0 RCP
dw int2_handler_ptr
db "INT3" // Ext: INT1 Pulled High in Schematic
dw int3_handler_ptr 
db "INT4" // Ext: INT2 PIF
dw int4_handler_ptr
db "INT5" // Ext: INT3 Pulled High in Schematic
dw int5_handler_ptr
db "INT6" // Ext: INT4 Pulled High in Schematic
dw int6_handler_ptr
db "INT7" // Timer Interrupt
dw int7_handler_ptr
db "END "
dw _END_Interrupt_Handler
_END_Interrupt_Handler: