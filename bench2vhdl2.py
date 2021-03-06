#!/usr/bin/env python

"""bench2vhdl2.py: converts ISCAS89 bench format to VHDL, inserts lis_ser_bist_ff instead of DFFs"""

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
from lis_ser_bist_ff import lis_ser_bist_ff

def main(argv):
   inputfile = ''
   outputfile = ''
   verbose = False
   try:
      opts, args = getopt.getopt(argv,"hvi:o:f:",["ifile=","ofile="])
   except getopt.GetoptError:
      print 'usage: bench2vhdl.py -i <inputfile> -o <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'usage: bench2vhdl.py -i <inputfile> -o <outputfile>'
         sys.exit()
      elif opt in ("-v", "--verbose"):
          verbose = True
      elif opt in ("-i", "--ifile"):
         inputfile = arg
      elif opt in ("-o", "--ofile"):
         outputfile = arg      
  

   # Initialize lists for inputs, outputs, FFs and gates
   l_statistics = []
   l_inputs = []
   l_outputs = []
   l_dffs = []
   l_ser_bist_ffs = []
   l_inverters = []
   l_and_gates = []
   l_nand_gates = []
   l_or_gates = []
   l_nor_gates = []
   l_connections = []
   l_ctrl_signals = []
   l_ser_bist_err_signals = []
   l_ser_bist_scan_signals = []

   verbosity_level = '1'

   # Print some information for the user if verbose made has been activated
   if verbose == True: 
    print 'This is bench2vhdl; verbose mode activated'
    print 'Input file is:', inputfile
    print 'Output file is:', outputfile

   ###############################################################
   #                  PROCESS .BENCH INPUT FILE                  #    
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
        #Processing of D flip-flops ----!!!
        elif 'DFF' in line:
          open_bracket = line.find('(')+1
          close_bracket = line.find(')')            
          D_in = line[open_bracket:close_bracket]
          if not(D_in.strip() in l_connections): 
            l_connections.append(D_in.strip())
          Q_output = line[0:line.find('=')-1]
          if not(Q_output.strip() in l_connections): 
            l_connections.append(Q_output.strip())
          if lis_ser_bist_ff.count == 0:
            Q_in = '--needs to be inserted manually!'            
            Scan_in = 'ctrl_Scan_out'            
          else:   
            Q_in = l_ser_bist_ffs[lis_ser_bist_ff.count-1].Q_out
            Scan_in = l_ser_bist_ffs[lis_ser_bist_ff.count-1].Scan_out

          err_out_signal = 'SER_BIST_FF_%d_ERR_out' % lis_ser_bist_ff.count
          scan_out_signal = 'SER_BIST_FF_%d_Scan_out' % lis_ser_bist_ff.count
          l_ser_bist_err_signals.append(err_out_signal)
          l_ser_bist_scan_signals.append(scan_out_signal)          
          new_lis_ser_bist_ff = lis_ser_bist_ff('clk','reset',D_in,Q_in,'ctrl_B0_out',\
            'ctrl_B1_out',Scan_in,'ctrl_BIST_eval_out','ctrl_Hold_out','ctrl_Rollback_out',\
            err_out_signal,scan_out_signal,Q_output)          
          l_ser_bist_ffs.append(new_lis_ser_bist_ff)
          

          #l_dffs.append(new_dff)                    
        elif 'NOT' in line:
          open_bracket = line.find('(')+1
          close_bracket = line.find(')')            
          A = line[open_bracket:close_bracket]
          if not (A.strip() in l_connections):
            l_connections.append(A.strip())
          Z = line[0:line.find('=')-1]          
          if not (Z.strip() in l_connections):
            l_connections.append(Z.strip())
          new_inverter = lis_not(A,Z)
          l_inverters.append(new_inverter)
        elif 'AND' in line and not 'NAND' in line and not '#' in line:
          open_bracket = line.find('(')+1
          close_bracket = line.find(')')
          gate_size = line.count(',', open_bracket, close_bracket) + 1
          Z = line[0:line.find('=')-1]            
          if not(Z.strip() in l_connections):
            l_connections.append(Z.strip())
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
          for signal in l_input_ports:
            if not(signal.strip() in l_connections):
              l_connections.append(signal.strip())
        elif 'OR' in line and not 'NOR' in line and not '#' in line: 
          open_bracket = line.find('(')+1
          close_bracket = line.find(')')
          gate_size = line.count(',', open_bracket, close_bracket) + 1
          Z = line[0:line.find('=')-1]
          if not(Z.strip() in l_connections):
            l_connections.append(Z.strip())            
          if gate_size == 2:            
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_or2 = lis_or2(l_input_ports[0].strip(), l_input_ports[1].strip(), Z)
            l_or_gates.append(new_or2)
          elif gate_size == 3:
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_or3 = lis_or3(l_input_ports[0].strip(), l_input_ports[1].strip(), l_input_ports[2].strip(), Z)            
            l_or_gates.append(new_or3)
          elif gate_size == 4:
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_or4 = lis_or4(l_input_ports[0].strip(), l_input_ports[1].strip(), l_input_ports[2].strip(), l_input_ports[3].strip(), Z)            
            l_or_gates.append(new_or4)
          for signal in l_input_ports:
            if not(signal.strip() in l_connections):
              l_connections.append(signal.strip())
        elif 'NAND' in line and not '#' in line:
          open_bracket = line.find('(')+1
          close_bracket = line.find(')')
          gate_size = line.count(',', open_bracket, close_bracket) + 1
          Z = line[0:line.find('=')-1]
          if not(Z.strip() in l_connections):
            l_connections.append(Z.strip())              
          if gate_size == 2:            
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_nand2 = lis_nand2(l_input_ports[0].strip(), l_input_ports[1].strip(), Z)
            l_nand_gates.append(new_nand2)
          elif gate_size == 3:
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_nand3 = lis_nand3(l_input_ports[0].strip(), l_input_ports[1].strip(), l_input_ports[2].strip(), Z)            
            l_nand_gates.append(new_nand3)            
          elif gate_size == 4:
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_nand4 = lis_nand4(l_input_ports[0].strip(), l_input_ports[1].strip(), l_input_ports[2].strip(), l_input_ports[3].strip(), Z)            
            l_nand_gates.append(new_nand4)
          for signal in l_input_ports:
            if not(signal.strip() in l_connections):
              l_connections.append(signal.strip())             
        elif 'NOR' in line and not '#' in line: 
          open_bracket = line.find('(')+1
          close_bracket = line.find(')')
          gate_size = line.count(',', open_bracket, close_bracket) + 1
          Z = line[0:line.find('=')-1]
          if not(Z.strip() in l_connections):
            l_connections.append(Z.strip())                       
          if gate_size == 2:            
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_nor2 = lis_nor2(l_input_ports[0].strip(), l_input_ports[1].strip(), Z)
            l_nor_gates.append(new_nor2)
          elif gate_size == 3:
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_nor3 = lis_nor3(l_input_ports[0].strip(), l_input_ports[1].strip(), l_input_ports[2].strip(), Z)            
            l_nor_gates.append(new_nor3)
          elif gate_size == 4:
            l_input_ports = line[open_bracket:close_bracket].split(',')
            new_nor4 = lis_nor4(l_input_ports[0].strip(), l_input_ports[1].strip(), l_input_ports[2].strip(), l_input_ports[3].strip(), Z)            
            l_nor_gates.append(new_nor4)
          for signal in l_input_ports:
            if not(signal.strip() in l_connections):
              l_connections.append(signal.strip())

   if verbose == True:
    print 'Done\n\nThe following elements have been found in the design:'
    print '%d inputs: %s' % ( len(l_inputs), l_inputs)
    print '%d outputs: %s' % ( len(l_outputs), l_outputs)
    print '%d D flip-flops' % len(l_dffs)
    print '%d inverters' % len(l_inverters)
    print '%d logic gates: %d ANDs, %d NANDs, %d ORs, %d NORs\n' % ( len(l_and_gates) + len(l_nand_gates) + len(l_or_gates) + len(l_nor_gates), len(l_and_gates), len(l_nand_gates), len(l_or_gates), len(l_nor_gates) )

   # Post processing of ser_bist_ffs
   l_ser_bist_ffs[-1].Scan_out = 'open'
   l_ser_bist_ffs[0].Q_in = l_ser_bist_ffs[-1].Q_out
   for ff in l_ser_bist_ffs:
     print lis_ser_bist_ff.writePortMap(ff)

   # Post processing of l_connections
   for signal in l_connections:
     if signal in l_inputs or signal in l_outputs:
      l_connections.remove(signal)        
   
   l_ctrl_signals = ['ctrl_B0_out','ctrl_B1_out','ctrl_Scan_out', 'ctrl_BIST_eval_out', \
   'ctrl_Hold_out','ctrl_Rollback_out', 'OR_tree_out']


   f.close

   ###############################################################
   #          CREATE VHDL DESCRIPTION OF THE CIRCUIT             #    
   ###############################################################
   # Open outputfile in write mode
   target = open(outputfile, 'w')
   
   # Write header with author information and statistics
   #entityname = inputfile[0:inputfile.find('.')]
   now = datetime.datetime.now()

   target.write('------------------------------------------------------------------------\n')
   target.write('--#LIS#\n')
   target.write('--Author: Sebastian Kroesche\n')
   target.write('--Date: %02d.%02d.%d \n' % (now.day, now.month, now.year) )
   target.write('--Description: Implementation of ISCAS89 %s circuit with the\n' % entityname)
   target.write('--             combined SER/BIST flip-flops\n')
   target.write('--             generated with bench2vhdl2\n')
   target.write('--Circuit statistics\n')
   for statline in l_statistics:
        target.write(statline)
   target.write('------------------------------------------------------------------------\n')
   # Write library imports to outputfile
   target.write('library IEEE;\nuse IEEE.std_logic_1164.all; \n \n')
   target.write('library lis_lib;\nuse lis_lib.ser_bist.all; \n \n')
   
   #Write entity declaration to outputfile 
   
   target.write('entity %s_ser_bist is\n' % entityname)
   #**** new for ser_bist ****#
   target.write('\tgeneric (\n' + '\t\tNUM_FF\t\t\t\t:\tinteger\t:= %s;\n' % lis_ser_bist_ff.count)
   target.write('\t\tBIST_LENGTH\t\t\t:\tinteger\t:= 20000;\n')
   exp_resp_string = '\t\tEXPECTED_RESPONSE\t:\tstd_logic_vector(' + str(lis_ser_bist_ff.count) + '-1 downto 0)\t:= "'
   for i in range(0, len(l_ser_bist_ffs)):
     exp_resp_string = exp_resp_string + '0'   
   exp_resp_string = exp_resp_string + '"\n\t);\n'
   target.write(exp_resp_string)
   #**** new for ser_bist ****#
   target.write('\tport (\n')
   target.write('\t\tclk : in std_logic; \n')
   target.write('\t\treset : in std_logic; \n')
   target.write('\t\tBIST_start_in : in std_logic; \n')
   for input_port in l_inputs:
   		#target.write(input_port)
   		target.write('\t\t%s: in std_logic; \n' % input_port)
   for i in range(0, len(l_outputs)-1):   		
   		target.write('\t\t%s: out std_logic; \n' % l_outputs[i])
   target.write('\t\t%s: out std_logic \n' % l_outputs[len(l_outputs)-1])
   target.write('\t\tBIST_done_out : in std_logic; \n')
   target.write('\t\tBIST_pass_out : in std_logic \n')
   target.write('\t);\n')		
   target.write('end entity; \n\n')		

  

   #Write opening line of architecture
   target.write('architecture rtl of %s is\n\n' % entityname)
   #Write interconnecting signals
   for signal in l_connections:
     target.write('\tsignal %s : std_logic;\n' % signal)
   #Write SER/BIST ctrl signals
   target.write('\n--SER/BIST ctrl signals\n')
   for signal in l_ctrl_signals:
     target.write('\tsignal %s : std_ulogic;\n' % signal)
   for signal in l_ser_bist_err_signals:
     target.write('\tsignal %s : std_ulogic;\n' % signal)
   for signal in l_ser_bist_scan_signals:
     target.write('\tsignal %s : std_ulogic;\n' % signal)
   #Write begin of architecture
   target.write('\nbegin\n\n')   
   
   #Write SER/BIST controller
   controller_string = 'CTRL:\tlis_ser_bist_controller \n\
\t\tgeneric map( \n\
\t\t\tNUM_FF\t\t=> NUM_FF, \n \
\t\t\tBIST_LENGTH\t=> BIST_LENGTH \n \
\t\t)\n\
\t\tport map(\n\
\t\t\tclk\t\t\t\t=> clk, \n \
\t\t\treset\t\t\t=> reset, \n \
\t\t\tERR_in\t\t\t=> OR_tree_out, \n \
\t\t\tBIST_start_in\t=> BIST_start_in, \n \
\t\t\tExp_resp_in\t\t=> EXPECTED_RESPONSE, \n \
\t\t\tHold_out\t\t=> ctrl_Hold_out, \n \
\t\t\tRollback_out\t=> ctrl_Rollback_out, \n \
\t\t\tBIST_eval_out\t=> ctrl_BIST_eval_out, \n \
\t\t\tB0_out\t\t\t=> ctrl_B0_out, \n \
\t\t\tB1_out\t\t\t=> ctrl_B1_out, \n \
\t\t\tBIST_done_out\t=> BIST_done_out, \n \
\t\t\tBIST_pass_out\t=> BIST_pass_out, \n \
\t\t\tScan_out\t\t=> ctrl_Scan_out \n \
\t\t);\n\n'
   target.write(controller_string)

   #Write flip-flops
   target.write('\n--Flip-flops (total number: %d)\n' % len(l_ser_bist_ffs))
   for i in range(0, len(l_ser_bist_ffs)):
       #target.write('DFF_%d:\t lis_dff port map( clk => clk, Q_out => %s, D_in => % s, reset => reset );\n' % (i, l_dffs[i].Q_out, l_dffs[i].D_in) )    
       target.write(lis_ser_bist_ff.writePortMap(l_ser_bist_ffs[i]))
   
   #Write OR-tree
   OR_tree_string = 'OR_tree_out <= ' + l_ser_bist_ffs[0].ERR_out + ' OR '
   for i in range(1, len(l_ser_bist_ffs)-1):
     OR_tree_string = OR_tree_string + l_ser_bist_ffs[i].ERR_out + ' OR '
   OR_tree_string = OR_tree_string + l_ser_bist_ffs[-1].ERR_out
   OR_tree_string = OR_tree_string + ";\n"
   target.write(OR_tree_string)

   #Write inverters
   target.write('\n--Inverters (total number: %d)\n'% len(l_inverters))
   for i in range(0, len(l_inverters)):
       target.write('INV_%d:\t lis_not port map( A => %s, Z => %s );\n' % (i, l_inverters[i].A, l_inverters[i].Z) )
   
   #Write AND-gates
   target.write('\n--AND-gates (total number: %d)\n' % len(l_and_gates))
   for i in range(0, len(l_and_gates)):       
       if isinstance(l_and_gates[i], and2):
         target.write(and2.writePortMap(l_and_gates[i]))
       elif isinstance(l_and_gates[i], lis_and3):
         target.write(lis_and3.writePortMap(l_and_gates[i]))
       elif isinstance(l_and_gates[i], lis_and4):
         target.write(lis_and4.writePortMap(l_and_gates[i]))   
   
   #Write OR-gates
   target.write('\n--OR-gates (total number: %d)\n' % len(l_or_gates))
   for i in range(0, len(l_or_gates)):       
    if isinstance(l_or_gates[i], lis_or2):
      target.write(lis_or2.writePortMap(l_or_gates[i]))
    elif isinstance(l_or_gates[i], lis_or3):
      target.write(lis_or3.writePortMap(l_or_gates[i]))
    elif isinstance(l_or_gates[i], lis_or4):
      target.write(lis_or4.writePortMap(l_or_gates[i])) 
   
   #Write NAND-gates
   target.write('\n--NAND-gates (total number: %d)\n' % len(l_nand_gates))#
   for i in range(0, len(l_nand_gates)):       
       if isinstance(l_nand_gates[i], lis_nand2):
         target.write(lis_nand2.writePortMap(l_nand_gates[i]))
       elif isinstance(l_nand_gates[i], lis_nand3):
         target.write(lis_nand3.writePortMap(l_nand_gates[i]))
       elif isinstance(l_nand_gates[i], lis_nand4):
         target.write(lis_nand4.writePortMap(l_nand_gates[i]))
   
   #Write NOR-gates
   target.write('\n--NOR-gates (total number: %d)\n' % len(l_nor_gates))
   for i in range(0, len(l_nor_gates)):       
    if isinstance(l_nor_gates[i], lis_nor2):
      target.write(lis_nor2.writePnortMap(l_nor_gates[i]))
    elif isinstance(l_nor_gates[i], lis_nor3):
      target.write(lis_nor3.writePnortMap(l_nor_gates[i]))
    elif isinstance(l_nor_gates[i], lis_nor4):
      target.write(lis_nor4.writePnortMap(l_nor_gates[i]))    
   target.write('\nend architecture;\n')   
   target.close

   if verbose == True and verbosity_level == '2':
    print '\nThe following VHDL design has been created from the inputfile:\n'
    target = open(outputfile, 'r')
    for line in target:
      print line[0:len(line)-1]
   ###############################################################
   #          CREATE STUCK-AT-FAULT DESCRIPTION FILE             #    
   ###############################################################
   # Open outputfile in write mode
   faultfile = '%s.fdf' % entityname
   target = open(faultfile, 'w')
   
   # Write header with author information and statistics
   target.write('# Stuck-at-fault description file for circuit %s\n' % entityname)
   target.write('# Created by bench2vhdl on %d-%d-%d\n' % (now.year, now.month, now.day) )
   #target.write('signal_name;s-a-1 det;s-a-0 det\n')
   for signal in l_inputs:
     target.write('%s\n' % signal)
   for signal in l_outputs:
     target.write('%s\n' % signal)
   #target.write('#;#;#\n')
   for signal in l_connections:
     target.write('%s\n' % signal)
   target.close

   if verbose == True:
    print 'stuck-at-fault description file written to %s' % faultfile

if __name__ == "__main__":
   main(sys.argv[1:])
