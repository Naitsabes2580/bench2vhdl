#This class is for and3 gates
class lis_and3:
   'Common base class for all and3 gates'
   and3Count = 0

   def __init__(self, A, B, C, Z):
      self.A = A
      self.B = B
      self.C = C
      self.Z = Z
      self.number = lis_and3.and3Count
      lis_and3.and3Count += 1
   
   def displayCount(self):
     print "# of AND3 gates: %d" % lis_and3.and3Count

   def writePortMap(self):
     rts = 'AND3_%d:\t LIS_AND3 port map( A => %s, B => %s, C => %s, Z => %s );\n' % (self.number, self.A, self.B, self.C, self.Z)
     return rts