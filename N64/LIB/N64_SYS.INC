macro sys_get_clock() {
	jal sys_get_clock
	nop
}

macro sys_random(min, max) {
	li a0, {min}
	li a1, {max}
	jal sys_random
	nop
}

macro sys_zero_fill(start, length) {
	li a0, {start}
	li a1, {length}
	jal sys_zero_fill
	nop
}

macro sys_max_fill(start, length) {
	li a0, {start}
	li a1, {length}
	jal sys_max_fill
	nop
}

macro sys_count_start1() {
	jal sys_count_start1
	nop
}

macro sys_count_end1() {
	jal sys_count_end1
	nop
}

macro sys_count_diff1() {
	jal sys_count_diff1
	nop
}

macro sys_count_start2() {
	jal sys_count_start2
	nop
}

macro sys_count_end2() {
	jal sys_count_end2
	nop
}

macro sys_count_diff2() {
	jal sys_count_diff2
	nop
}

macro sys_count_start3() {
	jal sys_count_start3
	nop
}

macro sys_count_end3() {
	jal sys_count_end3
	nop
}

macro sys_count_diff3() {
	jal sys_count_diff3
	nop
}

macro sys_count_start4() {
	jal sys_count_start4
	nop
}

macro sys_count_end4() {
	jal sys_count_end4
	nop
}

macro sys_count_diff4() {
	jal sys_count_diff4
	nop
}