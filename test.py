from lis_ser_bist_ff import lis_ser_bist_ff

a = lis_ser_bist_ff('clk','reset','A','B','C','D','E','F','G','H','I','J','K')

print lis_ser_bist_ff.writePortMap(a)

print a.Q_out

#if __name__ == "__main__":
#   main(sys.argv[1:])