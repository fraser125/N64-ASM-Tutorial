@ECHO OFF
set rom_name=Lesson2.N64
REM Space seperated list of source files
set source_files=Lesson2.asm

if exist %rom_name% (
	del /q %rom_name%
)
bass -strict -o %rom_name% %source_files%
if exist %rom_name% (
	@chksum64 %rom_name%
)