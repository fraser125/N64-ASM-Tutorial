@ECHO OFF
set rom_name=Color16_Test.N64
REM Space seperated list of source files
set source_files=Color16_Test.asm

if exist %rom_name% (
	del /q %rom_name%
)
bass -strict -create %1 -o %rom_name% %source_files%
if exist %rom_name% (
	@chksum64 %rom_name%
)