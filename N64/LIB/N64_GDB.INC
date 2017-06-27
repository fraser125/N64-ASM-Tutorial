macro gdb_sync() {
	break
}
// has to be called after the Interrupt handler has been put in place
// but before there are any handlers assigned.
// This way it will fall through the handlers and return,
// Also possible to determine if hander was executed.
macro gdb_communication_test() {
	jal gdb_serial_test
	nop
}