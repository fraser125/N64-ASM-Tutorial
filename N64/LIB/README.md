# N64 LIB Conventions
## File Extensions
* *.INC
-* Contain ONLY constants and macros
* *.S   
-* Code must be called with Jump or Branch instructions, may use global variables

To use the files:
The *.INC should always be at the top of the source file, similar to the #include statement in C.

The *.S files should be included in the code near where it's used or before/after specific sections based on the desired ROM layout.