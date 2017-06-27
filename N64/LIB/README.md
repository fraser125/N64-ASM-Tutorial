# N64 LIB Conventions
## File Extensions
* INC - Contain ONLY constants and macros
* S   - Code called with Jump or Branch instructions, may use global variables
In some cases there is an INC and an S file, that have to be used together

To use the files:
The *.INC should always be at the top of the source file, similar to the #include statement in C.

The *.S files should be included in the code near where it's used or before/after specific sections based on the desired ROM layout.

Inside each file the following code patterns apply

* The underscore _ prefixes labels and macros that are for internal use only.

