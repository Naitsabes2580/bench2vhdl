------------------------------------------------------------------------
--#LIS#
--Author: Sebastian Kroesche
--Date: 10.02.2016 
--Description: Implementation of ISCAS89 s298 circuit with the
--             combined SER/BIST flip-flops
--             generated with bench2vhdl2
--Circuit statistics
--# 3 inputs
--# 6 outputs
--# 14 D-type flipflops
--# 44 inverters
--# 75 gates (31 ANDs + 9 NANDs + 16 ORs + 19 NORs)
------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
 
library lis_lib;
use lis_lib.ser_bist.all; 
 
entity s298_ser_bist is
	generic (
		NUM_FF				:	integer	:= 14;
		BIST_LENGTH			:	integer	:= 20000;
		EXPECTED_RESPONSE	:	std_logic_vector(14-1 downto 0)	:= "00000000000000"
	);
	port (
		clk : in std_logic; 
		reset : in std_logic; 
		BIST_start_in : in std_logic; 
		G0: in std_logic; 
		G1: in std_logic; 
		G2: in std_logic; 
		G117: out std_logic; 
		G132: out std_logic; 
		G66: out std_logic; 
		G118: out std_logic; 
		G133: out std_logic; 
		G67: out std_logic 
		BIST_done_out : in std_logic; 
		BIST_pass_out : in std_logic 
	);
end entity; 

architecture rtl of s298 is

	signal G29 : std_logic;
	signal G10 : std_logic;
	signal G30 : std_logic;
	signal G11 : std_logic;
	signal G34 : std_logic;
	signal G12 : std_logic;
	signal G39 : std_logic;
	signal G13 : std_logic;
	signal G44 : std_logic;
	signal G14 : std_logic;
	signal G56 : std_logic;
	signal G15 : std_logic;
	signal G86 : std_logic;
	signal G16 : std_logic;
	signal G92 : std_logic;
	signal G17 : std_logic;
	signal G98 : std_logic;
	signal G18 : std_logic;
	signal G102 : std_logic;
	signal G19 : std_logic;
	signal G107 : std_logic;
	signal G20 : std_logic;
	signal G113 : std_logic;
	signal G21 : std_logic;
	signal G119 : std_logic;
	signal G22 : std_logic;
	signal G125 : std_logic;
	signal G23 : std_logic;
	signal G130 : std_logic;
	signal G28 : std_logic;
	signal G38 : std_logic;
	signal G40 : std_logic;
	signal G45 : std_logic;
	signal G46 : std_logic;
	signal G50 : std_logic;
	signal G51 : std_logic;
	signal G54 : std_logic;
	signal G55 : std_logic;
	signal G59 : std_logic;
	signal G60 : std_logic;
	signal G64 : std_logic;
	signal I155 : std_logic;
	signal I158 : std_logic;
	signal G76 : std_logic;
	signal G82 : std_logic;
	signal G87 : std_logic;
	signal G91 : std_logic;
	signal G93 : std_logic;
	signal G96 : std_logic;
	signal G99 : std_logic;
	signal G103 : std_logic;
	signal G112 : std_logic;
	signal G108 : std_logic;
	signal G114 : std_logic;
	signal I210 : std_logic;
	signal I213 : std_logic;
	signal G124 : std_logic;
	signal G120 : std_logic;
	signal G121 : std_logic;
	signal I221 : std_logic;
	signal G131 : std_logic;
	signal G126 : std_logic;
	signal G127 : std_logic;
	signal I229 : std_logic;
	signal I232 : std_logic;
	signal I235 : std_logic;
	signal I238 : std_logic;
	signal G26 : std_logic;
	signal G27 : std_logic;
	signal G31 : std_logic;
	signal G32 : std_logic;
	signal G33 : std_logic;
	signal G35 : std_logic;
	signal G36 : std_logic;
	signal G37 : std_logic;
	signal G42 : std_logic;
	signal G41 : std_logic;
	signal G48 : std_logic;
	signal G47 : std_logic;
	signal G49 : std_logic;
	signal G52 : std_logic;
	signal G57 : std_logic;
	signal G61 : std_logic;
	signal G58 : std_logic;
	signal G65 : std_logic;
	signal G62 : std_logic;
	signal G63 : std_logic;
	signal G74 : std_logic;
	signal G75 : std_logic;
	signal G88 : std_logic;
	signal G89 : std_logic;
	signal G90 : std_logic;
	signal G94 : std_logic;
	signal G95 : std_logic;
	signal G100 : std_logic;
	signal G105 : std_logic;
	signal G104 : std_logic;
	signal G110 : std_logic;
	signal G109 : std_logic;
	signal G111 : std_logic;
	signal G115 : std_logic;
	signal G122 : std_logic;
	signal G123 : std_logic;
	signal G128 : std_logic;
	signal G129 : std_logic;
	signal G24 : std_logic;
	signal G25 : std_logic;
	signal G68 : std_logic;
	signal G69 : std_logic;
	signal G70 : std_logic;
	signal G71 : std_logic;
	signal G72 : std_logic;
	signal G73 : std_logic;
	signal G77 : std_logic;
	signal G78 : std_logic;
	signal G79 : std_logic;
	signal G80 : std_logic;
	signal G81 : std_logic;
	signal G83 : std_logic;
	signal G84 : std_logic;
	signal G85 : std_logic;
	signal G43 : std_logic;
	signal G97 : std_logic;
	signal G101 : std_logic;
	signal G106 : std_logic;
	signal G116 : std_logic;
	signal G53 : std_logic;

