------------------------------------------------------------------------
--#LIS#
--Author: Sebastian Kroesche
--Date: 11.02.2016 
--Description: Implementation of ISCAS89 s838 circuit with the
--             combined SER/BIST flip-flops
--             generated with bench2vhdl2
--Circuit statistics
--# s838
--# 35 inputs
--# 2 outputs
--# 32 D-type flipflops
--# 149 inverters
--# 241 gates (58 ANDs + 89 NANDs + 16 ORs + 78 NORs)
------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
 
library lis_lib;
use lis_lib.ser_bist.all; 
 
entity s838_ser_bist is
	generic (
		NUM_FF				:	integer	:= 32;
		BIST_LENGTH			:	integer	:= 20000;
		EXPECTED_RESPONSE	:	std_logic_vector(32-1 downto 0)	:= "00000000000000000000000000000000"
	);
	port (
		clk : in std_logic; 
		reset : in std_logic; 
		BIST_start_in : in std_logic; 
		X: in std_logic; 
		Clear: in std_logic; 
		C_32: in std_logic; 
		C_31: in std_logic; 
		C_30: in std_logic; 
		C_29: in std_logic; 
		C_28: in std_logic; 
		C_27: in std_logic; 
		C_26: in std_logic; 
		C_25: in std_logic; 
		C_24: in std_logic; 
		C_23: in std_logic; 
		C_22: in std_logic; 
		C_21: in std_logic; 
		C_20: in std_logic; 
		C_19: in std_logic; 
		C_18: in std_logic; 
		C_17: in std_logic; 
		C_16: in std_logic; 
		C_15: in std_logic; 
		C_14: in std_logic; 
		C_13: in std_logic; 
		C_12: in std_logic; 
		C_11: in std_logic; 
		C_10: in std_logic; 
		C_9: in std_logic; 
		C_8: in std_logic; 
		C_7: in std_logic; 
		C_6: in std_logic; 
		C_5: in std_logic; 
		C_4: in std_logic; 
		C_3: in std_logic; 
		C_2: in std_logic; 
		C_1: in std_logic; 
		C_0: in std_logic; 
		W: out std_logic; 
		Z: out std_logic 
		BIST_done_out : in std_logic; 
		BIST_pass_out : in std_logic 
	);
end entity; 

