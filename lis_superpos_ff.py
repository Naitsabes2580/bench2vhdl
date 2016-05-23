#This class is for ser_bist flip-flops
class lis_superpos_ff:
   'Common base class for all superpos flip-flops'
   count = 0

   def __init__(self, clk, reset, D_in, Q_in, B0_in, B1_in, Hold_in, Rollback_in, ERR_out, Q_out):
      self.clk = clk
      self.reset = reset
      self.D_in = D_in
      self.Q_in = Q_in
      self.B0_in = B0_in
      self.B1_in = B1_in
      self.Hold_in = Hold_in
      self.Rollback_in = Rollback_in
      self.ERR_out = ERR_out
      self.Q_out = Q_out
      self.number = lis_superpos_ff.count
      lis_superpos_ff.count += 1
   
   def displayCount(self):
     print "Total SER/BIST FFs: %d" % lis_superpos_ff.number

   def writePortMap(self):
     rts = 'SUPERPOS_FF_%d:\tlis_superpos_ff \n\
\t\tport map( \n\
\t\t\tclk\t\t\t=> %s, \n \
\t\t\treset\t\t=> %s, \n \
\t\t\tD_in\t\t=> %s, \n \
\t\t\tQ_in\t\t=> %s, \n \
\t\t\tB0_in\t\t=> %s, \n \
\t\t\tB1_in\t\t=> %s,\n\
\t\t\tHold_in\t\t=> %s, \n \
\t\t\tRollback_in\t=> %s, \n \
\t\t\tERR_out\t\t=> %s, \n \
\t\t\tQ_out\t\t=> %s \n \
\t\t);\n\n' % (self.number, self.clk, self.reset, self.D_in, self.Q_in, self.B0_in, self.B1_in, self.Hold_in, self.Rollback_in, self.ERR_out, self.Q_out)
     return rts

