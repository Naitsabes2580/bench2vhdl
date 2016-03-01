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
\t\t\tclk\t\t\t=> %s, \n \
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

#Class for the test controller of Circular BIST
class lis_ser_bist_controller:
  'Class for the SER/BIST test controller'
  
  def __init__(self, NUM_FF, BIST_LENGTH, clk, reset, ERR_in, \
    parity_ok_in, BIST_start_in, Exp_resp_in, Hold_out, Rollback_out, \
    par_hold_out, par_reset_out, BIST_eval_out, B0_out, B1_out, \
    BIST_done_out, BIST_pass_out, Scan_out):
    self.NUM_FF = NUM_FF
    self.BIST_LENGTH = BIST_LENGTH
    self.clk = clk
    self.reset = reset
    self.ERR_in = ERR_in
    self.parity_ok_in = parity_ok_in
    self.BIST_start_in = BIST_start_in
    self.Exp_resp_in = Exp_resp_in
    self.Hold_out = Hold_out
    self.Rollback_out = Rollback_out
    self.par_hold_out = par_hold_out
    self.par_reset_out = par_reset_out
    self.BIST_eval_out = BIST_eval_out
    self.B0_out = B0_out
    self.B1_out = B1_out
    self.BIST_done_out = BIST_done_out
    self.BIST_pass_out = BIST_pass_out
    self.Scan_out = Scan_out
  #  lis_cbist_controller.count += 1

  
  def writeSignalDeclaration(self):    
    """ 
    Write the required signal declarations for the controller in the architecture definition part 
    """
    ctrl_signals = [self.ERR_in, self.parity_ok_in, self.Hold_out, self.Rollback_out, self.par_hold_out, self.par_reset_out, \
                    self.BIST_eval_out, self.B0_out, self.B1_out, self.Scan_out]
    rts = '\n\tsignal ' #%s, %s, %s : std_logic;\n' % (self.ERR_in, self.B0_out, self.B1_out)
    for i in range(0, len(ctrl_signals)-1):
      rts += '%s, ' % ctrl_signals[i]
    rts += '%s : std_logic;\n' % ctrl_signals[-1]
    return rts

  def writePortMap(self):
    rts   = '\n\nCTRL:\tlis_ser_bist_controller\n'
    rts  += '\t\t\tgeneric map( \n'
    rts  += '\t\t\t\tNUM_FF\t\t=> %s \n' % self.NUM_FF
    rts  += '\t\t\t\tBIST_LENGTH\t=> %s \n' % self.BIST_LENGTH
    rts  += '\t\t\t)\n'
    rts  += '\t\t\tport map( \n'
    rts  += '\t\t\t\tclk\t\t\t\t=> %s,\n' % self.clk
    rts  += '\t\t\t\treset\t\t\t=> %s,\n' % self.reset
    rts  += '\t\t\t\tERR_in\t\t\t=> %s,\n' % self.ERR_in
    rts  += '\t\t\t\tparity_ok_in\t=> %s,\n' % self.parity_ok_in
    rts  += '\t\t\t\tBIST_start_in\t=> %s,\n' % self.BIST_start_in
    rts  += '\t\t\t\tExp_resp_in\t\t=> %s,\n' % self.Exp_resp_in
    rts  += '\t\t\t\tHold_out\t\t=> %s,\n' % self.Hold_out
    rts  += '\t\t\t\tRollback_out\t=> %s,\n' % self.Rollback_out
    rts  += '\t\t\t\tpar_hold_out\t=> %s,\n' % self.par_hold_out
    rts  += '\t\t\t\tpar_reset_out\t=> %s,\n' % self.par_reset_out
    rts  += '\t\t\t\tBIST_eval_out\t=> %s,\n' % self.BIST_eval_out
    rts  += '\t\t\t\tB0_out\t\t\t=> %s,\n' % self.B0_out
    rts  += '\t\t\t\tB1_out\t\t\t=> %s,\n' % self.B1_out
    rts  += '\t\t\t\tBIST_done_out\t=> %s,\n' % self.BIST_done_out
    rts  += '\t\t\t\tBIST_pass_out\t=> %s\n' % self.BIST_pass_out
    rts  += '\t\t\t\tScan_out\t\t=> %s\n' % self.Scan_out
    rts  += '\t\t\t);\n\n'
    return rts