architecture rtl of s838 is

	signal II309 : std_logic;
	signal Y_10 : std_logic;
	signal II3 : std_logic;
	signal Y_4 : std_logic;
	signal II6 : std_logic;
	signal Y_1 : std_logic;
	signal II155 : std_logic;
	signal Y_8 : std_logic;
	signal II307 : std_logic;
	signal Y_12 : std_logic;
	signal II156 : std_logic;
	signal Y_7 : std_logic;
	signal II158 : std_logic;
	signal Y_5 : std_logic;
	signal II5 : std_logic;
	signal Y_2 : std_logic;
	signal II915 : std_logic;
	signal Y_28 : std_logic;
	signal II308 : std_logic;
	signal Y_11 : std_logic;
	signal II460 : std_logic;
	signal Y_15 : std_logic;
	signal II310 : std_logic;
	signal Y_9 : std_logic;
	signal II459 : std_logic;
	signal Y_16 : std_logic;
	signal II157 : std_logic;
	signal Y_6 : std_logic;
	signal II461 : std_logic;
	signal Y_14 : std_logic;
	signal II614 : std_logic;
	signal Y_17 : std_logic;
	signal II1067 : std_logic;
	signal Y_32 : std_logic;
	signal II611 : std_logic;
	signal Y_20 : std_logic;
	signal II613 : std_logic;
	signal Y_18 : std_logic;
	signal II763 : std_logic;
	signal Y_24 : std_logic;
	signal II916 : std_logic;
	signal Y_27 : std_logic;
	signal II765 : std_logic;
	signal Y_22 : std_logic;
	signal II766 : std_logic;
	signal Y_21 : std_logic;
	signal II764 : std_logic;
	signal Y_23 : std_logic;
	signal II4 : std_logic;
	signal Y_3 : std_logic;
	signal II612 : std_logic;
	signal Y_19 : std_logic;
	signal II462 : std_logic;
	signal Y_13 : std_logic;
	signal II917 : std_logic;
	signal Y_26 : std_logic;
	signal II918 : std_logic;
	signal Y_25 : std_logic;
	signal II1068 : std_logic;
	signal Y_31 : std_logic;
	signal II1069 : std_logic;
	signal Y_30 : std_logic;
	signal II1070 : std_logic;
	signal Y_29 : std_logic;
	signal II104 : std_logic;
	signal II92 : std_logic;
	signal II50 : std_logic;
	signal II40 : std_logic;
	signal II41 : std_logic;
	signal II42 : std_logic;
	signal II43 : std_logic;
	signal II44 : std_logic;
	signal II46 : std_logic;
	signal II47 : std_logic;
	signal II256 : std_logic;
	signal II244 : std_logic;
	signal II202 : std_logic;
	signal II1_1 : std_logic;
	signal II192 : std_logic;
	signal II193 : std_logic;
	signal II194 : std_logic;
	signal II195 : std_logic;
	signal II196 : std_logic;
	signal II198 : std_logic;
	signal II199 : std_logic;
	signal II408 : std_logic;
	signal II396 : std_logic;
	signal II354 : std_logic;
	signal II1_2 : std_logic;
	signal II344 : std_logic;
	signal II345 : std_logic;
	signal II346 : std_logic;
	signal II347 : std_logic;
	signal II348 : std_logic;
	signal II350 : std_logic;
	signal II351 : std_logic;
	signal II560 : std_logic;
	signal II548 : std_logic;
	signal II506 : std_logic;
	signal II1_3 : std_logic;
	signal II496 : std_logic;
	signal II497 : std_logic;
	signal II498 : std_logic;
	signal II499 : std_logic;
	signal II500 : std_logic;
	signal II502 : std_logic;
	signal II503 : std_logic;
	signal II712 : std_logic;
	signal II700 : std_logic;
	signal II658 : std_logic;
	signal II1_4 : std_logic;
	signal II648 : std_logic;
	signal II649 : std_logic;
	signal II650 : std_logic;
	signal II651 : std_logic;
	signal II652 : std_logic;
	signal II654 : std_logic;
	signal II655 : std_logic;
	signal II864 : std_logic;
	signal II852 : std_logic;
	signal II810 : std_logic;
	signal II1_5 : std_logic;
	signal II800 : std_logic;
	signal II801 : std_logic;
	signal II802 : std_logic;
	signal II803 : std_logic;
	signal II804 : std_logic;
	signal II806 : std_logic;
	signal II807 : std_logic;
	signal II1016 : std_logic;
	signal II1004 : std_logic;
	signal II962 : std_logic;
	signal II1_6 : std_logic;
	signal II952 : std_logic;
	signal II953 : std_logic;
	signal II954 : std_logic;
	signal II955 : std_logic;
	signal II956 : std_logic;
	signal II958 : std_logic;
	signal II959 : std_logic;
	signal II1168 : std_logic;
	signal II1156 : std_logic;
	signal II1114 : std_logic;
	signal II1_7 : std_logic;
	signal II1104 : std_logic;
	signal II1105 : std_logic;
	signal II1106 : std_logic;
	signal II1107 : std_logic;
	signal II1108 : std_logic;
	signal II1110 : std_logic;
	signal II1111 : std_logic;
	signal II1253 : std_logic;
	signal II1219_1 : std_logic;
	signal II1230 : std_logic;
	signal II1221 : std_logic;
	signal II1222 : std_logic;
	signal II1223 : std_logic;
	signal II1226 : std_logic;
	signal P_1 : std_logic;
	signal II1228 : std_logic;
	signal P_3 : std_logic;
	signal II1229 : std_logic;
	signal P_4 : std_logic;
	signal II1316 : std_logic;
	signal II1219_2 : std_logic;
	signal II1290 : std_logic;
	signal II1280 : std_logic;
	signal II1281 : std_logic;
	signal II1282 : std_logic;
	signal II1283 : std_logic;
	signal II1288 : std_logic;
	signal P_7 : std_logic;
	signal II1289 : std_logic;
	signal P_8 : std_logic;
	signal II1328 : std_logic;
	signal II1329 : std_logic;
	signal II1384 : std_logic;
	signal II1219_3 : std_logic;
	signal II1358 : std_logic;
	signal II1348 : std_logic;
	signal II1349 : std_logic;
	signal II1350 : std_logic;
	signal II1351 : std_logic;
	signal II1356 : std_logic;
	signal P_11 : std_logic;
	signal II1357 : std_logic;
	signal P_12 : std_logic;
	signal II1396 : std_logic;
	signal II1397 : std_logic;
	signal II1452 : std_logic;
	signal II1219_4 : std_logic;
	signal II1426 : std_logic;
	signal II1416 : std_logic;
	signal II1417 : std_logic;
	signal II1418 : std_logic;
	signal II1419 : std_logic;
	signal II1424 : std_logic;
	signal P_15 : std_logic;
	signal II1425 : std_logic;
	signal P_16 : std_logic;
	signal II1464 : std_logic;
	signal II1465 : std_logic;
	signal II1520 : std_logic;
	signal II1219_5 : std_logic;
	signal II1494 : std_logic;
	signal II1484 : std_logic;
	signal II1485 : std_logic;
	signal II1486 : std_logic;
	signal II1487 : std_logic;
	signal II1492 : std_logic;
	signal P_19 : std_logic;
	signal II1493 : std_logic;
	signal P_20 : std_logic;
	signal II1532 : std_logic;
	signal II1533 : std_logic;
	signal II1588 : std_logic;
	signal II1219_6 : std_logic;
	signal II1562 : std_logic;
	signal II1552 : std_logic;
	signal II1553 : std_logic;
	signal II1554 : std_logic;
	signal II1555 : std_logic;
	signal II1560 : std_logic;
	signal P_23 : std_logic;
	signal II1561 : std_logic;
	signal P_24 : std_logic;
	signal II1600 : std_logic;
	signal II1601 : std_logic;
	signal II1656 : std_logic;
	signal II1219_7 : std_logic;
	signal II1630 : std_logic;
	signal II1620 : std_logic;
	signal II1621 : std_logic;
	signal II1622 : std_logic;
	signal II1623 : std_logic;
	signal II1628 : std_logic;
	signal P_27 : std_logic;
	signal II1629 : std_logic;
	signal P_28 : std_logic;
	signal II1668 : std_logic;
	signal II1669 : std_logic;
	signal II1688 : std_logic;
	signal II1689 : std_logic;
	signal II1690 : std_logic;
	signal II1691 : std_logic;
	signal II1692 : std_logic;
	signal II1694 : std_logic;
	signal P_30 : std_logic;
	signal II1948 : std_logic;
	signal II1947 : std_logic;
	signal II1952 : std_logic;
	signal II1951 : std_logic;
	signal II1956 : std_logic;
	signal II1955 : std_logic;
	signal II1964 : std_logic;
	signal II1963 : std_logic;
	signal II1966 : std_logic;
	signal II1965 : std_logic;
	signal II1972 : std_logic;
	signal II1971 : std_logic;
	signal II1974 : std_logic;
	signal II1973 : std_logic;
	signal II1995 : std_logic;
	signal II1996 : std_logic;
	signal II2001 : std_logic;
	signal II2002 : std_logic;
	signal II127_1 : std_logic;
	signal II109 : std_logic;
	signal II127_2 : std_logic;
	signal II96 : std_logic;
	signal II113 : std_logic;
	signal II131_1 : std_logic;
	signal II131_2 : std_logic;
	signal II279_1 : std_logic;
	signal II261 : std_logic;
	signal II279_2 : std_logic;
	signal II248 : std_logic;
	signal II265 : std_logic;
	signal II283_1 : std_logic;
	signal II283_2 : std_logic;
	signal II431_1 : std_logic;
	signal II413 : std_logic;
	signal II431_2 : std_logic;
	signal II400 : std_logic;
	signal II417 : std_logic;
	signal II435_1 : std_logic;
	signal II435_2 : std_logic;
	signal II583_1 : std_logic;
	signal II565 : std_logic;
	signal II583_2 : std_logic;
	signal II552 : std_logic;
	signal II569 : std_logic;
	signal II587_1 : std_logic;
	signal II587_2 : std_logic;
	signal II735_1 : std_logic;
	signal II717 : std_logic;
	signal II735_2 : std_logic;
	signal II704 : std_logic;
	signal II721 : std_logic;
	signal II739_1 : std_logic;
	signal II739_2 : std_logic;
	signal II887_1 : std_logic;
	signal II869 : std_logic;
	signal II887_2 : std_logic;
	signal II856 : std_logic;
	signal II873 : std_logic;
	signal II891_1 : std_logic;
	signal II891_2 : std_logic;
	signal II1039_1 : std_logic;
	signal II1021 : std_logic;
	signal II1039_2 : std_logic;
	signal II1008 : std_logic;
	signal II1025 : std_logic;
	signal II1043_1 : std_logic;
	signal II1043_2 : std_logic;
	signal II1191_1 : std_logic;
	signal II1173 : std_logic;
	signal II1191_2 : std_logic;
	signal II1160 : std_logic;
	signal II1177 : std_logic;
	signal II1195_1 : std_logic;
	signal II1195_2 : std_logic;
	signal II2017_1 : std_logic;
	signal P_29 : std_logic;
	signal II2017_2 : std_logic;
	signal II2021_1 : std_logic;
	signal II2021_2 : std_logic;
	signal P_31 : std_logic;
	signal II2025_1 : std_logic;
	signal P_32 : std_logic;
	signal II2025_2 : std_logic;
	signal II2029_1 : std_logic;
	signal II2032_1 : std_logic;
	signal II2032_2 : std_logic;
	signal II2032_3 : std_logic;
	signal II2037_1 : std_logic;
	signal P_14 : std_logic;
	signal II2040_1 : std_logic;
	signal II2043_1 : std_logic;
	signal P_18 : std_logic;
	signal II2043_2 : std_logic;
	signal II2047_1 : std_logic;
	signal P_10 : std_logic;
	signal II2047_2 : std_logic;
	signal II2051_1 : std_logic;
	signal II2051_2 : std_logic;
	signal II2055_1 : std_logic;
	signal P_26 : std_logic;
	signal II2055_2 : std_logic;
	signal P_2 : std_logic;
	signal II2059_1 : std_logic;
	signal II2059_2 : std_logic;
	signal P_25 : std_logic;
	signal II2063_1 : std_logic;
	signal II2063_2 : std_logic;
	signal P_5 : std_logic;
	signal II2070_1 : std_logic;
	signal P_13 : std_logic;
	signal II2070_2 : std_logic;
	signal P_9 : std_logic;
	signal II135_1 : std_logic;
	signal II135_2 : std_logic;
	signal II100 : std_logic;
	signal II287_1 : std_logic;
	signal II287_2 : std_logic;
	signal II252 : std_logic;
	signal II439_1 : std_logic;
	signal II439_2 : std_logic;
	signal II404 : std_logic;
	signal II591_1 : std_logic;
	signal II591_2 : std_logic;
	signal II556 : std_logic;
	signal II743_1 : std_logic;
	signal II743_2 : std_logic;
	signal II708 : std_logic;
	signal II895_1 : std_logic;
	signal II895_2 : std_logic;
	signal II860 : std_logic;
	signal II1047_1 : std_logic;
	signal II1047_2 : std_logic;
	signal II1012 : std_logic;
	signal II1199_1 : std_logic;
	signal II1199_2 : std_logic;
	signal II1164 : std_logic;
	signal II1259 : std_logic;
	signal II1262 : std_logic;
	signal II1321 : std_logic;
	signal II1324 : std_logic;
	signal II1389 : std_logic;
	signal II1392 : std_logic;
	signal II1457 : std_logic;
	signal II1460 : std_logic;
	signal II1525 : std_logic;
	signal II1528 : std_logic;
	signal II1593 : std_logic;
	signal II1596 : std_logic;
	signal II1661 : std_logic;
	signal II1664 : std_logic;
	signal II1726 : std_logic;
	signal II1698 : std_logic;
	signal II1729 : std_logic;
	signal II2008 : std_logic;
	signal II1976 : std_logic;
	signal II1821 : std_logic;
	signal II1833 : std_logic;
	signal II1841 : std_logic;
	signal P_6 : std_logic;
	signal II1865 : std_logic;
	signal II1885 : std_logic;
	signal P_17 : std_logic;
	signal II1901 : std_logic;
	signal P_21 : std_logic;
	signal II1905 : std_logic;
	signal P_22 : std_logic;
	signal II1986 : std_logic;
	signal II1990 : std_logic;
	signal II1982 : std_logic;
	signal II1997 : std_logic;
	signal II1950 : std_logic;
	signal II1978 : std_logic;
	signal W : std_logic;

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
	signal SER_BIST_FF_14_ERR_out : std_ulogic;
	signal SER_BIST_FF_15_ERR_out : std_ulogic;
	signal SER_BIST_FF_16_ERR_out : std_ulogic;
	signal SER_BIST_FF_17_ERR_out : std_ulogic;
	signal SER_BIST_FF_18_ERR_out : std_ulogic;
	signal SER_BIST_FF_19_ERR_out : std_ulogic;
	signal SER_BIST_FF_20_ERR_out : std_ulogic;
	signal SER_BIST_FF_21_ERR_out : std_ulogic;
	signal SER_BIST_FF_22_ERR_out : std_ulogic;
	signal SER_BIST_FF_23_ERR_out : std_ulogic;
	signal SER_BIST_FF_24_ERR_out : std_ulogic;
	signal SER_BIST_FF_25_ERR_out : std_ulogic;
	signal SER_BIST_FF_26_ERR_out : std_ulogic;
	signal SER_BIST_FF_27_ERR_out : std_ulogic;
	signal SER_BIST_FF_28_ERR_out : std_ulogic;
	signal SER_BIST_FF_29_ERR_out : std_ulogic;
	signal SER_BIST_FF_30_ERR_out : std_ulogic;
	signal SER_BIST_FF_31_ERR_out : std_ulogic;
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
	signal SER_BIST_FF_14_Scan_out : std_ulogic;
	signal SER_BIST_FF_15_Scan_out : std_ulogic;
	signal SER_BIST_FF_16_Scan_out : std_ulogic;
	signal SER_BIST_FF_17_Scan_out : std_ulogic;
	signal SER_BIST_FF_18_Scan_out : std_ulogic;
	signal SER_BIST_FF_19_Scan_out : std_ulogic;
	signal SER_BIST_FF_20_Scan_out : std_ulogic;
	signal SER_BIST_FF_21_Scan_out : std_ulogic;
	signal SER_BIST_FF_22_Scan_out : std_ulogic;
	signal SER_BIST_FF_23_Scan_out : std_ulogic;
	signal SER_BIST_FF_24_Scan_out : std_ulogic;
	signal SER_BIST_FF_25_Scan_out : std_ulogic;
	signal SER_BIST_FF_26_Scan_out : std_ulogic;
	signal SER_BIST_FF_27_Scan_out : std_ulogic;
	signal SER_BIST_FF_28_Scan_out : std_ulogic;
	signal SER_BIST_FF_29_Scan_out : std_ulogic;
	signal SER_BIST_FF_30_Scan_out : std_ulogic;
	signal SER_BIST_FF_31_Scan_out : std_ulogic;

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


