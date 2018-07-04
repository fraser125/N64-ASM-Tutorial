@ECHO OFF
set rom_name=IPL_FONT.N64
REM Space seperated list of source files
set source_files=IPL_FONT.asm

if exist %rom_name% (
	del /q %rom_name%
)
bass -strict -create %1 -o %rom_name% %source_files%
if exist %rom_name% (
	@chksum64 %rom_name%
)