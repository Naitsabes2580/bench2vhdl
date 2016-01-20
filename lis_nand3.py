#This class is for nand3 gates
class lis_nand3:
   'Common base class for all nand3 gates'
   nand3Count = 0

   def __init__(self, A, B, C, Z):
      self.A = A
      self.B = B
      self.C = C
      self.Z = Z
      self.number = lis_nand3.nand3Count
      lis_nand3.nand3Count += 1
   
   def displayCount(self):
     print "# of nand3 gates: %d" % lis_nand3.nand3Count

   def writePortMap(self):
     rts = 'NAND3_%d: LIS_NAND3 port map( A => %s, B => %s, C => %s, Z => %s );\n' % (self.number, self.A, self.B, self.C, self.Z)
     return rts