--SER/BIST ctrl signals
	signal ctrl_B0_out : std_ulogic;
	signal ctrl_B1_out : std_ulogic;
	signal ctrl_Scan_out : std_ulogic;
	signal ctrl_BIST_eval_out : std_ulogic;
	signal ctrl_Hold_out : std_ulogic;
	signal ctrl_Rollback_out : std_ulogic;
	signal OR_tree_out : std_ulogic;
	signal SER_BIST_FF_0_ERR_out : std_ulogic;
	signal SER_BIST_FF_1_ERR_out : std_ulogic;
	signal SER_BIST_FF_2_ERR_out : std_ulogic;
	signal SER_BIST_FF_3_ERR_out : std_ulogic;
	signal SER_BIST_FF_4_ERR_out : std_ulogic;
	signal SER_BIST_FF_5_ERR_out : std_ulogic;
	signal SER_BIST_FF_6_ERR_out : std_ulogic;
	signal SER_BIST_FF_7_ERR_out : std_ulogic;
	signal SER_BIST_FF_8_ERR_out : std_ulogic;
	signal SER_BIST_FF_9_ERR_out : std_ulogic;
	signal SER_BIST_FF_10_ERR_out : std_ulogic;
	signal SER_BIST_FF_11_ERR_out : std_ulogic;
	signal SER_BIST_FF_12_ERR_out : std_ulogic;
	signal SER_BIST_FF_13_ERR_out : std_ulogic;
	signal SER_BIST_FF_0_Scan_out : std_ulogic;
	signal SER_BIST_FF_1_Scan_out : std_ulogic;
	signal SER_BIST_FF_2_Scan_out : std_ulogic;
	signal SER_BIST_FF_3_Scan_out : std_ulogic;
	signal SER_BIST_FF_4_Scan_out : std_ulogic;
	signal SER_BIST_FF_5_Scan_out : std_ulogic;
	signal SER_BIST_FF_6_Scan_out : std_ulogic;
	signal SER_BIST_FF_7_Scan_out : std_ulogic;
	signal SER_BIST_FF_8_Scan_out : std_ulogic;
	signal SER_BIST_FF_9_Scan_out : std_ulogic;
	signal SER_BIST_FF_10_Scan_out : std_ulogic;
	signal SER_BIST_FF_11_Scan_out : std_ulogic;
	signal SER_BIST_FF_12_Scan_out : std_ulogic;
	signal SER_BIST_FF_13_Scan_out : std_ulogic;

