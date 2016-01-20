#This class is for and2 gates
class and2:
   'Common base class for all and2 gates'
   and2Count = 0

   def __init__(self, A, B, Z):
      self.A = A
      self.B = B
      self.Z = Z
      self.number = and2.and2Count
      and2.and2Count += 1
   
   def displayCount(self):
     print "# of AND2 gates: %d" % and2.and2Count

   def writePortMap(self):
     rts = 'AND2_%d:\t LIS_AND2 port map( A => %s, B => %s, Z => %s);\n' % (self.number, self.A, self.B, self.Z)
     return rts