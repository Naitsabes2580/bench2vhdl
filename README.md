## bench2vhdl
Python script(s) for converting ISCAS89 bench format to VHDL
In addition a stuck-at-fault description file (<entityname>.fdf) is created that contains
a list of all signals that can be affected by s-a-0 and s-a-1 errors

### Usage
Command line arguments (optional parameters written in [])
bench2vhdl [-v] -i input_file -o output_file
[-v]	verbose (outputs information about the processed circuit and the created VHDL design)
-i 	specifies the input file
-o 	specifies the output file

## bench2vhdl_complete
In that script, the type of flip-flop to be used can be chosen:
(1) Conventional D-type flip-flop
(2) Soft Error Resilient flip-flop
(3) Circular BIST FF
(4) SER/BIST FF