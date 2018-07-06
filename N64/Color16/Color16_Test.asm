arch n64.cpu
endian msb
fill 1052672

origin $00000000
base $80000000 
include "../LIB/N64.INC" 
include "../LIB/COLORS16.INC" 
include "../LIB/N64_GFX.INC"

include "N64_HEADER.ASM" 
insert "../LIB/N64_BOOTCODE.BIN" 

Start:  
	N64_INIT()
	ScreenNTSC(320, 240, BPP16, $A0100000)
	DPC(RDPBuffer, RDPBufferEnd) 
	WaitScanline($200) 
	nop // Marker NOP's 
Loop:
  j Loop
  nop // Delay Slot
  
  
macro square16(col, row, color) {
  Set_Fill_Color ({color} << 16) | {color} 
  // Bottom Right X, Bottom Right Y, Top Left X, Top Left Y
  Fill_Rectangle (({row} * 16) + (({col} + 1) * 16)) << 2, ({row} * 16) + 16 << 2, (({row} * 16) + ({col} * 16)) << 2, ({row} * 16) << 2
}
	
	
align(8) // Align 64-Bit
RDPBuffer:
arch n64.rdp
  Set_Scissor 0<<2,0<<2, 0,0, 320<<2,240<<2
  Set_Other_Modes CYCLE_TYPE_FILL // | Z_MODE_OPAQUE 
  Set_Color_Image IMAGE_DATA_FORMAT_RGBA,SIZE_OF_PIXEL_16B,320-1, $00100000

  Set_Fill_Color (BLACK << 16) | BLACK // Set Fill Color: PACKED COLOR 32B R8G8B8A8 Pixel
  Fill_Rectangle 319<<2,239<<2, 0<<2,0<<2 // Fill Rectangle: XL 319.0,YL 239.0, XH 0.0,YH 0.0

  square16(0, 0, STEEL_BLUE)
  square16(1, 0, PALE_TURQUOISE)
  square16(0, 1, MEDIUM_TURQUOISE)
  square16(1, 1, CADET_BLUE)
RDPBufferEnd: 