--Flip-flops (total number: 32)
SER_BIST_FF_0:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II309, 
 			Q_in		=> Y_29, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> ctrl_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_0_ERR_out, 
 			Scan_out	=> SER_BIST_FF_0_Scan_out, 
 			Q_out		=> Y_10 
 		);

SER_BIST_FF_1:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II3, 
 			Q_in		=> Y_10, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_0_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_1_ERR_out, 
 			Scan_out	=> SER_BIST_FF_1_Scan_out, 
 			Q_out		=> Y_4 
 		);

SER_BIST_FF_2:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II6, 
 			Q_in		=> Y_4, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_1_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_2_ERR_out, 
 			Scan_out	=> SER_BIST_FF_2_Scan_out, 
 			Q_out		=> Y_1 
 		);

SER_BIST_FF_3:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II155, 
 			Q_in		=> Y_1, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_2_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_3_ERR_out, 
 			Scan_out	=> SER_BIST_FF_3_Scan_out, 
 			Q_out		=> Y_8 
 		);

SER_BIST_FF_4:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II307, 
 			Q_in		=> Y_8, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_3_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_4_ERR_out, 
 			Scan_out	=> SER_BIST_FF_4_Scan_out, 
 			Q_out		=> Y_12 
 		);

SER_BIST_FF_5:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II156, 
 			Q_in		=> Y_12, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_4_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_5_ERR_out, 
 			Scan_out	=> SER_BIST_FF_5_Scan_out, 
 			Q_out		=> Y_7 
 		);

SER_BIST_FF_6:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II158, 
 			Q_in		=> Y_7, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_5_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_6_ERR_out, 
 			Scan_out	=> SER_BIST_FF_6_Scan_out, 
 			Q_out		=> Y_5 
 		);

SER_BIST_FF_7:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II5, 
 			Q_in		=> Y_5, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_6_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_7_ERR_out, 
 			Scan_out	=> SER_BIST_FF_7_Scan_out, 
 			Q_out		=> Y_2 
 		);

SER_BIST_FF_8:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II915, 
 			Q_in		=> Y_2, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_7_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_8_ERR_out, 
 			Scan_out	=> SER_BIST_FF_8_Scan_out, 
 			Q_out		=> Y_28 
 		);

SER_BIST_FF_9:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II308, 
 			Q_in		=> Y_28, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_8_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_9_ERR_out, 
 			Scan_out	=> SER_BIST_FF_9_Scan_out, 
 			Q_out		=> Y_11 
 		);

SER_BIST_FF_10:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II460, 
 			Q_in		=> Y_11, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_9_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_10_ERR_out, 
 			Scan_out	=> SER_BIST_FF_10_Scan_out, 
 			Q_out		=> Y_15 
 		);

SER_BIST_FF_11:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II310, 
 			Q_in		=> Y_15, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_10_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_11_ERR_out, 
 			Scan_out	=> SER_BIST_FF_11_Scan_out, 
 			Q_out		=> Y_9 
 		);

SER_BIST_FF_12:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II459, 
 			Q_in		=> Y_9, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_11_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_12_ERR_out, 
 			Scan_out	=> SER_BIST_FF_12_Scan_out, 
 			Q_out		=> Y_16 
 		);

SER_BIST_FF_13:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II157, 
 			Q_in		=> Y_16, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_12_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_13_ERR_out, 
 			Scan_out	=> SER_BIST_FF_13_Scan_out, 
 			Q_out		=> Y_6 
 		);

SER_BIST_FF_14:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II461, 
 			Q_in		=> Y_6, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_13_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_14_ERR_out, 
 			Scan_out	=> SER_BIST_FF_14_Scan_out, 
 			Q_out		=> Y_14 
 		);

SER_BIST_FF_15:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II614, 
 			Q_in		=> Y_14, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_14_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_15_ERR_out, 
 			Scan_out	=> SER_BIST_FF_15_Scan_out, 
 			Q_out		=> Y_17 
 		);

SER_BIST_FF_16:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II1067, 
 			Q_in		=> Y_17, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_15_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_16_ERR_out, 
 			Scan_out	=> SER_BIST_FF_16_Scan_out, 
 			Q_out		=> Y_32 
 		);

SER_BIST_FF_17:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II611, 
 			Q_in		=> Y_32, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_16_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_17_ERR_out, 
 			Scan_out	=> SER_BIST_FF_17_Scan_out, 
 			Q_out		=> Y_20 
 		);

SER_BIST_FF_18:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II613, 
 			Q_in		=> Y_20, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_17_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_18_ERR_out, 
 			Scan_out	=> SER_BIST_FF_18_Scan_out, 
 			Q_out		=> Y_18 
 		);

SER_BIST_FF_19:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II763, 
 			Q_in		=> Y_18, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_18_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_19_ERR_out, 
 			Scan_out	=> SER_BIST_FF_19_Scan_out, 
 			Q_out		=> Y_24 
 		);

