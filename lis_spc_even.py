class lis_spc_even:
  """ Class for the serial parity checker """
  
  def __init__(self, clk, reset, scan_ctrl_in, scan_hffs_in, par_hold, par_ok):
    self.clk = clk
    self.reset = reset
    self.scan_ctrl_in = scan_ctrl_in
    self.scan_hffs_in = scan_hffs_in
    self.par_hold = par_hold
    self.par_ok = par_ok

  
  def writeSignalDeclaration(self):    
    """ 
    Write the required signal declarations for the controller in the architecture definition part 
    """
    rts = '\n\tsignal %s, %s : std_logic;\n' % (self.par_hold, self.par_ok)
    return rts

  def writePortMap(self):
    rts   = '\nPAR_CHK:\tlis_spc_even\n'
    rts  += '\t\t\tport map( \n'
    rts  += '\t\t\t\tclk\t\t\t\t=> %s,\n' % self.clk
    rts  += '\t\t\t\treset\t\t\t=> %s,\n' % self.reset
    rts  += '\t\t\t\tscan_ctrl_in\t=> %s,\n' % self.scan_ctrl_in    
    rts  += '\t\t\t\tscan_hffs_in\t=> %s,\n' % self.scan_hffs_in    
    rts  += '\t\t\t\tpar_hold\t\t=> %s,\n' % self.par_hold    
    rts  += '\t\t\t\tpar_ok\t\t\t=> %s\n' % self.par_ok
    rts  += '\t\t\t);\n'
    return rts