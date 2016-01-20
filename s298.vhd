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

--Flip-flops
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

--Inverters
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
end architecture;