SER_BIST_FF_20:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II916, 
 			Q_in		=> Y_24, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_19_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_20_ERR_out, 
 			Scan_out	=> SER_BIST_FF_20_Scan_out, 
 			Q_out		=> Y_27 
 		);

SER_BIST_FF_21:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II765, 
 			Q_in		=> Y_27, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_20_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_21_ERR_out, 
 			Scan_out	=> SER_BIST_FF_21_Scan_out, 
 			Q_out		=> Y_22 
 		);

SER_BIST_FF_22:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II766, 
 			Q_in		=> Y_22, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_21_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_22_ERR_out, 
 			Scan_out	=> SER_BIST_FF_22_Scan_out, 
 			Q_out		=> Y_21 
 		);

SER_BIST_FF_23:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II764, 
 			Q_in		=> Y_21, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_22_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_23_ERR_out, 
 			Scan_out	=> SER_BIST_FF_23_Scan_out, 
 			Q_out		=> Y_23 
 		);

SER_BIST_FF_24:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II4, 
 			Q_in		=> Y_23, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_23_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_24_ERR_out, 
 			Scan_out	=> SER_BIST_FF_24_Scan_out, 
 			Q_out		=> Y_3 
 		);

SER_BIST_FF_25:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II612, 
 			Q_in		=> Y_3, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_24_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_25_ERR_out, 
 			Scan_out	=> SER_BIST_FF_25_Scan_out, 
 			Q_out		=> Y_19 
 		);

SER_BIST_FF_26:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II462, 
 			Q_in		=> Y_19, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_25_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_26_ERR_out, 
 			Scan_out	=> SER_BIST_FF_26_Scan_out, 
 			Q_out		=> Y_13 
 		);

SER_BIST_FF_27:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II917, 
 			Q_in		=> Y_13, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_26_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_27_ERR_out, 
 			Scan_out	=> SER_BIST_FF_27_Scan_out, 
 			Q_out		=> Y_26 
 		);

SER_BIST_FF_28:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II918, 
 			Q_in		=> Y_26, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_27_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_28_ERR_out, 
 			Scan_out	=> SER_BIST_FF_28_Scan_out, 
 			Q_out		=> Y_25 
 		);

SER_BIST_FF_29:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II1068, 
 			Q_in		=> Y_25, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_28_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_29_ERR_out, 
 			Scan_out	=> SER_BIST_FF_29_Scan_out, 
 			Q_out		=> Y_31 
 		);

SER_BIST_FF_30:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II1069, 
 			Q_in		=> Y_31, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_29_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_30_ERR_out, 
 			Scan_out	=> SER_BIST_FF_30_Scan_out, 
 			Q_out		=> Y_30 
 		);

SER_BIST_FF_31:	lis_ser_bist_ff 
		port map( 
			clk		=> clk, 
 			reset		=> reset, 
 			D_in		=> II1070, 
 			Q_in		=> Y_30, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out, 
 			Scan_in		=> SER_BIST_FF_30_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_31_ERR_out, 
 			Scan_out	=> open, 
 			Q_out		=> Y_29 
 		);

OR_tree_out <= SER_BIST_FF_0_ERR_out OR SER_BIST_FF_1_ERR_out OR SER_BIST_FF_2_ERR_out OR SER_BIST_FF_3_ERR_out OR SER_BIST_FF_4_ERR_out OR SER_BIST_FF_5_ERR_out OR SER_BIST_FF_6_ERR_out OR SER_BIST_FF_7_ERR_out OR SER_BIST_FF_8_ERR_out OR SER_BIST_FF_9_ERR_out OR SER_BIST_FF_10_ERR_out OR SER_BIST_FF_11_ERR_out OR SER_BIST_FF_12_ERR_out OR SER_BIST_FF_13_ERR_out OR SER_BIST_FF_14_ERR_out OR SER_BIST_FF_15_ERR_out OR SER_BIST_FF_16_ERR_out OR SER_BIST_FF_17_ERR_out OR SER_BIST_FF_18_ERR_out OR SER_BIST_FF_19_ERR_out OR SER_BIST_FF_20_ERR_out OR SER_BIST_FF_21_ERR_out OR SER_BIST_FF_22_ERR_out OR SER_BIST_FF_23_ERR_out OR SER_BIST_FF_24_ERR_out OR SER_BIST_FF_25_ERR_out OR SER_BIST_FF_26_ERR_out OR SER_BIST_FF_27_ERR_out OR SER_BIST_FF_28_ERR_out OR SER_BIST_FF_29_ERR_out OR SER_BIST_FF_30_ERR_out OR SER_BIST_FF_31_ERR_out;