#Class for the test controller of Circular BIST
class lis_superpos_controller:
  'Class for the SER/BIST test controller'
  
  def __init__(self, NUM_FF, BIST_LENGTH, MEM_ADDR_WIDTH, MEM_ADDR_OFFSET, RESP_ADDR_WIDTH, SESSION_ROM_LOWER, SESSION_ROM_UPPER, RESP_ROM_LOWER, RESP_ROM_UPPER, clk, reset, ERR_in, COMP_in, BIST_start_in, pattern_in, address_out, response_address, read_memory, Hold_out, Rollback_out, input_mux_sel, AFF_chain_input_MUX_sel, B0_out, B1_out, BIST_done_out, BIST_pass_out, AFF_scan_out):
    self.NUM_FF             = NUM_FF
    self.BIST_LENGTH        = BIST_LENGTH
    self.MEM_ADDR_WIDTH     = MEM_ADDR_WIDTH
    self.MEM_ADDR_OFFSET    = MEM_ADDR_OFFSET
    self.RESP_ADDR_WIDTH    = RESP_ADDR_WIDTH    
    self.SESSION_ROM_LOWER  = SESSION_ROM_LOWER
    self.SESSION_ROM_UPPER  = SESSION_ROM_UPPER
    self.RESP_ROM_LOWER     = RESP_ROM_LOWER
    self.RESP_ROM_UPPER     = RESP_ROM_UPPER
    self.clk                = clk
    self.reset              = reset
    self.ERR_in             = ERR_in
    self.COMP_in            = COMP_in
    self.BIST_start_in      = BIST_start_in    
    self.pattern_in         = pattern_in    
    self.address_out        = address_out
    self.response_address   = response_address
    self.read_memory        = read_memory    
    self.Hold_out           = Hold_out
    self.Rollback_out       = Rollback_out    
    self.input_mux_sel      = input_mux_sel
    self.AFF_chain_input_MUX_sel  = AFF_chain_input_MUX_sel
    self.B0_out             = B0_out
    self.B1_out             = B1_out
    self.BIST_done_out      = BIST_done_out
    self.BIST_pass_out      = BIST_pass_out
    self.AFF_scan_out       = AFF_scan_out
  #  lis_cbist_controller.count += 1

  
  def writeSignalDeclaration(self):    
    """ 
    Write the required signal declarations for the controller in the architecture definition part 
    """
    ctrl_signals = [self.ERR_in, self.COMP_in, self.read_memory, self.Hold_out, self.Rollback_out, 
    self.B0_out, self.B1_out, self.AFF_scan_out]#, 'HFF_mux_sel']
    rts = '\n\tsignal ' #%s, %s, %s : std_logic;\n' % (self.ERR_in, self.B0_out, self.B1_out)
    for i in range(0, len(ctrl_signals)-1):
      rts += '%s, ' % ctrl_signals[i]
    rts += '%s : std_logic;\n' % ctrl_signals[-1]    
    #rts += '\tsignal %s : std_logic_vector(%s-1 downto 0);\n' % (self.address_out, self.MEM_ADDR_WIDTH)
    rts += '\tsignal %s : std_logic_vector(TBA downto 0);\n' % self.address_out
    rts += '\tsignal %s : std_logic_vector(TBA downto 0);\n' % self.response_address
    return rts

  def writePortMap(self):
    rts   = '\n\nCTRL:\tlis_superpos_controller\n'
    rts  += '\t\tgeneric map( \n'
    rts  += '\t\t\tNUM_FF\t\t\t\t=> %s,\n' % self.NUM_FF
    rts  += '\t\t\tBIST_LENGTH\t\t\t=> %s,\n' % self.BIST_LENGTH
    rts  += '\t\t\tMEM_ADDR_WIDTH\t\t=> %s,\n' % self.MEM_ADDR_WIDTH
    rts  += '\t\t\tMEM_ADDR_OFFSET\t\t=> %s,\n' % self.MEM_ADDR_OFFSET
    rts  += '\t\t\tRESP_ADDR_WIDTH\t\t=> %s,\n' % self.RESP_ADDR_WIDTH
    rts  += '\t\t\tSESSION_ROM_LOWER\t=> %s,\n' % self.SESSION_ROM_LOWER
    rts  += '\t\t\tSESSION_ROM_UPPER\t=> %s,\n' % self.SESSION_ROM_UPPER
    rts  += '\t\t\tRESP_ROM_LOWER\t=> %s,\n' % self.RESP_ROM_LOWER
    rts  += '\t\t\tRESP_ROM_UPPER\t=> %s\n' % self.RESP_ROM_UPPER
    rts  += '\t\t)\n'
    rts  += '\t\tport map( \n'
    rts  += '\t\t\tclk\t\t\t\t=> %s,\n' % self.clk
    rts  += '\t\t\treset\t\t\t=> %s,\n' % self.reset
    rts  += '\t\t\tERR_in\t\t\t=> %s,\n' % self.ERR_in
    rts  += '\t\t\tCOMP_in\t\t\t=> %s,\n' % self.COMP_in
    rts  += '\t\t\tBIST_start_in\t=> %s,\n' % self.BIST_start_in    
    rts  += '\t\t\tpattern_in\t\t=> %s,\n' % self.pattern_in    
    rts  += '\t\t\taddress_out\t\t=> %s,\n' % self.address_out
    rts  += '\t\t\tresponse_address\t\t=> %s,\n' % self.response_address
    rts  += '\t\t\tread_memory\t\t=> %s,\n' % self.read_memory
    rts  += '\t\t\tHold_out\t\t=> %s,\n' % self.Hold_out
    rts  += '\t\t\tRollback_out\t=> %s,\n' % self.Rollback_out    
    rts  += '\t\t\tinput_mux_sel\t=> %s,\n' % self.input_mux_sel
    rts  += '\t\t\tAFF_chain_input_mux_sel\t=> %s,\n' % self.AFF_chain_input_MUX_sel
    rts  += '\t\t\tB0_out\t\t\t=> %s,\n' % self.B0_out
    rts  += '\t\t\tB1_out\t\t\t=> %s,\n' % self.B1_out    
    rts  += '\t\t\tBIST_done_out\t=> %s,\n' % self.BIST_done_out
    rts  += '\t\t\tBIST_pass_out\t=> %s,\n' % self.BIST_pass_out        
    rts  += '\t\t\tAFF_Scan_out\t=> %s\n' % self.AFF_scan_out
    rts  += '\t\t);\n\n'    
    return rts