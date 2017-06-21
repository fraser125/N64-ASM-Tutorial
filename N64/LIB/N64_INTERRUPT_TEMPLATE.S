// This template lays over all of the Interrupt Handlers
// TLB: 0x8000'0000
// XTLB: 0x8000'0080
// Cache: 0xA000'0100
// Default: 0x8000'0180
// Unless the programmer defines a handler they all 
// jump through to the default:

_interrupt_handler_template:
variable code_pc(pc())
base $80000000
_tlb_handler:
	// Trash k0, k1
	la k0, tlb_handler_ptr
	lw k0, 0(k0)
	nop
	beq k0, r0, _tlb_default_handler
	nop
	// Jump to custom handler
	jalr k0
	nop
	mfc0 k0, EPC
	addiu k0, k0, 4
	mtc0 k0, EPC
	eret
_tlb_default_handler:
	j _default_handler
	nop	

fixed_gap(_tlb_handler, 0x3C)
InterruptHandlers:
int0_handler_ptr:
	dw 0x0
int1_handler_ptr:
	dw 0x0
int2_handler_ptr:
	dw 0x0
int3_handler_ptr:
	dw 0x0
int4_handler_ptr:
	dw 0x0
int5_handler_ptr:
	dw 0x0
int6_handler_ptr:
	dw 0x0
int7_handler_ptr:
	dw 0x0
tlb_handler_ptr:
	dw 0x0
cache_handler_ptr:
	dw 0x0
default_handler_ptr:
	dw 0x0
vblank_handler_ptr:
	dw 0x0
other_int_handler_ptr:
	dw 0x0
other_exc_handler_ptr:
	dw 0x0

fixed_gap(_tlb_handler, 0x80)
_xtlb_handler:
	// Only applies to 64-bit code
	// Just in case something gets here, let default handle it
	j _default_handler
	nop
fixed_gap(_xtlb_handler, 0x0C)

ExceptionHandlers:
exc01_handler_ptr:
	dw 0x0
exc02_handler_ptr:
	dw 0x0
exc03_handler_ptr:
	dw 0x0
exc04_handler_ptr:
	dw 0x0
exc05_handler_ptr:
	dw 0x0
exc06_handler_ptr:
	dw 0x0
exc07_handler_ptr:
	dw 0x0
exc08_handler_ptr:
	dw 0x0
exc09_handler_ptr:
	dw 0x0
exc10_handler_ptr:
	dw 0x0
exc11_handler_ptr:
	dw 0x0
exc12_handler_ptr:
	dw 0x0
exc13_handler_ptr:
	dw 0x0
exc14_handler_ptr:
	dw 0x0
exc15_handler_ptr:
	dw 0x0
exc23_handler_ptr:
	dw 0x0	
fixed_gap(_xtlb_handler, 0x80)

_cache_handler:
	la k0, cache_handler_ptr
	lw k0, 0(k0)
	nop
	beq k0, r0, _cache_default_handler
	nop
		// Jump to custom handler
	jalr k0
	nop
	mfc0 k0, EPC
	addiu k0, k0, 4
	mtc0 k0, EPC
	eret
_cache_default_handler:
	j _default_handler
	nop		
fixed_gap(_cache_handler, 0x80)

_default_handler:
	// Free up another register
	la k1, interrupt_saved_registers
	sw v0, at*4(k1)	

	mfc0 k0, SR // What we are watching for
	mfc0 k1, Cause // What happened
	and k0, k1, k0 // Happened & Watching = Action to take
	
	// Process Interrupts first
	// Shift Right 8 then multiply by 4 to get an address
	srl k1, k0, 8
	sll k1, k1, 2
	beq k1, r0, _exception_check
	la at, InterruptHandlers // Intentionally in Delay Slot, gets overwritten if wrong.
	j _interrupt_manage
	add k0, at, k1	
_exception_check:
	//srl k1, k0, 2
	//sll k1, k1, 4 Last 2 bits are Zero! These are freebies!
	beq k1, r0, _interrupt_other_exception
	la at, ExceptionHandlers // Intentionally in Delay Slot, gets overwritten if wrong.
	j _interrupt_manage
	add k0, at, k1	
_interrupt_other_exception:
	// Other Exception	
	la k0, default_handler_ptr
_interrupt_manage:
	add k0, k0, k1
	lw k0, 0(k0)
	beq k0, r0, _return_handler
	nop
	// Jump to custom handler
	jalr k0
	nop
	//This is the default handler, so return
_return_handler:
	mfc0 k0, EPC
	addiu k0, k0, 4
	mtc0 k0, EPC
	eret
fixed_gap(_default_handler, 0x80)
base code_pc