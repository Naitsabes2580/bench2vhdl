#This class is for and4 gates
class lis_and4:
   'Common base class for all and4 gates'
   and4Count = 0

   def __init__(self, A, B, C, D, Z):
      self.A = A
      self.B = B
      self.C = C
      self.D = D
      self.Z = Z
      self.number = lis_and4.and4Count
      lis_and4.and4Count += 1
   
   def displayCount(self):
     print "# of AND4 gates: %d" % lis_and4.and4Count

   def writePortMap(self):
     rts = 'AND4_%d:\t LIS_AND4 port map( A => %s, B => %s, C => %s, D => %s, Z => %s );\n' % (self.number, self.A, self.B, self.C, self.D, self.Z)
     return rts