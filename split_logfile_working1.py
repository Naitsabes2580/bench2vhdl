#! /usr/bin/env python

"""split_logfile.py: converts ISCAS89 bench format to VHDL"""

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
import linecache

# Import classes for lis_dff and lis_gates


def main(argv):
  inputfile = ''
  outputfile = ''
  verbose = False
  clk_period = '10 ns'
  selected_ff_type = '1'
  ff_type_preselected = False
  try:
     opts, args = getopt.getopt(argv,"hvi:o:",["ifile=","ofile="])
  except getopt.GetoptError:
     print 'usage: split_logfile.py -i <inputfile> -o <outputfile> [-v]'
     sys.exit(2)
  for opt, arg in opts:
     if opt == '-h':
        print 'usage: split_logfile.py -i <inputfile> -o <outputfile> [-v]'
        sys.exit()
     elif opt in ("-v", "--verbose"):
         verbose = True
     elif opt in ("-i", "--ifile"):
        inputfile = arg
     elif opt in ("-o", "--ofile"):
        outputfile = arg      
      

  # Initialize lists for inputs, outputs, FFs and gates
  print '#######################################################'
  if verbose == True:
   print '# This is split_logfile; verbose mode activated #'
  else:
   print '#          This is split_logfile               #'
  print '#######################################################'
  if os.path.isfile(inputfile):
   print 'Input file is: %s' % inputfile
  else:
   print 'Specified input file cannot be read. Terminating now...'
   sys.exit()
  print 'Output file is: %s\n' % outputfile

  l_output_lines = []
  l_linenumbers = []
  fp = open(inputfile)  
  #Find the lines where a new pattern starts
  for i, line in enumerate(fp):
    if line.startswith('pattern'):
      l_linenumbers.append(i)
      #print i
  l_linenumbers.append(i)
  fp.close()

  #Read the first chunk
  chunk_start = -1
  chunk_end = chunk_start + l_linenumbers[1]+1
  fp = open(inputfile)      
  for i, line in enumerate(fp):
    if i > chunk_start and i < chunk_end:
      l_output_lines.append(line.strip())
  fp.close()
  #print l_output_lines

  print l_linenumbers[-1]
  
  chunk_start = 0
  chunk_end = 0
  for j in range(1, len(l_linenumbers)-1):
    chunk_start = l_linenumbers[j]-1
    chunk_end = chunk_start + l_linenumbers[1]+1
    print(chunk_start, chunk_end)  
    chunk_content = []
    fp = open(inputfile)      
    for i, line in enumerate(fp):
      if i > chunk_start and i < chunk_end:
        chunk_content.append(line)    
    #print('##############')
    for j in range(0, len(l_output_lines)):
      l_output_lines[j] += ';' + chunk_content[j].split(';')[1].strip()                
      #print l_output_lines
    fp.close()  
    
    
    
  #
  # f 
  #if i > l_linenumbers[0] and i < l_linenumbers[1]:      
  #    l_output_lines.append(line)
  #  for j in range(1, len(l_linenumbers)-1):
  #    if i > l_linenumbers[j] and i < l_linenumbers[j+1]:
  #      #print line
  #  if i > l_linenumbers[-2] and i < l_linenumbers[-1]+1:
  #    #print line
  #fp.close()
    
      
      #l_output_lines.append(line)

  #for j in 0 to len(l_linenumbers):
  #first_chunk = linecache.getline(inputfile,l_linenumbers[0]+1)
  #print first_chunk
  #print l_output_lines
  target = open(outputfile, 'w')
  for line in l_output_lines:
    target.write(line + '\n')
  target.close()

if __name__ == "__main__":
   main(sys.argv[1:])
