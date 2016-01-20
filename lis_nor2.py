#This class is fnor nor2 gates
class lis_nor2:
   'Common base class fnor all nor2 gates'
   nor2Count = 0

   def __init__(self, A, B, Z):
      self.A = A
      self.B = B      
      self.Z = Z
      self.number = lis_nor2.nor2Count
      lis_nor2.nor2Count += 1
   
   def displayCount(self):
     print "# of NOR2 gates: %d" % lis_nor2.nor2Count

   def writePnortMap(self):
     rts = 'NOR2_%d:\t LIS_NOR2 port map( A => %s, B => %s, Z => %s );\n' % (self.number, self.A, self.B, self.Z)
     return rts