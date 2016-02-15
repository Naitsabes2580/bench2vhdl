------------------------------------------------------------------------
--#LIS#
--Author: Sebastian Kroesche
--Date: 22.1.2016 
--Description: Implementation of ISCAS89 s27 circuit with
--             D-type flip-flops
--             generated with bench2vhdl
--Circuit statistics
--# 4 inputs
--# 1 outputs
--# 3 D-type flipflops
--# 2 inverters
--# 8 gates (1 ANDs + 1 NANDs + 2 ORs + 4 NORs)
------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
 
library lis_lib;
use lis_lib.ser_bist.all; 
 
entity s27 is
	port (
		clk : in std_logic; 
		reset : in std_logic; 
		G0: in std_logic; 
		G1: in std_logic; 
		G2: in std_logic; 
		G3: in std_logic; 
		G17: out std_logic 
	);
end entity; 

architecture rtl of s27 is

	signal G10 : std_logic;
	signal G5 : std_logic;
	signal G11 : std_logic;
	signal G6 : std_logic;
	signal G13 : std_logic;
	signal G7 : std_logic;
	signal G14 : std_logic;
	signal G8 : std_logic;
	signal G15 : std_logic;
	signal G12 : std_logic;
	signal G16 : std_logic;
	signal G9 : std_logic;
	signal G2 : std_logic;

begin

--Flip-flops (total number: 3)
DFF_0:	 lis_dff port map( clk => clk, Q_out => G5, D_in => G10, reset => reset );
DFF_1:	 lis_dff port map( clk => clk, Q_out => G6, D_in => G11, reset => reset );
DFF_2:	 lis_dff port map( clk => clk, Q_out => G7, D_in => G13, reset => reset );

--Inverters (total number: 2)
INV_0:	 lis_not port map( A => G0, Z => G14 );
INV_1:	 lis_not port map( A => G11, Z => G17 );

--AND-gates (total number: 1)
AND2_0:	 LIS_AND2 port map( A => G14, B => G6, Z => G8);

--OR-gates (total number: 2)
OR2_0:	 LIS_OR2 port map( A => G12, B => G8, Z => G15 );
OR2_1:	 LIS_OR2 port map( A => G3, B => G8, Z => G16 );

--NAND-gates (total number: 1)
NAND2_0: LIS_NAND2 port map( A => G16, B => G15, Z => G9 );

--NOR-gates (total number: 4)
NOR2_0:	 LIS_NOR2 port map( A => G14, B => G11, Z => G10 );
NOR2_1:	 LIS_NOR2 port map( A => G5, B => G9, Z => G11 );
NOR2_2:	 LIS_NOR2 port map( A => G1, B => G7, Z => G12 );
NOR2_3:	 LIS_NOR2 port map( A => G2, B => G12, Z => G13 );

end architecture;