--Inverters (total number: 149)
INV_0:	 lis_not port map( A => II104, Z => II6 );
INV_1:	 lis_not port map( A => II92, Z => II50 );
INV_2:	 lis_not port map( A => X, Z => II40 );
INV_3:	 lis_not port map( A => Y_4, Z => II41 );
INV_4:	 lis_not port map( A => Y_3, Z => II42 );
INV_5:	 lis_not port map( A => Y_2, Z => II43 );
INV_6:	 lis_not port map( A => Y_1, Z => II44 );
INV_7:	 lis_not port map( A => II46, Z => II3 );
INV_8:	 lis_not port map( A => II47, Z => II4 );
INV_9:	 lis_not port map( A => II256, Z => II158 );
INV_10:	 lis_not port map( A => II244, Z => II202 );
INV_11:	 lis_not port map( A => II1_1, Z => II192 );
INV_12:	 lis_not port map( A => Y_8, Z => II193 );
INV_13:	 lis_not port map( A => Y_7, Z => II194 );
INV_14:	 lis_not port map( A => Y_6, Z => II195 );
INV_15:	 lis_not port map( A => Y_5, Z => II196 );
INV_16:	 lis_not port map( A => II198, Z => II155 );
INV_17:	 lis_not port map( A => II199, Z => II156 );
INV_18:	 lis_not port map( A => II408, Z => II310 );
INV_19:	 lis_not port map( A => II396, Z => II354 );
INV_20:	 lis_not port map( A => II1_2, Z => II344 );
INV_21:	 lis_not port map( A => Y_12, Z => II345 );
INV_22:	 lis_not port map( A => Y_11, Z => II346 );
INV_23:	 lis_not port map( A => Y_10, Z => II347 );
INV_24:	 lis_not port map( A => Y_9, Z => II348 );
INV_25:	 lis_not port map( A => II350, Z => II307 );
INV_26:	 lis_not port map( A => II351, Z => II308 );
INV_27:	 lis_not port map( A => II560, Z => II462 );
INV_28:	 lis_not port map( A => II548, Z => II506 );
INV_29:	 lis_not port map( A => II1_3, Z => II496 );
INV_30:	 lis_not port map( A => Y_16, Z => II497 );
INV_31:	 lis_not port map( A => Y_15, Z => II498 );
INV_32:	 lis_not port map( A => Y_14, Z => II499 );
INV_33:	 lis_not port map( A => Y_13, Z => II500 );
INV_34:	 lis_not port map( A => II502, Z => II459 );
INV_35:	 lis_not port map( A => II503, Z => II460 );
INV_36:	 lis_not port map( A => II712, Z => II614 );
INV_37:	 lis_not port map( A => II700, Z => II658 );
INV_38:	 lis_not port map( A => II1_4, Z => II648 );
INV_39:	 lis_not port map( A => Y_20, Z => II649 );
INV_40:	 lis_not port map( A => Y_19, Z => II650 );
INV_41:	 lis_not port map( A => Y_18, Z => II651 );
INV_42:	 lis_not port map( A => Y_17, Z => II652 );
INV_43:	 lis_not port map( A => II654, Z => II611 );
INV_44:	 lis_not port map( A => II655, Z => II612 );
INV_45:	 lis_not port map( A => II864, Z => II766 );
INV_46:	 lis_not port map( A => II852, Z => II810 );
INV_47:	 lis_not port map( A => II1_5, Z => II800 );
INV_48:	 lis_not port map( A => Y_24, Z => II801 );
INV_49:	 lis_not port map( A => Y_23, Z => II802 );
INV_50:	 lis_not port map( A => Y_22, Z => II803 );
INV_51:	 lis_not port map( A => Y_21, Z => II804 );
INV_52:	 lis_not port map( A => II806, Z => II763 );
INV_53:	 lis_not port map( A => II807, Z => II764 );
INV_54:	 lis_not port map( A => II1016, Z => II918 );
INV_55:	 lis_not port map( A => II1004, Z => II962 );
INV_56:	 lis_not port map( A => II1_6, Z => II952 );
INV_57:	 lis_not port map( A => Y_28, Z => II953 );
INV_58:	 lis_not port map( A => Y_27, Z => II954 );
INV_59:	 lis_not port map( A => Y_26, Z => II955 );
INV_60:	 lis_not port map( A => Y_25, Z => II956 );
INV_61:	 lis_not port map( A => II958, Z => II915 );
INV_62:	 lis_not port map( A => II959, Z => II916 );
INV_63:	 lis_not port map( A => II1168, Z => II1070 );
INV_64:	 lis_not port map( A => II1156, Z => II1114 );
INV_65:	 lis_not port map( A => II1_7, Z => II1104 );
INV_66:	 lis_not port map( A => Y_32, Z => II1105 );
INV_67:	 lis_not port map( A => Y_31, Z => II1106 );
INV_68:	 lis_not port map( A => Y_30, Z => II1107 );
INV_69:	 lis_not port map( A => Y_29, Z => II1108 );
INV_70:	 lis_not port map( A => II1110, Z => II1067 );
INV_71:	 lis_not port map( A => II1111, Z => II1068 );
INV_72:	 lis_not port map( A => II1253, Z => II1219_1 );
INV_73:	 lis_not port map( A => II1253, Z => II1230 );
INV_74:	 lis_not port map( A => Y_1, Z => II1221 );
INV_75:	 lis_not port map( A => Y_2, Z => II1222 );
INV_76:	 lis_not port map( A => Y_3, Z => II1223 );
INV_77:	 lis_not port map( A => II1226, Z => P_1 );
INV_78:	 lis_not port map( A => II1228, Z => P_3 );
INV_79:	 lis_not port map( A => II1229, Z => P_4 );
INV_80:	 lis_not port map( A => II1316, Z => II1219_2 );
INV_81:	 lis_not port map( A => II1316, Z => II1290 );
INV_82:	 lis_not port map( A => Y_4, Z => II1280 );
INV_83:	 lis_not port map( A => Y_5, Z => II1281 );
INV_84:	 lis_not port map( A => Y_6, Z => II1282 );
INV_85:	 lis_not port map( A => Y_7, Z => II1283 );
INV_86:	 lis_not port map( A => II1288, Z => P_7 );
INV_87:	 lis_not port map( A => II1289, Z => P_8 );
INV_88:	 lis_not port map( A => II1328, Z => II1329 );
INV_89:	 lis_not port map( A => II1384, Z => II1219_3 );
INV_90:	 lis_not port map( A => II1384, Z => II1358 );
INV_91:	 lis_not port map( A => Y_8, Z => II1348 );
INV_92:	 lis_not port map( A => Y_9, Z => II1349 );
INV_93:	 lis_not port map( A => Y_10, Z => II1350 );
INV_94:	 lis_not port map( A => Y_11, Z => II1351 );
INV_95:	 lis_not port map( A => II1356, Z => P_11 );
INV_96:	 lis_not port map( A => II1357, Z => P_12 );
INV_97:	 lis_not port map( A => II1396, Z => II1397 );
INV_98:	 lis_not port map( A => II1452, Z => II1219_4 );
INV_99:	 lis_not port map( A => II1452, Z => II1426 );
INV_100:	 lis_not port map( A => Y_12, Z => II1416 );
INV_101:	 lis_not port map( A => Y_13, Z => II1417 );
INV_102:	 lis_not port map( A => Y_14, Z => II1418 );
INV_103:	 lis_not port map( A => Y_15, Z => II1419 );
INV_104:	 lis_not port map( A => II1424, Z => P_15 );
INV_105:	 lis_not port map( A => II1425, Z => P_16 );
INV_106:	 lis_not port map( A => II1464, Z => II1465 );
INV_107:	 lis_not port map( A => II1520, Z => II1219_5 );
INV_108:	 lis_not port map( A => II1520, Z => II1494 );
INV_109:	 lis_not port map( A => Y_16, Z => II1484 );
INV_110:	 lis_not port map( A => Y_17, Z => II1485 );
INV_111:	 lis_not port map( A => Y_18, Z => II1486 );
INV_112:	 lis_not port map( A => Y_19, Z => II1487 );
INV_113:	 lis_not port map( A => II1492, Z => P_19 );
INV_114:	 lis_not port map( A => II1493, Z => P_20 );
INV_115:	 lis_not port map( A => II1532, Z => II1533 );
INV_116:	 lis_not port map( A => II1588, Z => II1219_6 );
INV_117:	 lis_not port map( A => II1588, Z => II1562 );
INV_118:	 lis_not port map( A => Y_20, Z => II1552 );
INV_119:	 lis_not port map( A => Y_21, Z => II1553 );
INV_120:	 lis_not port map( A => Y_22, Z => II1554 );
INV_121:	 lis_not port map( A => Y_23, Z => II1555 );
INV_122:	 lis_not port map( A => II1560, Z => P_23 );
INV_123:	 lis_not port map( A => II1561, Z => P_24 );
INV_124:	 lis_not port map( A => II1600, Z => II1601 );
INV_125:	 lis_not port map( A => II1656, Z => II1219_7 );
INV_126:	 lis_not port map( A => II1656, Z => II1630 );
INV_127:	 lis_not port map( A => Y_24, Z => II1620 );
INV_128:	 lis_not port map( A => Y_25, Z => II1621 );
INV_129:	 lis_not port map( A => Y_26, Z => II1622 );
INV_130:	 lis_not port map( A => Y_27, Z => II1623 );
INV_131:	 lis_not port map( A => II1628, Z => P_27 );
INV_132:	 lis_not port map( A => II1629, Z => P_28 );
INV_133:	 lis_not port map( A => II1668, Z => II1669 );
INV_134:	 lis_not port map( A => Y_28, Z => II1688 );
INV_135:	 lis_not port map( A => Y_29, Z => II1689 );
INV_136:	 lis_not port map( A => Y_30, Z => II1690 );
INV_137:	 lis_not port map( A => Y_31, Z => II1691 );
INV_138:	 lis_not port map( A => Y_32, Z => II1692 );
INV_139:	 lis_not port map( A => II1694, Z => P_30 );
INV_140:	 lis_not port map( A => II1948, Z => II1947 );
INV_141:	 lis_not port map( A => II1952, Z => II1951 );
INV_142:	 lis_not port map( A => II1956, Z => II1955 );
INV_143:	 lis_not port map( A => II1964, Z => II1963 );
INV_144:	 lis_not port map( A => II1966, Z => II1965 );
INV_145:	 lis_not port map( A => II1972, Z => II1971 );
INV_146:	 lis_not port map( A => II1974, Z => II1973 );
INV_147:	 lis_not port map( A => II1995, Z => II1996 );
INV_148:	 lis_not port map( A => II2001, Z => II2002 );