begin

CTRL:	lis_ser_bist_controller 
		generic map( 
			NUM_FF		=> NUM_FF, 
 			BIST_LENGTH	=> BIST_LENGTH 
 		)
		port map(
			clk				=> clk, 
 			reset			=> reset, 
 			ERR_in			=> OR_tree_out, 
 			BIST_start_in	=> BIST_start_in, 
 			Exp_resp_in		=> EXPECTED_RESPONSE, 
 			Hold_out		=> ctrl_Hold_out, 
 			Rollback_out	=> ctrl_Rollback_out, 
 			BIST_eval_out	=> ctrl_BIST_eval_out, 
 			B0_out			=> ctrl_B0_out, 
 			B1_out			=> ctrl_B1_out, 
 			BIST_done_out	=> BIST_done_out, 
 			BIST_pass_out	=> BIST_pass_out, 
 			Scan_out		=> ctrl_Scan_out 
 		);


--Flip-flops (total number: 14)
SER_BIST_FF_0:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G29, 
 			Q_in		=> G23, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> ctrl_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_0_ERR_out, 
 			Scan_out	=> SER_BIST_FF_0_Scan_out, 
 			Q_out		=> G10 
 		);

SER_BIST_FF_1:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G30, 
 			Q_in		=> G10, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_0_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_1_ERR_out, 
 			Scan_out	=> SER_BIST_FF_1_Scan_out, 
 			Q_out		=> G11 
 		);

SER_BIST_FF_2:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G34, 
 			Q_in		=> G11, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_1_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_2_ERR_out, 
 			Scan_out	=> SER_BIST_FF_2_Scan_out, 
 			Q_out		=> G12 
 		);

SER_BIST_FF_3:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G39, 
 			Q_in		=> G12, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_2_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_3_ERR_out, 
 			Scan_out	=> SER_BIST_FF_3_Scan_out, 
 			Q_out		=> G13 
 		);

SER_BIST_FF_4:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G44, 
 			Q_in		=> G13, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_3_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_4_ERR_out, 
 			Scan_out	=> SER_BIST_FF_4_Scan_out, 
 			Q_out		=> G14 
 		);

SER_BIST_FF_5:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G56, 
 			Q_in		=> G14, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_4_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_5_ERR_out, 
 			Scan_out	=> SER_BIST_FF_5_Scan_out, 
 			Q_out		=> G15 
 		);

SER_BIST_FF_6:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G86, 
 			Q_in		=> G15, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_5_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_6_ERR_out, 
 			Scan_out	=> SER_BIST_FF_6_Scan_out, 
 			Q_out		=> G16 
 		);

SER_BIST_FF_7:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G92, 
 			Q_in		=> G16, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_6_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_7_ERR_out, 
 			Scan_out	=> SER_BIST_FF_7_Scan_out, 
 			Q_out		=> G17 
 		);

SER_BIST_FF_8:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G98, 
 			Q_in		=> G17, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_7_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_8_ERR_out, 
 			Scan_out	=> SER_BIST_FF_8_Scan_out, 
 			Q_out		=> G18 
 		);

SER_BIST_FF_9:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G102, 
 			Q_in		=> G18, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_8_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_9_ERR_out, 
 			Scan_out	=> SER_BIST_FF_9_Scan_out, 
 			Q_out		=> G19 
 		);

SER_BIST_FF_10:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G107, 
 			Q_in		=> G19, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_9_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_10_ERR_out, 
 			Scan_out	=> SER_BIST_FF_10_Scan_out, 
 			Q_out		=> G20 
 		);

SER_BIST_FF_11:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G113, 
 			Q_in		=> G20, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_10_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_11_ERR_out, 
 			Scan_out	=> SER_BIST_FF_11_Scan_out, 
 			Q_out		=> G21 
 		);

