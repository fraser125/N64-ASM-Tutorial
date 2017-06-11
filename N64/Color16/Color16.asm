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
	nop // Marker NOP's 
	WaitScanline($200) 
	DPC(RDPBuffer, RDPBufferEnd) 
	nop // Marker NOP's 
Loop:
  j Loop
  nop // Delay Slot
  
align(8) // Align 64-Bit
RDPBuffer:
arch n64.rdp
// 140 Colors
// 320 / 20 = 16
// 240 / 20 = 12
// 
  Set_Scissor 0<<2,0<<2, 0,0, 320<<2,240<<2
  Set_Other_Modes CYCLE_TYPE_FILL 
  Set_Color_Image IMAGE_DATA_FORMAT_RGBA,SIZE_OF_PIXEL_16B,320-1, $00100000

  Set_Fill_Color $000000FF // Set Fill Color: PACKED COLOR 32B R8G8B8A8 Pixel
  Fill_Rectangle 319<<2,239<<2, 0<<2,0<<2 // Fill Rectangle: XL 319.0,YL 239.0, XH 0.0,YH 0.0
  
  Set_Fill_Color (INDIAN_RED <<16) | INDIAN_RED
  // Bottom Right X, Bottom Right Y, Top Left X, Top Left Y
  Fill_Rectangle 20<<2,20<<2, 1<<2,1<<2

  Set_Fill_Color (LIGHT_CORAL <<16) | LIGHT_CORAL
  Fill_Rectangle 40<<2,20<<2, 21<<2,1<<2
  Set_Fill_Color (SALMON <<16) | SALMON
  Fill_Rectangle 60<<2,20<<2, 41<<2,1<<2
  Set_Fill_Color (DARK_SALMON <<16) | DARK_SALMON
  Fill_Rectangle 80<<2,20<<2, 61<<2,1<<2
  Set_Fill_Color (CRIMSON <<16) | CRIMSON
  Fill_Rectangle 100<<2,20<<2, 81<<2,1<<2
  Set_Fill_Color (RED <<16) | RED
  Fill_Rectangle 120<<2,20<<2, 101<<2,1<<2
  Set_Fill_Color (FIRE_BRICK <<16) | FIRE_BRICK
  Fill_Rectangle 140<<2,20<<2, 121<<2,1<<2
  Set_Fill_Color (DARK_RED <<16) | DARK_RED
  Fill_Rectangle 160<<2,20<<2, 141<<2,1<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 180<<2,20<<2, 161<<2,1<<2

  Set_Fill_Color (PINK <<16) | PINK
  Fill_Rectangle 200<<2,20<<2, 181<<2,1<<2
  Set_Fill_Color (LIGHT_PINK <<16) | LIGHT_PINK
  Fill_Rectangle 220<<2,20<<2, 201<<2,1<<2
  Set_Fill_Color (HOT_PINK <<16) | HOT_PINK
  Fill_Rectangle 240<<2,20<<2, 221<<2,1<<2
  Set_Fill_Color (DEEP_PINK <<16) | DEEP_PINK
  Fill_Rectangle 260<<2,20<<2, 241<<2,1<<2
  Set_Fill_Color (MEDIUM_VIOLET_RED <<16) | MEDIUM_VIOLET_RED
  Fill_Rectangle 280<<2,20<<2, 261<<2,1<<2
  Set_Fill_Color (PALE_VIOLET_RED <<16) | PALE_VIOLET_RED
  Fill_Rectangle 300<<2,20<<2, 281<<2,1<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 320<<2,20<<2, 301<<2,1<<2
  
  // Bottom Right X, Bottom Right Y, Top Left X, Top Left Y
  Set_Fill_Color (LIGHT_SALMON <<16) | LIGHT_SALMON
  Fill_Rectangle 20<<2,40<<2, 1<<2,21<<2
  Set_Fill_Color (CORAL <<16) | CORAL
  Fill_Rectangle 40<<2,40<<2, 21<<2,21<<2
  Set_Fill_Color (TOMATO <<16) | TOMATO
  Fill_Rectangle 60<<2,40<<2, 41<<2,21<<2
  Set_Fill_Color (ORANGE_RED <<16) | ORANGE_RED
  Fill_Rectangle 80<<2,40<<2, 61<<2,21<<2
  Set_Fill_Color (DARK_ORANGE <<16) | DARK_ORANGE
  Fill_Rectangle 100<<2,40<<2, 81<<2,21<<2
  Set_Fill_Color (ORANGE <<16) | ORANGE
  Fill_Rectangle 120<<2,40<<2, 101<<2,21<<2
  Set_Fill_Color (BLACK	<<16) | BLACK	
  Fill_Rectangle 140<<2,40<<2, 121<<2,21<<2
  
  Set_Fill_Color (GOLD <<16) | GOLD
  Fill_Rectangle 160<<2,40<<2, 141<<2, 21<<2
  Set_Fill_Color (YELLOW <<16) | YELLOW
  Fill_Rectangle 180<<2,40<<2, 161<<2,21<<2
  Set_Fill_Color (LIGHT_YELLOW <<16) | LIGHT_YELLOW
  Fill_Rectangle 200<<2,40<<2, 181<<2,21<<2
  Set_Fill_Color (LEMON_CHIFFON <<16) | LEMON_CHIFFON
  Fill_Rectangle 220<<2,40<<2, 201<<2,21<<2
  Set_Fill_Color (LIGHT_GOLDENROD_YELLOW <<16) | LIGHT_GOLDENROD_YELLOW
  Fill_Rectangle 240<<2,40<<2, 221<<2,21<<2
  Set_Fill_Color (PAPAYA_WHIP <<16) | PAPAYA_WHIP
  Fill_Rectangle 260<<2,40<<2, 241<<2,21<<2
  Set_Fill_Color (MOCCASIN <<16) | MOCCASIN
  Fill_Rectangle 280<<2,40<<2, 261<<2,21<<2
  Set_Fill_Color (PEACH_PUFF <<16) | PEACH_PUFF
  Fill_Rectangle 300<<2,40<<2, 281<<2,21<<2
  Set_Fill_Color (PALE_GOLDENROD <<16) | PALE_GOLDENROD
  Fill_Rectangle 320<<2,40<<2, 301<<2,21<<2
  Set_Fill_Color (KHAKI <<16) | KHAKI
  Fill_Rectangle 340<<2,40<<2, 321<<2,21<<2
  
  Set_Fill_Color (DARK_KHAKI <<16) | DARK_KHAKI
  Fill_Rectangle 20<<2,60<<2,1<<2,41<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 40<<2,60<<2,21<<2,41<<2
  
  Set_Fill_Color (LAVENDER <<16) | LAVENDER
  Fill_Rectangle 60<<2,60<<2,41<<2,41<<2
  Set_Fill_Color (THISTLE <<16) | THISTLE
  Fill_Rectangle 80<<2,60<<2,61<<2,41<<2
  Set_Fill_Color (PLUM <<16) | PLUM
  Fill_Rectangle 100<<2,60<<2,81<<2,41<<2
  Set_Fill_Color (VIOLET <<16) | VIOLET
  Fill_Rectangle 120<<2,60<<2,101<<2,41<<2
  Set_Fill_Color (ORCHID <<16) | ORCHID
  Fill_Rectangle 140<<2,60<<2,121<<2,41<<2
  Set_Fill_Color (FUCHSIA <<16) | FUCHSIA
  Fill_Rectangle 160<<2,60<<2,141<<2,41<<2
  Set_Fill_Color (MAGENTA <<16) | MAGENTA
  Fill_Rectangle 180<<2,60<<2,161<<2,41<<2
  Set_Fill_Color (MEDIUM_ORCHID <<16) | MEDIUM_ORCHID
  Fill_Rectangle 200<<2,60<<2,181<<2,41<<2
  Set_Fill_Color (BLUE_VIOLET <<16) | BLUE_VIOLET
  Fill_Rectangle 220<<2,60<<2,201<<2,41<<2
  Set_Fill_Color (DARK_ORCHID <<16) | DARK_ORCHID
  Fill_Rectangle 240<<2,60<<2,221<<2,41<<2
  Set_Fill_Color (DARK_MAGENTA <<16) | DARK_MAGENTA
  Fill_Rectangle 260<<2,60<<2,241<<2,41<<2
  Set_Fill_Color (PURPLE <<16) | PURPLE
  Fill_Rectangle 280<<2,60<<2,261<<2,41<<2
  Set_Fill_Color (INDIGO <<16) | INDIGO
  Fill_Rectangle 300<<2,60<<2,281<<2,41<<2
  Set_Fill_Color (SLATE_BLUE <<16) | SLATE_BLUE
  Fill_Rectangle 320<<2,60<<2,301<<2,41<<2
  Set_Fill_Color (DARK_SLATE_BLUE <<16) | DARK_SLATE_BLUE
  Fill_Rectangle 340<<2,60<<2,321<<2,41<<2

  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 20<<2,80<<2,1<<2,61<<2
  Set_Fill_Color (GREEN_YELLOW <<16) | GREEN_YELLOW
  Fill_Rectangle 40<<2,80<<2,21<<2,61<<2  
  Set_Fill_Color (CHARTREUSE <<16) | CHARTREUSE
  Fill_Rectangle 60<<2,80<<2,41<<2,61<<2
  Set_Fill_Color (LAWN_GREEN <<16) | LAWN_GREEN
  Fill_Rectangle 80<<2,80<<2,61<<2,61<<2
  Set_Fill_Color (LIME <<16) | LIME
  Fill_Rectangle 100<<2,80<<2,81<<2,61<<2
  Set_Fill_Color (LIME_GREEN <<16) | LIME_GREEN
  Fill_Rectangle 120<<2,80<<2,101<<2,61<<2
  Set_Fill_Color (PALE_GREEN <<16) | PALE_GREEN
  Fill_Rectangle 140<<2,80<<2,121<<2,61<<2
  Set_Fill_Color (LIGHT_GREEN <<16) | LIGHT_GREEN
  Fill_Rectangle 160<<2,80<<2,141<<2,61<<2
  Set_Fill_Color (MEDIUM_SPRING_GREEN <<16) | MEDIUM_SPRING_GREEN
  Fill_Rectangle 180<<2,80<<2,161<<2,61<<2
  Set_Fill_Color (SPRING_GREEN <<16) | SPRING_GREEN
  Fill_Rectangle 200<<2,80<<2,181<<2,61<<2
  Set_Fill_Color (MEDIUM_SEA_GREEN <<16) | MEDIUM_SEA_GREEN
  Fill_Rectangle 220<<2,80<<2,201<<2,61<<2
  Set_Fill_Color (SEA_GREEN <<16) | SEA_GREEN
  Fill_Rectangle 240<<2,80<<2,221<<2,61<<2
  Set_Fill_Color (FOREST_GREEN <<16) | FOREST_GREEN
  Fill_Rectangle 260<<2,80<<2,241<<2,61<<2
  Set_Fill_Color (GREEN <<16) | GREEN
  Fill_Rectangle 280<<2,80<<2,261<<2,61<<2
  Set_Fill_Color (DARK_GREEN <<16) | DARK_GREEN
  Fill_Rectangle 300<<2,80<<2,281<<2,61<<2
  Set_Fill_Color (YELLOW_GREEN <<16) | YELLOW_GREEN
  Fill_Rectangle 320<<2,80<<2,301<<2,61<<2
  Set_Fill_Color (OLIVE_DRAB <<16) | OLIVE_DRAB
  Fill_Rectangle 340<<2,80<<2,321<<2,61<<2
  
  Set_Fill_Color (OLIVE <<16) | OLIVE
  Fill_Rectangle 20<<2,100<<2,1<<2,81<<2
  Set_Fill_Color (DARK_OLIVE_GREEN <<16) | DARK_OLIVE_GREEN
  Fill_Rectangle 40<<2,100<<2,21<<2,81<<2  
  Set_Fill_Color (MEDIUM_AQUAMARINE <<16) | MEDIUM_AQUAMARINE
  Fill_Rectangle 60<<2,100<<2,41<<2,81<<2
  Set_Fill_Color (DARK_SEA_GREEN <<16) | DARK_SEA_GREEN
  Fill_Rectangle 80<<2,100<<2,61<<2,81<<2
  Set_Fill_Color (LIGHT_SEA_GREEN <<16) | LIGHT_SEA_GREEN
  Fill_Rectangle 100<<2,100<<2,81<<2,81<<2
  Set_Fill_Color (DARK_CYAN <<16) | DARK_CYAN
  Fill_Rectangle 120<<2,100<<2,101<<2,81<<2
  Set_Fill_Color (TEAL <<16) | TEAL
  Fill_Rectangle 140<<2,100<<2,121<<2,81<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 160<<2,100<<2,141<<2,81<<2
  
  Set_Fill_Color (AQUA <<16) | AQUA
  Fill_Rectangle 180<<2,100<<2,161<<2,81<<2
  Set_Fill_Color (CYAN <<16) | CYAN
  Fill_Rectangle 200<<2,100<<2,181<<2,81<<2
  Set_Fill_Color (LIGHT_CYAN <<16) | LIGHT_CYAN
  Fill_Rectangle 220<<2,100<<2,201<<2,81<<2
  Set_Fill_Color (PALE_TURQUOISE <<16) | PALE_TURQUOISE
  Fill_Rectangle 240<<2,100<<2,221<<2,81<<2
  Set_Fill_Color (AQUAMARINE <<16) | AQUAMARINE
  Fill_Rectangle 260<<2,100<<2,241<<2,81<<2
  Set_Fill_Color (TURQUOISE <<16) | TURQUOISE
  Fill_Rectangle 280<<2,100<<2,261<<2,81<<2
  Set_Fill_Color (MEDIUM_TURQUOISE <<16) | MEDIUM_TURQUOISE
  Fill_Rectangle 300<<2,100<<2,281<<2,81<<2
  Set_Fill_Color (DARK_TURQUOISE <<16) | DARK_TURQUOISE
  Fill_Rectangle 320<<2,100<<2,301<<2,81<<2
  Set_Fill_Color (CADET_BLUE <<16) | CADET_BLUE
  Fill_Rectangle 340<<2,100<<2,321<<2,81<<2
  
  Set_Fill_Color (STEEL_BLUE <<16) | STEEL_BLUE
  Fill_Rectangle 20<<2,120<<2,1<<2,101<<2
  Set_Fill_Color (LIGHT_STEEL_BLUE <<16) | LIGHT_STEEL_BLUE
  Fill_Rectangle 40<<2,120<<2,21<<2,101<<2  
  Set_Fill_Color (POWDER_BLUE <<16) | POWDER_BLUE
  Fill_Rectangle 60<<2,120<<2,41<<2,101<<2
  Set_Fill_Color (LIGHT_BLUE <<16) | LIGHT_BLUE
  Fill_Rectangle 80<<2,120<<2,61<<2,101<<2
  Set_Fill_Color (SKY_BLUE <<16) | SKY_BLUE
  Fill_Rectangle 100<<2,120<<2,81<<2,101<<2
  Set_Fill_Color (LIGHT_SKY_BLUE <<16) | LIGHT_SKY_BLUE
  Fill_Rectangle 120<<2,120<<2,101<<2,101<<2
  Set_Fill_Color (DEEP_SKY_BLUE <<16) | DEEP_SKY_BLUE
  Fill_Rectangle 140<<2,120<<2,121<<2,101<<2
  Set_Fill_Color (DODGER_BLUE <<16) | DODGER_BLUE
  Fill_Rectangle 160<<2,120<<2,141<<2,101<<2  
  Set_Fill_Color (CORN_FLOWER_BLUE <<16) | CORN_FLOWER_BLUE
  Fill_Rectangle 180<<2,120<<2,161<<2,101<<2
  Set_Fill_Color (MEDIUM_SLATE_BLUE <<16) | MEDIUM_SLATE_BLUE
  Fill_Rectangle 200<<2,120<<2,181<<2,101<<2
  Set_Fill_Color (ROYAL_BLUE <<16) | ROYAL_BLUE
  Fill_Rectangle 220<<2,120<<2,201<<2,101<<2
  Set_Fill_Color (MEDIUM_BLUE <<16) | MEDIUM_BLUE
  Fill_Rectangle 240<<2,120<<2,221<<2,101<<2
  Set_Fill_Color (BLUE <<16) | BLUE
  Fill_Rectangle 260<<2,120<<2,241<<2,101<<2
  Set_Fill_Color (DARK_BLUE <<16) | DARK_BLUE
  Fill_Rectangle 280<<2,120<<2,261<<2,101<<2
  Set_Fill_Color (NAVY <<16) | NAVY
  Fill_Rectangle 300<<2,120<<2,281<<2,101<<2
  Set_Fill_Color (MIDNIGHT_BLUE <<16) | MIDNIGHT_BLUE
  Fill_Rectangle 320<<2,120<<2,301<<2,101<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 340<<2,120<<2,321<<2,101<<2
    
  Set_Fill_Color (CORNSILK <<16) | CORNSILK
  Fill_Rectangle 20<<2,140<<2,1<<2,121<<2
  Set_Fill_Color (BLANCHED_ALMOND <<16) | BLANCHED_ALMOND
  Fill_Rectangle 40<<2,140<<2,21<<2,121<<2  
  Set_Fill_Color (BISQUE <<16) | BISQUE
  Fill_Rectangle 60<<2,140<<2,41<<2,121<<2
  Set_Fill_Color (NAVAJO_WHITE <<16) | NAVAJO_WHITE
  Fill_Rectangle 80<<2,140<<2,61<<2,121<<2
  Set_Fill_Color (WHEAT <<16) | WHEAT
  Fill_Rectangle 100<<2,140<<2,81<<2,121<<2
  Set_Fill_Color (BURLY_WOOD <<16) | BURLY_WOOD
  Fill_Rectangle 120<<2,140<<2,101<<2,121<<2
  Set_Fill_Color (TAN <<16) | TAN
  Fill_Rectangle 140<<2,140<<2,121<<2,121<<2
  Set_Fill_Color (ROSY_BROWN <<16) | ROSY_BROWN
  Fill_Rectangle 160<<2,140<<2,141<<2,121<<2  
  Set_Fill_Color (SANDY_BROWN <<16) | SANDY_BROWN
  Fill_Rectangle 180<<2,140<<2,161<<2,121<<2
  Set_Fill_Color (GOLDENROD <<16) | GOLDENROD
  Fill_Rectangle 200<<2,140<<2,181<<2,121<<2
  Set_Fill_Color (DARK_GOLDENROD <<16) | DARK_GOLDENROD
  Fill_Rectangle 220<<2,140<<2,201<<2,121<<2
  Set_Fill_Color (PERU <<16) | PERU
  Fill_Rectangle 240<<2,140<<2,221<<2,121<<2
  Set_Fill_Color (CHOCOLATE <<16) | CHOCOLATE
  Fill_Rectangle 260<<2,140<<2,241<<2,121<<2
  Set_Fill_Color (SADDLE_BROWN <<16) | SADDLE_BROWN
  Fill_Rectangle 280<<2,140<<2,261<<2,121<<2
  Set_Fill_Color (SIENNA <<16) | SIENNA
  Fill_Rectangle 300<<2,140<<2,281<<2,121<<2
  Set_Fill_Color (BROWN <<16) | BROWN
  Fill_Rectangle 320<<2,140<<2,301<<2,121<<2
  Set_Fill_Color (MAROON <<16) | MAROON
  Fill_Rectangle 340<<2,140<<2,321<<2,121<<2
  
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 20<<2,160<<2,1<<2,141<<2
  Set_Fill_Color (WHITE <<16) | WHITE
  Fill_Rectangle 40<<2,160<<2,21<<2,141<<2  
  Set_Fill_Color (SNOW <<16) | SNOW
  Fill_Rectangle 60<<2,160<<2,41<<2,141<<2
  Set_Fill_Color (HONEYDEW <<16) | HONEYDEW
  Fill_Rectangle 80<<2,160<<2,61<<2,141<<2
  Set_Fill_Color (MINT_CREAM <<16) | MINT_CREAM
  Fill_Rectangle 100<<2,160<<2,81<<2,141<<2
  Set_Fill_Color (AZURE <<16) | AZURE
  Fill_Rectangle 120<<2,160<<2,101<<2,141<<2
  Set_Fill_Color (ALICE_BLUE <<16) | ALICE_BLUE
  Fill_Rectangle 140<<2,160<<2,121<<2,141<<2
  Set_Fill_Color (GHOST_WHITE <<16) | GHOST_WHITE
  Fill_Rectangle 160<<2,160<<2,141<<2,141<<2  
  Set_Fill_Color (WHITE_SMOKE <<16) | WHITE_SMOKE
  Fill_Rectangle 180<<2,160<<2,161<<2,141<<2
  Set_Fill_Color (SEA_SHELL <<16) | SEA_SHELL
  Fill_Rectangle 200<<2,160<<2,181<<2,141<<2
  Set_Fill_Color (BEIGE <<16) | BEIGE
  Fill_Rectangle 220<<2,160<<2,201<<2,141<<2
  Set_Fill_Color (OLD_LACE <<16) | OLD_LACE
  Fill_Rectangle 240<<2,160<<2,221<<2,141<<2
  Set_Fill_Color (FLORAL_WHITE <<16) | FLORAL_WHITE
  Fill_Rectangle 260<<2,160<<2,241<<2,141<<2
  Set_Fill_Color (IVORY <<16) | IVORY
  Fill_Rectangle 280<<2,160<<2,261<<2,141<<2
  Set_Fill_Color (ANTIQUE_WHITE <<16) | ANTIQUE_WHITE
  Fill_Rectangle 300<<2,160<<2,281<<2,141<<2
  Set_Fill_Color (LINEN <<16) | LINEN
  Fill_Rectangle 320<<2,160<<2,301<<2,141<<2
  Set_Fill_Color (LAVENDER_BLUSH <<16) | LAVENDER_BLUSH
  Fill_Rectangle 340<<2,160<<2,321<<2,141<<2
  
  Set_Fill_Color (MISTY_ROSE <<16) | MISTY_ROSE
  Fill_Rectangle 20<<2,180<<2,1<<2,161<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 40<<2,180<<2,21<<2,161<<2  
  Set_Fill_Color (GAINSBORO <<16) | GAINSBORO
  Fill_Rectangle 60<<2,180<<2,41<<2,161<<2
  Set_Fill_Color (LIGHT_GREY <<16) | LIGHT_GREY
  Fill_Rectangle 80<<2,180<<2,61<<2,161<<2
  Set_Fill_Color (SILVER <<16) | SILVER
  Fill_Rectangle 100<<2,180<<2,81<<2,161<<2
  Set_Fill_Color (DARK_GREY <<16) | DARK_GREY
  Fill_Rectangle 120<<2,180<<2,101<<2,161<<2
  Set_Fill_Color (GREY <<16) | GREY
  Fill_Rectangle 140<<2,180<<2,121<<2,161<<2
  Set_Fill_Color (DIM_GREY <<16) | DIM_GREY
  Fill_Rectangle 160<<2,180<<2,141<<2,161<<2  
  Set_Fill_Color (LIGHT_SLATE_GREY <<16) | LIGHT_SLATE_GREY
  Fill_Rectangle 180<<2,180<<2,161<<2,161<<2
  Set_Fill_Color (SLATE_GREY <<16) | SLATE_GREY
  Fill_Rectangle 200<<2,180<<2,181<<2,161<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 220<<2,180<<2,201<<2,161<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 240<<2,180<<2,221<<2,161<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 260<<2,180<<2,241<<2,161<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 280<<2,180<<2,261<<2,161<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 300<<2,180<<2,281<<2,161<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 320<<2,180<<2,301<<2,161<<2
  Set_Fill_Color (BLACK <<16) | BLACK
  Fill_Rectangle 340<<2,180<<2,321<<2,161<<2
  
  Sync_Full // Ensure Entire Scene Is Fully Drawn
RDPBufferEnd: 