--AND-gates (total number: 58)
AND3_0:	 LIS_AND3 port map( A => II41, B => Y_3, C => II109, Z => II127_1 );
AND3_1:	 LIS_AND3 port map( A => II96, B => II113, C => Y_4, Z => II127_2 );
AND3_2:	 LIS_AND3 port map( A => II113, B => II92, C => Y_3, Z => II131_1 );
AND2_0:	 LIS_AND2 port map( A => II42, B => II109, Z => II131_2);
AND3_3:	 LIS_AND3 port map( A => II193, B => Y_7, C => II261, Z => II279_1 );
AND3_4:	 LIS_AND3 port map( A => II248, B => II265, C => Y_8, Z => II279_2 );
AND3_5:	 LIS_AND3 port map( A => II265, B => II244, C => Y_7, Z => II283_1 );
AND2_1:	 LIS_AND2 port map( A => II194, B => II261, Z => II283_2);
AND3_6:	 LIS_AND3 port map( A => II345, B => Y_11, C => II413, Z => II431_1 );
AND3_7:	 LIS_AND3 port map( A => II400, B => II417, C => Y_12, Z => II431_2 );
AND3_8:	 LIS_AND3 port map( A => II417, B => II396, C => Y_11, Z => II435_1 );
AND2_2:	 LIS_AND2 port map( A => II346, B => II413, Z => II435_2);
AND3_9:	 LIS_AND3 port map( A => II497, B => Y_15, C => II565, Z => II583_1 );
AND3_10:	 LIS_AND3 port map( A => II552, B => II569, C => Y_16, Z => II583_2 );
AND3_11:	 LIS_AND3 port map( A => II569, B => II548, C => Y_15, Z => II587_1 );
AND2_3:	 LIS_AND2 port map( A => II498, B => II565, Z => II587_2);
AND3_12:	 LIS_AND3 port map( A => II649, B => Y_19, C => II717, Z => II735_1 );
AND3_13:	 LIS_AND3 port map( A => II704, B => II721, C => Y_20, Z => II735_2 );
AND3_14:	 LIS_AND3 port map( A => II721, B => II700, C => Y_19, Z => II739_1 );
AND2_4:	 LIS_AND2 port map( A => II650, B => II717, Z => II739_2);
AND3_15:	 LIS_AND3 port map( A => II801, B => Y_23, C => II869, Z => II887_1 );
AND3_16:	 LIS_AND3 port map( A => II856, B => II873, C => Y_24, Z => II887_2 );
AND3_17:	 LIS_AND3 port map( A => II873, B => II852, C => Y_23, Z => II891_1 );
AND2_5:	 LIS_AND2 port map( A => II802, B => II869, Z => II891_2);
AND3_18:	 LIS_AND3 port map( A => II953, B => Y_27, C => II1021, Z => II1039_1 );
AND3_19:	 LIS_AND3 port map( A => II1008, B => II1025, C => Y_28, Z => II1039_2 );
AND3_20:	 LIS_AND3 port map( A => II1025, B => II1004, C => Y_27, Z => II1043_1 );
AND2_6:	 LIS_AND2 port map( A => II954, B => II1021, Z => II1043_2);
AND3_21:	 LIS_AND3 port map( A => II1105, B => Y_31, C => II1173, Z => II1191_1 );
AND3_22:	 LIS_AND3 port map( A => II1160, B => II1177, C => Y_32, Z => II1191_2 );
AND3_23:	 LIS_AND3 port map( A => II1177, B => II1156, C => Y_31, Z => II1195_1 );
AND2_7:	 LIS_AND2 port map( A => II1106, B => II1173, Z => II1195_2);
AND2_8:	 LIS_AND2 port map( A => P_29, B => C_29, Z => II2017_1);
AND2_9:	 LIS_AND2 port map( A => P_19, B => C_19, Z => II2017_2);
AND2_10:	 LIS_AND2 port map( A => P_30, B => C_30, Z => II2021_1);
AND2_11:	 LIS_AND2 port map( A => P_31, B => C_31, Z => II2021_2);
AND2_12:	 LIS_AND2 port map( A => P_32, B => C_32, Z => II2025_1);
AND2_13:	 LIS_AND2 port map( A => P_24, B => C_24, Z => II2025_2);
AND2_14:	 LIS_AND2 port map( A => P_23, B => C_23, Z => II2029_1);
AND2_15:	 LIS_AND2 port map( A => P_28, B => C_28, Z => II2032_1);
AND2_16:	 LIS_AND2 port map( A => P_11, B => C_11, Z => II2032_2);
AND2_17:	 LIS_AND2 port map( A => P_15, B => C_15, Z => II2032_3);
AND2_18:	 LIS_AND2 port map( A => P_14, B => C_14, Z => II2037_1);
AND2_19:	 LIS_AND2 port map( A => P_7, B => C_7, Z => II2040_1);
AND2_20:	 LIS_AND2 port map( A => P_18, B => C_18, Z => II2043_1);
AND2_21:	 LIS_AND2 port map( A => P_20, B => C_20, Z => II2043_2);
AND2_22:	 LIS_AND2 port map( A => P_10, B => C_10, Z => II2047_1);
AND2_23:	 LIS_AND2 port map( A => P_3, B => C_3, Z => II2047_2);
AND2_24:	 LIS_AND2 port map( A => P_8, B => C_8, Z => II2051_1);
AND2_25:	 LIS_AND2 port map( A => P_27, B => C_27, Z => II2051_2);
AND2_26:	 LIS_AND2 port map( A => P_26, B => C_26, Z => II2055_1);
AND2_27:	 LIS_AND2 port map( A => P_2, B => C_2, Z => II2055_2);
AND2_28:	 LIS_AND2 port map( A => X, B => C_0, Z => II2059_1);
AND2_29:	 LIS_AND2 port map( A => P_25, B => C_25, Z => II2059_2);
AND2_30:	 LIS_AND2 port map( A => P_16, B => C_16, Z => II2063_1);
AND2_31:	 LIS_AND2 port map( A => P_5, B => C_5, Z => II2063_2);
AND2_32:	 LIS_AND2 port map( A => P_13, B => C_13, Z => II2070_1);
AND2_33:	 LIS_AND2 port map( A => P_9, B => C_9, Z => II2070_2);

--OR-gates (total number: 16)
OR2_0:	 LIS_OR2 port map( A => II43, B => II104, Z => II135_1 );
OR2_1:	 LIS_OR2 port map( A => Y_2, B => II100, Z => II135_2 );
OR2_2:	 LIS_OR2 port map( A => II195, B => II256, Z => II287_1 );
OR2_3:	 LIS_OR2 port map( A => Y_6, B => II252, Z => II287_2 );
OR2_4:	 LIS_OR2 port map( A => II347, B => II408, Z => II439_1 );
OR2_5:	 LIS_OR2 port map( A => Y_10, B => II404, Z => II439_2 );
OR2_6:	 LIS_OR2 port map( A => II499, B => II560, Z => II591_1 );
OR2_7:	 LIS_OR2 port map( A => Y_14, B => II556, Z => II591_2 );
OR2_8:	 LIS_OR2 port map( A => II651, B => II712, Z => II743_1 );
OR2_9:	 LIS_OR2 port map( A => Y_18, B => II708, Z => II743_2 );
OR2_10:	 LIS_OR2 port map( A => II803, B => II864, Z => II895_1 );
OR2_11:	 LIS_OR2 port map( A => Y_22, B => II860, Z => II895_2 );
OR2_12:	 LIS_OR2 port map( A => II955, B => II1016, Z => II1047_1 );
OR2_13:	 LIS_OR2 port map( A => Y_26, B => II1012, Z => II1047_2 );
OR2_14:	 LIS_OR2 port map( A => II1107, B => II1168, Z => II1199_1 );
OR2_15:	 LIS_OR2 port map( A => Y_30, B => II1164, Z => II1199_2 );

