#This class is for or4 gates
class lis_or4:
   'Common base class for all or4 gates'
   or4Count = 0

   def __init__(self, A, B, C, D, Z):
      self.A = A
      self.B = B      
      self.C = C
      self.D = D
      self.Z = Z
      self.number = lis_or4.or4Count
      lis_or4.or4Count += 1
   
   def displayCount(self):
     print "# of OR4 gates: %d" % lis_or4.or4Count

   def writePortMap(self):
     rts = 'OR4_%d:\t LIS_OR4 port map( A => %s, B => %s, C => %s, D => %s, Z => %s );\n' % (self.number, self.A, self.B, self.C, self.D, self.Z)
     return rts