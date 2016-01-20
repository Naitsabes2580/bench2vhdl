------------------------------------------------------------------------
--#LIS#
--Author: Sebastian Kroesche
--Date: 20.1.2016 
--Description: Implementation of ISCAS89 s298 circuit with
--             D-type flip-flops
--             generated with bench2vhdl
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
 
entity s298 is
port (
clk : in std_logic; 
reset : in std_logic; 
G0: in std_logic; 
G1: in std_logic; 
G2: in std_logic; 
G117: out std_logic; 
G132: out std_logic; 
G66: out std_logic; 
G118: out std_logic; 
G133: out std_logic; 
G67: out std_logic 
);
end entity; 

architecture rtl of s298 is
begin

--Flip-flops (total number: 14)
DFF_0:	 lis_dff port map( clk => clk, Q_out => G10, D_in => G29, reset => reset );
DFF_1:	 lis_dff port map( clk => clk, Q_out => G11, D_in => G30, reset => reset );
DFF_2:	 lis_dff port map( clk => clk, Q_out => G12, D_in => G34, reset => reset );
DFF_3:	 lis_dff port map( clk => clk, Q_out => G13, D_in => G39, reset => reset );
DFF_4:	 lis_dff port map( clk => clk, Q_out => G14, D_in => G44, reset => reset );
DFF_5:	 lis_dff port map( clk => clk, Q_out => G15, D_in => G56, reset => reset );
DFF_6:	 lis_dff port map( clk => clk, Q_out => G16, D_in => G86, reset => reset );
DFF_7:	 lis_dff port map( clk => clk, Q_out => G17, D_in => G92, reset => reset );
DFF_8:	 lis_dff port map( clk => clk, Q_out => G18, D_in => G98, reset => reset );
DFF_9:	 lis_dff port map( clk => clk, Q_out => G19, D_in => G102, reset => reset );
DFF_10:	 lis_dff port map( clk => clk, Q_out => G20, D_in => G107, reset => reset );
DFF_11:	 lis_dff port map( clk => clk, Q_out => G21, D_in => G113, reset => reset );
DFF_12:	 lis_dff port map( clk => clk, Q_out => G22, D_in => G119, reset => reset );
DFF_13:	 lis_dff port map( clk => clk, Q_out => G23, D_in => G125, reset => reset );

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
