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

class lis_shadow_cell_controller:
  'Class for the lis_shadow_cell_controller'

  def __init__(self, clk, reset, ERR_in, Hold_out, Rollback_out):
    self.clk = clk
    self.reset = reset
    self.ERR_in = ERR_in
    self.Hold_out = Hold_out
    self.Rollback_out = Rollback_out

  def writeSignalDeclarations(self):
    rts = '\n\tsignal %s, %s, %s : std_logic;\n' % (self.ERR_in, self.Hold_out, self.Rollback_out)
    return rts

  def writePortMap(self):
    rts = 'CTRL:\tlis_shadow_cell_controller\n'
    rts += '\t\tport map( \n'
    rts += '\t\t\tclk\t\t\t=>%s,\n' % self.clk
    rts += '\t\t\treset\t\t=>%s,\n' % self.reset
    rts += '\t\t\tERR_in\t\t=>%s,\n' % self.ERR_in
    rts += '\t\t\tHold_out\t\t=>%s,\n' % self.Hold_out
    rts += '\t\t\tRollback_out\t=>%s,\n' % self.Rollback_out
    return rts
