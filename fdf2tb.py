#!/usr/bin/env python

"""fdf2tb.py: converts fault description file to VHDL testbench code"""

__author__ = "Sebastian Kroesche"
__copyright__ = "Copyright 2016, Sebastian Kroesche"
__license__ = "GPL"
__version__ = "0.1"
__maintainer__ = "Sebastian Kroesche"
__email__ = "sebastian.kroesche@mytum.de"
__status__ = "Development"

import sys, getopt
import datetime
import re 
import os.path

# Import classes for lis_dff and lis_gates
from dff import dff
from lis_not import lis_not
from and2 import and2
from lis_and3 import lis_and3
from lis_and4 import lis_and4
from lis_or2 import lis_or2
from lis_or3 import lis_or3
from lis_or4 import lis_or4
from lis_nand2 import lis_nand2
from lis_nand3 import lis_nand3
from lis_nand4 import lis_nand4
from lis_nor2 import lis_nor2
from lis_nor3 import lis_nor3
from lis_nor4 import lis_nor4

def main(argv):
   inputfile = ''
   outputfile = ''
   verbose = False
   try:
      opts, args = getopt.getopt(argv,"hvi:o:f:",["ifile=","ofile="])
   except getopt.GetoptError:
      print 'usage: fdf2tb.py -i <inputfile> -o <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'usage: fdf2tb.py -i <inputfile> -o <outputfile>'
         sys.exit()
      elif opt in ("-v", "--verbose"):
          verbose = True
      elif opt in ("-i", "--ifile"):
         inputfile = arg
      elif opt in ("-o", "--ofile"):
         outputfile = arg      
  

   # Initialize lists for inputs, outputs, FFs and gates
   l_statistics = []
   l_signals = []
   
   verbosity_level = '1'

   # Print some information for the user if verbose made has been activated
   if verbose == True:
    print 'This is fdf2tb; verbose mode activated'
    print 'Input file is:', inputfile
    print 'Output file is:', outputfile

   ###############################################################
   #                  PROCESS .FDF INPUT FILE                    #    
   ###############################################################
   entityname = os.path.basename(inputfile)
   entityname = entityname[0:entityname.find('.')]
   if verbose == True:
     print 'Parsing input file for entity %s .....' % entityname

   with open(inputfile) as f:
    for line in f:
        # Skip comment lines
        if line.startswith('#') == True: 
          l_statistics.append('--% s' % line)
          #print 'comment detected: %s' % line
        else:
          l_signals.append(line.strip())
          #print 'signal detected: %s' % line
   
   #if verbose == True:
   # print 'Done\n\nThe following elements have been found in the design:'
   # print '%d inputs: %s' % ( len(l_inputs), l_inputs)
   # print '%d outputs: %s' % ( len(l_outputs), l_outputs)
   # print '%d D flip-flops' % len(l_dffs)
   # print '%d inverters' % len(l_inverters)
   # print '%d logic gates: %d ANDs, %d NANDs, %d ORs, %d NORs\n' % ( len(l_and_gates) + len(l_nand_gates) + len(l_or_gates) + len(l_nor_gates), len(l_and_gates), len(l_nand_gates), len(l_or_gates), len(l_nor_gates) )

   # Post processing of l_connections
   #for signal in l_connections:
   #  if signal in l_inputs or signal in l_outputs:
   #   l_connections.remove(signal)        

   f.close

   ###############################################################
   #      CREATE SIGNAL FORCES FOR SIMULATING STUCK @ FAULTS     #    
   ###############################################################
   target = open(outputfile, 'w')

   for signal in l_signals:
    target.write('--------------------------------------------------------------------------------\n');
    target.write('-- Testing signal %s with stuck-at-1 and stuck-at-0\n' % signal);
    target.write('write(s_a_line,string'); target.write("'("); target.write('"%s;"));\n' % signal);
    target.write('signal_force("/s298_fc_tb/uut/%s", "1", open, freeze, open, 0);\n' % signal);            
    target.write("BIST_start_in <= '1';\n");
    target.write("wait for clock_period;\n");
    target.write("BIST_start_in <= '0';\n");
    target.write("wait until BIST_Done_out = '1';\n");
    target.write("wait for 0.2*clock_period;\n");
    #target.write("sa1_result := NOT BIST_result_out;\n");    
    target.write("write(s_a_line, NOT BIST_result_out);\n");
    target.write('write(s_a_line,string'); target.write("'("); target.write('";"));\n');
    target.write("wait for clock_period;\n");
    target.write('signal_release("/s298_fc_tb/uut/%s", 0);\n' % signal);            
    target.write('signal_force("/s298_fc_tb/uut/%s", "0", open, freeze, open, 0);\n' % signal);             
    target.write("BIST_start_in <= '1';\n");
    target.write("wait for clock_period;\n");
    target.write("BIST_start_in <= '0';\n");
    target.write("wait until BIST_Done_out = '1';\n");
    target.write("wait for 0.2*clock_period;\n");
    #target.write("sa0_result := NOT BIST_result_out;\n");
    target.write("write(s_a_line, NOT BIST_result_out);\n");
    target.write("wait for clock_period;\n");
    target.write('signal_release("/s298_fc_tb/uut/%s", 0);\n' % signal );       
    #target.write('report(strcat(strcat("%s;",To_String(sa1_result,"%%s;")),To_String(sa0_result,"%%s")));\n' % signal);
    #print('--------------------------------------------------------------------------------');
    target.write("writeline(out_file, s_a_line);\n");

    target.close
   #if verbose == True:
   #  print 'stuck-at-fault description file written to %s' % faultfile

if __name__ == "__main__":
   main(sys.argv[1:])