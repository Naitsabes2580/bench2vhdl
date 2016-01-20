#This class is for or2 gates
class lis_or2:
   'Common base class for all or2 gates'
   or2Count = 0

   def __init__(self, A, B, Z):
      self.A = A
      self.B = B      
      self.Z = Z
      self.number = lis_or2.or2Count
      lis_or2.or2Count += 1
   
   def displayCount(self):
     print "# of OR2 gates: %d" % lis_or2.or2Count

   def writePortMap(self):
     rts = 'OR2_%d:\t LIS_OR2 port map( A => %s, B => %s, Z => %s );\n' % (self.number, self.A, self.B, self.Z)
     return rts