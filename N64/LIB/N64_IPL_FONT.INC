macro font_init16(forecolor, backcolor, dest) {
	li a0, {forecolor}
	li a1, {backcolor}
	li a2, {dest}
	jal fontinit16
	nop
}

macro font_print_line16(fontname, framebuffer, left, top, string_address, length) {
	li a0, {fontname}
	li a1, {framebuffer}
	li a2, {left}
	li a3, {top}
	li v0, {string_address}
	li v1, {length}
	jal fontprintline16
	nop
}
