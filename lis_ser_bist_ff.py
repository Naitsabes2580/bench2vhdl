#This class is for ser_bist flip-flops
class lis_ser_bist_ff:
   'Common base class for all ser_bist flip-flops'
   count = 0

   def __init__(self, clk, reset, D_in, Q_in, B0_in, B1_in, HFF_MUX_sel, Scan_in, Test_Done, Hold_in, Rollback_in, ERR_out, Scan_out, Q_out):
      self.clk = clk
      self.reset = reset
      self.D_in = D_in
      self.Q_in = Q_in
      self.B0_in = B0_in
      self.B1_in = B1_in
      self.HFF_MUX_sel = HFF_MUX_sel
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
\t\t\tB1_in\t\t=> %s,\n\
\t\t\tHFF_MUX_sel => %s, \n \
\t\t\tScan_in\t\t=> %s, \n \
\t\t\tTest_Done\t=> %s, \n \
\t\t\tHold_in\t\t=> %s, \n \
\t\t\tRollback_in\t=> %s, \n \
\t\t\tERR_out\t\t=> %s, \n \
\t\t\tScan_out\t=> %s, \n \
\t\t\tQ_out\t\t=> %s \n \
\t\t);\n\n' % (self.number, self.clk, self.reset, self.D_in, self.Q_in, self.B0_in, self.B1_in, self.HFF_MUX_sel,\
            self.Scan_in, self.Test_Done, self.Hold_in, self.Rollback_in, self.ERR_out, \
            self.Scan_out, self.Q_out)
     return rts

