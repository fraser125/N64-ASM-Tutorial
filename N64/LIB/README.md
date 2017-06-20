# N64 LIB Conventions
## File Extensions
* *.INC
-* Contain ONLY constants and macros
* *.S   
-* Contain code that must be called with Jump or Branch instructions
-* Contain code that may use global variables

To use the files the *.INC should always be at the top of the source file, similar to the #include statement in C.

The *.S files should be included in the code near where it's used or before/after specific sections based on the desired ROM layout.