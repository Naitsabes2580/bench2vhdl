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
import datetime

from dff import dff
from lis_not import lis_not
from and2 import and2
from lis_and3 import lis_and3
from lis_and4 import lis_and4

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
   l_statistics = []
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
        	l_statistics.append('--% s' % line)
          #print 'comment detected: %s' % line
        # Detect inputs
        if line.startswith('INPUT') == True:	
        	open_bracket = line.find('(')+1
        	close_bracket = line.find(')')	
        	l_inputs.append(line[open_bracket:close_bracket])    	
        # Detect outputs
        elif line.startswith('OUTPUT') == True:	
        	open_bracket = line.find('(')+1
        	close_bracket = line.find(')')	
        	l_outputs.append(line[open_bracket:close_bracket])
        #Processing of D flip-flops
        elif 'DFF' in line:
          open_bracket = line.find('(')+1
          close_bracket = line.find(')')            
          D_in = line[open_bracket:close_bracket]
          Q_out = line[0:line.find('=')-1]
          new_dff = dff(D_in, Q_out, 'clk', 'reset')          
          l_dffs.append(new_dff)
        elif 'NOT' in line:
          open_bracket = line.find('(')+1
          close_bracket = line.find(')')            
          A = line[open_bracket:close_bracket]
          Z = line[0:line.find('=')-1]          
          new_inverter = lis_not(A,Z)
          l_inverters.append(new_inverter)
        elif 'AND' in line:
          open_bracket = line.find('(')+1
          close_bracket = line.find(')')
          gate_size = line.count(',', open_bracket, close_bracket) + 1
          Z = line[0:line.find('=')-1]            
          if gate_size == 2:            
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_and2 = and2(l_input_ports[0].strip(), l_input_ports[1].strip(), Z)
            l_and_gates.append(new_and2)
          elif gate_size == 3:
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_and3 = lis_and3(l_input_ports[0].strip(), l_input_ports[1].strip(), l_input_ports[2].strip(), Z)            
            l_and_gates.append(new_and3)
          elif gate_size == 4:
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_and4 = lis_and4(l_input_ports[0].strip(), l_input_ports[1].strip(), l_input_ports[2].strip(), l_input_ports[3].strip(), Z)            
            l_and_gates.append(new_and4)

            

   # Open outputfile in write mode
   target = open(outputfile, 'w')
   
   # Write header with author information and statistics
   entityname = inputfile[0:inputfile.find('.')]
   now = datetime.datetime.now()

   target.write('------------------------------------------------------------------------\n')
   target.write('--#LIS#\n')
   target.write('--Author: Sebastian Kroesche\n')
   target.write('--Date: %d.%d.%d \n' % (now.day, now.month, now.year) )
   target.write('--Description: Implementation of ISCAS89 %s circuit with\n' % entityname)
   target.write('--             D-type flip-flops\n')
   target.write('--             generated with bench2vhdl\n')
   target.write('--Circuit statistics\n')
   for statline in l_statistics:
        target.write(statline)
   target.write('------------------------------------------------------------------------\n')
   # Write library imports to outputfile
   target.write('library IEEE;\n use IEEE.std_logic_1164.all; \n \n')
   target.write('library lis_lib;\n use lis_lib.ser_bist.all; \n \n')
   
   #Write entity declaration to outputfile 
   
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
   #Write flip-flops
   target.write('\n--Flip-flops\n')
   for i in range(0, len(l_dffs)):
       target.write('DFF_%d:\t lis_dff port map( clk => clk, Q_out => %s, D_in => % s, reset => reset );\n' % (i, l_dffs[i].Q_out, l_dffs[i].D_in) )    
   target.write('\n--Inverters\n')
   #Write inverters
   for i in range(0, len(l_inverters)):
       target.write('INV_%d:\t lis_not port map( A => %s, Z => %s );\n' % (i, l_inverters[i].A, l_inverters[i].Z) )
   #Write AND-gates
   target.write('\n--AND-gates\n')
   for i in range(0, len(l_and_gates)):       
       if isinstance(l_and_gates[i], and2):
         target.write(and2.writePortMap(l_and_gates[i]))
       elif isinstance(l_and_gates[i], lis_and3):
         target.write(lis_and3.writePortMap(l_and_gates[i]))
       elif isinstance(l_and_gates[i], lis_and4):
         target.write(lis_and4.writePortMap(l_and_gates[i]))   
   target.write('end architecture;\n')


   target.close

if __name__ == "__main__":
   main(sys.argv[1:])