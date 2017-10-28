arch n64.cpu
endian msb

// Every Handler can safely assume that k0, k1, ra are usable registers

//define DEBUG_SHOW_STATIC_VALUE(yes)
align(8)
_inthandler_overlay:
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

	
InterruptHandlers:
	// Software
	int0_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT0")

	// Software 
	int1_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT1")

	// Ext: INT0 RCP
	int2_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT2")

	// Ext: INT1 Pulled High in Schematic
	int3_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT3")

	// Ext: INT2 PIF
	int4_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT4")

	// Ext: INT3 Pulled High in Schematic
	int5_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT5")

	// Ext: INT4 Pulled High in Schematic
	int6_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT6")

	// Timer Interrupt
	int7_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "INT7")

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
	
// Dont modify k0 from here until we set the Function Pointer
	andi k1, k0, $00FF // Exceptions
	beq k1, r0, _default_handler_interrupts
	srl k1, k1, 2 // Make the value become a 0-31 number
// Load k0 with indexed Exception Handler
	la k0, ExceptionHandlers
	sll k1, k1, 2
	add k0, k1, k0	
	j _interrupt_custom_handler
	nop
_default_handler_interrupts:
	mfc0 k1, SR // Watching	
	nop
	and k0, k0, k1 // Happened & Watching = Action to take
	andi k1, k0, $8000 // Timer Interrupt
	andi k1, k0, $1000 // PIF Interrupt
	andi k1, k0, $0040 // RCP Interrupt
	andi k1, k0, $0002 // Software1 Interrupt
	andi k1, k0, $0001 // Software0 Interrupt
	
InterruptHandlers	
	nop
	nop
	// Load k0 with indexed Interrupt Handler
	// TODO: INT0, INT1, INT2, INT4, INT7

	// parse MI Interrupts
	//lui k1, MI_BASE
	//lw k1, MI_INTR(k1) // Happened
	//lw k0, MI_INTR_MASK(k1) // Watching
		
_interrupt_custom_handler:
    lw k0, 0(k0)
	nop
    beq k0, r0, _interrupt_return_handler
	nop
	jalr k0
	nop	
_interrupt_return_handler:
	mfc0 k0, EPC
	// Restore the 'ra' register
	mfc0 ra, PErr
	addiu k0, k0, 4
	mtc0 k0, EPC	
	eret
_interrupt_END:
fixed_gap(_tlb_handler, 0x200)
