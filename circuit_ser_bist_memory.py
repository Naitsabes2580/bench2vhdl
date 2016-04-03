#This class is for ser_bist flip-flops
class circuit_ser_bist_memory:
  'Common base class for ser_bist memory'
  count = 0

  def __init__(self, name, clk, reset, start, read_address, pattern_out, response_out):
    self.name = name
    self.clk = clk
    self.reset = reset
    self.start = start
    self.read_address = read_address
    self.pattern_out = pattern_out
    self.response_out = response_out      
  
  def writePortMap(self):
    rts = 'MEM: %s \n\
\t\tport map( \n\
\t\t\tclk\t\t\t\t=> %s, \n \
\t\t\treset\t\t\t=> %s, \n \
\t\t\tread_adddress\t=> %s, \n \
\t\t\tpattern_out\t\t=> %s, \n \
\t\t\tresponse_out\t=> %s \n \
\t\t);\n\n' % (self.name, self.clk, self.reset, self.read_address, self.pattern_out, self.response_out)
    return rts