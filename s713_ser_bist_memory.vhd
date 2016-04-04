------------------------------------------------------------------------
--#LIS#
--Author: Sebastian Kroesche
--Date: 04.04.2016 - 11:40:51  
--Description: Pattern/Response ROM for s713_ser_bist circuit 
--             generated with create_ser_bist_memory
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library lis_lib;
use lis_lib.ser_bist.all;

LIBRARY XilinxCoreLib;

entity s713_ser_bist_memory is
	port (
		clk				: in	std_logic;
		reset			: in	std_logic;
		start			: in	std_logic;
		read_address	: in	std_logic_vector(5 downto 0);
		pattern_out		: out	std_logic;
		response_out	: out	std_logic
	);
end s713_ser_bist_memory;

architecture RTL of s713_ser_bist_memory is

	component s713_ser_bist_pattern_rom
	port (
		clka	: in	std_logic;
		addra	: in	std_logic_vector(5 downto 0);
		douta	: in	std_logic_vector(76 downto 0);
	);
	end component;

	component s713_ser_bist_response_rom
	port (
		clka	: in	std_logic;
		addra	: in	std_logic_vector(5 downto 0);
		douta	: in	std_logic_vector(76 downto 0);
	);
	end component;

	signal pat_mem_data, resp_mem_data : std_logic_vector(76 downto 0);

begin

	PAT_MEM: s713_ser_bist_pattern_rom
	port map(
		clka	=> clk,
		addra	=> read_address,
		douta	=> pat_mem_data
	);

	RESP_MEM: s713_ser_bist_pattern_rom
	port map(
		clka	=> clk,
		addra	=> read_address,
		douta	=> pat_mem_data
	);

	PAT_SERIALIZER : lis_parallel_to_serial
	generic map(
		N			=> 77
	)
	port map(
		clk			=> clk,
		reset		=> reset,
		start		=> start,
		parallel_in	=> pat_mem_data,
		serial_out	=> pattern_out
	);

	RESP_SERIALIZER : lis_parallel_to_serial
	generic map(
		N			=> 77
	)
	port map(
		clk			=> clk,
		reset		=> reset,
		start		=> start,
		parallel_in	=> resp_mem_data,
		serial_out	=> pattern_out
	);

end RTL;