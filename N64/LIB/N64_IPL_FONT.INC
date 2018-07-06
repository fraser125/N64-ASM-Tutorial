macro font_init16(forecolor, backcolor, dest) {
	li a0, {forecolor}
	li a1, {backcolor}
	li a2, {dest}
	jal fontinit16
	nop
}

macro font_init32(forecolor, backcolor, dest) {
	li a0, {forecolor}
	li a1, {backcolor}
	li a2, {dest}
	jal fontinit32
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

macro font_print_line32(fontname, framebuffer, left, top, string_address, length) {
	li a0, {fontname}
	li a1, {framebuffer}
	li a2, {left}
	li a3, {top}
	li v0, {string_address}
	li v1, {length}
	jal fontprintline32
	nop
}

macro font_conv_hex2dec(text_hex_address, text_hex_length, text_dec_address, text_dec_length) {
	li a0, {text_hex_address}
	li a1, {text_hex_length}
	li a2, {text_dec_address}
	li a3, {text_dec_length}
	jal fontconvhex2dec
	nop
}