SER_BIST_FF_12:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G119, 
 			Q_in		=> G21, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_11_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_12_ERR_out, 
 			Scan_out	=> SER_BIST_FF_12_Scan_out, 
 			Q_out		=> G22 
 		);

SER_BIST_FF_13:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> G125, 
 			Q_in		=> G22, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_12_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_13_ERR_out, 
 			Scan_out	=> open, 
 			Q_out		=> G23 
 		);

OR_tree_out <= SER_BIST_FF_0_ERR_out OR SER_BIST_FF_1_ERR_out OR SER_BIST_FF_2_ERR_out OR SER_BIST_FF_3_ERR_out OR SER_BIST_FF_4_ERR_out OR SER_BIST_FF_5_ERR_out OR SER_BIST_FF_6_ERR_out OR SER_BIST_FF_7_ERR_out OR SER_BIST_FF_8_ERR_out OR SER_BIST_FF_9_ERR_out OR SER_BIST_FF_10_ERR_out OR SER_BIST_FF_11_ERR_out OR SER_BIST_FF_12_ERR_out OR SER_BIST_FF_13_ERR_out;

--Inverters (total number: 44)
INV_0:	 lis_not port map( A => G130, Z => G28 );
INV_1:	 lis_not port map( A => G10, Z => G38 );
INV_2:	 lis_not port map( A => G13, Z => G40 );
INV_3:	 lis_not port map( A => G12, Z => G45 );
INV_4:	 lis_not port map( A => G11, Z => G46 );
INV_5:	 lis_not port map( A => G14, Z => G50 );
INV_6:	 lis_not port map( A => G23, Z => G51 );
INV_7:	 lis_not port map( A => G11, Z => G54 );
INV_8:	 lis_not port map( A => G13, Z => G55 );
INV_9:	 lis_not port map( A => G12, Z => G59 );
INV_10:	 lis_not port map( A => G22, Z => G60 );
INV_11:	 lis_not port map( A => G15, Z => G64 );
INV_12:	 lis_not port map( A => G16, Z => I155 );
INV_13:	 lis_not port map( A => I155, Z => G66 );
INV_14:	 lis_not port map( A => G17, Z => I158 );
INV_15:	 lis_not port map( A => I158, Z => G67 );
INV_16:	 lis_not port map( A => G10, Z => G76 );
INV_17:	 lis_not port map( A => G11, Z => G82 );
INV_18:	 lis_not port map( A => G16, Z => G87 );
INV_19:	 lis_not port map( A => G12, Z => G91 );
INV_20:	 lis_not port map( A => G17, Z => G93 );
INV_21:	 lis_not port map( A => G14, Z => G96 );
INV_22:	 lis_not port map( A => G18, Z => G99 );
INV_23:	 lis_not port map( A => G13, Z => G103 );
INV_24:	 lis_not port map( A => G112, Z => G108 );
INV_25:	 lis_not port map( A => G21, Z => G114 );
INV_26:	 lis_not port map( A => G18, Z => I210 );
INV_27:	 lis_not port map( A => I210, Z => G117 );
INV_28:	 lis_not port map( A => G19, Z => I213 );
INV_29:	 lis_not port map( A => I213, Z => G118 );
INV_30:	 lis_not port map( A => G124, Z => G120 );
INV_31:	 lis_not port map( A => G22, Z => G121 );
INV_32:	 lis_not port map( A => G2, Z => I221 );
INV_33:	 lis_not port map( A => I221, Z => G124 );
INV_34:	 lis_not port map( A => G131, Z => G126 );
INV_35:	 lis_not port map( A => G23, Z => G127 );
INV_36:	 lis_not port map( A => G0, Z => I229 );
INV_37:	 lis_not port map( A => I229, Z => G130 );
INV_38:	 lis_not port map( A => G1, Z => I232 );
INV_39:	 lis_not port map( A => I232, Z => G131 );
INV_40:	 lis_not port map( A => G20, Z => I235 );
INV_41:	 lis_not port map( A => I235, Z => G132 );
INV_42:	 lis_not port map( A => G21, Z => I238 );
INV_43:	 lis_not port map( A => I238, Z => G133 );

