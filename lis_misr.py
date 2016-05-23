class lis_misr2_ff:
	count = 0

	def __init__(self, name, clk, reset, CUT_in, Q_in, B0_in, B1_in, Q_out):
		self.name = name
		self.clk = clk
		self.reset = reset
		self.CUT_in = CUT_in
		self.Q_in = Q_in
		self.B0_in = B0_in
		self.B1_in = B1_in
		self.Q_out = Q_out
		#self.number = lis_misr2_ff.count
      	#lis_misr2_ff.count += 1

	def writePortMap(self):
		rts = '\n%s:\tlis_misr2_ff \n' % self.name
		rts += '\t\t\tport map( \n'
		rts += '\t\t\t\tclk\t=> %s,\n' % self.clk
		#rts += '\t\t\t\treset\t=> %s,\n' % self.reset
		rts += '\t\t\t\tCUT_in\t=> %s,\n' % self.CUT_in
		rts += '\t\t\t\tQ_in\t=> %s,\n' % self.Q_in
		rts += '\t\t\t\tB0_in\t=> %s,\n' % self.B0_in
		rts += '\t\t\t\tB1_in\t=> %s,\n' % self.B1_in
		rts += '\t\t\t\tQ_out\t=> %s\n' % self.Q_out
		rts += '\t\t\t);\n'
		return rts

class lis_misr3_ff:
	count = 0

	def __init__(self, name, clk, reset, CUT_in, Q_in, B0_in, B1_in, FB_in, Q_out):
		self.name = name
		self.clk = clk
		self.reset = reset
		self.CUT_in = CUT_in
		self.Q_in = Q_in
		self.B0_in = B0_in
		self.B1_in = B1_in
		self.FB_in = FB_in
		self.Q_out = Q_out
		#self.number = lis_misr3_ff.count
      	#lis_misr3_ff.count += 1

	def writePortMap(self):
		rts = '\n%s:\tlis_misr3_ff \n' % self.name
		rts += '\t\t\tport map( \n'
		rts += '\t\t\t\tclk\t=> %s,\n' % self.clk
		#rts += '\t\t\t\treset\t=> %s,\n' % self.reset
		rts += '\t\t\t\tCUT_in\t=> %s,\n' % self.CUT_in
		rts += '\t\t\t\tQ_in\t=> %s,\n' % self.Q_in
		rts += '\t\t\t\tB0_in\t=> %s,\n' % self.B0_in
		rts += '\t\t\t\tB1_in\t=> %s,\n' % self.B1_in
		rts += '\t\t\t\tFB_in\t=> %s,\n' % self.FB_in
		rts += '\t\t\t\tQ_out\t=> %s\n' % self.Q_out
		rts += '\t\t\t);\n'
		return rts

class lis_misr:
	#TODO!!!
	prim_poly_coeff = {
		1:[1, 0],
		2: [2, 1, 0],
		3: [3, 1, 0],
		4: [4, 1, 0],
		20: [20, 3, 0]
	}

	def __init__(self, length):
	#def __init__(self, length, reset_signal, feedback_signal):
		self.length = length
		self.misr_ffs = []		
		self.coefficients = lis_misr.prim_poly_coeff[length]
		#self.misr2_ffs = []
		#self.misr3_ffs = []
		# Add first misr2_ff for 0 coefficient
		#coeff0_misr2_ff = lis_misr2_ff('PO_DFF_CBIST', 'clk', self.reset_signal, self.feedback_signal, )
		#for i in range(0, length-1):
		#	if i not in lis_misr.prim_poly_coeff[length]:
		#		new_misr2_ff = lis_misr2_ff()

		#print ('new MISR of length %d created!' % self.length )
	
	def addFlipFlop(self, flip_flop):
		self.misr_ffs.append(flip_flop)
		#if isinstance(flip_flop, lis_misr2_ff):
		#	print lis_misr2_ff.writePortMap(flip_flop)

	def printCoefficients(self):
		print ('coefficients are: %s' % lis_misr.prim_poly_coeff[self.length] )

	def writeAllPortMaps(self):
		rts = ''
		for i in range(0, len(self.misr_ffs)):
			if isinstance(self.misr_ffs[i], lis_misr2_ff):
				rts += lis_misr2_ff.writePortMap(self.misr_ffs[i])
			elif isinstance(self.misr_ffs[i], lis_misr3_ff):
				rts += lis_misr3_ff.writePortMap(self.misr_ffs[i])
		return rts

