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