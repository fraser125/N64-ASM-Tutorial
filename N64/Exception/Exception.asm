libn64_tlb_exception_handler:
base $80000000
	mtc0 ra, $30
	lui ra, 0x8000
fixed_gap(libn64_tlb_exception_handler, 0x080) 
libn64_xtlb_exception_handler:
fixed_gap(libn64_xtlb_exception_handler, 0x100) 
libn64_cache_exception_handler:
fixed_gap(libn64_cache_exception_handler, 0x180) 
libn64_general_exception_handler:

fixed_gap(libn64_tlb_exception_handler, 0x300) 
libn64_exception_jump_table:

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
db "End of Data"