--NAND-gates (total number: 89)
NAND2_0: LIS_NAND2 port map( A => II135_1, B => II135_2, Z => II5 );
NAND2_1: LIS_NAND2 port map( A => Y_2, B => Y_1, Z => II92 );
NAND2_2: LIS_NAND2 port map( A => Y_3, B => II50, Z => II96 );
NAND2_3: LIS_NAND2 port map( A => Y_1, B => II113, Z => II100 );
NAND2_4: LIS_NAND2 port map( A => II44, B => II113, Z => II104 );
NAND2_5: LIS_NAND2 port map( A => II287_1, B => II287_2, Z => II157 );
NAND2_6: LIS_NAND2 port map( A => Y_6, B => Y_5, Z => II244 );
NAND2_7: LIS_NAND2 port map( A => Y_7, B => II202, Z => II248 );
NAND2_8: LIS_NAND2 port map( A => Y_5, B => II265, Z => II252 );
NAND2_9: LIS_NAND2 port map( A => II196, B => II265, Z => II256 );
NAND2_10: LIS_NAND2 port map( A => II439_1, B => II439_2, Z => II309 );
NAND2_11: LIS_NAND2 port map( A => Y_10, B => Y_9, Z => II396 );
NAND2_12: LIS_NAND2 port map( A => Y_11, B => II354, Z => II400 );
NAND2_13: LIS_NAND2 port map( A => Y_9, B => II417, Z => II404 );
NAND2_14: LIS_NAND2 port map( A => II348, B => II417, Z => II408 );
NAND2_15: LIS_NAND2 port map( A => II591_1, B => II591_2, Z => II461 );
NAND2_16: LIS_NAND2 port map( A => Y_14, B => Y_13, Z => II548 );
NAND2_17: LIS_NAND2 port map( A => Y_15, B => II506, Z => II552 );
NAND2_18: LIS_NAND2 port map( A => Y_13, B => II569, Z => II556 );
NAND2_19: LIS_NAND2 port map( A => II500, B => II569, Z => II560 );
NAND2_20: LIS_NAND2 port map( A => II743_1, B => II743_2, Z => II613 );
NAND2_21: LIS_NAND2 port map( A => Y_18, B => Y_17, Z => II700 );
NAND2_22: LIS_NAND2 port map( A => Y_19, B => II658, Z => II704 );
NAND2_23: LIS_NAND2 port map( A => Y_17, B => II721, Z => II708 );
NAND2_24: LIS_NAND2 port map( A => II652, B => II721, Z => II712 );
NAND2_25: LIS_NAND2 port map( A => II895_1, B => II895_2, Z => II765 );
NAND2_26: LIS_NAND2 port map( A => Y_22, B => Y_21, Z => II852 );
NAND2_27: LIS_NAND2 port map( A => Y_23, B => II810, Z => II856 );
NAND2_28: LIS_NAND2 port map( A => Y_21, B => II873, Z => II860 );
NAND2_29: LIS_NAND2 port map( A => II804, B => II873, Z => II864 );
NAND2_30: LIS_NAND2 port map( A => II1047_1, B => II1047_2, Z => II917 );
NAND2_31: LIS_NAND2 port map( A => Y_26, B => Y_25, Z => II1004 );
NAND2_32: LIS_NAND2 port map( A => Y_27, B => II962, Z => II1008 );
NAND2_33: LIS_NAND2 port map( A => Y_25, B => II1025, Z => II1012 );
NAND2_34: LIS_NAND2 port map( A => II956, B => II1025, Z => II1016 );
NAND2_35: LIS_NAND2 port map( A => II1199_1, B => II1199_2, Z => II1069 );
NAND2_36: LIS_NAND2 port map( A => Y_30, B => Y_29, Z => II1156 );
NAND2_37: LIS_NAND2 port map( A => Y_31, B => II1114, Z => II1160 );
NAND2_38: LIS_NAND2 port map( A => Y_29, B => II1177, Z => II1164 );
NAND2_39: LIS_NAND2 port map( A => II1108, B => II1177, Z => II1168 );
NAND2_40: LIS_NAND2 port map( A => X, B => Y_1, Z => II1226 );
NAND2_41: LIS_NAND2 port map( A => Y_3, B => II1259, Z => II1228 );
NAND2_42: LIS_NAND2 port map( A => Y_4, B => II1230, Z => II1229 );
NAND2_43: LIS_NAND2 port map( A => II1223, B => II1259, Z => II1253 );
NAND2_44: LIS_NAND2 port map( A => X, B => II1221, Z => II1262 );
NAND2_45: LIS_NAND2 port map( A => Y_7, B => II1321, Z => II1288 );
NAND2_46: LIS_NAND2 port map( A => Y_8, B => II1290, Z => II1289 );
NAND2_47: LIS_NAND2 port map( A => II1283, B => II1321, Z => II1316 );
NAND2_48: LIS_NAND2 port map( A => II1281, B => II1329, Z => II1324 );
NAND2_49: LIS_NAND2 port map( A => II1219_1, B => II1280, Z => II1328 );
NAND2_50: LIS_NAND2 port map( A => Y_11, B => II1389, Z => II1356 );
NAND2_51: LIS_NAND2 port map( A => Y_12, B => II1358, Z => II1357 );
NAND2_52: LIS_NAND2 port map( A => II1351, B => II1389, Z => II1384 );
NAND2_53: LIS_NAND2 port map( A => II1349, B => II1397, Z => II1392 );
NAND2_54: LIS_NAND2 port map( A => II1219_2, B => II1348, Z => II1396 );
NAND2_55: LIS_NAND2 port map( A => Y_15, B => II1457, Z => II1424 );
NAND2_56: LIS_NAND2 port map( A => Y_16, B => II1426, Z => II1425 );
NAND2_57: LIS_NAND2 port map( A => II1419, B => II1457, Z => II1452 );
NAND2_58: LIS_NAND2 port map( A => II1417, B => II1465, Z => II1460 );
NAND2_59: LIS_NAND2 port map( A => II1219_3, B => II1416, Z => II1464 );
NAND2_60: LIS_NAND2 port map( A => Y_19, B => II1525, Z => II1492 );
NAND2_61: LIS_NAND2 port map( A => Y_20, B => II1494, Z => II1493 );
NAND2_62: LIS_NAND2 port map( A => II1487, B => II1525, Z => II1520 );
NAND2_63: LIS_NAND2 port map( A => II1485, B => II1533, Z => II1528 );
NAND2_64: LIS_NAND2 port map( A => II1219_4, B => II1484, Z => II1532 );
NAND2_65: LIS_NAND2 port map( A => Y_23, B => II1593, Z => II1560 );
NAND2_66: LIS_NAND2 port map( A => Y_24, B => II1562, Z => II1561 );
NAND2_67: LIS_NAND2 port map( A => II1555, B => II1593, Z => II1588 );
NAND2_68: LIS_NAND2 port map( A => II1553, B => II1601, Z => II1596 );
NAND2_69: LIS_NAND2 port map( A => II1219_5, B => II1552, Z => II1600 );
NAND2_70: LIS_NAND2 port map( A => Y_27, B => II1661, Z => II1628 );
NAND2_71: LIS_NAND2 port map( A => Y_28, B => II1630, Z => II1629 );
NAND2_72: LIS_NAND2 port map( A => II1623, B => II1661, Z => II1656 );
NAND2_73: LIS_NAND2 port map( A => II1621, B => II1669, Z => II1664 );
NAND2_74: LIS_NAND2 port map( A => II1219_6, B => II1620, Z => II1668 );
NAND2_75: LIS_NAND2 port map( A => Y_30, B => II1726, Z => II1694 );
NAND2_76: LIS_NAND2 port map( A => II1726, B => II1690, Z => II1698 );
NAND2_77: LIS_NAND2 port map( A => II1688, B => II1219_7, Z => II1729 );
NAND4_0: LIS_NAND4 port map( A => II2002, B => II2008, C => II1996, D => II1976, Z => Z );
NAND2_78: LIS_NAND2 port map( A => P_1, B => C_1, Z => II1821 );
NAND2_79: LIS_NAND2 port map( A => P_4, B => C_4, Z => II1833 );
NAND2_80: LIS_NAND2 port map( A => P_6, B => C_6, Z => II1841 );
NAND2_81: LIS_NAND2 port map( A => P_12, B => C_12, Z => II1865 );
NAND2_82: LIS_NAND2 port map( A => P_17, B => C_17, Z => II1885 );
NAND2_83: LIS_NAND2 port map( A => P_21, B => C_21, Z => II1901 );
NAND2_84: LIS_NAND2 port map( A => P_22, B => C_22, Z => II1905 );
NAND4_1: LIS_NAND4 port map( A => II1986, B => II1990, C => II1982, D => II1885, Z => II1995 );
NAND4_2: LIS_NAND4 port map( A => II1950, B => II1833, C => II1821, D => II1905, Z => II1997 );
NAND4_3: LIS_NAND4 port map( A => II1865, B => II1841, C => II1978, D => II1901, Z => II2001 );

