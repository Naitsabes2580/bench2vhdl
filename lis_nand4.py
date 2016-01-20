#This class is for nand4 gates
class lis_nand4:
   'Common base class for all nand4 gates'
   nand4Count = 0

   def __init__(self, A, B, C, D, Z):
      self.A = A
      self.B = B
      self.C = C
      self.D = D
      self.Z = Z
      self.number = lis_nand4.nand4Count
      lis_nand4.nand4Count += 1
   
   def displayCount(self):
     print "# of nand4 gates: %d" % lis_nand4.nand4Count

   def writePortMap(self):
     rts = 'NAND4_%d: LIS_NAND4 port map( A => %s, B => %s, C => %s, D => %s, Z => %s );\n' % (self.number, self.A, self.B, self.C, self.D, self.Z)
     return rts