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
		rts += '\t\t\t\treset\t=> %s,\n' % self.reset
		rts += '\t\t\t\tCUT_in\t=> %s,\n' % self.CUT_in
		rts += '\t\t\t\tQ_in\t=> %s,\n' % self.Q_in
		rts += '\t\t\t\tB0_in\t=> %s,\n' % self.B0_in
		rts += '\t\t\t\tB1_in\t=> %s,\n' % self.B1_in
		rts += '\t\t\t\tQ_out\t=> %s\n' % self.Q_out
		rts += '\t\t\t);\n'
		return rts

class lis_misr2_superpos_ff:
	count = 0

	def __init__(self, name, clk, reset, CUT_in, Q_in, B0_in, B1_in, Hold_in, Rollback_in, Q_out, ERR_out):
		self.name = name
		self.clk = clk
		self.reset = reset
		self.CUT_in = CUT_in
		self.Q_in = Q_in
		self.B0_in = B0_in
		self.B1_in = B1_in
		self.Hold_in = Hold_in
		self.Rollback_in = Rollback_in
		self.Q_out = Q_out
		self.ERR_out = ERR_out
		#self.number = lis_misr2_ff.count
      	#lis_misr2_ff.count += 1

	def writePortMap(self):
		rts = '\n%s:\tlis_misr2_superpos_ff \n' % self.name
		rts += '\t\t\tport map( \n'
		rts += '\t\t\t\tclk\t=> %s,\n' % self.clk
		rts += '\t\t\t\treset\t=> %s,\n' % self.reset
		rts += '\t\t\t\tCUT_in\t=> %s,\n' % self.CUT_in
		rts += '\t\t\t\tQ_in\t=> %s,\n' % self.Q_in
		rts += '\t\t\t\tB0_in\t=> %s,\n' % self.B0_in
		rts += '\t\t\t\tB1_in\t=> %s,\n' % self.B1_in
		rts += '\t\t\t\tHold_in\t=> %s,\n' % self.Hold_in
		rts += '\t\t\t\tRollback_in\t=> %s,\n' % self.Rollback_in
		rts += '\t\t\t\tQ_out\t=> %s,\n' % self.Q_out
		rts += '\t\t\t\tERR_out\t=> %s\n' % self.ERR_out
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
		rts += '\t\t\t\treset\t=> %s,\n' % self.reset
		rts += '\t\t\t\tCUT_in\t=> %s,\n' % self.CUT_in
		rts += '\t\t\t\tQ_in\t=> %s,\n' % self.Q_in
		rts += '\t\t\t\tB0_in\t=> %s,\n' % self.B0_in
		rts += '\t\t\t\tB1_in\t=> %s,\n' % self.B1_in
		rts += '\t\t\t\tFB_in\t=> %s,\n' % self.FB_in
		rts += '\t\t\t\tQ_out\t=> %s\n' % self.Q_out
		rts += '\t\t\t);\n'
		return rts

class lis_misr3_superpos_ff:
	count = 0

	def __init__(self, name, clk, reset, CUT_in, Q_in, B0_in, B1_in, Hold_in, Rollback_in, FB_in, ERR_out, Q_out):
		self.name = name
		self.clk = clk
		self.reset = reset
		self.CUT_in = CUT_in
		self.Q_in = Q_in
		self.B0_in = B0_in
		self.B1_in = B1_in
		self.Hold_in = Hold_in
		self.Rollback_in = Rollback_in
		self.FB_in = FB_in
		self.ERR_out = ERR_out
		self.Q_out = Q_out
		#self.number = lis_misr3_ff.count
      	#lis_misr3_ff.count += 1

	def writePortMap(self):
		rts = '\n%s:\tlis_misr3_superpos_ff \n' % self.name
		rts += '\t\t\tport map( \n'
		rts += '\t\t\t\tclk\t=> %s,\n' % self.clk
		rts += '\t\t\t\treset\t=> %s,\n' % self.reset
		rts += '\t\t\t\tCUT_in\t=> %s,\n' % self.CUT_in
		rts += '\t\t\t\tQ_in\t=> %s,\n' % self.Q_in
		rts += '\t\t\t\tB0_in\t=> %s,\n' % self.B0_in
		rts += '\t\t\t\tB1_in\t=> %s,\n' % self.B1_in
		rts += '\t\t\t\tHold_in\t=> %s,\n' % self.Hold_in
		rts += '\t\t\t\tRollback_in\t=> %s,\n' % self.Rollback_in		
		rts += '\t\t\t\tFB_in\t=> %s,\n' % self.FB_in
		rts += '\t\t\t\tERR_out\t=> %s,\n' % self.ERR_out
		rts += '\t\t\t\tQ_out\t=> %s\n' % self.Q_out
		rts += '\t\t\t);\n'
		return rts

