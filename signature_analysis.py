#!/usr/bin/python

"""signature_analysis.py: Analyzes the frequency of occurence of final circuit signatures"""

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
   outputfile = ''
   sigcol1 = 2
   sigcol2 = 4
   verbose = False
   try:
      opts, args = getopt.getopt(argv,"hvi:o:sc1:sc2:",["ifile=","ofile=","sigcol1=","sigcol2="])
   except getopt.GetoptError:
      print 'usage: signature_analysis.py -i <inputfile> -o <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'usage: signature_analysis.py -i <inputfile>'
         sys.exit()
      elif opt in ("-v", "--verbose"):
          verbose = True
      elif opt in ("-i", "--ifile"):
         inputfile = arg
      elif opt in ("-o", "--ofile"):
         outputfile = arg
      elif opt in ("-sc1", "--sigcol1"):         
         sigcol1 = int(arg)
      elif opt in ("-sc2", "--sigcol2"):
         sigcol2 = int(arg)
   
   print (sigcol1, sigcol2)
   l_all_signatures = []
   l_ambigous_signatures = []
   # list that contains the number of occurences for each unique signature
   l_num_ambigous_signatures = []

   # Print some information for the user if verbose made has been activated
   if verbose == True:
    print 'This is signature_analysis; verbose mode activated'
    print 'Input file is:', inputfile
    print 'Output file is:', outputfile
    print 'signature 1 column is: %s' % sigcol1
    print 'signature 2 column is: %s' % sigcol2

   ###############################################################
   #                  PROCESS .FCF INPUT FILE                    #    
   ###############################################################
   with open(inputfile) as f:
    for line in f:        
        #skip the header line
        if not line.startswith('signal'):                   
          splitted_line = (line.strip()).split(";")          
          #l_all_signatures.append(splitted_line[2])
          #l_all_signatures.append(splitted_line[4])
          l_all_signatures.append(splitted_line[sigcol1])
          l_all_signatures.append(splitted_line[sigcol2])   
   f.close

   l_all_signatures.sort()
   for element in l_all_signatures:
    if not element in l_ambigous_signatures:
      l_ambigous_signatures.append(element)
   
   for i in range(0,len(l_ambigous_signatures)):
    l_num_ambigous_signatures.append(0)   
   
   for i in range(0,len(l_ambigous_signatures)):
    for j in range(0,len(l_all_signatures)):
      if l_all_signatures[j] == l_ambigous_signatures[i]:
        l_num_ambigous_signatures[i] = l_num_ambigous_signatures[i] + 1

   num_unique_sigs = 0
   #determine number of signature that occur only once:
   #for i in range(0,len(l_num_ambigous_signatures)):
   for element in l_num_ambigous_signatures:
    if element == 1:
      num_unique_sigs += 1

   print 'number of signatures with only 1 occurence: %s' % num_unique_sigs
   print 'number of signatures with more than 1 occurence: %s' % (len(l_num_ambigous_signatures)-num_unique_sigs)
   print 'total number of signatures: %s' %(num_unique_sigs+(len(l_num_ambigous_signatures)-num_unique_sigs))

   ###############################################################
   #      WRITE RESULT OF SIGNATURE ANALYSIS TO OUTPUTFILE       #    
   ###############################################################
   target = open(outputfile, 'w')

   target.write('id;signature;num_occurences\n')
   for i in range(0,len(l_ambigous_signatures)):
    target.write('%s;%s;%s\n' % (i,l_ambigous_signatures[i], l_num_ambigous_signatures[i]))

   target.close
   if verbose == True:
     print 'results of signature_analysis written to file %s' % outputfile

if __name__ == "__main__":
   main(sys.argv[1:])
