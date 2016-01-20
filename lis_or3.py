#This class is for or3 gates
class lis_or3:
   'Common base class for all or3 gates'
   or3Count = 0

   def __init__(self, A, B, C, Z):
      self.A = A
      self.B = B      
      self.C = C
      self.Z = Z
      self.number = lis_or3.or3Count
      lis_or3.or3Count += 1
   
   def displayCount(self):
     print "# of OR3 gates: %d" % lis_or3.or3Count

   def writePortMap(self):
     rts = 'OR3_%d:\t LIS_OR3 port map( A => %s, B => %s, C => %s, Z => %s );\n' % (self.number, self.A, self.B, self.C, self.Z)
     return rts