#Class for the test controller of Circular BIST
class lis_ser_bist_controller:
  'Class for the SER/BIST test controller'
  
  def __init__(self, NUM_FF, BIST_LENGTH, MEM_ADDR_WIDTH, \
    SESSION_ROM_LOWER, SESSION_ROM_UPPER, LOC_ROM_LOWER, LOC_ROM_UPPER, \
    clk, reset, ERR_in, parity_ok_in, BIST_start_in, Capture_in, pattern_in, \
    response_in, address_out, read_memory, Hold_out, par_hold_out, par_reset_out, \
    Rollback_out, BIST_eval_out, B0_out, B1_out, Capture_out, BIST_done_out, 
    BIST_pass_out, err_code, Scan_out, AFF_scan_out):
    self.NUM_FF             = NUM_FF
    self.BIST_LENGTH        = BIST_LENGTH
    self.MEM_ADDR_WIDTH     = MEM_ADDR_WIDTH
    self.SESSION_ROM_LOWER  = SESSION_ROM_LOWER
    self.SESSION_ROM_UPPER  = SESSION_ROM_UPPER
    self.LOC_ROM_LOWER      = LOC_ROM_LOWER
    self.LOC_ROM_UPPER      = LOC_ROM_UPPER
    self.clk                = clk
    self.reset              = reset
    self.ERR_in             = ERR_in
    self.parity_ok_in       = parity_ok_in
    self.BIST_start_in      = BIST_start_in
    self.Capture_in         = Capture_in
    self.pattern_in         = pattern_in
    self.response_in        = response_in
    self.address_out        = address_out
    self.read_memory        = read_memory    
    self.Hold_out           = Hold_out
    self.par_hold_out       = par_hold_out
    self.par_reset_out      = par_reset_out
    self.Rollback_out       = Rollback_out
    self.BIST_eval_out      = BIST_eval_out
    self.B0_out             = B0_out
    self.B1_out             = B1_out
    self.Capture_out        = Capture_out
    self.BIST_done_out      = BIST_done_out
    self.BIST_pass_out      = BIST_pass_out
    self.err_code           = err_code
    self.Scan_out           = Scan_out
    self.AFF_scan_out       = AFF_scan_out
  #  lis_cbist_controller.count += 1

  
  def writeSignalDeclaration(self):    
    """ 
    Write the required signal declarations for the controller in the architecture definition part 
    """
    ctrl_signals = [self.ERR_in, self.parity_ok_in, self.read_memory, self.Hold_out, self.par_hold_out, self.par_reset_out, self.Rollback_out, 
    self.BIST_eval_out, self.B0_out, self.B1_out, self.Capture_out, self.err_code, self.Scan_out, self.AFF_scan_out, 'HFF_mux_sel']
    rts = '\n\tsignal ' #%s, %s, %s : std_logic;\n' % (self.ERR_in, self.B0_out, self.B1_out)
    for i in range(0, len(ctrl_signals)-1):
      rts += '%s, ' % ctrl_signals[i]
    rts += '%s : std_logic;\n' % ctrl_signals[-1]
    rts += '\tsignal %s : std_logic_vector(TBA downto 0);\n' % self.address_out
    return rts

  def writePortMap(self):
    rts   = '\n\nCTRL:\tlis_ser_bist_controller\n'
    rts  += '\t\t\tgeneric map( \n'
    rts  += '\t\t\t\tNUM_FF\t\t\t\t=> %s,\n' % self.NUM_FF
    rts  += '\t\t\t\tBIST_LENGTH\t\t\t=> %s,\n' % self.BIST_LENGTH
    rts  += '\t\t\t\tMEM_ADDR_WIDTH\t\t=> %s,\n' % self.MEM_ADDR_WIDTH
    rts  += '\t\t\t\tSESSION_ROM_LOWER\t=> %s,\n' % self.SESSION_ROM_LOWER
    rts  += '\t\t\t\tSESSION_ROM_UPPER\t=> %s,\n' % self.SESSION_ROM_UPPER
    rts  += '\t\t\t\tLOC_ROM_LOWER\t\t=> %s,\n' % self.LOC_ROM_LOWER
    rts  += '\t\t\t\tLOC_ROM_UPPER\t\t=> %s \n' % self.LOC_ROM_UPPER
    rts  += '\t\t\t)\n'
    rts  += '\t\t\tport map( \n'
    rts  += '\t\t\t\tclk\t\t\t\t=> %s,\n' % self.clk
    rts  += '\t\t\t\treset\t\t\t=> %s,\n' % self.reset
    rts  += '\t\t\t\tERR_in\t\t\t=> %s,\n' % self.ERR_in
    rts  += '\t\t\t\tparity_ok_in\t=> %s,\n' % self.parity_ok_in
    rts  += '\t\t\t\tBIST_start_in\t=> %s,\n' % self.BIST_start_in    
    rts  += '\t\t\t\tCapture_in\t\t=> %s,\n' % self.Capture_in
    rts  += '\t\t\t\tpattern_in\t\t=> %s,\n' % self.pattern_in
    rts  += '\t\t\t\tresponse_in\t\t=> %s,\n' % self.response_in
    rts  += '\t\t\t\taddress_out\t\t=> %s,\n' % self.address_out
    rts  += '\t\t\t\tread_memory\t\t=> %s,\n' % self.read_memory
    rts  += '\t\t\t\tHold_out\t\t=> %s,\n' % self.Hold_out
    rts  += '\t\t\t\tpar_hold_out\t=> %s,\n' % self.par_hold_out
    rts  += '\t\t\t\tpar_reset_out\t=> %s,\n' % self.par_reset_out
    rts  += '\t\t\t\tRollback_out\t=> %s,\n' % self.Rollback_out
    rts  += '\t\t\t\tBIST_eval_out\t=> %s,\n' % self.BIST_eval_out
    rts  += '\t\t\t\tB0_out\t\t\t=> %s,\n' % self.B0_out
    rts  += '\t\t\t\tB1_out\t\t\t=> %s,\n' % self.B1_out
    rts  += '\t\t\t\tCapture_out\t\t=> %s,\n' % self.Capture_out
    rts  += '\t\t\t\tBIST_done_out\t=> %s,\n' % self.BIST_done_out
    rts  += '\t\t\t\tBIST_pass_out\t=> %s,\n' % self.BIST_pass_out
    rts  += '\t\t\t\terr_code\t\t=> %s,\n' % self.err_code
    rts  += '\t\t\t\tScan_out\t\t=> %s,\n' % self.Scan_out
    rts  += '\t\t\t\tAFF_Scan_out\t=> %s\n' % self.AFF_scan_out
    rts  += '\t\t\t);\n\n'
    return rts