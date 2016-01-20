#This class is for inverters
class lis_not:
   'Common base class for all inverters'
   invertersCount = 0

   def __init__(self, A, Z):
      self.A = A
      self.Z = Z
      lis_not.invertersCount += 1
   
   def displayCount(self):
     print "# of inverters %d" % lis_not.invertersCount

   def displayDFF(self):
      print "A: ", self.A,  ", Z: ", self.Z