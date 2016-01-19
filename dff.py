#This class is for D flip-flops
class dff:
   'Common base class for all DFFs'
   dffCount = 0

   def __init__(self, D_in, Q_out, clk, reset):
      self.D_in = D_in
      self.Q_out = Q_out
      self.clk = clk
      self.reset = reset
      dff.dffCount += 1
   
   def displayCount(self):
     print "Total DFFs %d" % dff.dffCount

   def displayDFF(self):
      print "D_in : ", self.D_in,  ", Q_out: ", self.Q_out