arch n64.cpu
endian msb
fill 1052672

origin $00000000
base $80000000 
include "../LIB/N64.INC" 
include "../LIB/COLORS32.INC" 
include "../LIB/N64_GFX.INC"

include "N64_HEADER.ASM" 
insert "../LIB/N64_BOOTCODE.BIN" 

Start:  
	N64_INIT()
	ScreenNTSC(320, 240, BPP32, $A0100000)
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
  Set_Scissor 0<<2,0<<2, 0,0, 320<<2,240<<2
  Set_Other_Modes CYCLE_TYPE_FILL 
  Set_Color_Image IMAGE_DATA_FORMAT_RGBA,SIZE_OF_PIXEL_32B,320-1, $00100000

  Set_Fill_Color $000000FF // Set Fill Color: PACKED COLOR 32B R8G8B8A8 Pixel
  Fill_Rectangle 319<<2,239<<2, 0<<2,0<<2 // Fill Rectangle: XL 319.0,YL 239.0, XH 0.0,YH 0.0
  
  Set_Fill_Color INDIAN_RED
  // Bottom Right X, Bottom Right Y, Top Left X, Top Left Y
  Fill_Rectangle 20<<2,20<<2, 1<<2,1<<2

  Set_Fill_Color LIGHT_CORAL
  Fill_Rectangle 40<<2,20<<2, 21<<2,1<<2
  Set_Fill_Color SALMON
  Fill_Rectangle 60<<2,20<<2, 41<<2,1<<2
  Set_Fill_Color DARK_SALMON
  Fill_Rectangle 80<<2,20<<2, 61<<2,1<<2
  Set_Fill_Color CRIMSON
  Fill_Rectangle 100<<2,20<<2, 81<<2,1<<2
  Set_Fill_Color RED
  Fill_Rectangle 120<<2,20<<2, 101<<2,1<<2
  Set_Fill_Color FIRE_BRICK
  Fill_Rectangle 140<<2,20<<2, 121<<2,1<<2
  Set_Fill_Color DARK_RED
  Fill_Rectangle 160<<2,20<<2, 141<<2,1<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 180<<2,20<<2, 161<<2,1<<2

  Set_Fill_Color PINK
  Fill_Rectangle 200<<2,20<<2, 181<<2,1<<2
  Set_Fill_Color LIGHT_PINK
  Fill_Rectangle 220<<2,20<<2, 201<<2,1<<2
  Set_Fill_Color HOT_PINK
  Fill_Rectangle 240<<2,20<<2, 221<<2,1<<2
  Set_Fill_Color DEEP_PINK
  Fill_Rectangle 260<<2,20<<2, 241<<2,1<<2
  Set_Fill_Color MEDIUM_VIOLET_RED
  Fill_Rectangle 280<<2,20<<2, 261<<2,1<<2
  Set_Fill_Color PALE_VIOLET_RED
  Fill_Rectangle 300<<2,20<<2, 281<<2,1<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 320<<2,20<<2, 301<<2,1<<2
  
  // Bottom Right X, Bottom Right Y, Top Left X, Top Left Y
  Set_Fill_Color LIGHT_SALMON
  Fill_Rectangle 20<<2,40<<2, 1<<2,21<<2
  Set_Fill_Color CORAL
  Fill_Rectangle 40<<2,40<<2, 21<<2,21<<2
  Set_Fill_Color TOMATO
  Fill_Rectangle 60<<2,40<<2, 41<<2,21<<2
  Set_Fill_Color ORANGE_RED
  Fill_Rectangle 80<<2,40<<2, 61<<2,21<<2
  Set_Fill_Color DARK_ORANGE
  Fill_Rectangle 100<<2,40<<2, 81<<2,21<<2
  Set_Fill_Color ORANGE
  Fill_Rectangle 120<<2,40<<2, 101<<2,21<<2
  Set_Fill_Color BLACK	
  Fill_Rectangle 140<<2,40<<2, 121<<2,21<<2
  
  Set_Fill_Color GOLD
  Fill_Rectangle 160<<2,40<<2, 141<<2, 21<<2
  Set_Fill_Color YELLOW
  Fill_Rectangle 180<<2,40<<2, 161<<2,21<<2
  Set_Fill_Color LIGHT_YELLOW
  Fill_Rectangle 200<<2,40<<2, 181<<2,21<<2
  Set_Fill_Color LEMON_CHIFFON
  Fill_Rectangle 220<<2,40<<2, 201<<2,21<<2
  Set_Fill_Color LIGHT_GOLDENROD_YELLOW
  Fill_Rectangle 240<<2,40<<2, 221<<2,21<<2
  Set_Fill_Color PAPAYA_WHIP
  Fill_Rectangle 260<<2,40<<2, 241<<2,21<<2
  Set_Fill_Color MOCCASIN
  Fill_Rectangle 280<<2,40<<2, 261<<2,21<<2
  Set_Fill_Color PEACH_PUFF
  Fill_Rectangle 300<<2,40<<2, 281<<2,21<<2
  Set_Fill_Color PALE_GOLDENROD
  Fill_Rectangle 320<<2,40<<2, 301<<2,21<<2
  Set_Fill_Color KHAKI
  Fill_Rectangle 340<<2,40<<2, 321<<2,21<<2
  
  Set_Fill_Color DARK_KHAKI
  Fill_Rectangle 20<<2,60<<2,1<<2,41<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 40<<2,60<<2,21<<2,41<<2
  
  Set_Fill_Color LAVENDER
  Fill_Rectangle 60<<2,60<<2,41<<2,41<<2
  Set_Fill_Color THISTLE
  Fill_Rectangle 80<<2,60<<2,61<<2,41<<2
  Set_Fill_Color PLUM
  Fill_Rectangle 100<<2,60<<2,81<<2,41<<2
  Set_Fill_Color VIOLET
  Fill_Rectangle 120<<2,60<<2,101<<2,41<<2
  Set_Fill_Color ORCHID
  Fill_Rectangle 140<<2,60<<2,121<<2,41<<2
  Set_Fill_Color FUCHSIA
  Fill_Rectangle 160<<2,60<<2,141<<2,41<<2
  Set_Fill_Color MAGENTA
  Fill_Rectangle 180<<2,60<<2,161<<2,41<<2
  Set_Fill_Color MEDIUM_ORCHID
  Fill_Rectangle 200<<2,60<<2,181<<2,41<<2
  Set_Fill_Color BLUE_VIOLET
  Fill_Rectangle 220<<2,60<<2,201<<2,41<<2
  Set_Fill_Color DARK_ORCHID
  Fill_Rectangle 240<<2,60<<2,221<<2,41<<2
  Set_Fill_Color DARK_MAGENTA
  Fill_Rectangle 260<<2,60<<2,241<<2,41<<2
  Set_Fill_Color PURPLE
  Fill_Rectangle 280<<2,60<<2,261<<2,41<<2
  Set_Fill_Color INDIGO
  Fill_Rectangle 300<<2,60<<2,281<<2,41<<2
  Set_Fill_Color SLATE_BLUE
  Fill_Rectangle 320<<2,60<<2,301<<2,41<<2
  Set_Fill_Color DARK_SLATE_BLUE
  Fill_Rectangle 340<<2,60<<2,321<<2,41<<2

  Set_Fill_Color BLACK
  Fill_Rectangle 20<<2,80<<2,1<<2,61<<2
  Set_Fill_Color GREEN_YELLOW
  Fill_Rectangle 40<<2,80<<2,21<<2,61<<2  
  Set_Fill_Color CHARTREUSE
  Fill_Rectangle 60<<2,80<<2,41<<2,61<<2
  Set_Fill_Color LAWN_GREEN
  Fill_Rectangle 80<<2,80<<2,61<<2,61<<2
  Set_Fill_Color LIME
  Fill_Rectangle 100<<2,80<<2,81<<2,61<<2
  Set_Fill_Color LIME_GREEN
  Fill_Rectangle 120<<2,80<<2,101<<2,61<<2
  Set_Fill_Color PALE_GREEN
  Fill_Rectangle 140<<2,80<<2,121<<2,61<<2
  Set_Fill_Color LIGHT_GREEN
  Fill_Rectangle 160<<2,80<<2,141<<2,61<<2
  Set_Fill_Color MEDIUM_SPRING_GREEN
  Fill_Rectangle 180<<2,80<<2,161<<2,61<<2
  Set_Fill_Color SPRING_GREEN
  Fill_Rectangle 200<<2,80<<2,181<<2,61<<2
  Set_Fill_Color MEDIUM_SEA_GREEN
  Fill_Rectangle 220<<2,80<<2,201<<2,61<<2
  Set_Fill_Color SEA_GREEN
  Fill_Rectangle 240<<2,80<<2,221<<2,61<<2
  Set_Fill_Color FOREST_GREEN
  Fill_Rectangle 260<<2,80<<2,241<<2,61<<2
  Set_Fill_Color GREEN
  Fill_Rectangle 280<<2,80<<2,261<<2,61<<2
  Set_Fill_Color DARK_GREEN
  Fill_Rectangle 300<<2,80<<2,281<<2,61<<2
  Set_Fill_Color YELLOW_GREEN
  Fill_Rectangle 320<<2,80<<2,301<<2,61<<2
  Set_Fill_Color OLIVE_DRAB
  Fill_Rectangle 340<<2,80<<2,321<<2,61<<2
  
  Set_Fill_Color OLIVE
  Fill_Rectangle 20<<2,100<<2,1<<2,81<<2
  Set_Fill_Color DARK_OLIVE_GREEN
  Fill_Rectangle 40<<2,100<<2,21<<2,81<<2  
  Set_Fill_Color MEDIUM_AQUAMARINE
  Fill_Rectangle 60<<2,100<<2,41<<2,81<<2
  Set_Fill_Color DARK_SEA_GREEN
  Fill_Rectangle 80<<2,100<<2,61<<2,81<<2
  Set_Fill_Color LIGHT_SEA_GREEN
  Fill_Rectangle 100<<2,100<<2,81<<2,81<<2
  Set_Fill_Color DARK_CYAN
  Fill_Rectangle 120<<2,100<<2,101<<2,81<<2
  Set_Fill_Color TEAL
  Fill_Rectangle 140<<2,100<<2,121<<2,81<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 160<<2,100<<2,141<<2,81<<2
  
  Set_Fill_Color AQUA
  Fill_Rectangle 180<<2,100<<2,161<<2,81<<2
  Set_Fill_Color CYAN
  Fill_Rectangle 200<<2,100<<2,181<<2,81<<2
  Set_Fill_Color LIGHT_CYAN
  Fill_Rectangle 220<<2,100<<2,201<<2,81<<2
  Set_Fill_Color PALE_TURQUOISE
  Fill_Rectangle 240<<2,100<<2,221<<2,81<<2
  Set_Fill_Color AQUAMARINE
  Fill_Rectangle 260<<2,100<<2,241<<2,81<<2
  Set_Fill_Color TURQUOISE
  Fill_Rectangle 280<<2,100<<2,261<<2,81<<2
  Set_Fill_Color MEDIUM_TURQUOISE
  Fill_Rectangle 300<<2,100<<2,281<<2,81<<2
  Set_Fill_Color DARK_TURQUOISE
  Fill_Rectangle 320<<2,100<<2,301<<2,81<<2
  Set_Fill_Color CADET_BLUE
  Fill_Rectangle 340<<2,100<<2,321<<2,81<<2
  
  Set_Fill_Color STEEL_BLUE
  Fill_Rectangle 20<<2,120<<2,1<<2,101<<2
  Set_Fill_Color LIGHT_STEEL_BLUE
  Fill_Rectangle 40<<2,120<<2,21<<2,101<<2  
  Set_Fill_Color POWDER_BLUE
  Fill_Rectangle 60<<2,120<<2,41<<2,101<<2
  Set_Fill_Color LIGHT_BLUE
  Fill_Rectangle 80<<2,120<<2,61<<2,101<<2
  Set_Fill_Color SKY_BLUE
  Fill_Rectangle 100<<2,120<<2,81<<2,101<<2
  Set_Fill_Color LIGHT_SKY_BLUE
  Fill_Rectangle 120<<2,120<<2,101<<2,101<<2
  Set_Fill_Color DEEP_SKY_BLUE
  Fill_Rectangle 140<<2,120<<2,121<<2,101<<2
  Set_Fill_Color DODGER_BLUE
  Fill_Rectangle 160<<2,120<<2,141<<2,101<<2  
  Set_Fill_Color CORN_FLOWER_BLUE
  Fill_Rectangle 180<<2,120<<2,161<<2,101<<2
  Set_Fill_Color MEDIUM_SLATE_BLUE
  Fill_Rectangle 200<<2,120<<2,181<<2,101<<2
  Set_Fill_Color ROYAL_BLUE
  Fill_Rectangle 220<<2,120<<2,201<<2,101<<2
  Set_Fill_Color MEDIUM_BLUE
  Fill_Rectangle 240<<2,120<<2,221<<2,101<<2
  Set_Fill_Color BLUE
  Fill_Rectangle 260<<2,120<<2,241<<2,101<<2
  Set_Fill_Color DARK_BLUE
  Fill_Rectangle 280<<2,120<<2,261<<2,101<<2
  Set_Fill_Color NAVY
  Fill_Rectangle 300<<2,120<<2,281<<2,101<<2
  Set_Fill_Color MIDNIGHT_BLUE
  Fill_Rectangle 320<<2,120<<2,301<<2,101<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 340<<2,120<<2,321<<2,101<<2
    
  Set_Fill_Color CORNSILK
  Fill_Rectangle 20<<2,140<<2,1<<2,121<<2
  Set_Fill_Color BLANCHED_ALMOND
  Fill_Rectangle 40<<2,140<<2,21<<2,121<<2  
  Set_Fill_Color BISQUE
  Fill_Rectangle 60<<2,140<<2,41<<2,121<<2
  Set_Fill_Color NAVAJO_WHITE
  Fill_Rectangle 80<<2,140<<2,61<<2,121<<2
  Set_Fill_Color WHEAT
  Fill_Rectangle 100<<2,140<<2,81<<2,121<<2
  Set_Fill_Color BURLY_WOOD
  Fill_Rectangle 120<<2,140<<2,101<<2,121<<2
  Set_Fill_Color TAN
  Fill_Rectangle 140<<2,140<<2,121<<2,121<<2
  Set_Fill_Color ROSY_BROWN
  Fill_Rectangle 160<<2,140<<2,141<<2,121<<2  
  Set_Fill_Color SANDY_BROWN
  Fill_Rectangle 180<<2,140<<2,161<<2,121<<2
  Set_Fill_Color GOLDENROD
  Fill_Rectangle 200<<2,140<<2,181<<2,121<<2
  Set_Fill_Color DARK_GOLDENROD
  Fill_Rectangle 220<<2,140<<2,201<<2,121<<2
  Set_Fill_Color PERU
  Fill_Rectangle 240<<2,140<<2,221<<2,121<<2
  Set_Fill_Color CHOCOLATE
  Fill_Rectangle 260<<2,140<<2,241<<2,121<<2
  Set_Fill_Color SADDLE_BROWN
  Fill_Rectangle 280<<2,140<<2,261<<2,121<<2
  Set_Fill_Color SIENNA
  Fill_Rectangle 300<<2,140<<2,281<<2,121<<2
  Set_Fill_Color BROWN
  Fill_Rectangle 320<<2,140<<2,301<<2,121<<2
  Set_Fill_Color MAROON
  Fill_Rectangle 340<<2,140<<2,321<<2,121<<2
  
  Set_Fill_Color BLACK
  Fill_Rectangle 20<<2,160<<2,1<<2,141<<2
  Set_Fill_Color WHITE
  Fill_Rectangle 40<<2,160<<2,21<<2,141<<2  
  Set_Fill_Color SNOW
  Fill_Rectangle 60<<2,160<<2,41<<2,141<<2
  Set_Fill_Color HONEYDEW
  Fill_Rectangle 80<<2,160<<2,61<<2,141<<2
  Set_Fill_Color MINT_CREAM
  Fill_Rectangle 100<<2,160<<2,81<<2,141<<2
  Set_Fill_Color AZURE
  Fill_Rectangle 120<<2,160<<2,101<<2,141<<2
  Set_Fill_Color ALICE_BLUE
  Fill_Rectangle 140<<2,160<<2,121<<2,141<<2
  Set_Fill_Color GHOST_WHITE
  Fill_Rectangle 160<<2,160<<2,141<<2,141<<2  
  Set_Fill_Color WHITE_SMOKE
  Fill_Rectangle 180<<2,160<<2,161<<2,141<<2
  Set_Fill_Color SEA_SHELL
  Fill_Rectangle 200<<2,160<<2,181<<2,141<<2
  Set_Fill_Color BEIGE
  Fill_Rectangle 220<<2,160<<2,201<<2,141<<2
  Set_Fill_Color OLD_LACE
  Fill_Rectangle 240<<2,160<<2,221<<2,141<<2
  Set_Fill_Color FLORAL_WHITE
  Fill_Rectangle 260<<2,160<<2,241<<2,141<<2
  Set_Fill_Color IVORY
  Fill_Rectangle 280<<2,160<<2,261<<2,141<<2
  Set_Fill_Color ANTIQUE_WHITE
  Fill_Rectangle 300<<2,160<<2,281<<2,141<<2
  Set_Fill_Color LINEN
  Fill_Rectangle 320<<2,160<<2,301<<2,141<<2
  Set_Fill_Color LAVENDER_BLUSH
  Fill_Rectangle 340<<2,160<<2,321<<2,141<<2
  
  Set_Fill_Color MISTY_ROSE
  Fill_Rectangle 20<<2,180<<2,1<<2,161<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 40<<2,180<<2,21<<2,161<<2  
  Set_Fill_Color GAINSBORO
  Fill_Rectangle 60<<2,180<<2,41<<2,161<<2
  Set_Fill_Color LIGHT_GREY
  Fill_Rectangle 80<<2,180<<2,61<<2,161<<2
  Set_Fill_Color SILVER
  Fill_Rectangle 100<<2,180<<2,81<<2,161<<2
  Set_Fill_Color DARK_GREY
  Fill_Rectangle 120<<2,180<<2,101<<2,161<<2
  Set_Fill_Color GREY
  Fill_Rectangle 140<<2,180<<2,121<<2,161<<2
  Set_Fill_Color DIM_GREY
  Fill_Rectangle 160<<2,180<<2,141<<2,161<<2  
  Set_Fill_Color LIGHT_SLATE_GREY
  Fill_Rectangle 180<<2,180<<2,161<<2,161<<2
  Set_Fill_Color SLATE_GREY
  Fill_Rectangle 200<<2,180<<2,181<<2,161<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 220<<2,180<<2,201<<2,161<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 240<<2,180<<2,221<<2,161<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 260<<2,180<<2,241<<2,161<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 280<<2,180<<2,261<<2,161<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 300<<2,180<<2,281<<2,161<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 320<<2,180<<2,301<<2,161<<2
  Set_Fill_Color BLACK
  Fill_Rectangle 340<<2,180<<2,321<<2,161<<2
  
  Sync_Full // Ensure Entire Scene Is Fully Drawn
RDPBufferEnd: