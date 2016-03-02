#!/usr/bin/env python

"""vhd2fctb.py: creates testbench from VHDL circuit description and fdf file"""

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
from vhdl_entity import vhdl_port
from vhdl_entity import vhdl_entity
from vhdl_entity import vhdl_generic
from vhdl_entity import vhdl_component

def main(argv):
   inputfile = ''
   outputfile = ''
   faultfile = ''
   verbose = False
   try:
      opts, args = getopt.getopt(argv,"hvi:f:o:",["ifile=","ffile=","ofile="])
   except getopt.GetoptError:
      print 'usage: vhd2fctb -i <inputfile> -f <fault_description_file> -o <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'usage: vhd2fctb -i <inputfile> -f <fault_description_file> -o <outputfile>'
         sys.exit()
      elif opt in ("-v", "--verbose"):
          verbose = True
      elif opt in ("-i", "--ifile"):
         inputfile = arg
      elif opt in ("-f", "--ffile"):
         faultfile = arg
      elif opt in ("-o", "--ofile"):
         outputfile = arg      
  

   verbosity_level = '1'
   log_signatures = True

   # Print some information for the user if verbose made has been activated
   if verbose == True: 
    print 'This is vhd2fctb; verbose mode activated'
    print 'Input file is:', inputfile
    print 'Output file is:', outputfile

   l_libraries = []
   l_generics = []
   l_entity_inputs = [] 
   l_entity_outputs = [] 
   l_signals = []

   in_file = open(inputfile)
   in_file.seek(0)
   in_file_lines = in_file.readlines()
   #Process generics
   for i in range(0, len(in_file_lines)):
    if 'generic' in in_file_lines[i]:
      generic_declaration_start = i
      for j in range(generic_declaration_start,len(in_file_lines)):
        if ');' in in_file_lines[j]:
          generic_declaration_end = j
          break
      break   
   for i in range(generic_declaration_start+1,generic_declaration_end):
    first_delim = in_file_lines[i].find(':')
    second_delim = in_file_lines[i].find(':=')
    generic_name = in_file_lines[i][0:first_delim-1].strip()
    generic_type = in_file_lines[i][first_delim+1:second_delim-1].strip()
    generic_std_value = in_file_lines[i][second_delim+2:-1].strip()
    generic_std_value = generic_std_value.replace(';','')
    new_generic = vhdl_generic(generic_name,generic_type,generic_std_value)
    l_generics.append(new_generic)
   #Process ports
   for i in range(0,len(in_file_lines)):
    if 'port' in in_file_lines[i]:
      port_declaration_start = i
      for j in range(port_declaration_start,len(in_file_lines)):
        if ');' in in_file_lines[j]:
          port_declaration_end = j
          break
      break          
   for i in range(port_declaration_start,port_declaration_end):
    if 'in' in in_file_lines[i]:
      splitted_line = in_file_lines[i].split(":")
      input_name = splitted_line[0].strip()
      input_type = splitted_line[1][splitted_line[1].find('in')+2:splitted_line[1].find(';')].strip()
      new_input_port = vhdl_port(input_name,'in',input_type)
      l_entity_inputs.append(new_input_port)          
    if 'out' in in_file_lines[i]:
      splitted_line = in_file_lines[i].split(":")
      output_name = splitted_line[0].strip()
      output_type = splitted_line[1][splitted_line[1].find('out')+3:splitted_line[1].find(';')].strip()
      new_output_port = vhdl_port(output_name,'out',output_type)
      l_entity_outputs.append(new_output_port)      
      
   in_file.close



   with open(inputfile) as in_file:
    for line in in_file:
      if line.startswith('entity') == True:
        stripped_line = line.strip()                
        p = re.compile(r'\bis\b')
        for m in p.finditer(stripped_line):
          a = (m.start(), m.group())
        entityname = stripped_line[stripped_line.find('entity')+7:m.start()].strip()
        print 'entityname: %s' % entityname
      if line.startswith('library') or line.startswith('use') or line.startswith('LIBRARY') or line.startswith('USE'):
        l_libraries.append(line)
   

   l_libraries.append('\nuse ieee.std_logic_textio.all;\nuse std.textio.all;\n')
   l_libraries.append('\nlibrary modelsim_lib;\nuse modelsim_lib.util.all;\n')
   l_libraries.append('\nuse ieee.std_logic_textio.all;\nuse std.textio.all;\n')


   tb_entity = vhdl_entity(entityname + '_fc_tb',[],[],[])   
   uut_component = vhdl_component(entityname,l_generics,l_entity_inputs,l_entity_outputs)     
   
   # Process fault description file
   with open(faultfile) as f:
    for line in f:
        # Skip comment lines
        if not (line.startswith('#') == True): 
          #l_statistics.append('--% s' % line)
          #print 'comment detected: %s' % line
        #else:
          l_signals.append(line.strip())
          #print 'signal detected: %s' % line
   f.close() 

   #Write testbench to file

   target = open(outputfile,'w')
   now = datetime.datetime.now()

   
   target.write('------------------------------------------------------------------------\n')
   target.write('--#LIS#\n')
   target.write('--Author: Sebastian Kroesche\n')
   target.write('--Date: %02d.%02d.%d \n' % (now.day, now.month, now.year) )
   target.write('--Description: Testbench for ISCAS89 %s circuit with the\n' % entityname)
   target.write('--             combined SER/BIST flip-flops\n')
   target.write('--             generated with vhd2fctb\n')
   #target.write('--Circuit statistics\n')
   #for statline in l_statistics:
   #     target.write(statline)
   target.write('------------------------------------------------------------------------\n')

   for lib in l_libraries:
    target.write(lib)

   target.write('\n' + vhdl_entity.writeEmptyEntity(tb_entity))

   target.write('\narchitecture bench of %s_fc_tb is\n' % entityname)
   target.write(vhdl_component.writeComponentDeclaration(uut_component))
   
   target.write('\n')
   for uut_input_signal in l_entity_inputs:
    target.write('\tsignal %s: %s;\n' % (uut_input_signal.name, uut_input_signal.type))    
   for uut_output_signal in l_entity_outputs:
    target.write('\tsignal %s: %s;\n' % (uut_output_signal.name, uut_output_signal.type))


   ## part with my specific signals#
   target.write('\n')
   target.write('\tconstant clock_period: time := 10 ns;\n')
   target.write('\tsignal stop_the_clock: boolean;\n')
   target.write('\ttype t_fsm_state is( idle, ser_detect, ser_correct, bist_init, bist_seq_start, bist_sig_scan_completed, bist_eval, check_parity, bist_end );\n\n')
   target.write('\tsignal spy_ctrl_state : t_fsm_state;\n')
   target.write('\tfile out_file: text open write_mode is "test_out_%s.fcf";\n' % entityname)

   target.write('\nbegin\n\n')
   
   target.write('\tinit_signal_spy("/%s_fc_tb/uut/CTRL/current_state","/%s_fc_tb/spy_ctrl_state", 1);\n\n' % (entityname, entityname))

   ## Write uut component mapping
   target.write(vhdl_component.writeComponentMap(uut_component))

   ##Write stimulus process
   target.write('\n\nstimulus: process\n')
   target.write('\tvariable s_a_line : line;\n')
   target.write('begin\n')
   for i in range(0,len(l_entity_inputs)):
    if l_entity_inputs[i].name != 'reset' and l_entity_inputs[i].name != 'clk':
      target.write('\t%s\t<= \'0\';\n' % l_entity_inputs[i].name)
   target.write('\treset\t<= \'1\';\n')
   target.write('\twait for 10*clock_period;\n')
   target.write('\treset\t<= \'0\';\n')
   target.write('\n\t-- Determine fault free circuit signature\n')
   target.write('\twait for 10*clock_period;\n')
   target.write('\tBIST_start_in <= \'1\';\n')
   target.write('\twait for clock_period;\n')
   target.write('\tBIST_start_in <= \'0\';\n')          
   target.write('\twait until BIST_Done_out = \'1\';\n')        
   target.write('\twait for 0.1*clock_period;\n')
   target.write('\tif BIST_result_out = \'1\' then\n')
   target.write('\t\treport "Testing a successfull BIST execution passed successfully" severity note;\n')
   target.write('\telse\n')
   target.write('\t\treport "Testing a successfull BIST execution failed" severity failure;\n')
   target.write('\tend if;\n\n')

   target.write('\twait for 10*clock_period;\n\t-- Testing the fault coverage\n')
   for signal in l_signals:
    target.write('\t--------------------------------------------------------------------------------\n');
    target.write('\t-- Testing signal %s with stuck-at-1 and stuck-at-0\n' % signal);
    target.write('\twrite(s_a_line,string'); target.write("'("); target.write('"%s;"));\n' % signal);
    target.write('\tsignal_force("/%s_fc_tb/uut/%s", "1", open, freeze, open, 0);\n' % (entityname, signal));            
    target.write("\tBIST_start_in <= '1';\n");
    target.write("\twait for clock_period;\n");
    target.write("\tBIST_start_in <= '0';\n");    
    target.write("\twait until spy_ctrl_state = bist_eval;\n");
    #target.write("\twrite(s_a_line,string'(\";\"));\n");
    target.write("\twrite(s_a_line,to_bstring(spy_misr_signature));\n");
    target.write("\twrite(s_a_line,string'(\";\"));\n");
    target.write("\twait until BIST_Done_out = '1';\n");
    target.write("\twait for 0.2*clock_period;\n");  
    target.write("\twrite(s_a_line, NOT BIST_result_out);\n");    
    target.write("\twrite(s_a_line,string'(\";\"));\n");
    target.write("\twait for clock_period;\n");
    target.write('\tsignal_release("/%s_fc_tb/uut/%s", 0);\n' % (entityname, signal));            
    target.write('\tsignal_force("/%s_fc_tb/uut/%s", "0", open, freeze, open, 0);\n' % (entityname, signal));             
    target.write("\tBIST_start_in <= '1';\n");
    target.write("\twait for clock_period;\n");
    target.write("\tBIST_start_in <= '0';\n");
    target.write("\twait until spy_ctrl_state = bist_eval;\n");
    #target.write("\twrite(s_a_line,string'(\";\"));\n");
    target.write("\twrite(s_a_line,to_bstring(spy_misr_signature));\n");
    target.write("\twrite(s_a_line,string'(\";\"));\n");    
    target.write("\twait until BIST_Done_out = '1';\n");
    target.write("\twait for 0.2*clock_period;\n");    
    target.write("\twrite(s_a_line, NOT BIST_result_out);\n");
    target.write("\twait for clock_period;\n");
    target.write('\tsignal_release("/%s_fc_tb/uut/%s", 0);\n' % (entityname, signal) );           
    target.write("\twriteline(out_file, s_a_line);\n");
   target.write('\n\treport "Testing fault coverage DONE!" severity note;\n') 
   target.write('\twait for 50*clock_period;\n') 
   target.write('\tstop_the_clock <= true;\n') 
   target.write('\twait;\n') 
   target.write('end process;\n\n')
   
   target.write('clocking: process\n')
   target.write('begin\n')
   target.write('\twhile not stop_the_clock loop\n')
   target.write('\t\tclk <= \'0\', \'1\' after clock_period / 2;\n')
   target.write('\t\twait for clock_period;\n')
   target.write('\t\tend loop;\n')
   target.write('\twait;\n')
   target.write('end process;\n')

   target.write('\nend architecture;')
   target.close()

if __name__ == "__main__":
   main(sys.argv[1:])
