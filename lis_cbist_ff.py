#This class is for ser_bist flip-flops
class lis_cbist_ff:
   'Common base class for all Circular BIST flip-flops'
   count = 0

   def __init__(self, clk, D_in, Q_in, B0_in, B1_in, Q_out):
      self.clk = clk      
      self.D_in = D_in
      self.Q_in = Q_in
      self.B0_in = B0_in
      self.B1_in = B1_in      
      self.Q_out = Q_out
      self.number = lis_cbist_ff.count
      lis_cbist_ff.count += 1
   
   def displayCount(self):
     print "Total CBIST FFs: %d" % lis_cbist_ff.number

   def writePortMap(self):
     rts = 'CBIST_FF_%d:\tlis_cbist_ff \n\
\t\t\tport map( \n\
\t\t\t\tclk\t\t=> %s, \n \
\t\t\t\tD_in\t=> %s, \n \
\t\t\t\tQ_in\t=> %s, \n \
\t\t\t\tB0_in\t=> %s, \n \
\t\t\t\tB1_in\t=> %s, \n \
\t\t\t\tQ_out\t=> %s \n \
\t\t\t);\n\n' % (self.number, self.clk, self.D_in, self.Q_in, self.B0_in, self.B1_in, self.Q_out)
     return rts

#Class for the test controller of Circular BIST
class lis_cbist_controller:
  'Class for the CBIST test controller'
  
  def __init__(self, NUM_FF, BIST_LENGTH, MEM_ADDR_WIDTH, MEM_ADDR_OFFSET, RESP_ADDR_WIDTH, SESSION_ROM_LOWER, SESSION_ROM_UPPER, RESP_ROM_LOWER, RESP_ROM_UPPER, clk, reset, COMP_in,  BIST_start_in, pattern_in, address_out, response_address, read_memory, input_mux_sel, AFF_chain_input_MUX_sel, B0_out, B1_out, BIST_done_out, BIST_pass_out, AFF_scan_out):

    self.NUM_FF                   = NUM_FF
    self.BIST_LENGTH              = BIST_LENGTH
    self.MEM_ADDR_WIDTH           = MEM_ADDR_WIDTH
    self.MEM_ADDR_OFFSET          = MEM_ADDR_OFFSET
    self.RESP_ADDR_WIDTH          = RESP_ADDR_WIDTH
    self.SESSION_ROM_LOWER        = SESSION_ROM_LOWER
    self.SESSION_ROM_UPPER        = SESSION_ROM_UPPER
    self.RESP_ROM_LOWER           = RESP_ROM_LOWER
    self.RESP_ROM_UPPER           = RESP_ROM_UPPER
    self.clk                      = clk
    self.reset                    = reset
    self.COMP_in                  = COMP_in
    self.BIST_start_in           = BIST_start_in
    self.pattern_in               = pattern_in
    self.address_out              = address_out
    self.response_address         = response_address
    self.read_memory              = read_memory
    self.input_mux_sel            = input_mux_sel
    self.AFF_chain_input_MUX_sel  = AFF_chain_input_MUX_sel
    self.B0_out                   = B0_out
    self.B1_out                   = B1_out
    self.BIST_done_out            = BIST_done_out
    self.BIST_pass_out            = BIST_pass_out
    self.AFF_scan_out             = AFF_scan_out
  #  lis_cbist_controller.count += 1

  
  def writeSignalDeclaration(self):    
    """ 
    Write the required signal declarations for the controller in the architecture definition part 
    """
    rts = '\n\tsignal %s, %s, %s, %s, %s : std_logic;\n' % (self.COMP_in, self.read_memory, self.B0_out, self.B1_out, self.AFF_scan_out)
    rts += '\tsignal %s : std_logic_vector(TBA downto 0);\n' % self.address_out
    rts += '\tsignal %s : std_logic_vector(TBA downto 0);\n' % self.response_address
    return rts

  def writePortMap(self):
    rts   = '\n\nCTRL:\tlis_cbist_controller\n'
    rts  += '\t\t\tgeneric map( \n'
    rts  += '\t\t\t\tNUM_FF\t=> %s, \n' % self.NUM_FF
    rts  += '\t\t\t\tBIST_LENGTH\t=> %s, \n' % self.BIST_LENGTH
    rts  += '\t\t\t\tMEM_ADDR_WIDTH\t=> %s, \n' % self.MEM_ADDR_WIDTH
    rts  += '\t\t\t\tMEM_ADDR_OFFSET\t=> %s, \n' % self.MEM_ADDR_OFFSET
    rts  += '\t\t\t\tRESP_ADDR_WIDTH\t=> %s, \n' % self.RESP_ADDR_WIDTH
    rts  += '\t\t\t\tSESSION_ROM_LOWER\t=> %s, \n' % self.SESSION_ROM_LOWER
    rts  += '\t\t\t\tSESSION_ROM_UPPER\t=> %s, \n' % self.SESSION_ROM_UPPER
    rts  += '\t\t\t\tRESP_ROM_LOWER\t=> %s, \n' % self.RESP_ROM_LOWER
    rts  += '\t\t\t\tRESP_ROM_UPPER\t=> %s \n' % self.RESP_ROM_UPPER
    rts  += '\t\t\t)\n'
    rts  += '\t\t\tport map( \n'
    rts  += '\t\t\t\tclk\t\t\t\t=> %s,\n' % self.clk
    rts  += '\t\t\t\treset\t\t\t=> %s,\n' % self.reset
    rts  += '\t\t\t\tCOMP_in\t\t\t=> %s,\n' % self.COMP_in
    rts  += '\t\t\t\tBIST_start_in\t=> %s,\n' % self.BIST_start_in
    rts  += '\t\t\t\tpattern_in\t=> %s,\n' % self.pattern_in
    rts  += '\t\t\t\taddress_out\t=> %s,\n' % self.address_out
    rts  += '\t\t\t\tresponse_address\t=> %s,\n' % self.response_address
    rts  += '\t\t\t\tread_memory\t=> %s,\n' % self.read_memory
    rts  += '\t\t\t\tinput_mux_sel\t=> %s,\n' % self.input_mux_sel
    rts  += '\t\t\t\tAFF_chain_input_MUX_sel\t=> %s,\n' % self.AFF_chain_input_MUX_sel
    rts  += '\t\t\t\tB0_out\t\t\t=> %s,\n' % self.B0_out
    rts  += '\t\t\t\tB1_out\t\t\t=> %s,\n' % self.B1_out
    rts  += '\t\t\t\tBIST_done_out\t=> %s,\n' % self.BIST_done_out
    rts  += '\t\t\t\tBIST_pass_out\t=> %s,\n' % self.BIST_pass_out
    rts  += '\t\t\t\tAFF_scan_out\t=> %s\n' % self.AFF_scan_out
    rts  += '\t\t\t);\n\n'
    return rts