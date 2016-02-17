#This class is for ser flip-flops
class lis_ser_ff:
   'Common base class for all ser flip-flops'
   count = 0

   def __init__(self, CLOCK_PERIOD, clk, reset, D_in, Hold_in, Rollback_in, Q_out, ERR_out):
      self.CLOCK_PERIOD = CLOCK_PERIOD
      self.clk = clk
      self.reset = reset
      self.D_in = D_in
      self.Hold_in = Hold_in
      self.Rollback_in = Rollback_in
      self.Q_out = Q_out
      self.ERR_out = ERR_out
      self.number = lis_ser_ff.count
      lis_ser_ff.count += 1
   
   def displayCount(self):
     print "Total SER FFs: %d" % lis_ser_ff.count

   def writePortMap(self):
     rts = 'SER_FF_%d:\tlis_ser_ff \n\
\t\t\tgeneric map( \n \
\t\t\t\tCLOCK_PERIOD => %s\n \
\t\t\t)\n\
\t\t\tport map( \n\
\t\t\t\tclk\t\t\t=> %s, \n \
\t\t\t\treset\t\t=> %s, \n \
\t\t\t\tD_in\t\t=> %s, \n \
\t\t\t\tHold_in\t\t=> %s, \n \
\t\t\t\tRollback_in\t=> %s, \n \
\t\t\t\tQ_out\t\t=> %s, \n \
\t\t\t\tERR_out\t\t=> %s \n \
\t\t\t);\n\n' % (self.number, self.CLOCK_PERIOD, self.clk, self.reset, self.D_in, \
            self.Hold_in, self.Rollback_in, self.Q_out, self.ERR_out)
     return rts