--NOR-gates (total number: 78)
NOR2_0:	 LIS_NOR2 port map( A => II41, B => II96, Z => II1_1 );
NOR2_1:	 LIS_NOR2 port map( A => II127_1, B => II127_2, Z => II46 );
NOR2_2:	 LIS_NOR2 port map( A => II131_1, B => II131_2, Z => II47 );
NOR2_3:	 LIS_NOR2 port map( A => II43, B => II100, Z => II109 );
NOR2_4:	 LIS_NOR2 port map( A => Clear, B => II40, Z => II113 );
NOR2_5:	 LIS_NOR2 port map( A => II193, B => II248, Z => II1_2 );
NOR2_6:	 LIS_NOR2 port map( A => II279_1, B => II279_2, Z => II198 );
NOR2_7:	 LIS_NOR2 port map( A => II283_1, B => II283_2, Z => II199 );
NOR2_8:	 LIS_NOR2 port map( A => II195, B => II252, Z => II261 );
NOR2_9:	 LIS_NOR2 port map( A => Clear, B => II192, Z => II265 );
NOR2_10:	 LIS_NOR2 port map( A => II345, B => II400, Z => II1_3 );
NOR2_11:	 LIS_NOR2 port map( A => II431_1, B => II431_2, Z => II350 );
NOR2_12:	 LIS_NOR2 port map( A => II435_1, B => II435_2, Z => II351 );
NOR2_13:	 LIS_NOR2 port map( A => II347, B => II404, Z => II413 );
NOR2_14:	 LIS_NOR2 port map( A => Clear, B => II344, Z => II417 );
NOR2_15:	 LIS_NOR2 port map( A => II497, B => II552, Z => II1_4 );
NOR2_16:	 LIS_NOR2 port map( A => II583_1, B => II583_2, Z => II502 );
NOR2_17:	 LIS_NOR2 port map( A => II587_1, B => II587_2, Z => II503 );
NOR2_18:	 LIS_NOR2 port map( A => II499, B => II556, Z => II565 );
NOR2_19:	 LIS_NOR2 port map( A => Clear, B => II496, Z => II569 );
NOR2_20:	 LIS_NOR2 port map( A => II649, B => II704, Z => II1_5 );
NOR2_21:	 LIS_NOR2 port map( A => II735_1, B => II735_2, Z => II654 );
NOR2_22:	 LIS_NOR2 port map( A => II739_1, B => II739_2, Z => II655 );
NOR2_23:	 LIS_NOR2 port map( A => II651, B => II708, Z => II717 );
NOR2_24:	 LIS_NOR2 port map( A => Clear, B => II648, Z => II721 );
NOR2_25:	 LIS_NOR2 port map( A => II801, B => II856, Z => II1_6 );
NOR2_26:	 LIS_NOR2 port map( A => II887_1, B => II887_2, Z => II806 );
NOR2_27:	 LIS_NOR2 port map( A => II891_1, B => II891_2, Z => II807 );
NOR2_28:	 LIS_NOR2 port map( A => II803, B => II860, Z => II869 );
NOR2_29:	 LIS_NOR2 port map( A => Clear, B => II800, Z => II873 );
NOR2_30:	 LIS_NOR2 port map( A => II953, B => II1008, Z => II1_7 );
NOR2_31:	 LIS_NOR2 port map( A => II1039_1, B => II1039_2, Z => II958 );
NOR2_32:	 LIS_NOR2 port map( A => II1043_1, B => II1043_2, Z => II959 );
NOR2_33:	 LIS_NOR2 port map( A => II955, B => II1012, Z => II1021 );
NOR2_34:	 LIS_NOR2 port map( A => Clear, B => II952, Z => II1025 );
NOR2_35:	 LIS_NOR2 port map( A => II1105, B => II1160, Z => W );
NOR2_36:	 LIS_NOR2 port map( A => II1191_1, B => II1191_2, Z => II1110 );
NOR2_37:	 LIS_NOR2 port map( A => II1195_1, B => II1195_2, Z => II1111 );
NOR2_38:	 LIS_NOR2 port map( A => II1107, B => II1164, Z => II1173 );
NOR2_39:	 LIS_NOR2 port map( A => Clear, B => II1104, Z => II1177 );
NOR2_40:	 LIS_NOR2 port map( A => II1222, B => II1262, Z => P_2 );
NOR2_41:	 LIS_NOR2 port map( A => Y_2, B => II1262, Z => II1259 );
NOR2_42:	 LIS_NOR2 port map( A => II1281, B => II1328, Z => P_5 );
NOR2_43:	 LIS_NOR2 port map( A => II1282, B => II1324, Z => P_6 );
NOR2_44:	 LIS_NOR2 port map( A => Y_6, B => II1324, Z => II1321 );
NOR2_45:	 LIS_NOR2 port map( A => II1349, B => II1396, Z => P_9 );
NOR2_46:	 LIS_NOR2 port map( A => II1350, B => II1392, Z => P_10 );
NOR2_47:	 LIS_NOR2 port map( A => Y_10, B => II1392, Z => II1389 );
NOR2_48:	 LIS_NOR2 port map( A => II1417, B => II1464, Z => P_13 );
NOR2_49:	 LIS_NOR2 port map( A => II1418, B => II1460, Z => P_14 );
NOR2_50:	 LIS_NOR2 port map( A => Y_14, B => II1460, Z => II1457 );
NOR2_51:	 LIS_NOR2 port map( A => II1485, B => II1532, Z => P_17 );
NOR2_52:	 LIS_NOR2 port map( A => II1486, B => II1528, Z => P_18 );
NOR2_53:	 LIS_NOR2 port map( A => Y_18, B => II1528, Z => II1525 );
NOR2_54:	 LIS_NOR2 port map( A => II1553, B => II1600, Z => P_21 );
NOR2_55:	 LIS_NOR2 port map( A => II1554, B => II1596, Z => P_22 );
NOR2_56:	 LIS_NOR2 port map( A => Y_22, B => II1596, Z => II1593 );
NOR2_57:	 LIS_NOR2 port map( A => II1621, B => II1668, Z => P_25 );
NOR2_58:	 LIS_NOR2 port map( A => II1622, B => II1664, Z => P_26 );
NOR2_59:	 LIS_NOR2 port map( A => Y_26, B => II1664, Z => II1661 );
NOR2_60:	 LIS_NOR2 port map( A => II1689, B => II1729, Z => P_29 );
NOR2_61:	 LIS_NOR2 port map( A => II1691, B => II1698, Z => P_31 );
NOR3_0:	 LIS_NOR3 port map( A => Y_31, B => II1698, C => II1692, Z => P_32 );
NOR2_62:	 LIS_NOR2 port map( A => II1729, B => Y_29, Z => II1726 );
NOR2_63:	 LIS_NOR2 port map( A => II2017_1, B => II2017_2, Z => II1948 );
NOR2_64:	 LIS_NOR2 port map( A => II2021_1, B => II2021_2, Z => II1950 );
NOR2_65:	 LIS_NOR2 port map( A => II2025_1, B => II2025_2, Z => II1952 );
NOR2_66:	 LIS_NOR2 port map( A => II1951, B => II2029_1, Z => II1956 );
NOR3_1:	 LIS_NOR3 port map( A => II2032_1, B => II2032_2, C => II2032_3, Z => II1964 );
NOR2_67:	 LIS_NOR2 port map( A => II1955, B => II2037_1, Z => II1966 );
NOR2_68:	 LIS_NOR2 port map( A => II1947, B => II2040_1, Z => II1972 );
NOR2_69:	 LIS_NOR2 port map( A => II2043_1, B => II2043_2, Z => II1974 );
NOR3_2:	 LIS_NOR3 port map( A => II2047_1, B => II2047_2, C => II1963, Z => II1976 );
NOR3_3:	 LIS_NOR3 port map( A => II2051_1, B => II2051_2, C => II1971, Z => II1978 );
NOR3_4:	 LIS_NOR3 port map( A => II2055_1, B => II2055_2, C => II1965, Z => II1982 );
NOR2_70:	 LIS_NOR2 port map( A => II2059_1, B => II2059_2, Z => II1986 );
NOR3_5:	 LIS_NOR3 port map( A => II2063_1, B => II2063_2, C => II1973, Z => II1990 );
NOR3_6:	 LIS_NOR3 port map( A => II2070_1, B => II2070_2, C => II1997, Z => II2008 );

end architecture;
