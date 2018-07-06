// This template lays over all of the Interrupt Handlers
// TLB: 0x8000'0000
// XTLB: 0x8000'0080
// Cache: 0xA000'0100
// Default: 0x8000'0180
// End: 0x8000'0200
// Unless the programmer defines a handler they all 
// jump through to the default:
// Assumption: Trash k0, k1

// libdragon notes:
// Checks for Exceptions $0000 00FF
// Checks for Reset Interrupt $0000 1000
// Checks for Timer Interrupt $0000 8000
// $0000 0400 RCP Assumed Type remaining MI has details
// Software Interrupts are not checked

// VR4300 Programming Guide notes:
// 

db "Inter. Block"
align(8)
_interrupt_handler_template:
variable code_pc(pc())
base $80000000
_tlb_handler:
	la k0, tlb_handler_ptr
	lw k0, 0(k0)
	nop
	beq k0, r0, _default_handler
	nop
	// Jump to custom handler
	jalr k0
	nop
	j _return_handler
	nop	

fixed_gap(_tlb_handler, 0x40)
ExceptionHandlers:
exc0_Int_handler_ptr: // Interrupt
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "EInt")

exc1_Mod_handler_ptr: // TLB Change Exception
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "EMod")

exc2_TLBL_handler_ptr: // TLB Refill Exception (Load/Fetch)
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "TLBL")

exc3_TLBS_handler_ptr: // TLB Refill Exception (Store)
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "TLBS")

exc4_AdEL_handler_ptr: // Address Error (Load/Fetch)
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "AdEL")

exc5_AdES_handler_ptr: // Address Error (Store)
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "AdES")

exc6_IBE_handler_ptr: // Bus Error (Fetch)
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "IBE ")

exc7_DBE_handler_ptr: // Bus Error (Load/Store)
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "DBE ")

exc8_Sys_handler_ptr: // System Exception Call
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Sys ")

exc9_Bp_handler_ptr: // Breakpoint Exception
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Bp  ")

exc10_RI_handler_ptr: // Reserved Instruction Exception
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "RI  ")

exc11_CpU_handler_ptr: // Coprocessor Unusable
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "CpU ")

exc12_Ov_handler_ptr: // Operation Overflow
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Ov  ")

exc13_Tr_handler_ptr: // Trap Exception
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Tr  ")

exc14_reserved_handler_ptr: // Reserved
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "Rv  ")

exc15_FPE_handler_ptr: // Floating Point Exception
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "FPE ")

fixed_gap(_tlb_handler, 0x80)

_xtlb_handler:
	// Only applies to 64-bit code
	// Just in case something gets here, send backwards
	j _tlb_handler
	nop

fixed_gap(ExceptionHandlers, 0x5C)
exc23_WATCH_handler_ptr: // Watch
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "WATH")
	
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
nt3_handler_ptr: 
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

tlb_handler_ptr:
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "TLBH")

cache_handler_ptr:
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "CACH")

default_handler_ptr:
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "DEFT")

vblank_handler_ptr:
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "VBLK")

other_int_handler_ptr:
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "IOTR")

other_exc_handler_ptr:
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "EOTR")
	
_intterupt_save_ra:
static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "ra  ")

fixed_gap(_xtlb_handler, 0x80)

_cache_handler:
	la k0, cache_handler_ptr	
	lw k0, 0(k0)
	nop
	beq k0, r0, _default_handler
	nop
// Jump to custom handler
	jalr k0
	nop
	j _return_handler
	nop
fixed_gap(_cache_handler, 0x80)

// libdragon notes:
// Checks for Exceptions $0000 00FF
// Checks for Reset Interrupt $0000 1000
// Checks for Timer Interrupt $0000 8000
// $0000 0400 RCP Assumed Type remaining MI has details
// Software Interrupts are not checked

_default_handler:
	// Free up another register
	lui k1, $8000
	sw ra, _intterupt_save_ra(k1)

	mfc0 k0, SR // What we are watching for
	// Very careful use of 'ra' register
	mfc0 ra, Cause // What happened
	and k0, ra, k0 // Happened & Watching = Action to take
	andi ra, k0, $00FF
	
	// Process Interrupts first
	// Shift Right 8 then multiply by 4 to get an address
	srl k0, k0, 8
	beq k0, r0, _exception_check // k0 before or after are fine for this branch
	sll k0, k0, 1
		
	la k1, InterruptHandlers	
	j _interrupt_custom_execute
	add k0, k0, k1	
	
_exception_check: 
	blez ra, _interrupt_other_exception
	la k0, ExceptionHandlers // Intentionally in Delay Slot, gets overwritten if wrong.
	j _interrupt_custom_execute
	add k0, k0, ra
		
_interrupt_other_exception:
	// Other Exception	
	la k0, default_handler_ptr
	
_interrupt_custom_execute: // Test custom handler
	lw k0, 0(k0)
	nop
	beq k0, r0, _return_handler
	nop
_interrupt_custom_handler:
	// Jump to custom handler
	jalr k0
	nop	
	
	//This is the return handler
	// Clean up and return
_return_handler:
	// Restore the 'ra' register
	lui k1, $8000
	lw ra, _intterupt_save_ra(k1)

	mfc0 k0, EPC
	addiu k0, k0, 4
	mtc0 k0, EPC
	eret
fixed_gap(_default_handler, 0x80)
base code_pc
db "EndBlock"