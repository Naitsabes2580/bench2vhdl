#!/usr/bin/env python

"""bench2vhdl.py: converts ISCAS89 bench format to VHDL"""

__author__ = "Sebastian Kroesche"
__copyright__ = "Copyright 2016, Sebastian Kroesche"
__license__ = "GPL"
__version__ = "0.1"
__maintainer__ = "Sebastian Kroesche"
__email__ = "sebastian.kroesche@mytum.de"
__status__ = "Development"

import sys, getopt

from dff import dff

def main(argv):
   inputfile = ''
   outputfile = ''
   try:
      opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
   except getopt.GetoptError:
      print 'usage: bench2vhdl.py -i <inputfile> -o <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'usage: bench2vhdl.py -i <inputfile> -o <outputfile>'
         sys.exit()
      elif opt in ("-i", "--ifile"):
         inputfile = arg
      elif opt in ("-o", "--ofile"):
         outputfile = arg
   print 'Input file is', inputfile
   print 'Output file is', outputfile

   # Initialize lists for inputs, outputs, FFs and gates
   l_inputs = []
   l_outputs = []
   l_dffs = []
   l_inverters = []
   l_and_gates = []
   l_nand_gates = []
   l_or_gates = []
   l_nor_gates = []

   with open(inputfile) as f:
    for line in f:
        # Skip comment lines
        if line.startswith('#') == True: 
        	print 'comment detected: %s' % line
        # Detect inputs
        elif line.startswith('INPUT') == True:	
        	open_bracket = line.find('(')+1
        	close_bracket = line.find(')')	
        	l_inputs.append(line[open_bracket:close_bracket])    	
        # Detect outputs
        elif line.startswith('OUTPUT') == True:	
        	open_bracket = line.find('(')+1
        	close_bracket = line.find(')')	
        	l_outputs.append(line[open_bracket:close_bracket])
   
   #Write entity declaration to outputfile 
   target = open(outputfile, 'w')
   entityname = inputfile[0:inputfile.find('.')]
  
   target.write('entity %s is\n' % entityname)
   target.write('port (\n')
   for input_port in l_inputs:
   		target.write(input_port)
   		target.write(': in std_logic; \n')
   for i in range(0, len(l_outputs)-1):
   		target.write(l_outputs[i])
   		target.write(': out std_logic; \n')
   target.write(l_outputs[len(l_outputs)-1])
   target.write(': out std_logic \n')
   target.write(');\n')		
   target.write('end entity; \n\n')		

   #
   print 'entity %s has the following' % entityname     	
   print 'inputs: %s' % l_inputs
   print 'outputs: %s' % l_outputs

   #Write architecture
   target.write('architecture rtl of %s is\n' % entityname)
   #TODO: add signal definitions
   target.write('begin\n')
   #TODO: add architecture
   target.write('end architecture;\n')

   target.close

if __name__ == "__main__":
   main(sys.argv[1:])