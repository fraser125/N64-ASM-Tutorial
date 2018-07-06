align(8)
	nop
	nop
	nop
variable zero(r0)
variable forecolor(a0)	
variable backcolor(a1) // (0x01 = transparent)	
variable destination(a2)

variable ipl_font(t0)
variable font_cur_word(t1)
variable font_bits(t2)
variable font_bit_count(t3)
variable font_top_bit_mask(t4)
variable ipl_font_end(t5)

	// 50 Characters @ 23 bytes + (18 0x00 bytes) = 1168 bytes
	// 1168 / 4 (word size) = 292 Ignore the last 16 bytes = 288 * 4 = 1152
	// 32 bits expand to 16 bit color for each bit = 64 bytes
	// Each Font will use 18.5 KB of RAM
	
fontinit16:
	la ipl_font, $B0000B70
	addi ipl_font_end, ipl_font, 1168
	li font_top_bit_mask, 0x80000000
	
font_next_word16:
	lw font_cur_word, 0(ipl_font)
	addi font_bit_count, zero, 31

font_next_bits16:
	and font_bits, font_cur_word, font_top_bit_mask
	sll font_cur_word, font_cur_word, 1
	bnel font_bits, zero, font_forecolor16
	nop
	sh backcolor, 0(destination)
	j font_continue16
	nop
font_forecolor16:
	sh forecolor, 0(destination)	
	nop
font_continue16:
	addi destination, destination, 2
	bne font_bit_count, zero, font_next_bits16
	addi font_bit_count, font_bit_count, -1
	
	bne ipl_font, ipl_font_end, font_next_word16
	addi ipl_font, ipl_font, 4
	jr ra
	addiu v0, zero, 18768
	nop
	nop

	nop
	nop
fontinit32:
	la ipl_font, $B0000B70
	addi ipl_font_end, ipl_font, 1168
	li font_top_bit_mask, 0x80000000
	
font_next_word32:
	lw font_cur_word, 0(ipl_font)
	addi font_bit_count, zero, 31

font_next_bits32:
	and font_bits, font_cur_word, font_top_bit_mask
	sll font_cur_word, font_cur_word, 1
	bnel font_bits, zero, font_forecolor32
	nop
	sh backcolor, 0(destination)
	j font_continue32
	nop
font_forecolor32:
	sh forecolor, 0(destination)	
	nop
font_continue32:
	addi destination, destination, 4
	bne font_bit_count, zero, font_next_bits32
	addi font_bit_count, font_bit_count, -1
	
	bne ipl_font, ipl_font_end, font_next_word32
	addi ipl_font, ipl_font, 4
	jr ra
	addiu v0, zero, 37536
	nop
	nop

	nop
	nop
	nop
align(8)	
	nop
	nop
	nop
fontprintline16:
// Constant Values
constant font_addr(a0)
constant fb_addr(a1)
constant fb_left(a2)
constant fb_top(a3)
constant fb_base(fb_top)
constant text_address(v0)
constant text_length(v1)
constant font_char_len(t2)
constant line_byte_width(t4)

// Variable - i.e. change for each line/char, etc
constant text_curr_idx(t5)
constant text_curr_char(t0)

constant font_curr_addr(t1)
constant fb_curr_addr(t3)

// Totally Temp, so anything goes
constant tmp_reg0(t7)
constant tmp_reg1(t8)
constant tmp_reg2(t9)

	addi text_curr_idx, zero, zero
// Each character is 23 original bytes, 368 in expanded font
	addi font_char_len, zero, 368
	
// Get the Video Pixel Width * 2 for 16 bit color
	lui tmp_reg0, VI_BASE
	lw tmp_reg0, VI_WIDTH(tmp_reg0)	
	sll line_byte_width, tmp_reg0, 1 // *2
	
// Set fb_curr_addr based on values we have
	add fb_curr_addr, zero, fb_addr
	// last line is only a partial for this calc, so remove it
	addi tmp_reg0, fb_top, -1
	// Multiply Video pixel width * number of lines from the top
	multu line_byte_width, tmp_reg0
	mflo fb_top
	// Add Line pixels
	add fb_curr_addr, fb_curr_addr, fb_top
	// Add partial line pixels
	sll tmp_reg0, fb_left, 1 // *2 16 bit color	
	add fb_base, tmp_reg0, fb_curr_addr

font_next_char:
	beql text_length, zero, font_finished
	nop
	// Add char offset to fb_base
	addi tmp_reg0, zero, 26
	multu text_curr_idx, tmp_reg0
	mflo tmp_reg0
	add fb_curr_addr, fb_base, tmp_reg0	
	// Get selected char
	lb text_curr_char, 0(text_address)
	// Check for ' ' (space)
	addi tmp_reg0, zero, 0x33
	beql text_curr_char, tmp_reg0, font_space
	nop
	// Position font address
	multu font_char_len, text_curr_char
	mflo font_curr_addr
	add font_curr_addr, font_curr_addr, font_addr
	addi t6, zero, 13
font_line_loop:
	ld tmp_reg0, 0(font_curr_addr)
	ld tmp_reg1, 8(font_curr_addr)
	ld tmp_reg2, 16(font_curr_addr)
	
	sd tmp_reg0, 0(fb_curr_addr)
	lh tmp_reg0, 24(font_curr_addr)
	sd tmp_reg1, 8(fb_curr_addr)
	sd tmp_reg2, 16(fb_curr_addr)
	sh tmp_reg0, 24(fb_curr_addr)
	
	add fb_curr_addr, fb_curr_addr, line_byte_width
	addi font_curr_addr, font_curr_addr, 26
	bne t6, zero, font_line_loop
	addi t6, t6, -1
	// Loop over 14 lines
	
font_space:
// Char Complete, setup for the next	
	addi text_address, text_address, 1
	addi text_curr_idx, text_curr_idx, 1
	bnel text_length, zero, font_next_char
	addi text_length, text_length, -1
font_finished:
	jr ra
	nop
	nop
	nop


align(8)
// https://stackoverflow.com/questions/5558492/divide-by-10-using-bit-shifts
divide10:
variable n(a0)
variable q(v0)
variable r(t0)
variable t(t1)
	srl q, n, 1
	srl r, n, 2
	add q, q, r
	srl r, q, 4
	add q, q, r
	srl r, q, 8
	add q, q, r
	srl r, q, 16
	add q, q, r
	srl q, q, 3	
	sll t, q, 2
	add t, t, q
	sll t, t, 1
	sub r, n, t
	addi t, zero, 10 
	slt t, t, r
	jr ra
	add q, q, t

	nop
	nop
	nop
	nop
	nop
	nop

align(8)	
fontconvhex2dec:
variable text_hex_address(a0)
variable text_hex_length(a1)
variable text_dec_address(a2)
variable text_dec_length(a3)
	// based on length load the value into a register (upto 64-bit values supported)
	// only populated the provided decimal length starting from the right LSB
	//jal divide10
	//addi a0, zero, -1
	// v0 = 0x19999999

	jr ra
	nop
	nop
	nop