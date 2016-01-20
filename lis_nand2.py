#This class is for nand2 gates
class lis_nand2:
   'Common base class for all nand2 gates'
   nand2Count = 0

   def __init__(self, A, B, Z):
      self.A = A
      self.B = B
      self.Z = Z
      self.number = lis_nand2.nand2Count
      lis_nand2.nand2Count += 1
   
   def displayCount(self):
     print "# of nand2 gates: %d" % lis_nand2.nand2Count

   def writePortMap(self):
     rts = 'NAND2_%d: LIS_NAND2 port map( A => %s, B => %s, Z => %s );\n' % (self.number, self.A, self.B, self.Z)
     return rts