--AND-gates (total number: 31)
AND2_0:	 LIS_AND2 port map( A => G28, B => G50, Z => G26);
AND2_1:	 LIS_AND2 port map( A => G51, B => G28, Z => G27);
AND3_0:	 LIS_AND3 port map( A => G10, B => G45, C => G13, Z => G31 );
AND2_2:	 LIS_AND2 port map( A => G10, B => G11, Z => G32);
AND2_3:	 LIS_AND2 port map( A => G38, B => G46, Z => G33);
AND3_1:	 LIS_AND3 port map( A => G10, B => G11, C => G12, Z => G35 );
AND2_4:	 LIS_AND2 port map( A => G38, B => G45, Z => G36);
AND2_5:	 LIS_AND2 port map( A => G46, B => G45, Z => G37);
AND2_6:	 LIS_AND2 port map( A => G40, B => G41, Z => G42);
AND4_0:	 LIS_AND4 port map( A => G45, B => G46, C => G10, D => G47, Z => G48 );
AND3_2:	 LIS_AND3 port map( A => G50, B => G51, C => G52, Z => G49 );
AND4_1:	 LIS_AND4 port map( A => G59, B => G11, C => G60, D => G61, Z => G57 );
AND2_7:	 LIS_AND2 port map( A => G64, B => G65, Z => G58);
AND4_2:	 LIS_AND4 port map( A => G59, B => G11, C => G60, D => G61, Z => G62 );
AND2_8:	 LIS_AND2 port map( A => G64, B => G65, Z => G63);
AND3_3:	 LIS_AND3 port map( A => G12, B => G14, C => G19, Z => G74 );
AND3_4:	 LIS_AND3 port map( A => G82, B => G91, C => G14, Z => G75 );
AND2_9:	 LIS_AND2 port map( A => G14, B => G87, Z => G88);
AND2_10:	 LIS_AND2 port map( A => G103, B => G96, Z => G89);
AND2_11:	 LIS_AND2 port map( A => G91, B => G103, Z => G90);
AND2_12:	 LIS_AND2 port map( A => G93, B => G13, Z => G94);
AND2_13:	 LIS_AND2 port map( A => G96, B => G13, Z => G95);
AND3_5:	 LIS_AND3 port map( A => G99, B => G14, C => G12, Z => G100 );
AND3_6:	 LIS_AND3 port map( A => G103, B => G108, C => G104, Z => G105 );
AND2_14:	 LIS_AND2 port map( A => G108, B => G109, Z => G110);
AND2_15:	 LIS_AND2 port map( A => G10, B => G112, Z => G111);
AND2_16:	 LIS_AND2 port map( A => G114, B => G14, Z => G115);
AND2_17:	 LIS_AND2 port map( A => G120, B => G121, Z => G122);
AND2_18:	 LIS_AND2 port map( A => G124, B => G22, Z => G123);
AND2_19:	 LIS_AND2 port map( A => G126, B => G127, Z => G128);
AND2_20:	 LIS_AND2 port map( A => G131, B => G23, Z => G129);