class lis_misr:
	#Coefficients taken from Bardell1987
	prim_poly_coeff = {
		1: [1, 0],
		2: [2, 1, 0],
		3: [3, 1, 0],
		4: [4, 1, 0],
		5: [2, 0],
		6: [1, 0],
		7: [1, 0],
		8: [6, 5, 1, 0],
		9: [4, 0],
		10: [3, 0],
		11: [2, 0],
		12: [7, 4, 3, 0],
		13: [4, 3, 1, 0],
		14: [12, 11, 1, 0],
		15: [1, 0],
		16: [5, 3, 2, 0],
		17: [3, 0],
		18: [7, 0],
		19: [6, 5, 1, 0],
		20: [20, 3, 0],
		21: [2, 0],
		22: [1, 0],
		23: [5, 0],
		24: [4, 3, 1, 0],
		25: [3, 0],
		26: [8, 7, 1, 0],		
		27: [8, 7, 1, 0],		
		28: [3, 0],
		29: [2, 0],
		30: [16, 15, 1, 0],
		31: [3, 0],
		32: [28, 27, 1, 0],
		33: [13, 0],
		34: [15, 14, 1, 0],
		35: [2, 0],
		36: [11, 0],
		37: [12, 10, 2, 0],
		38: [6, 5, 1, 0],
		39: [4, 0],
		40: [21, 19, 2, 0],
		41: [3, 0],
		42: [23, 22, 1, 0],
		43: [6, 5, 1, 0],
		44: [27, 26, 1, 0],
		45: [4, 3, 1, 0],
		46: [21, 20, 1, 0],
		47: [5, 0],
		48: [28, 27, 1, 0],
		49: [9, 0],
		50: [27, 26, 1, 0],
		51: [16, 15, 1, 0],
		52: [3, 0],
		53: [16, 15, 1, 0],
		54: [37, 36, 1, 0],
		55: [24, 0],
		56: [22, 21, 1, 0],
		57: [7, 0],
		58: [19, 0],
		59: [22, 21, 1, 0],
		60: [1, 0],
		61: [16, 15, 1, 0],
		62: [57, 56, 1, 0],
		63: [1, 0],
		64: [4, 3, 1, 0],
		65: [18, 0],
		66: [10, 9, 1, 0],
		67: [10, 9, 1, 0],
		68: [9, 0],
		69: [29, 27, 2, 0],
		70: [16, 15, 1, 0],
		71: [6, 0],
		72: [53, 47, 6, 0],
		73: [25, 0],
		74: [16, 15, 1, 0],
		75: [11, 10, 1, 0],
		76: [36, 35, 1, 0],
		77: [31, 30, 1, 0],
		78: [20, 19, 1, 0],
		79: [9, 0],
		80: [38, 37, 1, 0],
		81: [4, 0],
		82: [38, 35, 3, 0],
		83: [46, 45, 1, 0],
		84: [13, 0],
		85: [28, 27, 1, 0],
		86: [13, 12, 1, 0],
		87: [13, 0],
		88: [72, 71, 1, 0],
		89: [38, 0],
		90: [19, 18, 1, 0],
		91: [84, 83, 1, 0],
		92: [13, 12, 1, 0],
		93: [2, 0],
		94: [21, 0],
		95: [11, 0],
		96: [49, 47, 2, 0],
		97: [6, 0],
		98: [11, 0],
		99: [47, 45, 2, 0],
		100: [37, 0],
		101: [7, 6, 1, 0],
		102: [77, 76, 1, 0],
		103: [9, 0],
		104: [11, 10, 1, 0],
		105: [16, 0],
		106: [15, 0],
		107: [65, 63, 2, 0],
		108: [31, 0],
		109: [7, 6, 1, 0],
		110: [77, 76, 1, 0],
		111: [9, 0],
		112: [11, 10, 1, 0],
		113: [9, 0],
		114: [82, 81, 1, 0],
		115: [15, 14, 1, 0],
		116: [71, 70, 1, 0],
		117: [20, 18, 2, 0],
		118: [33, 0],
		119: [8, 0],
		120: [118, 111, 7, 0],
		121: [18, 0],
		122: [60, 59, 1, 0],
		123: [2, 0],
		124: [37, 0],
		125: [108, 107, 1, 0],
		126: [37, 36, 1, 0],
		127: [1, 0],
		128: [29, 27, 2, 0],
		129: [5, 0],
		130: [3, 0],
		131: [48, 47, 1, 0],
		132: [29, 0],
		133: [52, 51, 1, 0],
		134: [57, 0],
		135: [11, 0],
		136: [126, 125, 1, 0],
		137: [21, 0],
		138: [8, 7, 1, 0],
		139: [8, 5, 3, 0],
		140: [29, 0],
		141: [32, 31, 1, 0],
		142: [21, 0],
		143: [21, 20, 1, 0],
		144: [70, 69, 1, 0],
		145: [52, 0],
		146: [60, 59, 1, 0],
		147: [38, 37, 1, 0],
		148: [27, 0],
		149: [110, 109, 1, 0],
		150: [53, 0],
		151: [3, 0],
		152: [66, 65, 1, 0],
		153: [1, 0],
		154: [129, 127, 2, 0],
		155: [32, 31, 1, 0],
		156: [116, 115, 1, 0],
		157: [27, 26, 1, 0],
		158: [27, 26, 1, 0],
		159: [31, 0],
		160: [19, 18, 1, 0],
		161: [18, 0],
		162: [88, 87, 1, 0],
		163: [60, 59, 1, 0],
		164: [14, 13, 1, 0],
		165: [31, 30, 1, 0],
		166: [39, 38, 1, 0],
		167: [6, 0],
		168: [17, 15, 2, 0],
		169: [34, 0],
		170: [23, 0],
		171: [42, 3, 1, 0],
		172: [7, 0],
		173: [10, 2, 1, 0],
		174: [13, 0],
		175: [6, 0],
		176: [43, 2, 1, 0],
		177: [8, 0],
		178: [87, 0],
		179: [4, 2, 1, 0],
		180: [52, 2, 1, 0],
		181: [89, 2, 1, 0],
		182: [121, 2, 1, 0],
		183: [56, 0],
		184: [41, 3, 1, 0],
		185: [24, 0],
		186: [53, 2, 1, 0],
		187: [20, 2, 1, 0],
		188: [186, 2, 1, 0],
		189: [49, 2, 1, 0],
		190: [47, 2, 1, 0],
		191: [9, 0],
		192: [112, 3, 1, 0],
		193: [15, 0],
		194: [87, 0],
		195: [37, 2, 1, 0],
		196: [101, 2, 1, 0],
		197: [21, 2, 1, 0],
		198: [65, 0],
		199: [34, 0],
		200: [163, 2, 1, 0],
		201: [14, 0],
		202: [55, 0],
		203: [45, 2, 1, 0],
		204: [86, 2, 1, 0],
		205: [21, 2, 1, 0],
		206: [147, 2, 1, 0],
		207: [43, 0],
		208: [83, 2, 1, 0],
		209: [6, 0],
		210: [31, 2, 1, 0],
		211: [165, 2, 1, 0],
		212: [105, 0],
		213: [62, 2, 1, 0],
		214: [87, 2, 1, 0],
		215: [23, 0],
		216: [107, 2, 1, 0],
		217: [45, 0],
		218: [11, 0],
		219: [65, 2, 1, 0],
		220: [53, 3, 1, 0],
		221: [18, 2, 1, 0],
		222: [73, 2, 1, 0],
		223: [33, 0],
		224: [159, 2, 1, 0],
		225: [32, 0],
		226: [57, 2, 1, 0],
		227: [21, 2, 1, 0],
		228: [58, 2, 1, 0],
		229: [21, 2, 1, 0],
		230: [25, 2, 1, 0],
		231: [26, 0],
		232: [23, 2, 1, 0],
		233: [74, 0],
		234: [31, 0],
		235: [45, 2, 1, 0],
		236: [5, 0],
		237: [163, 2, 1, 0],
		238: [5, 2, 1, 0],
		239: [36, 0],
		240: [49, 3, 1, 0],
		241: [70, 0],
		242: [81, 4, 1, 0],
		243: [17, 2, 1, 0],
		244: [96, 2, 1, 0],
		245: [37, 2, 1, 0],
		246: [11, 2, 1, 0],
		247: [82, 0],
		248: [243, 2, 1, 0],
		249: [86, 0],
		250: [103, 0],
		251: [45, 2, 1, 0],
		252: [67, 0],
		253: [33, 2, 1, 0],
		254: [7, 2, 1, 0],
		255: [52, 0],
		256: [16, 3, 1, 0],
		257: [12, 0],
		258: [83, 0],
		259: [254, 2, 1, 0],
		260: [74, 3, 1, 0],
		261: [74, 3, 1, 0],
		262: [252, 2, 1, 0],
		263: [93, 0],
		264: [169, 2, 1, 0],
		265: [42, 0],
		266: [47, 0],
		267: [29, 2, 1, 0],
		268: [25, 0],
		269: [117, 2, 1, 0],
		270: [53, 0],
		271: [58, 0],
		272: [56, 3, 1, 0],
		273: [23, 0],
		274: [67, 0],
		275: [28, 2, 1, 0],
		276: [28, 2, 1, 0],
		277: [254, 5, 1, 0],
		278: [5, 0],
		279: [5, 0],
		280: [146, 3, 1, 0],
		281: [93, 0],
		282: [35, 0],
		283: [200, 2, 1, 0],
		284: [119, 0],
		285: [77, 2, 1, 0],
		286: [69, 0],
		287: [71, 0],
		288: [11, 10, 1, 0],
		289: [21, 0],
		290: [5, 3, 2, 0],
		291: [76, 2, 1, 0],
		292: [97, 0],
		293: [154, 3, 1, 0],
		294: [61, 0],
		295: [48, 0],
		296: [11, 9, 4, 0],
		297: [5, 0],
		298: [78, 2, 1, 0],
		299: [21, 2, 1, 0],
		300: [7, 0]
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
			elif isinstance(self.misr_ffs[i], lis_misr2_superpos_ff):
				rts += lis_misr2_superpos_ff.writePortMap(self.misr_ffs[i])
			elif isinstance(self.misr_ffs[i], lis_misr3_superpos_ff):
				rts += lis_misr3_superpos_ff.writePortMap(self.misr_ffs[i])
		return rts

