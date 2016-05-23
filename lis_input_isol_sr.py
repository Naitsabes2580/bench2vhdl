#This class is for ser_bist flip-flops
class lis_input_isol_sr:
   'Common base class for all ser_bist flip-flops'
   count = 0

   def __init__(self, clk, reset, PI_in, chain_in, sel_in, mux_out, chain_out):
      self.clk = clk
      self.reset = reset
      self.PI_in = PI_in
      self.chain_in = chain_in
      self.sel_in = sel_in
      self.mux_out = mux_out
      self.chain_out = chain_out
      self.number = lis_input_isol_sr.count
      lis_input_isol_sr.count += 1
   
   def displayCount(self):
     print "Total Input Isolation SR MUXes: %d" % lis_input_isol_sr.number

   def writePortMap(self):
     rts = 'MUX_%s:\tlis_input_isol_sr \n\
\t\tport map( \n\
\t\t\tclk\t\t\t=> %s, \n \
\t\t\treset\t\t=> %s, \n \
\t\t\tPI_in\t\t=> %s, \n \
\t\t\tchain_in\t=> %s, \n \
\t\t\tsel_in\t\t=> %s, \n \
\t\t\tmux_out\t\t=> %s, \n \
\t\t\tchain_out\t=> %s \n \
\t\t);\n\n' % (self.PI_in, self.clk, self.reset, self.PI_in, self.chain_in, self.sel_in, self.mux_out, self.chain_out)
     return rts

#This class is for ser_bist input isolation shift registers
class lis_ser_bist_input_isol_sr:   
   count = 0

   def __init__(self, clk, reset, PI_in, chain_in, sel_in, HFF_MUX_sel, Scan_in, \
    Test_Done_in, Hold_in, Rollback_in, ERR_out, Scan_out, mux_out, chain_out):
      self.clk = clk
      self.reset = reset
      self.PI_in = PI_in
      self.chain_in = chain_in
      self.sel_in = sel_in
      self.HFF_MUX_sel = HFF_MUX_sel
      self.Scan_in = Scan_in
      self.Test_Done_in = Test_Done_in
      self.Hold_in = Hold_in
      self.Rollback_in = Rollback_in
      self.ERR_out = ERR_out
      self.Scan_out = Scan_out
      self.mux_out = mux_out
      self.chain_out = chain_out
      self.number = lis_ser_bist_input_isol_sr.count
      lis_ser_bist_input_isol_sr.count += 1
   
   def displayCount(self):
     print "Total Input Isolation SR MUXes: %d" % lis_ser_bist_input_isol_sr.number

   def writePortMap(self):
      rts = 'MUX_%s:\tlis_ser_bist_input_isol_sr \n' % self.PI_in
      rts += '\t\t\tport map( \n'
      rts += '\t\t\t\tclk\t\t\t\t=> %s,\n' % self.clk 
      rts += '\t\t\t\treset\t\t\t=> %s,\n ' % self.reset 
      rts += '\t\t\t\tPI_in\t\t\t=> %s,\n' % self.PI_in
      rts += '\t\t\t\tchain_in\t\t=> %s,\n' % self.chain_in 
      rts += '\t\t\t\tsel_in\t\t\t=> %s,\n' % self.sel_in 
      rts += '\t\t\t\tHFF_MUX_sel\t\t=> %s,\n' % self.HFF_MUX_sel 
      rts += '\t\t\t\tScan_in\t\t\t=> %s,\n' % self.Scan_in 
      rts += '\t\t\t\tTest_Done_in\t=> %s,\n' % self.Test_Done_in 
      rts += '\t\t\t\tHold_in\t\t\t=> %s,\n' % self.Hold_in 
      rts += '\t\t\t\tRollback_in\t\t=> %s,\n' % self.Rollback_in 
      rts += '\t\t\t\tERR_out\t\t\t=> %s,\n' % self.ERR_out 
      rts += '\t\t\t\tScan_out\t\t=> %s,\n' % self.Scan_out 
      rts += '\t\t\t\tmux_out\t\t\t=> %s,\n' % self.mux_out 
      rts += '\t\t\t\tchain_out\t\t=> %s \n' % self.chain_out
      rts += '\t\t\t);\n\n' 
      return rts


#This class is for superpos input isolation shift registers
class lis_superpos_iisr:   
   count = 0

   def __init__(self, clk, reset, PI_in, chain_in, sel_in, Hold_in, Rollback_in, mux_out, chain_out, ERR_out):
      self.clk = clk
      self.reset = reset
      self.PI_in = PI_in
      self.chain_in = chain_in
      self.sel_in = sel_in
      self.Hold_in = Hold_in
      self.Rollback_in = Rollback_in
      self.mux_out = mux_out
      self.chain_out = chain_out
      self.ERR_out = ERR_out      
      self.number = lis_superpos_iisr.count
      lis_superpos_iisr.count += 1
   
   def displayCount(self):
     print "Total Input Isolation SR MUXes: %d" % lis_superpos_iisr.number

   def writePortMap(self):
      rts = 'MUX_%s:\tlis_superpos_iisr \n' % self.PI_in
      rts += '\t\t\tport map( \n'
      rts += '\t\t\t\tclk\t\t\t\t=> %s,\n' % self.clk 
      rts += '\t\t\t\treset\t\t\t=> %s,\n ' % self.reset 
      rts += '\t\t\t\tPI_in\t\t\t=> %s,\n' % self.PI_in
      rts += '\t\t\t\tchain_in\t\t=> %s,\n' % self.chain_in 
      rts += '\t\t\t\tsel_in\t\t\t=> %s,\n' % self.sel_in       
      rts += '\t\t\t\tHold_in\t\t\t=> %s,\n' % self.Hold_in 
      rts += '\t\t\t\tRollback_in\t\t=> %s,\n' % self.Rollback_in 
      rts += '\t\t\t\tmux_out\t\t\t=> %s,\n' % self.mux_out 
      rts += '\t\t\t\tchain_out\t\t=> %s, \n' % self.chain_out      
      rts += '\t\t\t\tERR_out\t\t\t=> %s\n' % self.ERR_out 
      rts += '\t\t\t);\n\n' 
      return rts