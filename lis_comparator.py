#This class is for ser_bist flip-flops
class lis_comparator:
   'Common base class for all lis_comparators'
   count = 0

   def __init__(self, A_in, B_in, C_out):
      self.A_in = A_in
      self.B_in = B_in
      self.C_out = C_out
      self.number = lis_comparator.count
      lis_comparator.count += 1
   
   def displayCount(self):
     print "Total lis_comparators: %d" % lis_comparator.number

   def writePortMap(self):
    rts = 'COMP_%d:\tlis_comparator\n' % self.number
    rts += '\t\t\tport map( \n'
    rts += '\t\t\t\tA_in\t=> %s, \n' % self.A_in
    rts += '\t\t\t\tB_in\t=> %s, \n' % self.B_in
    rts += '\t\t\t\tC_out\t=> %s \n' % self.C_out
    rts += '\t\t\t);\n\n' 
    return rts