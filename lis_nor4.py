#This class is fnor nor4 gates
class lis_nor4:
   'Common base class fnor all nor4 gates'
   nor4Count = 0

   def __init__(self, A, B, C, D, Z):
      self.A = A
      self.B = B      
      self.C = C
      self.D = D
      self.Z = Z
      self.number = lis_nor4.nor4Count
      lis_nor4.nor4Count += 1
   
   def displayCount(self):
     print "# of NOR4 gates: %d" % lis_nor4.nor4Count

   def writePnortMap(self):
     rts = 'NOR4_%d:\t LIS_NOR4 port map( A => %s, B => %s, C => %s, D => %s, Z => %s );\n' % (self.number, self.A, self.B, self.C, self.D, self.Z)
     return rts