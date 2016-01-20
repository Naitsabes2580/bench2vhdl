#This class is fnor nor3 gates
class lis_nor3:
   'Common base class fnor all nor3 gates'
   nor3Count = 0

   def __init__(self, A, B, C, Z):
      self.A = A
      self.B = B      
      self.C = C
      self.Z = Z
      self.number = lis_nor3.nor3Count
      lis_nor3.nor3Count += 1
   
   def displayCount(self):
     print "# of NOR3 gates: %d" % lis_nor3.nor3Count

   def writePnortMap(self):
     rts = 'NOR3_%d:\t LIS_NOR3 port map( A => %s, B => %s, C => %s, Z => %s );\n' % (self.number, self.A, self.B, self.C, self.Z)
     return rts