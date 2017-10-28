arch n64.cpu
endian msb

//define DEBUG_SHOW_STATIC_VALUE(yes)

// Based on http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
align(8)
syscall_mars:
    interrupt_register_save() 
	la t0, SYSCALL_Handlers
	sll t1, v0, 2
	lw t0, 0(t1)
	jr t0
	
_syscall_1:
	// Printer Integer
	// $a0 = integer to print
_syscall_2:
	// Printer Float
	// 	$f12 = float to print
_syscall_3:
	// Printer Double
	// $f12 = double to print
_syscall_4:
	// Printer String
	// $a0 = address of null-terminated string to print
_syscall_5:
	// Read Integer
	// 	$v0 contains integer read
_syscall_6:
	// Read Float
	// $f0 contains float read
_syscall_7:
	// Read Double
	// $f0 contains double read
_syscall_8:
	// Read String
	// $a0 = address of input buffer
	// $a1 = maximum number of characters to read
	// Service 8 - Follows semantics of UNIX 'fgets'. For specified length n, 
	//	string can be no longer than n-1. If less than that, adds newline to end. 
	//	In either case, then pads with null byte If n = 1, input is ignored and 
	//	null byte placed at buffer address. If n < 1, input is ignored and nothing 
	//	is written to the buffer. 
_syscall_9:
	// sbrk (allocate heap memory)
	// $a0 = number of bytes to allocate
	// $v0 contains address of allocated memory
_syscall_10:
	// exit (terminate execution)
_syscall_11:
	// $a0 = character to print
	// Service 11 - Prints ASCII character corresponding to contents of low-order byte. 
_syscall_12:
	// Read Character
	// $v0 contains character read
_syscall_13:
	// open file
	// $a0 = address of null-terminated string containing filename
	// $a1 = flags
	// $a2 = mode
	// $v0 contains file descriptor (negative if error). See note below table
_syscall_14:
	// read from file
	// $a0 = file descriptor
	// $a1 = address of input buffer
	// $a2 = maximum number of characters to read
	// $v0 contains number of characters read 
	//	(0 if end-of-file, negative if error).
_syscall_15:
	// write to file
	// $a0 = file descriptor
	// $a1 = address of output buffer
	// $a2 = number of characters to write
	// $v0 contains number of characters written (negative if error).
_syscall_16:
	// close file
	// $a0 = file descriptor
_syscall_17:
	// exit2 (terminate with value)	
	// $a0 = termination result
	interrupt_register_restore()	
	jr ra
	nop

//fixed_gap(_tlb_handler, 0x40)
SYSCALL_Handlers:
	// Interrupt
	syscall_01_handler_ptr: 
			static_value(DEBUG_SHOW_STATIC_VALUE, dw 0x0, db "PInt")