--OR-gates (total number: 16)
OR4_0:	 LIS_OR4 port map( A => G38, B => G46, C => G45, D => G40, Z => G24 );
OR3_0:	 LIS_OR3 port map( A => G38, B => G11, C => G12, Z => G25 );
OR4_1:	 LIS_OR4 port map( A => G11, B => G12, C => G13, D => G96, Z => G68 );
OR2_0:	 LIS_OR2 port map( A => G103, B => G18, Z => G69 );
OR2_1:	 LIS_OR2 port map( A => G103, B => G14, Z => G70 );
OR3_1:	 LIS_OR3 port map( A => G82, B => G12, C => G13, Z => G71 );
OR2_2:	 LIS_OR2 port map( A => G91, B => G20, Z => G72 );
OR2_3:	 LIS_OR2 port map( A => G103, B => G20, Z => G73 );
OR4_2:	 LIS_OR4 port map( A => G112, B => G103, C => G96, D => G19, Z => G77 );
OR2_4:	 LIS_OR2 port map( A => G108, B => G76, Z => G78 );
OR2_5:	 LIS_OR2 port map( A => G103, B => G14, Z => G79 );
OR2_6:	 LIS_OR2 port map( A => G11, B => G14, Z => G80 );
OR2_7:	 LIS_OR2 port map( A => G12, B => G13, Z => G81 );
OR4_3:	 LIS_OR4 port map( A => G11, B => G12, C => G13, D => G96, Z => G83 );
OR3_2:	 LIS_OR3 port map( A => G82, B => G91, C => G14, Z => G84 );
OR3_3:	 LIS_OR3 port map( A => G91, B => G96, C => G17, Z => G85 );

--NAND-gates (total number: 9)
NAND3_0: LIS_NAND3 port map( A => G12, B => G11, C => G10, Z => G41 );
NAND3_1: LIS_NAND3 port map( A => G24, B => G25, C => G28, Z => G43 );
NAND4_0: LIS_NAND4 port map( A => G13, B => G45, C => G46, D => G10, Z => G52 );
NAND4_1: LIS_NAND4 port map( A => G59, B => G54, C => G22, D => G61, Z => G65 );
NAND4_2: LIS_NAND4 port map( A => G83, B => G84, C => G85, D => G108, Z => G97 );
NAND4_3: LIS_NAND4 port map( A => G68, B => G69, C => G70, D => G108, Z => G101 );
NAND2_0: LIS_NAND2 port map( A => G77, B => G78, Z => G106 );
NAND4_4: LIS_NAND4 port map( A => G71, B => G72, C => G73, D => G14, Z => G109 );
NAND4_5: LIS_NAND4 port map( A => G79, B => G80, C => G81, D => G108, Z => G116 );

--NOR-gates (total number: 19)
NOR2_0:	 LIS_NOR2 port map( A => G10, B => G130, Z => G29 );
NOR4_0:	 LIS_NOR4 port map( A => G31, B => G32, C => G33, D => G130, Z => G30 );
NOR4_1:	 LIS_NOR4 port map( A => G35, B => G36, C => G37, D => G130, Z => G34 );
NOR2_1:	 LIS_NOR2 port map( A => G42, B => G43, Z => G39 );
NOR3_0:	 LIS_NOR3 port map( A => G48, B => G49, C => G53, Z => G44 );
NOR2_2:	 LIS_NOR2 port map( A => G50, B => G40, Z => G47 );
NOR2_3:	 LIS_NOR2 port map( A => G26, B => G27, Z => G53 );
NOR3_1:	 LIS_NOR3 port map( A => G57, B => G58, C => G130, Z => G56 );
NOR2_4:	 LIS_NOR2 port map( A => G14, B => G55, Z => G61 );
NOR4_2:	 LIS_NOR4 port map( A => G88, B => G89, C => G90, D => G112, Z => G86 );
NOR3_2:	 LIS_NOR3 port map( A => G94, B => G95, C => G97, Z => G92 );
NOR2_5:	 LIS_NOR2 port map( A => G100, B => G101, Z => G98 );
NOR2_6:	 LIS_NOR2 port map( A => G105, B => G106, Z => G102 );
NOR2_7:	 LIS_NOR2 port map( A => G74, B => G75, Z => G104 );
NOR2_8:	 LIS_NOR2 port map( A => G110, B => G111, Z => G107 );
NOR2_9:	 LIS_NOR2 port map( A => G62, B => G63, Z => G112 );
NOR2_10:	 LIS_NOR2 port map( A => G115, B => G116, Z => G113 );
NOR3_3:	 LIS_NOR3 port map( A => G122, B => G123, C => G130, Z => G119 );
NOR3_4:	 LIS_NOR3 port map( A => G128, B => G129, C => G130, Z => G125 );

end architecture;
