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
  
  def __init__(self, BIST_LENGTH, clk, reset, ERR_in, BIST_start_in, B0_out, B1_out, BIST_done_out, BIST_pass_out):
    self.BIST_LENGTH = BIST_LENGTH
    self.clk = clk
    self.reset = reset
    self.ERR_in = ERR_in
    self.BIST_start_in = BIST_start_in
    self.B0_out = B0_out
    self.B1_out = B1_out
    self.BIST_done_out = BIST_done_out
    self.BIST_pass_out = BIST_pass_out
  #  lis_cbist_controller.count += 1

  
  def writeSignalDeclaration(self):    
    """ 
    Write the required signal declarations for the controller in the architecture definition part 
    """
    rts = '\n\tsignal %s, %s, %s : std_logic;\n' % (self.ERR_in, self.B0_out, self.B1_out)
    return rts

  def writePortMap(self):
    rts   = '\n\nCBIST_CTRL:\tlis_cbist_controller\n'
    rts  += '\t\t\tgeneric map( \n'
    rts  += '\t\t\t\tBIST_LENGTH\t=> %s \n' % self.BIST_LENGTH
    rts  += '\t\t\t)\n'
    rts  += '\t\t\tport map( \n'
    rts  += '\t\t\t\tclk\t\t\t\t=> %s,\n' % self.clk
    rts  += '\t\t\t\treset\t\t\t=> %s,\n' % self.reset
    rts  += '\t\t\t\tERR_in\t\t\t=> %s,\n' % self.ERR_in
    rts  += '\t\t\t\tBIST_start_in\t=> %s,\n' % self.BIST_start_in
    rts  += '\t\t\t\tB0_out\t\t\t=> %s,\n' % self.B0_out
    rts  += '\t\t\t\tB1_out\t\t\t=> %s,\n' % self.B1_out
    rts  += '\t\t\t\tBIST_done_out\t=> %s,\n' % self.BIST_done_out
    rts  += '\t\t\t\tBIST_pass_out\t=> %s\n' % self.BIST_pass_out
    rts  += '\t\t\t);\n\n'
    return rts