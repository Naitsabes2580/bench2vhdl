#! /usr/bin/env python

"""create_ser_bist_memory.py"""

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

def main(argv):
  entityname = ''
  outputfile = ''
  verbose = False
  clk_period = '10 ns'
  selected_ff_type = '1'
  ff_type_preselected = False
  try:
    opts, args = getopt.getopt(argv,"hve:o:",["entityname=","ofile="])
  except getopt.GetoptError:
    print 'usage: create_ser_bist_memory.py -e <entityname> -o <outputfile>'
    sys.exit(2)
  for opt, arg in opts:
    if opt == '-h':
      print 'usage: create_ser_bist_memory.py -e <entityname> -o <outputfile>'
      sys.exit()
    elif opt in ("-v", "--verbose"):
      verbose = True
    elif opt in ("-e", "--entityname"):
      entityname = arg
    elif opt in ("-o", "--ofile"):
      outputfile = arg            

  
  print '#######################################################'
  if verbose == True:
   print '# This is create_ser_bist_memory; verbose mode activated #'
  else:
   print '#          This is create_ser_bist_memory               #'
  print '#######################################################'   
  print 'Output file is: %s\n' % outputfile

   
  data_width = raw_input('Please specify data width: ')
  while not(data_width.isdigit() and int(data_width) > 0):
   print 'Invalid option selected. Try again!'    
   data_width = raw_input('Please specify data width: ')
  print 'Data width of %s bits selected.' % data_width  

  addr_width = raw_input('Please specify address width: ')
  while not(addr_width.isdigit() and int(addr_width) > 0):
   print 'Invalid option selected. Try again!'    
   addr_width = raw_input('Please specify address width: ')
  print 'Address width of %s bits selected.' % addr_width  
  

    
  now = datetime.datetime.now()
  ###############################################################
  #                  PROCESS .BENCH INPUT FILE                  #    
  ###############################################################
  
  ###############################################################
  #                     CREATE OUTPUT FILE                      #    
  ###############################################################
  target = open(outputfile, 'w')

  target.write('------------------------------------------------------------------------\n')
  target.write('--#LIS#\n')
  target.write('--Author: Sebastian Kroesche\n')
  target.write('--Date: %02d.%02d.%d - %02d:%02d:%02d  \n' % (now.day, now.month, now.year, now.hour, now.minute, now.second) )
  target.write('--Description: Pattern/Response ROM for %s_ser_bist circuit \n' % entityname)
  target.write('--             generated with create_ser_bist_memory\n')
  target.write('------------------------------------------------------------------------\n')
  
  target.write('library IEEE;\nuse IEEE.STD_LOGIC_1164.ALL;\n\n')
  target.write('library lis_lib;\nuse lis_lib.ser_bist.all;\n\n')
  target.write('LIBRARY XilinxCoreLib;\n\n')       
  
  target.write('entity %s_ser_bist_memory is\n' % entityname)
  target.write('\tport (\n')
  target.write('\t\tclk\t\t\t\t: in\tstd_logic;\n')
  target.write('\t\treset\t\t\t: in\tstd_logic;\n')
  target.write('\t\tstart\t\t\t: in\tstd_logic;\n')
  target.write('\t\tread_address\t: in\tstd_logic_vector(%s downto 0);\n' % str(int(addr_width)-1))
  target.write('\t\tpattern_out\t\t: out\tstd_logic;\n')
  target.write('\t\tresponse_out\t: out\tstd_logic\n')
  target.write('\t);\n')
  target.write('end %s_ser_bist_memory;\n\n' % entityname)

  target.write('architecture RTL of %s_ser_bist_memory is\n\n' % entityname)
  target.write('\tcomponent %s_ser_bist_pattern_rom\n' % entityname)
  target.write('\tport (\n')  
  target.write('\t\tclka\t: in\tstd_logic;\n')
  target.write('\t\taddra\t: in\tstd_logic_vector(%s downto 0);\n' % str(int(addr_width)-1))
  target.write('\t\tdouta\t: in\tstd_logic_vector(%s downto 0);\n' % str(int(data_width)-1))
  target.write('\t);\n')
  target.write('\tend component;\n\n')
  target.write('\tcomponent %s_ser_bist_response_rom\n' % entityname)
  target.write('\tport (\n')  
  target.write('\t\tclka\t: in\tstd_logic;\n')
  target.write('\t\taddra\t: in\tstd_logic_vector(%s downto 0);\n' % str(int(addr_width)-1))
  target.write('\t\tdouta\t: in\tstd_logic_vector(%s downto 0);\n' % str(int(data_width)-1))
  target.write('\t);\n')
  target.write('\tend component;\n')

  target.write('\n\tsignal pat_mem_data, resp_mem_data : std_logic_vector(%s downto 0);\n\n' % str(int(data_width)-1))

  target.write('begin\n\n')
  target.write('\tPAT_MEM: %s_ser_bist_pattern_rom\n' % entityname)
  target.write('\tport map(\n')  
  target.write('\t\tclka\t=> clk,\n')
  target.write('\t\taddra\t=> read_address,\n')
  target.write('\t\tdouta\t=> pat_mem_data\n')
  target.write('\t);\n\n')

  target.write('\tRESP_MEM: %s_ser_bist_pattern_rom\n' % entityname)
  target.write('\tport map(\n')  
  target.write('\t\tclka\t=> clk,\n')
  target.write('\t\taddra\t=> read_address,\n')
  target.write('\t\tdouta\t=> pat_mem_data\n')
  target.write('\t);\n\n')

  target.write('\tPAT_SERIALIZER : lis_parallel_to_serial\n')
  target.write('\tgeneric map(\n')
  target.write('\t\tN\t\t\t=> %s\n' % data_width)
  target.write('\t)\n')
  target.write('\tport map(\n')
  target.write('\t\tclk\t\t\t=> clk,\n')
  target.write('\t\treset\t\t=> reset,\n')
  target.write('\t\tstart\t\t=> start,\n')
  target.write('\t\tparallel_in\t=> pat_mem_data,\n')
  target.write('\t\tserial_out\t=> pattern_out\n')
  target.write('\t);\n\n')
  
  target.write('\tRESP_SERIALIZER : lis_parallel_to_serial\n')
  target.write('\tgeneric map(\n')
  target.write('\t\tN\t\t\t=> %s\n' % data_width)
  target.write('\t)\n')
  target.write('\tport map(\n')
  target.write('\t\tclk\t\t\t=> clk,\n')
  target.write('\t\treset\t\t=> reset,\n')
  target.write('\t\tstart\t\t=> start,\n')
  target.write('\t\tparallel_in\t=> resp_mem_data,\n')
  target.write('\t\tserial_out\t=> pattern_out\n')
  target.write('\t);\n\n')
  
  target.write('end RTL;')

  target.close()
  print 'Output written to file %s .' % outputfile

if __name__ == "__main__":
   main(sys.argv[1:])
