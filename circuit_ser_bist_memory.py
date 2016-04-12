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
  
  def writeComponentDeclaration(self):
    rts = '\n\n\tCOMPONENT %s\n' % self.name
    rts += '\t\tPORT(\n'
    rts += '\t\t\tclk : IN std_logic;\n'
    rts += '\t\t\treset : IN std_logic;\n'
    rts += '\t\t\tstart : IN std_logic;\n'
    rts += '\t\t\tread_address : IN std_logic_vector(TBA downto 0);\n'
    rts += '\t\t\tpattern_out : OUT std_logic;\n'
    rts += '\t\t\tresponse_out : OUT std_logic\n'
    rts += '\t\t);\n'
    rts += '\tEND COMPONENT;\n'
    return rts

  def writePortMap(self):
    rts = 'MEM: %s \n\
\t\tport map( \n\
\t\t\tclk\t\t\t\t=> %s, \n \
\t\t\treset\t\t\t=> %s, \n \
\t\t\tstart\t\t\t=> %s, \n \
\t\t\tread_address\t=> %s, \n \
\t\t\tpattern_out\t\t=> %s, \n \
\t\t\tresponse_out\t=> %s \n \
\t\t);\n\n' % (self.name, self.clk, self.reset, self.start, self.read_address, self.pattern_out, self.response_out)
    return rts

#This class is for superpos flip-flops
class circuit_superpos_memory:
  'Common base class for superpos memory'
  count = 0

  def __init__(self, name, clk, reset, start, read_address, pattern_out, response_out):
    self.name = name
    self.clk = clk
    self.reset = reset
    self.start = start
    self.read_address = read_address
    self.pattern_out = pattern_out
    self.response_out = response_out      
  
  def writeComponentDeclaration(self):
    rts = '\n\n\tCOMPONENT %s\n' % self.name
    rts += '\t\tPORT(\n'
    rts += '\t\t\tclk : IN std_logic;\n'
    rts += '\t\t\treset : IN std_logic;\n'
    rts += '\t\t\tstart : IN std_logic;\n'
    rts += '\t\t\tread_address : IN std_logic_vector(TBA downto 0);\n'
    rts += '\t\t\tpattern_out : OUT std_logic;\n'
    rts += '\t\t\tresponse_out : OUT std_logic\n'
    rts += '\t\t);\n'
    rts += '\tEND COMPONENT;\n'
    return rts

  def writePortMap(self):
    rts = 'MEM: %s \n\
\t\tport map( \n\
\t\t\tclk\t\t\t\t=> %s, \n \
\t\t\treset\t\t\t=> %s, \n \
\t\t\tstart\t\t\t=> %s, \n \
\t\t\tread_address\t=> %s, \n \
\t\t\tpattern_out\t\t=> %s, \n \
\t\t\tresponse_out\t=> %s \n \
\t\t);\n\n' % (self.name, self.clk, self.reset, self.start, self.read_address, self.pattern_out, self.response_out)
    return rts    