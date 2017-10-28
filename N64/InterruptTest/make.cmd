@ECHO OFF
set rom_name=InterruptTest.N64
REM Space seperated list of source files
set source_files=InterruptTest.asm

if exist %rom_name% (
	del /q %rom_name%
)
bass -strict -create %1 -o %rom_name% %source_files%
if ERRORLEVEL 0 ECHO Compile Success!
if exist %rom_name% (
	@chksum64 %rom_name%	
)