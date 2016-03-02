#!/usr/bin/env python

"""bench2vhdl_complete.py: converts ISCAS89 bench format to VHDL"""

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
from lis_ser_ff import lis_ser_ff
from lis_ser_bist_ff import lis_ser_bist_ff, lis_ser_bist_controller
from lis_po_dff import lis_po_dff
from lis_cbist_ff import lis_cbist_ff
from lis_cbist_ff import lis_cbist_controller
from lis_input_isol_sr import lis_input_isol_sr, lis_ser_bist_input_isol_sr
from lis_spc_even import lis_spc_even
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

from lis_misr import lis_misr
from lis_misr import lis_misr2_ff
from lis_misr import lis_misr3_ff
from lis_comparator import lis_comparator


def main(argv):
   inputfile = ''
   outputfile = ''
   verbose = False
   clk_period = '10 ns'
   selected_ff_type = '1'
   ff_type_preselected = False
   try:
      opts, args = getopt.getopt(argv,"hvi:o:t:",["ifile=","ofile=","fftype="])
   except getopt.GetoptError:
      print 'usage: bench2vhdl_complete.py -i <inputfile> -o <outputfile> -t <flip-flop-type>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'usage: bench2vhdl_complete.py -i <inputfile> -o <outputfile> -t <flip-flop-type>'
         sys.exit()
      elif opt in ("-v", "--verbose"):
          verbose = True
      elif opt in ("-i", "--ifile"):
         inputfile = arg
      elif opt in ("-o", "--ofile"):
         outputfile = arg      
      elif opt in ("-t", "--fftype"):
        if int(arg) >= 1 and int(arg) <= 4:
          selected_ff_type = str(arg)
          ff_type_preselected = True


   # Initialize lists for inputs, outputs, FFs and gates
   l_statistics = []
   l_inputs = []
   l_outputs = []
   l_flip_flops = []
   l_po_dffs = []
   l_po_signals = []
   l_inverters = []
   l_and_gates = []
   l_nand_gates = []
   l_or_gates = []
   l_nor_gates = []
   l_connections = []

   
   
   # Needed for CBIST and SER/BIST FF
   #l_err_signals = []
   #l_scan_signals = []
   l_input_isol_muxes = []
   l_bist_signals = ['input_mux_sel']

   verbosity_level = '1'

   ff_types = [
      '(1) Standard positive edge triggered D-type flip-flop', 
      '(2) Soft error resilient flip-flop with shadow cell',
      '(3) Circular BIST flip-flop',
      '(4) Combined SER/BIST flip-flop (merges option 2 and 3)']

   # Print some information for the user if verbose made has been activated
   #if verbose == True
   print '#######################################################'
   if verbose == True:
    print '# This is bench2vhdl_complete; verbose mode activated #'
   else:
    print '#          This is bench2vhdl_complete               #'
   print '#######################################################'
   if os.path.isfile(inputfile):
    print 'Input file is: %s' % inputfile
   else:
    print 'Specified input file cannot be read. Terminating now...'
    sys.exit()
   print 'Output file is: %s\n' % outputfile

   # Ask user which flip-flops to use
   if ff_type_preselected == False:
    print 'The following types of flip-flops can be selected:'
    for entry in ff_types:
     print entry  
    selected_ff_type = raw_input('Please specify number of the flip-flops to use: ')
    while not(selected_ff_type.isdigit() and int(selected_ff_type) >= 1 and int(selected_ff_type) <= 4):
     print 'Invalid option selected. Try again!'    
     selected_ff_type = raw_input('Please specify number of the flip-flops to use: ')   
    print 'Option \"%s\" selected\n' % ff_types[int(selected_ff_type)-1]
   
    

   ###############################################################
   #                  PROCESS .BENCH INPUT FILE                  #    
   ###############################################################
   entityname = os.path.basename(inputfile)
   entityname = entityname[0:entityname.find('.')]
   if verbose == True:
    print 'Parsing input file for entity %s .....' % entityname

   if int(selected_ff_type) == 3:
    entityname += '_cbist'
   elif int(selected_ff_type) == 4:
    entityname += '_ser_bist'

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
      #Processing of flip-flops
      elif 'DFF' in line:
        open_bracket = line.find('(')+1
        close_bracket = line.find(')')            
        D_in = line[open_bracket:close_bracket]
        if not(D_in.strip() in l_connections): 
          l_connections.append(D_in.strip())
        Q_out = line[0:line.find('=')-1]
        if not(Q_out.strip() in l_connections): 
          l_connections.append(Q_out.strip())        

        if int(selected_ff_type) == 1:   # D flip-flop selected
          new_ff = dff(D_in, Q_out, 'clk', 'reset')          
          l_flip_flops.append(new_ff)                    
        
        elif int(selected_ff_type) == 2: # SER flip-flop with shadow cell selected
          new_ERR_out = 'SER_FF_%s_ERR_out' % lis_ser_ff.count
          new_ff = lis_ser_ff(clk_period, 'clk', 'reset', D_in, 'ctrl_Hold_out', 'ctrl_Rollback_out', Q_out , new_ERR_out)
          l_flip_flops.append(new_ff)    
        
        elif int(selected_ff_type) == 3: # CBIST flip-flop selected
          if lis_cbist_ff.count == 0:
            Q_in = '--needs to be inserted manually!'  #this has to be connected to last ff of CBIST chain            
          else:   
            Q_in = l_flip_flops[lis_cbist_ff.count-1].Q_out                                
          new_lis_cbist_ff = lis_cbist_ff('clk', D_in, Q_in, 'ctrl_B0_out', 'ctrl_B1_out', Q_out)          
          l_flip_flops.append(new_lis_cbist_ff)

        elif int(selected_ff_type) == 4:          
          if lis_ser_bist_ff.count == 0:
            Q_in = '--needs to be inserted manually!'  #this has to be connected to last ff of CBIST chain            
            Scan_in = '--output of last input isolation SR ff'            
          else:                           
            Q_in = l_flip_flops[-1].Q_out
            Scan_in = l_flip_flops[-1].Scan_out
          new_lis_ser_bist_ff = lis_ser_bist_ff('clk', 'reset', D_in, Q_in, 'ctrl_B0_out', \
            'ctrl_B1_out', Scan_in, 'ctrl_BIST_eval_out', 'ctrl_Hold_out', 'ctrl_Rollback_out',\
            'SER_BIST_FF_%s_ERR_out' % lis_ser_bist_ff.count, 'SER_BIST_FF_%s_Scan_out' % lis_ser_bist_ff.count, \
            Q_out)
          l_flip_flops.append(new_lis_ser_bist_ff)          


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
    print '%d D flip-flops' % len(l_flip_flops)
    print '%d inverters' % len(l_inverters)
    print '%d logic gates: %d ANDs, %d NANDs, %d ORs, %d NORs\n' % ( len(l_and_gates) + len(l_nand_gates) + len(l_or_gates) + len(l_nor_gates), len(l_and_gates), len(l_nand_gates), len(l_or_gates), len(l_nor_gates) )

   # Post processing of l_connections   
   for signal in l_connections:
    if signal in l_inputs or signal in l_outputs:
      l_connections.remove(signal)      
   l_connections = [item for item in l_connections if item not in l_inputs]
   l_connections = [item for item in l_connections if item not in l_outputs]   

   f.close

   # Processing of input isolation muxes
   if int(selected_ff_type) == 3:
    for input_sig in l_inputs:      
       if lis_input_isol_sr.count == 0:
         chain_in = '--needs to be inserted manually!'  #this has to be connected to last ff of CBIST chain            
       else:   
         chain_in = l_input_isol_muxes[lis_input_isol_sr.count-1].chain_out                                
       chain_out = 'MUX_%s_chain_out' % input_sig
       mux_out = '%s_muxed' % input_sig
       new_lis_input_isol_sr = lis_input_isol_sr('clk', 'mux_reset', input_sig, chain_in, 'input_mux_sel', mux_out, chain_out)
       l_input_isol_muxes.append(new_lis_input_isol_sr)        
       l_bist_signals.append(chain_out)
       l_bist_signals.append(mux_out)
    l_bist_signals.append('mux_reset')
    l_flip_flops[0].Q_in = l_input_isol_muxes[-1].chain_out   

   if int(selected_ff_type) == 4:
    for input_sig in l_inputs:      
       if lis_ser_bist_input_isol_sr.count == 0:
         chain_in = '--needs to be inserted manually!'  #this has to be connected to last ff of CBIST chain            
         scan_in = 'ctrl_Scan_out'
       else:   
         chain_in = l_input_isol_muxes[lis_ser_bist_input_isol_sr.count-1].chain_out                                
         scan_in = l_input_isol_muxes[-1].Scan_out
       err_out = 'MUX_%s_ERR_out' % input_sig
       scan_out = 'MUX_%s_Scan_out' % input_sig
       chain_out = 'MUX_%s_chain_out' % input_sig
       mux_out = '%s_muxed' % input_sig
       new_lis_ser_bist_input_isol_sr = lis_ser_bist_input_isol_sr('clk', \
        'mux_reset', input_sig, chain_in, 'input_mux_sel', 'ctrl_B1_out', \
        scan_in, 'ctrl_BIST_eval_out', 'ctrl_Hold_out', 'ctrl_Rollback_out', \
        err_out, scan_out, mux_out, chain_out)
       l_input_isol_muxes.append(new_lis_ser_bist_input_isol_sr)        
       l_bist_signals.append(chain_out)
       l_bist_signals.append(mux_out)
    l_bist_signals.append('mux_reset')
    l_flip_flops[0].Q_in = l_input_isol_muxes[-1].chain_out   
    l_flip_flops[0].Scan_in = l_input_isol_muxes[-1].Scan_out

   if int(selected_ff_type) == 3 or int(selected_ff_type) == 4:
    for inv in l_inverters:
      if inv.A in l_inputs:
        inv.A += '_muxed'
      if inv.Z in l_inputs:
        inv.Z += '_muxed'
    for gate in l_and_gates:
      if isinstance(gate, and2):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
      elif isinstance(gate, lis_and3):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.C in l_inputs:
          gate.C += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
      elif isinstance(gate, lis_and4):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.C in l_inputs:
          gate.C += '_muxed'
        if gate.D in l_inputs:
          gate.D += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
    for gate in l_nand_gates:
      if isinstance(gate, lis_nand2):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
      elif isinstance(gate, lis_nand3):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.C in l_inputs:
          gate.C += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
      elif isinstance(gate, lis_nand4):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.C in l_inputs:
          gate.C += '_muxed'
        if gate.D in l_inputs:
          gate.D += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
    for gate in l_or_gates:
      if isinstance(gate, lis_or2):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
      elif isinstance(gate, lis_or3):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.C in l_inputs:
          gate.C += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
      elif isinstance(gate, lis_or4):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.C in l_inputs:
          gate.C += '_muxed'
        if gate.D in l_inputs:
          gate.D += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
    for gate in l_nor_gates:
      if isinstance(gate, lis_nor2):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
      elif isinstance(gate, lis_nor3):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.C in l_inputs:
          gate.C += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
      elif isinstance(gate, lis_nor4):
        if gate.A in l_inputs:
          gate.A += '_muxed'
        if gate.B in l_inputs:
          gate.B += '_muxed'
        if gate.C in l_inputs:
          gate.C += '_muxed'
        if gate.D in l_inputs:
          gate.D += '_muxed'
        if gate.Z in l_inputs:
          gate.Z += '_muxed'
   
   #####################################
   ##   Handling of PRIMARY OUTPUTS   ##
   #####################################
   # For CBIST circuits: Creation of MISR
   if int(selected_ff_type) == 3:
    l_misr_signals = ['misr_reset', 'misr_feedback_path', 'PO_DFF_CBIST_out']
    misr = lis_misr(len(l_outputs) + 1)   
    misr.addFlipFlop(lis_misr2_ff('PO_DFF_CBIST', 'clk', 'misr_reset', 'misr_feedback_path', l_flip_flops[-1].Q_out, 'PO_DFF_CBIST_out'))
    #for i in range(0, len(l_outputs)):
    # l_outputs[i] = l_outputs[i] + '_temp'
    for i in l_outputs:    
     if l_outputs.index(i) in misr.coefficients and l_outputs.index(i) != 0:
       #print 'hier muss ein lis_misr3_ff hin: %d' % i 
       misr.addFlipFlop(lis_misr3_ff('PO_DFF_%s' % l_outputs.index(i), 'clk', 'misr_reset', l_outputs[l_outputs.index(i)] + '_temp' , misr.misr_ffs[l_outputs.index(i)].Q_out, 'misr_feedback_path', 'PO_DFF_%s_out' % l_outputs.index(i)))            
       l_misr_signals.append('PO_DFF_%s_out' % l_outputs.index(i))
       l_misr_signals.append(l_outputs[l_outputs.index(i)] + '_temp')
     elif l_outputs.index(i) not in misr.coefficients or l_outputs.index(i) == 0:
       misr.addFlipFlop(lis_misr2_ff('PO_DFF_%s' % l_outputs.index(i), 'clk', 'misr_reset', l_outputs[l_outputs.index(i)] + '_temp', misr.misr_ffs[l_outputs.index(i)].Q_out, 'PO_DFF_%s_out' % l_outputs.index(i)))      
       l_misr_signals.append('PO_DFF_%s_out' % l_outputs.index(i))
       l_misr_signals.append(l_outputs[l_outputs.index(i)] + '_temp')
    l_input_isol_muxes[0].chain_in = misr.misr_ffs[-1].Q_out
   
   if int(selected_ff_type) == 4:
    for i in range(0, len(l_outputs)):
      D_in = l_outputs[i] + '_temp'      
      l_po_signals.append(D_in)
      if len(l_po_dffs) == 0:
        Q_in = l_flip_flops[-1].Q_out
        Scan_in = l_flip_flops[-1].Scan_out
        Q_out = 'PO_DFF_0_out'    
      else:                           
        Q_out = 'PO_DFF_%s_out' % str(len(l_po_dffs))
        Q_in = l_po_dffs[-1].Q_out
        Scan_in = l_po_dffs[-1].Scan_out
      new_po_ff = lis_po_dff('clk', 'reset', D_in, Q_in, 'ctrl_B0_out', \
            'ctrl_B1_out', Scan_in, 'ctrl_BIST_eval_out', 'ctrl_Hold_out', 'ctrl_Rollback_out',\
            'PO_DFF_%s_ERR_out' % str(len(l_po_dffs)), 'PO_DFF_%s_Scan_out' % str(len(l_po_dffs)), \
            Q_out)     
      l_po_dffs.append(new_po_ff)         
      l_po_signals.append(Q_out)
    l_input_isol_muxes[0].chain_in = l_po_dffs[-1].Q_out

   # Adaption to modified driving of circuit outputs for CBIST & SER/BIST
   if int(selected_ff_type) == 3 or int(selected_ff_type) == 4:
    for inv in l_inverters:
      if inv.A in l_outputs:
        inv.A += '_temp'
      if inv.Z in l_outputs:
        inv.Z += '_temp'
    for gate in l_and_gates:
      if isinstance(gate, and2):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
      elif isinstance(gate, lis_and3):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.C in l_outputs:
          gate.C += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
      elif isinstance(gate, lis_and4):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.C in l_outputs:
          gate.C += '_temp'
        if gate.D in l_outputs:
          gate.D += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
    for gate in l_nand_gates:
      if isinstance(gate, lis_nand2):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
      elif isinstance(gate, lis_nand3):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.C in l_outputs:
          gate.C += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
      elif isinstance(gate, lis_nand4):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.C in l_outputs:
          gate.C += '_temp'
        if gate.D in l_outputs:
          gate.D += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
    for gate in l_or_gates:
      if isinstance(gate, lis_or2):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
      elif isinstance(gate, lis_or3):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.C in l_outputs:
          gate.C += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
      elif isinstance(gate, lis_or4):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.C in l_outputs:
          gate.C += '_temp'
        if gate.D in l_outputs:
          gate.D += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
    for gate in l_nor_gates:
      if isinstance(gate, lis_nor2):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
      elif isinstance(gate, lis_nor3):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.C in l_outputs:
          gate.C += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
      elif isinstance(gate, lis_nor4):
        if gate.A in l_outputs:
          gate.A += '_temp'
        if gate.B in l_outputs:
          gate.B += '_temp'
        if gate.C in l_outputs:
          gate.C += '_temp'
        if gate.D in l_outputs:
          gate.D += '_temp'
        if gate.Z in l_outputs:
          gate.Z += '_temp'
    

   # Processing of comparators placed at MISR outputs
   if int(selected_ff_type) == 3:
    l_comparators = []
    l_comparator_signals = []
    #for ff in misr.misr_ffs:
    for i in range(0, len(misr.misr_ffs)):
      l_comparators.append(lis_comparator(misr.misr_ffs[i].Q_out, 'EXPECTED_RESPONSE(%s)' % str(len(misr.misr_ffs)-i-1), 'COMP_out(%s)' % str(len(misr.misr_ffs)-i-1)))
      #print lis_comparator.writePortMap(new_comp)
   
   # Processing of controller circuits that might be needed
   if int(selected_ff_type) == 3:
    controller_circuit = lis_cbist_controller('BIST_LENGTH', 'clk', 'reset', 'COMP_tree_out', 'BIST_start_in', 'ctrl_B0_out', 'ctrl_B1_out', 'BIST_done_out', 'BIST_result_out' )
   
   elif int(selected_ff_type) == 4:
    controller_circuit = lis_ser_bist_controller('NUM_FF', 'BIST_LENGTH', 'clk', 'reset', 'OR_tree_out', \
      'spc_par_ok_out', 'BIST_start_in', 'EXPECTED_RESPONSE', 'ctrl_Hold_out', 'ctrl_Rollback_out', \
      'ctrl_par_hold_out', 'ctrl_par_reset_out', 'ctrl_BIST_eval_out', 'ctrl_B0_out', 'ctrl_B1_out', \
      'BIST_done_out', 'BIST_result_out', 'ctrl_Scan_out')

   # Generation of parity checker, in case that ser_bist_ff has been selected:
   if int(selected_ff_type) == 4:
    parity_checker = lis_spc_even('clk', controller_circuit.par_reset_out, controller_circuit.Scan_out, l_po_dffs[-1].Scan_out, controller_circuit.par_hold_out, 'spc_par_ok_out')

   if int(selected_ff_type) == 3 or int(selected_ff_type) == 4:
    l_inputs.append('BIST_start_in')
    l_outputs.append('BIST_done_out')
    l_outputs.append('BIST_result_out')


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
   target.write('--Date: %02d.%02d.%d - %02d:%02d:%02d  \n' % (now.day, now.month, now.year, now.hour, now.minute, now.second) )
   target.write('--Description: Implementation of ISCAS89 %s circuit with\n' % entityname)
   target.write('--             %s \n' % ff_types[int(selected_ff_type)-1])#[4:-1])
   target.write('--             generated with bench2vhdl_complete\n')
   target.write('--Circuit statistics\n')
   for statline in l_statistics:
        target.write(statline)
   target.write('------------------------------------------------------------------------\n')
   # Write library imports to outputfile
   target.write('library IEEE;\nuse IEEE.std_logic_1164.all; \n \n')
   target.write('library lis_lib;\nuse lis_lib.ser_bist.all; \n \n')
 
   #Write entity declaration to outputfile 
 
   target.write('entity %s is\n' % entityname)
   if int(selected_ff_type) == 3:
    target.write('\tgeneric (\n')
    target.write('\t\tBIST_LENGTH : integer := 5000;\n')
    #target.write('\t\tEXPECTED_RESPONSE : std_logic_vector(%s downto 0) := ((%s downto 0) => \'0\');\n' % (str(len(l_comparators)-1)), str(len(l_comparators)-1))    
    target.write('\t\tEXPECTED_RESPONSE : std_logic_vector(%s downto 0) := (%s downto 0 => \'0\')\n' % ( str(len(l_comparators)-1), str(len(l_comparators)-1) ) )
    target.write('\t);\n')
   elif int(selected_ff_type) == 4:    
    NUM_FF = (len(l_input_isol_muxes)+len(l_flip_flops)+len(l_outputs)-2)
    target.write('\tgeneric (\n')
    target.write('\t\tNUM_FF : integer := %d;\n' % NUM_FF)
    target.write('\t\tBIST_LENGTH : integer := 5000;\n')    
    target.write('\t\tEXPECTED_RESPONSE : std_logic_vector(%s downto 0) := (%s downto 0 => \'0\')\n' \
      % (str(NUM_FF-1), str(NUM_FF-1) ) )
    target.write('\t);\n')

   target.write('\tport (\n')
   target.write('\t\tclk : in std_logic; \n')
   target.write('\t\treset : in std_logic; \n')
   for input_port in l_inputs:
   		#target.write(input_port)
   		target.write('\t\t%s: in std_logic; \n' % input_port)
   for i in range(0, len(l_outputs)-1):   		
   		target.write('\t\t%s: out std_logic; \n' % l_outputs[i])
   target.write('\t\t%s: out std_logic \n' % l_outputs[len(l_outputs)-1])
   target.write('\t);\n')		
   target.write('end entity; \n\n')		

  

   #Write opening line of architecture
   target.write('architecture rtl of %s is\n\n' % entityname)
   
   # Write interconnecting and internal signals      
   signal_string = '\tsignal '      
   for j in range(0,len(l_connections)-1):
     signal_string += '%s, ' % l_connections[j]
   signal_string += l_connections[len(l_connections)-1]   
   target.write(signal_string)
   target.write(' : std_logic;\n')
   if int(selected_ff_type) == 2:
    target.write('\n\tsignal OR_tree_out, ctrl_Hold_out, ctrl_Rollback_out : std_logic;\n\n')
    target.write('\tsignal ')
    for i in range(0, len(l_flip_flops)-1):
      target.write('%s, ' % l_flip_flops[i].ERR_out)
    target.write('%s : std_logic;\n' % l_flip_flops[-1].ERR_out) 

   elif int(selected_ff_type) == 3:
    target.write('\n\tsignal ')
    for i in range(0, len(l_bist_signals)-1):
      target.write('%s, ' % l_bist_signals[i])
    target.write('%s : std_logic;\n' % l_bist_signals[-1])
    target.write('\n\tsignal COMP_out : std_logic_vector(%s downto 0) := (others => \'0\');\n' % str(len(l_comparators)-1))
    target.write(lis_cbist_controller.writeSignalDeclaration(controller_circuit))
    target.write('\n\tsignal ')
    for i in range(0, len(l_misr_signals)-1):
      target.write('%s, ' % l_misr_signals[i])
    target.write('%s : std_logic;\n' % l_misr_signals[-1])
    target.write('\tsignal misr_signature : std_logic_vector(%s downto 0) := (others => \'0\');\n' % str(len(misr.misr_ffs)-1))

   elif int(selected_ff_type) == 4:
    target.write('\n\tsignal ')
    for i in range(0, len(l_bist_signals)-1):
      target.write('%s, ' % l_bist_signals[i])
    target.write('%s : std_logic;\n' % l_bist_signals[-1])
    target.write('\n\tsignal ')
    for i in range(0, len(l_po_signals)-1):
      target.write('%s, ' % l_po_signals[i])
    target.write('%s : std_logic;\n' % l_po_signals[-1])
    target.write(lis_ser_bist_controller.writeSignalDeclaration(controller_circuit))
    #Generate circuit signature
    #dim_circ_sig = len(l_input_isol_muxes) + len(l_flip_flops) + len(l_po_dffs)
    #target.write('signal circuit_signature : std_logic_vector(%s downto 0) := (others => \'0\');\n' % str(dim_circ_sig-1))
   
   #Write begin of architecture
   target.write('\nbegin\n')   
    
   #Write controllers if neccessary (needed for selected flip-flop types 2, 3 and 4)
   if int(selected_ff_type) == 2:
    #Write OR-tree and shadow cell controller
    OR_tree_string = 'OR_tree_out <= ' + l_flip_flops[0].ERR_out + ' OR '
    for i in range(1, len(l_flip_flops)-1):
      OR_tree_string = OR_tree_string + l_flip_flops[i].ERR_out + ' OR '
    OR_tree_string = OR_tree_string + l_flip_flops[-1].ERR_out
    OR_tree_string = OR_tree_string + ";\n"
    target.write(OR_tree_string)
    target.write('\nSER_CTRL: lis_shadow_cell_controller\n')
    target.write('\tport map(\n')
    target.write('\t\tclk\t\t\t\t=>\tclk,\n')
    target.write('\t\treset\t\t\t=>\treset,\n')
    target.write('\t\tERR_in\t\t\t=>\tOR_tree_out,\n')
    target.write('\t\tHold_out\t\t=>\tctrl_Hold_out,\n')
    target.write('\t\tRollback_out\t=>\tctrl_Rollback_out\n')
    target.write('\t);')

   elif int(selected_ff_type) == 3:
    target.write(lis_cbist_controller.writePortMap(controller_circuit))

   elif int(selected_ff_type) == 4:
    #target.write()
    # target.write('\ncircuit_sig_proc: process(')
    # for i in range(0, len(l_input_isol_muxes)):
    #   target.write('%s, ' % l_input_isol_muxes[i].chain_out)
    # for i in range(0, len(l_flip_flops)):
    #   target.write('%s, ' % l_flip_flops[i].Q_out)
    # for i in range(0, len(l_po_dffs)-1):
    #   target.write('%s, ' % l_po_dffs[i].Q_out)
    # target.write('%s)\n' % l_po_dffs[-1].Q_out)
    # target.write('begin\n')
    # target.write('circuit_signature <= ')
    # for i in range(0, len(l_input_isol_muxes)):
    #   target.write('%s & ' % l_input_isol_muxes[i].chain_out)
    # for i in range(0, len(l_flip_flops)):
    #   target.write('%s & ' % l_flip_flops[i].Q_out)
    # for i in range(0, len(l_po_dffs)-1):
    #   target.write('%s & ' % l_po_dffs[i].Q_out)
    # target.write('%s;' % l_po_dffs[-1].Q_out)
    # target.write('end process;\n\n')
    target.write(lis_ser_bist_controller.writePortMap(controller_circuit))

   # Write input isolation multiplexers (needed for CBIST FF and SER/BIST FF)
   if int(selected_ff_type) == 3 or int(selected_ff_type) == 4:
    target.write('--------------------------------------------------------------------------------\n')
    target.write('--                    START INPUT ISOLATION MUXES                             --\n')
    target.write('--------------------------------------------------------------------------------\n')
    if int(selected_ff_type) == 4:
      target.write('\ninput_mux_sel_proc: process (reset, ctrl_B0_out, ctrl_B1_out)\n')
    else:
      target.write('\ninput_mux_sel_proc: process (ctrl_B0_out, ctrl_B1_out)\n')
    target.write('begin\n')
    target.write('\tinput_mux_sel <= NOT( ctrl_B0_out XOR ctrl_B1_out );\n')
    if int(selected_ff_type) == 4:
      target.write('\tmux_reset <= reset OR ( ctrl_B0_out NOR ctrl_B1_out );\n')
    target.write('end process;\n\n')
    for element in l_input_isol_muxes:
      if int(selected_ff_type) == 3:
        target.write(lis_input_isol_sr.writePortMap(element))
      elif int(selected_ff_type) == 4:
        target.write(lis_ser_bist_input_isol_sr.writePortMap(element))
    target.write('--------------------------------------------------------------------------------\n')
    target.write('--                      END INPUT ISOLATION MUXES                             --\n')
    target.write('--------------------------------------------------------------------------------\n')

   #Write flip-flops
   target.write('\n--Flip-flops (total number: %d)\n' % len(l_flip_flops))
   for i in range(0, len(l_flip_flops)):
    #D-type flip-flops selected
    if int(selected_ff_type) == 1:
      target.write('DFF_%d:\t lis_dff port map( clk => clk, Q_out => %s, D_in => % s, reset => reset );\n' % (i, l_flip_flops[i].Q_out, l_flip_flops[i].D_in) )    
   
    #SER flip-flop with shadow cell selected
    elif int(selected_ff_type) == 2:
      target.write(lis_ser_ff.writePortMap(l_flip_flops[i]))      

    #CBIST flip-flop selected
    elif int(selected_ff_type) == 3:
      target.write(lis_cbist_ff.writePortMap(l_flip_flops[i]))

    #SER/BIST flip-flop selected
    elif int(selected_ff_type) == 4:
      target.write(lis_ser_bist_ff.writePortMap(l_flip_flops[i]))
      
   if int(selected_ff_type) == 3:
    #Write MISR
    target.write('------------------------------------------------------------------------\n')
    target.write('--                            START MISR                                \n')
    target.write('--      of width %d (%d POs + 1 for connecting with CBIST chain) with   \n' % (misr.length, misr.length-1))
    target.write('--      primitive polynomial and coefficients %s                        \n' % misr.coefficients)
    target.write('------------------------------------------------------------------------\n')
    target.write('misr_reset <= reset or (%s NOR %s);\n' % (controller_circuit.B0_out, controller_circuit.B1_out))
    target.write('mux_reset <= reset or (%s NOR %s);\n' % (controller_circuit.B0_out, controller_circuit.B1_out))
    target.write(lis_misr.writeAllPortMaps(misr))
    target.write('\nmisr_feedback_path <= %s;\n' % misr.misr_ffs[-1].Q_out)
    target.write('\nmisr_signature <= ')
    for i in range(0, len(misr.misr_ffs)-1):
      target.write('%s & ' % misr.misr_ffs[i].Q_out)
    target.write('%s;\n' % misr.misr_ffs[-1].Q_out)
    target.write('\noutput_temp_proc: process(')
    for i in range(1, len(misr.misr_ffs)-1):
      target.write('%s, ' % misr.misr_ffs[i].CUT_in)
    target.write('%s)\n' % misr.misr_ffs[-1].CUT_in)    
    target.write('begin\n')
    for i in range(1, len(misr.misr_ffs)-1):
      target.write('\t%s <= %s;\n' % (misr.misr_ffs[i].CUT_in[0:-5], misr.misr_ffs[i].CUT_in))
    target.write('\t%s <= %s;\n' % (misr.misr_ffs[-1].CUT_in[0:-5], misr.misr_ffs[-1].CUT_in))
    target.write('end process;\n')
    target.write('------------------------------------------------------------------------\n')
    target.write('--                            END MISR                                --\n')
    target.write('------------------------------------------------------------------------\n')
    
    #Write Comparators
    for comp in l_comparators:
      target.write(lis_comparator.writePortMap(comp))
    target.write("\nCOMP_tree_out <= \'0\' when (COMP_out = (%s downto 0 => '0')) else \'1\';\n" % str(len(l_comparators)-1))

   elif int(selected_ff_type) == 4:
    target.write('------------------------------------------------------------------------\n')
    target.write('--                 START PRIMARY OUTPUT HANDLING                      --\n')
    target.write('------------------------------------------------------------------------\n')
    #print l_po_dffs
    lis_ser_bist_ff.count = 0
    for po_dff in l_po_dffs:
      target.write(lis_po_dff.writePortMap(po_dff))
    target.write('\noutput_temp_proc: process(')
    sensitivity_list = ''
    for i in range (0,len(l_outputs)-1):
      if l_outputs[i] not in ['BIST_done_out', 'BIST_result_out']:
        #target.write('%s_temp, ' % i)        
        sensitivity_list += '%s_temp, ' % l_outputs[i]
    sensitivity_list = sensitivity_list[0:-2] + ')\n'
    target.write(sensitivity_list)    
    target.write('begin\n')
    for i in range(1, len(l_outputs)-1):
      if l_outputs[i] not in ['BIST_done_out', 'BIST_result_out']:
        target.write('\t%s <= %s;\n' % (l_outputs[i], l_outputs[i] + '_temp'))
    #target.write('\t%s <= %s;\n' % (misr.misr_ffs[-1].CUT_in[0:-5], misr.misr_ffs[-1].CUT_in))
    target.write('end process;\n')
    target.write('------------------------------------------------------------------------\n')
    target.write('--                  END PRIMARY OUTPUT HANDLING                       --\n')
    target.write('------------------------------------------------------------------------\n\n')
    target.write('------------------------------------------------------------------------\n')
    target.write('--            START PARITY CHECKING OF EXPECTED RESPONSE              --\n')
    target.write('------------------------------------------------------------------------')
    target.write(lis_spc_even.writePortMap(parity_checker))
    target.write('------------------------------------------------------------------------\n')
    target.write('--             END PARITY CHECKING OF EXPECTED RESPONSE               --\n')
    target.write('------------------------------------------------------------------------\n')
    target.write('------------------------------------------------------------------------\n')
    target.write('--                          START OR-TREE                             --\n')
    target.write('------------------------------------------------------------------------\n')
    #Write OR-tree and shadow cell controller
    #OR_tree_string = 'OR_tree_out <= ' + l_flip_flops[0].ERR_out + ' OR '
    OR_tree_string = 'OR_tree_out <= ' + l_input_isol_muxes[0].ERR_out + ' OR '
    for i in range(1, len(l_input_isol_muxes)):
      OR_tree_string += l_input_isol_muxes[i].ERR_out + ' OR '
    for i in range(0, len(l_flip_flops)):
      OR_tree_string += l_flip_flops[i].ERR_out + ' OR '
    for i in range(0, len(l_po_dffs)-1):
      OR_tree_string += l_po_dffs[i].ERR_out + ' OR '
    OR_tree_string += '%s;\n' % l_po_dffs[-1].ERR_out    
    target.write(OR_tree_string)
    target.write('------------------------------------------------------------------------\n')
    target.write('--                           END OR-TREE                              --\n')
    target.write('------------------------------------------------------------------------\n')

   target.write('\n--Inverters (total number: %d)\n'% len(l_inverters))
   #Write inverters
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
   if int(selected_ff_type) > 2: 
     # Open outputfile in write mode
     
     faultfile = os.path.dirname(outputfile) + '/%s.fdf' % entityname
     target = open(faultfile, 'w')
     
     # Write header with author information and statistics
     target.write('# Stuck-at-fault description file for circuit %s\n' % entityname)
     target.write('# Created by bench2vhdl_complete on %d-%02d-%02d\n' % (now.year, now.month, now.day) )
     #target.write('# signal_name;s-a-1 det;s-a-0 det\n')
     for signal in l_inputs:      
      if int(selected_ff_type) == 3 or int(selected_ff_type) == 4:        
        if signal != 'BIST_start_in':
          target.write('%s_muxed\n' % signal)              
      else: 
          target.write('%s\n' % signal)  
     for signal in l_outputs:
      if int(selected_ff_type) == 3 or int(selected_ff_type) == 4:        
        if not signal in ['BIST_result_out', 'BIST_done_out']:
          target.write('%s_temp\n' % signal)              
      else: 
          target.write('%s\n' % signal)  
     #target.write('#;#;#\n')
     for signal in l_connections:
      target.write('%s\n' % signal)
     target.close

     if verbose == True:
      print 'stuck-at-fault description file written to %s' % faultfile

if __name__ == "__main__":
   main(sys.argv[1:])
