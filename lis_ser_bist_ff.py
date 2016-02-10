#This class is for ser_bist flip-flops
class lis_ser_bist_ff:
   'Common base class for all ser_bist flip-flops'
   count = 0

   def __init__(self, clk, reset, D_in, Q_in, B0_in, B1_in, Scan_in, Test_Done, Hold_in, Rollback_in, ERR_out, Scan_out, Q_out):
      self.clk = clk
      self.reset = reset
      self.D_in = D_in
      self.Q_in = Q_in
      self.B0_in = B0_in
      self.B1_in = B1_in
      self.Scan_in = Scan_in
      self.Test_Done = Test_Done
      self.Hold_in = Hold_in
      self.Rollback_in = Rollback_in
      self.ERR_out = ERR_out
      self.Scan_out = Scan_out
      self.Q_out = Q_out
      self.number = lis_ser_bist_ff.count
      lis_ser_bist_ff.count += 1
   
   def displayCount(self):
     print "Total SER/BIST FFs: %d" % lis_ser_bist_ff.number

   def writePortMap(self):
     rts = 'SER_BIST_FF_%d:\tlis_ser_bist_ff \n\
\t\tport map( \n\
\t\t\tclk\t\t=> %s, \n \
\t\t\treset\t\t=> %s, \n \
\t\t\tD_in\t\t=> %s, \n \
\t\t\tQ_in\t\t=> %s, \n \
\t\t\tB0_in\t\t=> %s, \n \
\t\t\tB1_in\t\t=> %s, \n \
\t\t\tScan_in\t\t=> %s, \n \
\t\t\tTest_Done\t=> %s, \n \
\t\t\tHold_in\t\t=> %s, \n \
\t\t\tRollback_in\t=> %s, \n \
\t\t\tERR_out\t\t=> %s, \n \
\t\t\tScan_out\t=> %s, \n \
\t\t\tQ_out\t\t=> %s \n \
\t\t);\n\n' % (self.number, self.clk, self.reset, self.D_in, self.Q_in, self.B0_in, \
            self.B1_in, self.Scan_in, self.Test_Done, self.Hold_in, self.Rollback_in, self.ERR_out, \
            self.Scan_out, self.Q_out)
     return rts