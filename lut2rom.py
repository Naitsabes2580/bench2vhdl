#! /usr/bin/env python

"""lut2rom.py: converts csv file with ROM contents into Xilinx COE file format"""

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
  inputfile = ''
  verbose = False
  prefix = ''
  try:
     opts, args = getopt.getopt(argv,"hvi:p:",["ifile=","prefix="])
  except getopt.GetoptError:
     print 'usage: lut2rom.py -i <inputfile> -p <prefix> [-v]'
     sys.exit(2)
  for opt, arg in opts:
     if opt == '-h':
        print 'usage: lut2rom.py -i <inputfile> -p <prefix> [-v]'
        sys.exit()
     elif opt in ("-v", "--verbose"):
         verbose = True
     elif opt in ("-i", "--ifile"):
        inputfile = arg
     elif opt in ("-p", "--prefix"):
        prefix = arg      
      

  # Initialize lists for inputs, outputs, FFs and gates
  l_patterns = []
  l_responses = []
     
  verbosity_level = '1'

  # Print some information for the user if verbose made has been activated
  #if verbose == True
  print '#######################################################'
  if verbose == True:
    print '# This is lut2rom; verbose mode activated #'
  else:
    print '#          This is lut2rom               #'
  print '#######################################################'
  if os.path.isfile(inputfile):
    print 'Input file is: %s' % inputfile
  else:
    print 'Specified input file cannot be read. Terminating now...'
    sys.exit()
    print 'Output file is: %s\n' % outputfile
    print 'prefix is: %s\n'
    

   ###############################################################
   #                  PROCESS .BENCH INPUT FILE                  #    
   ###############################################################
  entityname = os.path.basename(inputfile)
  entityname = entityname[0:entityname.find('.')]
  if not prefix:
    prefix = entityname
  if verbose == True:
    print 'Parsing LUT file %s .....' % inputfile

  with open(inputfile) as f:
    for line in f:
      # Skip comment lines
      if not line.startswith('#') == True: 
        splitted_line = line.split(';')
        print "%s:%s" % (splitted_line[0], splitted_line[1])
        l_patterns.append(splitted_line[0].strip())
        l_responses.append(splitted_line[1].strip())
    f.close

   ###############################################################
   #                      CREATE COE FILES                       #    
   ###############################################################
   # Open outputfile in write mode
  patternfile = os.path.dirname(inputfile) + '/' + prefix + '_pattern_rom_content.coe'
  responsefile = os.path.dirname(inputfile) + '/' + prefix + '_response_rom_content.coe'
  print patternfile

  pattern_target = open(patternfile, 'w')
  pattern_target.write('memory_initialization_radix=2;\nmemory_initialization_vector=\n')
  for i in range(0, len(l_patterns)-1):
    pattern_target.write("%s,\n" % l_patterns[i])
  pattern_target.write("%s;" % l_patterns[-1])
  pattern_target.close

  response_target = open(responsefile, 'w')
  response_target.write('memory_initialization_radix=2;\nmemory_initialization_vector=\n')
  for i in range(0, len(l_responses)-1):
    response_target.write("%s,\n" % l_responses[i])
  response_target.write("%s;" % l_responses[-1])
  response_target.close

if __name__ == "__main__":
   main(sys.argv[1:])
