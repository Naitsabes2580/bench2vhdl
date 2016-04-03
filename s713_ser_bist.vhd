------------------------------------------------------------------------
--#LIS#
--Author: Sebastian Kroesche
--Date: 03.04.2016 - 13:30:51  
--Description: Implementation of ISCAS89 s713_ser_bist circuit with
--             (4) Combined SER/BIST flip-flop (merges option 2 and 3) 
--             generated with bench2vhdl_complete
--Circuit statistics
--# s713
--# 35 inputs
--# 23 outputs
--# 19 D-type flipflops
--# 254 inverters
--# 139 gates (94 ANDs + 28 NANDs + 17 ORs + 0 NORs)
------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
 
library lis_lib;
use lis_lib.ser_bist.all; 
 
entity s713_ser_bist is
	generic (
		NUM_FF : integer := 77;
		BIST_LENGTH : integer := 5000
	);
	port (
		clk : in std_logic; 
		reset : in std_logic; 
		G1: in std_logic; 
		G2: in std_logic; 
		G3: in std_logic; 
		G4: in std_logic; 
		G5: in std_logic; 
		G6: in std_logic; 
		G8: in std_logic; 
		G9: in std_logic; 
		G10: in std_logic; 
		G11: in std_logic; 
		G12: in std_logic; 
		G13: in std_logic; 
		G14: in std_logic; 
		G15: in std_logic; 
		G16: in std_logic; 
		G17: in std_logic; 
		G18: in std_logic; 
		G19: in std_logic; 
		G20: in std_logic; 
		G21: in std_logic; 
		G22: in std_logic; 
		G23: in std_logic; 
		G24: in std_logic; 
		G25: in std_logic; 
		G26: in std_logic; 
		G27: in std_logic; 
		G28: in std_logic; 
		G29: in std_logic; 
		G30: in std_logic; 
		G31: in std_logic; 
		G32: in std_logic; 
		G33: in std_logic; 
		G34: in std_logic; 
		G35: in std_logic; 
		G36: in std_logic; 
		BIST_start_in: in std_logic; 
		Capture_in : in std_logic;
		Capture_out : out std_logic;
		err_code : out std_logic_vector(TBA downto 0);
		G103BF: out std_logic; 
		G104BF: out std_logic; 
		G105BF: out std_logic; 
		G106BF: out std_logic; 
		G107: out std_logic; 
		G83: out std_logic; 
		G84: out std_logic; 
		G85: out std_logic; 
		G86BF: out std_logic; 
		G87BF: out std_logic; 
		G88BF: out std_logic; 
		G89BF: out std_logic; 
		G90: out std_logic; 
		G91: out std_logic; 
		G92: out std_logic; 
		G94: out std_logic; 
		G95BF: out std_logic; 
		G96BF: out std_logic; 
		G97BF: out std_logic; 
		G98BF: out std_logic; 
		G99BF: out std_logic; 
		G100BF: out std_logic; 
		G101BF: out std_logic; 
		BIST_done_out: out std_logic; 
		BIST_result_out: out std_logic 
	);
end entity; 

architecture rtl of s713_ser_bist is

	signal G380, G64, G262, G65, G394, G66, G250, G67, G122, G68, G133, G69, G138, G70, G139, G71, G140, G72, G141, G73, G142, G74, G125, G75, G126, G76, G127, G77, G128, G78, G129, G79, G130, G80, G131, G81, G132, G82, I633, G366, G379, I643, I646, I649, I652, I655, I660, I680, I684, I687, I165, II178, I169, G113, I172, G115, I175, G117, I178, G219, I181, G119, I184, G221, I187, G121, I190, G223, I193, G209, I196, G109, I199, G211, I202, G111, I205, G213, I208, G215, I211, G217, G352, G360, G361, G362, G363, G364, G367, G386, G388, G389, G110, G114, G118, G216, G218, G220, G222, G365, G368, G387, G225, G390, G289, I356, G324, I254, G166, I257, G325, G338, I260, G194, I263, G339, G344, I266, G202, I269, G345, G312, I272, G313, G315, I275, G316, G318, I278, G319, G321, I281, G322, G143, I287, G381, I291, G375, I295, G371, I303, G350, G281, I299, G283, I313, G382, G100, G376, G98, G372, G96, I301, I315, G135, I321, G329, G137, I324, G333, G87, I406, G89, I422, G173, G183, I335, G174, I338, G184, I341, G355, G359, G356, G108, G116, G293, I354, G146, I357, G294, G309, I360, G162, I363, G310, G341, I366, G198, I369, G342, G303, I372, G154, I375, G304, I378, G383, I382, G396, I386, G373, I390, G392, G384, G101, G397, G106, G374, G97, G393, G104, II476, G278, I279, G224, G282, I306, G286, I334, G285, I327, G268, II208, I308, I336, I329, I210, G136, I442, G331, G88, I414, G178, I449, G179, I452, G357, G358, G112, G335, I460, G190, I463, G336, G306, I466, G158, I469, G307, I472, G377, I476, G378, G99, G395, G105, G277, II272, G276, I265, G284, I320, G279, I285, G280, I292, I322, II287, I294, G134, I517, G327, G86, I398, G168, I524, G169, I527, G353, G354, G120, G347, I535, G206, I538, G348, G300, I541, G150, I544, G301, I547, G369, I551, G370, G95, G391, G103, G271, I230, G275, I258, G288, I348, G287, II341, G270, I222, I350, I343, G272, I237, G273, I244, G274, I251, I224, G124, I608, G298, G231, G232, G233, G234, G247, G248, G263, G264, G214, G210, G240, G266, G229, G245, G253, I533, G227, G243, G249, G265, G236, G237, G252, II527, G212, G251, I512, II538, G228, G244, G256, G230, G235, G246, I515, G261, G208, I495, G255, G257, I537, G226, G242, I553, G241, G267, G238, G239, G254, I518, I521, II524, G258, G259, G260, I546, I300, I314, I307, II335, I328, I209, II321, I286, I293, I349, I342, I223 : std_logic;

	signal input_mux_sel, MUX_G1_chain_out, G1_muxed, MUX_G2_chain_out, G2_muxed, MUX_G3_chain_out, G3_muxed, MUX_G4_chain_out, G4_muxed, MUX_G5_chain_out, G5_muxed, MUX_G6_chain_out, G6_muxed, MUX_G8_chain_out, G8_muxed, MUX_G9_chain_out, G9_muxed, MUX_G10_chain_out, G10_muxed, MUX_G11_chain_out, G11_muxed, MUX_G12_chain_out, G12_muxed, MUX_G13_chain_out, G13_muxed, MUX_G14_chain_out, G14_muxed, MUX_G15_chain_out, G15_muxed, MUX_G16_chain_out, G16_muxed, MUX_G17_chain_out, G17_muxed, MUX_G18_chain_out, G18_muxed, MUX_G19_chain_out, G19_muxed, MUX_G20_chain_out, G20_muxed, MUX_G21_chain_out, G21_muxed, MUX_G22_chain_out, G22_muxed, MUX_G23_chain_out, G23_muxed, MUX_G24_chain_out, G24_muxed, MUX_G25_chain_out, G25_muxed, MUX_G26_chain_out, G26_muxed, MUX_G27_chain_out, G27_muxed, MUX_G28_chain_out, G28_muxed, MUX_G29_chain_out, G29_muxed, MUX_G30_chain_out, G30_muxed, MUX_G31_chain_out, G31_muxed, MUX_G32_chain_out, G32_muxed, MUX_G33_chain_out, G33_muxed, MUX_G34_chain_out, G34_muxed, MUX_G35_chain_out, G35_muxed, MUX_G36_chain_out, G36_muxed, mux_reset : std_logic;

	signal G103BF_temp, PO_DFF_0_out, G104BF_temp, PO_DFF_1_out, G105BF_temp, PO_DFF_2_out, G106BF_temp, PO_DFF_3_out, G107_temp, PO_DFF_4_out, G83_temp, PO_DFF_5_out, G84_temp, PO_DFF_6_out, G85_temp, PO_DFF_7_out, G86BF_temp, PO_DFF_8_out, G87BF_temp, PO_DFF_9_out, G88BF_temp, PO_DFF_10_out, G89BF_temp, PO_DFF_11_out, G90_temp, PO_DFF_12_out, G91_temp, PO_DFF_13_out, G92_temp, PO_DFF_14_out, G94_temp, PO_DFF_15_out, G95BF_temp, PO_DFF_16_out, G96BF_temp, PO_DFF_17_out, G97BF_temp, PO_DFF_18_out, G98BF_temp, PO_DFF_19_out, G99BF_temp, PO_DFF_20_out, G100BF_temp, PO_DFF_21_out, G101BF_temp, PO_DFF_22_out : std_logic;

	signal OR_tree_out, spc_par_ok_out, ctrl_read_memory_out, ctrl_Hold_out, ctrl_par_hold_out, ctrl_par_reset_out, ctrl_Rollback_out, ctrl_BIST_eval_out, ctrl_B0_out, ctrl_B1_out, ctrl_Capture_out, ctrl_err_code_out, ctrl_Scan_out, ctrl_AFF_scan_out, HFF_mux_sel : std_logic;
	signal ctrl_read_address_out : std_logic_vector(TBA downto 0);

	signal memory_serializer_reset, mem_pattern_out, mem_response_out : std_ulogic := '0';
	signal AFF_chain_input, AFF_chain_input_MUX_sel : std_ulogic := '0';
begin

	memory_serializer_reset <= reset OR BIST_start_in;

MEM: s713_ser_bist_memory 
		port map( 
			clk				=> clk, 
 			reset			=> memory_serializer_reset, 
 			read_adddress	=> ctrl_read_address_out, 
 			pattern_out		=> mem_pattern_out, 
 			response_out	=> mem_response_out 
 		);



CTRL:	lis_ser_bist_controller
			generic map( 
				NUM_FF				=> NUM_FF,
				BIST_LENGTH			=> BIST_LENGTH,
				MEM_ADDR_WIDTH		=> TBA!,
				SESSION_ROM_LOWER	=> "TBA!",
				SESSION_ROM_UPPER	=> "TBA!",
				LOC_ROM_LOWER		=> "TBA!",
				LOC_ROM_UPPER		=> "TBA!" 
			)
			port map( 
				clk				=> clk,
				reset			=> reset,
				ERR_in			=> OR_tree_out,
				parity_ok_in	=> spc_par_ok_out,
				BIST_start_in	=> BIST_start_in,
				Capture_in		=> Capture_in,
				pattern_in		=> mem_pattern_out,
				response_in		=> mem_response_out,
				address_out		=> ctrl_read_address_out,
				read_memory		=> ctrl_read_memory_out,
				Hold_out		=> ctrl_Hold_out,
				par_hold_out	=> ctrl_par_hold_out,
				par_reset_out	=> ctrl_par_reset_out,
				Rollback_out	=> ctrl_Rollback_out,
				BIST_eval_out	=> ctrl_BIST_eval_out,
				B0_out			=> ctrl_B0_out,
				B1_out			=> ctrl_B1_out,
				Capture_out		=> ctrl_Capture_out,
				BIST_done_out	=> BIST_done_out,
				BIST_pass_out	=> BIST_result_out,
				err_code		=> ctrl_err_code_out,
				Scan_out		=> ctrl_Scan_out,
				AFF_Scan_out	=> ctrl_AFF_scan_out
			);


	 err_code		<= ctrl_err_code_out;
	 HFF_MUX_sel	<= ctrl_B1_out OR ctrl_Capture_out ;
--------------------------------------------------------------------------------
--                    START INPUT ISOLATION MUXES                             --
--------------------------------------------------------------------------------

input_mux_sel_proc: process (reset, ctrl_B0_out, ctrl_B1_out)
begin
	input_mux_sel <= NOT( ctrl_B0_out XOR ctrl_B1_out );
	mux_reset <= reset OR ( ctrl_B0_out NOR ctrl_B1_out );
end process;

AFF_chain_input_MUX: lis_mux
port map (
	A_in	=> PO_DFF_22_out,
	B_in	=> ctrl_AFF_scan_out,
	sel_in	=> AFF_chain_input_MUX_sel,
	C_out	=> AFF_chain_input
);

MUX_G1:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G1,
				chain_in		=> AFF_chain_input,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> ctrl_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G1_ERR_out,
				Scan_out		=> MUX_G1_Scan_out,
				mux_out			=> G1_muxed,
				chain_out		=> MUX_G1_chain_out 
			);

MUX_G2:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G2,
				chain_in		=> MUX_G1_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G1_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G2_ERR_out,
				Scan_out		=> MUX_G2_Scan_out,
				mux_out			=> G2_muxed,
				chain_out		=> MUX_G2_chain_out 
			);

MUX_G3:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G3,
				chain_in		=> MUX_G2_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G2_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G3_ERR_out,
				Scan_out		=> MUX_G3_Scan_out,
				mux_out			=> G3_muxed,
				chain_out		=> MUX_G3_chain_out 
			);

MUX_G4:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G4,
				chain_in		=> MUX_G3_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G3_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G4_ERR_out,
				Scan_out		=> MUX_G4_Scan_out,
				mux_out			=> G4_muxed,
				chain_out		=> MUX_G4_chain_out 
			);

MUX_G5:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G5,
				chain_in		=> MUX_G4_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G4_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G5_ERR_out,
				Scan_out		=> MUX_G5_Scan_out,
				mux_out			=> G5_muxed,
				chain_out		=> MUX_G5_chain_out 
			);

MUX_G6:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G6,
				chain_in		=> MUX_G5_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G5_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G6_ERR_out,
				Scan_out		=> MUX_G6_Scan_out,
				mux_out			=> G6_muxed,
				chain_out		=> MUX_G6_chain_out 
			);

MUX_G8:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G8,
				chain_in		=> MUX_G6_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G6_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G8_ERR_out,
				Scan_out		=> MUX_G8_Scan_out,
				mux_out			=> G8_muxed,
				chain_out		=> MUX_G8_chain_out 
			);

MUX_G9:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G9,
				chain_in		=> MUX_G8_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G8_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G9_ERR_out,
				Scan_out		=> MUX_G9_Scan_out,
				mux_out			=> G9_muxed,
				chain_out		=> MUX_G9_chain_out 
			);

MUX_G10:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G10,
				chain_in		=> MUX_G9_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G9_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G10_ERR_out,
				Scan_out		=> MUX_G10_Scan_out,
				mux_out			=> G10_muxed,
				chain_out		=> MUX_G10_chain_out 
			);

MUX_G11:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G11,
				chain_in		=> MUX_G10_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G10_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G11_ERR_out,
				Scan_out		=> MUX_G11_Scan_out,
				mux_out			=> G11_muxed,
				chain_out		=> MUX_G11_chain_out 
			);

MUX_G12:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G12,
				chain_in		=> MUX_G11_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G11_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G12_ERR_out,
				Scan_out		=> MUX_G12_Scan_out,
				mux_out			=> G12_muxed,
				chain_out		=> MUX_G12_chain_out 
			);

MUX_G13:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G13,
				chain_in		=> MUX_G12_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G12_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G13_ERR_out,
				Scan_out		=> MUX_G13_Scan_out,
				mux_out			=> G13_muxed,
				chain_out		=> MUX_G13_chain_out 
			);

MUX_G14:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G14,
				chain_in		=> MUX_G13_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G13_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G14_ERR_out,
				Scan_out		=> MUX_G14_Scan_out,
				mux_out			=> G14_muxed,
				chain_out		=> MUX_G14_chain_out 
			);

MUX_G15:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G15,
				chain_in		=> MUX_G14_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G14_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G15_ERR_out,
				Scan_out		=> MUX_G15_Scan_out,
				mux_out			=> G15_muxed,
				chain_out		=> MUX_G15_chain_out 
			);

MUX_G16:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G16,
				chain_in		=> MUX_G15_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G15_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G16_ERR_out,
				Scan_out		=> MUX_G16_Scan_out,
				mux_out			=> G16_muxed,
				chain_out		=> MUX_G16_chain_out 
			);

MUX_G17:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G17,
				chain_in		=> MUX_G16_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G16_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G17_ERR_out,
				Scan_out		=> MUX_G17_Scan_out,
				mux_out			=> G17_muxed,
				chain_out		=> MUX_G17_chain_out 
			);

MUX_G18:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G18,
				chain_in		=> MUX_G17_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G17_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G18_ERR_out,
				Scan_out		=> MUX_G18_Scan_out,
				mux_out			=> G18_muxed,
				chain_out		=> MUX_G18_chain_out 
			);

MUX_G19:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G19,
				chain_in		=> MUX_G18_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G18_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G19_ERR_out,
				Scan_out		=> MUX_G19_Scan_out,
				mux_out			=> G19_muxed,
				chain_out		=> MUX_G19_chain_out 
			);

MUX_G20:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G20,
				chain_in		=> MUX_G19_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G19_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G20_ERR_out,
				Scan_out		=> MUX_G20_Scan_out,
				mux_out			=> G20_muxed,
				chain_out		=> MUX_G20_chain_out 
			);

MUX_G21:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G21,
				chain_in		=> MUX_G20_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G20_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G21_ERR_out,
				Scan_out		=> MUX_G21_Scan_out,
				mux_out			=> G21_muxed,
				chain_out		=> MUX_G21_chain_out 
			);

MUX_G22:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G22,
				chain_in		=> MUX_G21_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G21_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G22_ERR_out,
				Scan_out		=> MUX_G22_Scan_out,
				mux_out			=> G22_muxed,
				chain_out		=> MUX_G22_chain_out 
			);

MUX_G23:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G23,
				chain_in		=> MUX_G22_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G22_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G23_ERR_out,
				Scan_out		=> MUX_G23_Scan_out,
				mux_out			=> G23_muxed,
				chain_out		=> MUX_G23_chain_out 
			);

MUX_G24:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G24,
				chain_in		=> MUX_G23_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G23_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G24_ERR_out,
				Scan_out		=> MUX_G24_Scan_out,
				mux_out			=> G24_muxed,
				chain_out		=> MUX_G24_chain_out 
			);

MUX_G25:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G25,
				chain_in		=> MUX_G24_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G24_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G25_ERR_out,
				Scan_out		=> MUX_G25_Scan_out,
				mux_out			=> G25_muxed,
				chain_out		=> MUX_G25_chain_out 
			);

MUX_G26:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G26,
				chain_in		=> MUX_G25_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G25_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G26_ERR_out,
				Scan_out		=> MUX_G26_Scan_out,
				mux_out			=> G26_muxed,
				chain_out		=> MUX_G26_chain_out 
			);

MUX_G27:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G27,
				chain_in		=> MUX_G26_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G26_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G27_ERR_out,
				Scan_out		=> MUX_G27_Scan_out,
				mux_out			=> G27_muxed,
				chain_out		=> MUX_G27_chain_out 
			);

MUX_G28:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G28,
				chain_in		=> MUX_G27_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G27_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G28_ERR_out,
				Scan_out		=> MUX_G28_Scan_out,
				mux_out			=> G28_muxed,
				chain_out		=> MUX_G28_chain_out 
			);

MUX_G29:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G29,
				chain_in		=> MUX_G28_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G28_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G29_ERR_out,
				Scan_out		=> MUX_G29_Scan_out,
				mux_out			=> G29_muxed,
				chain_out		=> MUX_G29_chain_out 
			);

MUX_G30:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G30,
				chain_in		=> MUX_G29_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G29_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G30_ERR_out,
				Scan_out		=> MUX_G30_Scan_out,
				mux_out			=> G30_muxed,
				chain_out		=> MUX_G30_chain_out 
			);

MUX_G31:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G31,
				chain_in		=> MUX_G30_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G30_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G31_ERR_out,
				Scan_out		=> MUX_G31_Scan_out,
				mux_out			=> G31_muxed,
				chain_out		=> MUX_G31_chain_out 
			);

MUX_G32:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G32,
				chain_in		=> MUX_G31_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G31_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G32_ERR_out,
				Scan_out		=> MUX_G32_Scan_out,
				mux_out			=> G32_muxed,
				chain_out		=> MUX_G32_chain_out 
			);

MUX_G33:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G33,
				chain_in		=> MUX_G32_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G32_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G33_ERR_out,
				Scan_out		=> MUX_G33_Scan_out,
				mux_out			=> G33_muxed,
				chain_out		=> MUX_G33_chain_out 
			);

MUX_G34:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G34,
				chain_in		=> MUX_G33_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G33_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G34_ERR_out,
				Scan_out		=> MUX_G34_Scan_out,
				mux_out			=> G34_muxed,
				chain_out		=> MUX_G34_chain_out 
			);

MUX_G35:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G35,
				chain_in		=> MUX_G34_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G34_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G35_ERR_out,
				Scan_out		=> MUX_G35_Scan_out,
				mux_out			=> G35_muxed,
				chain_out		=> MUX_G35_chain_out 
			);

MUX_G36:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> mux_reset,
 				PI_in			=> G36,
				chain_in		=> MUX_G35_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_G35_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_G36_ERR_out,
				Scan_out		=> MUX_G36_Scan_out,
				mux_out			=> G36_muxed,
				chain_out		=> MUX_G36_chain_out 
			);

--------------------------------------------------------------------------------
--                      END INPUT ISOLATION MUXES                             --
--------------------------------------------------------------------------------

--Flip-flops (total number: 19)
SER_BIST_FF_0:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G380, 
 			Q_in		=> MUX_G36_chain_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> MUX_G36_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_0_ERR_out, 
 			Scan_out	=> SER_BIST_FF_0_Scan_out, 
 			Q_out		=> G64 
 		);

SER_BIST_FF_1:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G262, 
 			Q_in		=> G64, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_0_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_1_ERR_out, 
 			Scan_out	=> SER_BIST_FF_1_Scan_out, 
 			Q_out		=> G65 
 		);

SER_BIST_FF_2:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G394, 
 			Q_in		=> G65, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_1_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_2_ERR_out, 
 			Scan_out	=> SER_BIST_FF_2_Scan_out, 
 			Q_out		=> G66 
 		);

SER_BIST_FF_3:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G250, 
 			Q_in		=> G66, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_2_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_3_ERR_out, 
 			Scan_out	=> SER_BIST_FF_3_Scan_out, 
 			Q_out		=> G67 
 		);

SER_BIST_FF_4:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G122, 
 			Q_in		=> G67, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_3_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_4_ERR_out, 
 			Scan_out	=> SER_BIST_FF_4_Scan_out, 
 			Q_out		=> G68 
 		);

SER_BIST_FF_5:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G133, 
 			Q_in		=> G68, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_4_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_5_ERR_out, 
 			Scan_out	=> SER_BIST_FF_5_Scan_out, 
 			Q_out		=> G69 
 		);

SER_BIST_FF_6:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G138, 
 			Q_in		=> G69, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_5_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_6_ERR_out, 
 			Scan_out	=> SER_BIST_FF_6_Scan_out, 
 			Q_out		=> G70 
 		);

SER_BIST_FF_7:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G139, 
 			Q_in		=> G70, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_6_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_7_ERR_out, 
 			Scan_out	=> SER_BIST_FF_7_Scan_out, 
 			Q_out		=> G71 
 		);

SER_BIST_FF_8:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G140, 
 			Q_in		=> G71, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_7_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_8_ERR_out, 
 			Scan_out	=> SER_BIST_FF_8_Scan_out, 
 			Q_out		=> G72 
 		);

SER_BIST_FF_9:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G141, 
 			Q_in		=> G72, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_8_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_9_ERR_out, 
 			Scan_out	=> SER_BIST_FF_9_Scan_out, 
 			Q_out		=> G73 
 		);

SER_BIST_FF_10:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G142, 
 			Q_in		=> G73, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_9_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_10_ERR_out, 
 			Scan_out	=> SER_BIST_FF_10_Scan_out, 
 			Q_out		=> G74 
 		);

SER_BIST_FF_11:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G125, 
 			Q_in		=> G74, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_10_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_11_ERR_out, 
 			Scan_out	=> SER_BIST_FF_11_Scan_out, 
 			Q_out		=> G75 
 		);

SER_BIST_FF_12:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G126, 
 			Q_in		=> G75, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_11_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_12_ERR_out, 
 			Scan_out	=> SER_BIST_FF_12_Scan_out, 
 			Q_out		=> G76 
 		);

SER_BIST_FF_13:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G127, 
 			Q_in		=> G76, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_12_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_13_ERR_out, 
 			Scan_out	=> SER_BIST_FF_13_Scan_out, 
 			Q_out		=> G77 
 		);

SER_BIST_FF_14:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G128, 
 			Q_in		=> G77, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_13_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_14_ERR_out, 
 			Scan_out	=> SER_BIST_FF_14_Scan_out, 
 			Q_out		=> G78 
 		);

SER_BIST_FF_15:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G129, 
 			Q_in		=> G78, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_14_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_15_ERR_out, 
 			Scan_out	=> SER_BIST_FF_15_Scan_out, 
 			Q_out		=> G79 
 		);

SER_BIST_FF_16:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G130, 
 			Q_in		=> G79, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_15_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_16_ERR_out, 
 			Scan_out	=> SER_BIST_FF_16_Scan_out, 
 			Q_out		=> G80 
 		);

SER_BIST_FF_17:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G131, 
 			Q_in		=> G80, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_16_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_17_ERR_out, 
 			Scan_out	=> SER_BIST_FF_17_Scan_out, 
 			Q_out		=> G81 
 		);

SER_BIST_FF_18:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G132, 
 			Q_in		=> G81, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_17_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_18_ERR_out, 
 			Scan_out	=> SER_BIST_FF_18_Scan_out, 
 			Q_out		=> G82 
 		);

------------------------------------------------------------------------
--                 START PRIMARY OUTPUT HANDLING                      --
------------------------------------------------------------------------
PO_DFF_0:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G103BF_temp, 
 			Q_in		=> G82, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_18_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_0_ERR_out, 
 			Scan_out	=> PO_DFF_0_Scan_out, 
 			Q_out		=> PO_DFF_0_out 
 		);

PO_DFF_1:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G104BF_temp, 
 			Q_in		=> PO_DFF_0_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_0_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_1_ERR_out, 
 			Scan_out	=> PO_DFF_1_Scan_out, 
 			Q_out		=> PO_DFF_1_out 
 		);

PO_DFF_2:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G105BF_temp, 
 			Q_in		=> PO_DFF_1_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_1_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_2_ERR_out, 
 			Scan_out	=> PO_DFF_2_Scan_out, 
 			Q_out		=> PO_DFF_2_out 
 		);

PO_DFF_3:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G106BF_temp, 
 			Q_in		=> PO_DFF_2_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_2_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_3_ERR_out, 
 			Scan_out	=> PO_DFF_3_Scan_out, 
 			Q_out		=> PO_DFF_3_out 
 		);

PO_DFF_4:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G107_temp, 
 			Q_in		=> PO_DFF_3_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_3_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_4_ERR_out, 
 			Scan_out	=> PO_DFF_4_Scan_out, 
 			Q_out		=> PO_DFF_4_out 
 		);

PO_DFF_5:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G83_temp, 
 			Q_in		=> PO_DFF_4_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_4_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_5_ERR_out, 
 			Scan_out	=> PO_DFF_5_Scan_out, 
 			Q_out		=> PO_DFF_5_out 
 		);

PO_DFF_6:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G84_temp, 
 			Q_in		=> PO_DFF_5_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_5_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_6_ERR_out, 
 			Scan_out	=> PO_DFF_6_Scan_out, 
 			Q_out		=> PO_DFF_6_out 
 		);

PO_DFF_7:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G85_temp, 
 			Q_in		=> PO_DFF_6_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_6_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_7_ERR_out, 
 			Scan_out	=> PO_DFF_7_Scan_out, 
 			Q_out		=> PO_DFF_7_out 
 		);

PO_DFF_8:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G86BF_temp, 
 			Q_in		=> PO_DFF_7_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_7_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_8_ERR_out, 
 			Scan_out	=> PO_DFF_8_Scan_out, 
 			Q_out		=> PO_DFF_8_out 
 		);

PO_DFF_9:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G87BF_temp, 
 			Q_in		=> PO_DFF_8_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_8_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_9_ERR_out, 
 			Scan_out	=> PO_DFF_9_Scan_out, 
 			Q_out		=> PO_DFF_9_out 
 		);

PO_DFF_10:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G88BF_temp, 
 			Q_in		=> PO_DFF_9_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_9_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_10_ERR_out, 
 			Scan_out	=> PO_DFF_10_Scan_out, 
 			Q_out		=> PO_DFF_10_out 
 		);

PO_DFF_11:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G89BF_temp, 
 			Q_in		=> PO_DFF_10_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_10_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_11_ERR_out, 
 			Scan_out	=> PO_DFF_11_Scan_out, 
 			Q_out		=> PO_DFF_11_out 
 		);

PO_DFF_12:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G90_temp, 
 			Q_in		=> PO_DFF_11_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_11_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_12_ERR_out, 
 			Scan_out	=> PO_DFF_12_Scan_out, 
 			Q_out		=> PO_DFF_12_out 
 		);

PO_DFF_13:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G91_temp, 
 			Q_in		=> PO_DFF_12_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_12_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_13_ERR_out, 
 			Scan_out	=> PO_DFF_13_Scan_out, 
 			Q_out		=> PO_DFF_13_out 
 		);

PO_DFF_14:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G92_temp, 
 			Q_in		=> PO_DFF_13_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_13_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_14_ERR_out, 
 			Scan_out	=> PO_DFF_14_Scan_out, 
 			Q_out		=> PO_DFF_14_out 
 		);

PO_DFF_15:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G94_temp, 
 			Q_in		=> PO_DFF_14_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_14_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_15_ERR_out, 
 			Scan_out	=> PO_DFF_15_Scan_out, 
 			Q_out		=> PO_DFF_15_out 
 		);

PO_DFF_16:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G95BF_temp, 
 			Q_in		=> PO_DFF_15_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_15_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_16_ERR_out, 
 			Scan_out	=> PO_DFF_16_Scan_out, 
 			Q_out		=> PO_DFF_16_out 
 		);

PO_DFF_17:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G96BF_temp, 
 			Q_in		=> PO_DFF_16_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_16_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_17_ERR_out, 
 			Scan_out	=> PO_DFF_17_Scan_out, 
 			Q_out		=> PO_DFF_17_out 
 		);

PO_DFF_18:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G97BF_temp, 
 			Q_in		=> PO_DFF_17_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_17_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_18_ERR_out, 
 			Scan_out	=> PO_DFF_18_Scan_out, 
 			Q_out		=> PO_DFF_18_out 
 		);

PO_DFF_19:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G98BF_temp, 
 			Q_in		=> PO_DFF_18_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_18_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_19_ERR_out, 
 			Scan_out	=> PO_DFF_19_Scan_out, 
 			Q_out		=> PO_DFF_19_out 
 		);

PO_DFF_20:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G99BF_temp, 
 			Q_in		=> PO_DFF_19_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_19_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_20_ERR_out, 
 			Scan_out	=> PO_DFF_20_Scan_out, 
 			Q_out		=> PO_DFF_20_out 
 		);

PO_DFF_21:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G100BF_temp, 
 			Q_in		=> PO_DFF_20_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_20_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_21_ERR_out, 
 			Scan_out	=> PO_DFF_21_Scan_out, 
 			Q_out		=> PO_DFF_21_out 
 		);

PO_DFF_22:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> G101BF_temp, 
 			Q_in		=> PO_DFF_21_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> PO_DFF_21_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> PO_DFF_22_ERR_out, 
 			Scan_out	=> PO_DFF_22_Scan_out, 
 			Q_out		=> PO_DFF_22_out 
 		);

Capture_out	 <= PO_DFF_22_Scan_out;

output_temp_proc: process(G103BF_temp, G104BF_temp, G105BF_temp, G106BF_temp, G107_temp, G83_temp, G84_temp, G85_temp, G86BF_temp, G87BF_temp, G88BF_temp, G89BF_temp, G90_temp, G91_temp, G92_temp, G94_temp, G95BF_temp, G96BF_temp, G97BF_temp, G98BF_temp, G99BF_temp, G100BF_temp, G101BF_temp)
begin
	G104BF <= G104BF_temp;
	G105BF <= G105BF_temp;
	G106BF <= G106BF_temp;
	G107 <= G107_temp;
	G83 <= G83_temp;
	G84 <= G84_temp;
	G85 <= G85_temp;
	G86BF <= G86BF_temp;
	G87BF <= G87BF_temp;
	G88BF <= G88BF_temp;
	G89BF <= G89BF_temp;
	G90 <= G90_temp;
	G91 <= G91_temp;
	G92 <= G92_temp;
	G94 <= G94_temp;
	G95BF <= G95BF_temp;
	G96BF <= G96BF_temp;
	G97BF <= G97BF_temp;
	G98BF <= G98BF_temp;
	G99BF <= G99BF_temp;
	G100BF <= G100BF_temp;
	G101BF <= G101BF_temp;
end process;
------------------------------------------------------------------------
--                  END PRIMARY OUTPUT HANDLING                       --
------------------------------------------------------------------------

------------------------------------------------------------------------
--            START PARITY CHECKING OF EXPECTED RESPONSE              --
------------------------------------------------------------------------
PAR_CHK:	lis_spc_even
			port map( 
				clk				=> clk,
				reset			=> ctrl_par_reset_out,
				scan_ctrl_in	=> ctrl_Scan_out,
				scan_hffs_in	=> PO_DFF_22_Scan_out,
				par_hold		=> ctrl_par_hold_out,
				par_ok			=> spc_par_ok_out
			);
------------------------------------------------------------------------
--             END PARITY CHECKING OF EXPECTED RESPONSE               --
------------------------------------------------------------------------
------------------------------------------------------------------------
--                          START OR-TREE                             --
------------------------------------------------------------------------
OR_tree_out <= MUX_G1_ERR_out OR MUX_G2_ERR_out OR MUX_G3_ERR_out OR MUX_G4_ERR_out OR MUX_G5_ERR_out OR MUX_G6_ERR_out OR MUX_G8_ERR_out OR MUX_G9_ERR_out OR MUX_G10_ERR_out OR MUX_G11_ERR_out OR MUX_G12_ERR_out OR MUX_G13_ERR_out OR MUX_G14_ERR_out OR MUX_G15_ERR_out OR MUX_G16_ERR_out OR MUX_G17_ERR_out OR MUX_G18_ERR_out OR MUX_G19_ERR_out OR MUX_G20_ERR_out OR MUX_G21_ERR_out OR MUX_G22_ERR_out OR MUX_G23_ERR_out OR MUX_G24_ERR_out OR MUX_G25_ERR_out OR MUX_G26_ERR_out OR MUX_G27_ERR_out OR MUX_G28_ERR_out OR MUX_G29_ERR_out OR MUX_G30_ERR_out OR MUX_G31_ERR_out OR MUX_G32_ERR_out OR MUX_G33_ERR_out OR MUX_G34_ERR_out OR MUX_G35_ERR_out OR MUX_G36_ERR_out OR SER_BIST_FF_0_ERR_out OR SER_BIST_FF_1_ERR_out OR SER_BIST_FF_2_ERR_out OR SER_BIST_FF_3_ERR_out OR SER_BIST_FF_4_ERR_out OR SER_BIST_FF_5_ERR_out OR SER_BIST_FF_6_ERR_out OR SER_BIST_FF_7_ERR_out OR SER_BIST_FF_8_ERR_out OR SER_BIST_FF_9_ERR_out OR SER_BIST_FF_10_ERR_out OR SER_BIST_FF_11_ERR_out OR SER_BIST_FF_12_ERR_out OR SER_BIST_FF_13_ERR_out OR SER_BIST_FF_14_ERR_out OR SER_BIST_FF_15_ERR_out OR SER_BIST_FF_16_ERR_out OR SER_BIST_FF_17_ERR_out OR SER_BIST_FF_18_ERR_out OR PO_DFF_0_ERR_out OR PO_DFF_1_ERR_out OR PO_DFF_2_ERR_out OR PO_DFF_3_ERR_out OR PO_DFF_4_ERR_out OR PO_DFF_5_ERR_out OR PO_DFF_6_ERR_out OR PO_DFF_7_ERR_out OR PO_DFF_8_ERR_out OR PO_DFF_9_ERR_out OR PO_DFF_10_ERR_out OR PO_DFF_11_ERR_out OR PO_DFF_12_ERR_out OR PO_DFF_13_ERR_out OR PO_DFF_14_ERR_out OR PO_DFF_15_ERR_out OR PO_DFF_16_ERR_out OR PO_DFF_17_ERR_out OR PO_DFF_18_ERR_out OR PO_DFF_19_ERR_out OR PO_DFF_20_ERR_out OR PO_DFF_21_ERR_out OR PO_DFF_22_ERR_out;
------------------------------------------------------------------------
--                           END OR-TREE                              --
------------------------------------------------------------------------

--Inverters (total number: 254)
INV_0:	 lis_not port map( A => G1_muxed, Z => I633 );
INV_1:	 lis_not port map( A => G2_muxed, Z => G366 );
INV_2:	 lis_not port map( A => G3_muxed, Z => G379 );
INV_3:	 lis_not port map( A => G4_muxed, Z => I643 );
INV_4:	 lis_not port map( A => G5_muxed, Z => I646 );
INV_5:	 lis_not port map( A => G6_muxed, Z => I649 );
INV_6:	 lis_not port map( A => G8_muxed, Z => I652 );
INV_7:	 lis_not port map( A => G9_muxed, Z => I655 );
INV_8:	 lis_not port map( A => G10_muxed, Z => I660 );
INV_9:	 lis_not port map( A => G11_muxed, Z => I680 );
INV_10:	 lis_not port map( A => G12_muxed, Z => I684 );
INV_11:	 lis_not port map( A => G13_muxed, Z => I687 );
INV_12:	 lis_not port map( A => G27_muxed, Z => I165 );
INV_13:	 lis_not port map( A => I165, Z => G91_temp );
INV_14:	 lis_not port map( A => G29_muxed, Z => II178 );
INV_15:	 lis_not port map( A => G70, Z => I169 );
INV_16:	 lis_not port map( A => I169, Z => G113 );
INV_17:	 lis_not port map( A => G71, Z => I172 );
INV_18:	 lis_not port map( A => I172, Z => G115 );
INV_19:	 lis_not port map( A => G72, Z => I175 );
INV_20:	 lis_not port map( A => I175, Z => G117 );
INV_21:	 lis_not port map( A => G80, Z => I178 );
INV_22:	 lis_not port map( A => I178, Z => G219 );
INV_23:	 lis_not port map( A => G73, Z => I181 );
INV_24:	 lis_not port map( A => I181, Z => G119 );
INV_25:	 lis_not port map( A => G81, Z => I184 );
INV_26:	 lis_not port map( A => I184, Z => G221 );
INV_27:	 lis_not port map( A => G74, Z => I187 );
INV_28:	 lis_not port map( A => I187, Z => G121 );
INV_29:	 lis_not port map( A => G82, Z => I190 );
INV_30:	 lis_not port map( A => I190, Z => G223 );
INV_31:	 lis_not port map( A => G75, Z => I193 );
INV_32:	 lis_not port map( A => I193, Z => G209 );
INV_33:	 lis_not port map( A => G68, Z => I196 );
INV_34:	 lis_not port map( A => I196, Z => G109 );
INV_35:	 lis_not port map( A => G76, Z => I199 );
INV_36:	 lis_not port map( A => I199, Z => G211 );
INV_37:	 lis_not port map( A => G69, Z => I202 );
INV_38:	 lis_not port map( A => I202, Z => G111 );
INV_39:	 lis_not port map( A => G77, Z => I205 );
INV_40:	 lis_not port map( A => I205, Z => G213 );
INV_41:	 lis_not port map( A => G78, Z => I208 );
INV_42:	 lis_not port map( A => I208, Z => G215 );
INV_43:	 lis_not port map( A => G79, Z => I211 );
INV_44:	 lis_not port map( A => I211, Z => G217 );
INV_45:	 lis_not port map( A => I633, Z => G352 );
INV_46:	 lis_not port map( A => I643, Z => G360 );
INV_47:	 lis_not port map( A => I646, Z => G361 );
INV_48:	 lis_not port map( A => I649, Z => G362 );
INV_49:	 lis_not port map( A => I652, Z => G363 );
INV_50:	 lis_not port map( A => I655, Z => G364 );
INV_51:	 lis_not port map( A => I660, Z => G367 );
INV_52:	 lis_not port map( A => I680, Z => G386 );
INV_53:	 lis_not port map( A => I684, Z => G388 );
INV_54:	 lis_not port map( A => I687, Z => G389 );
INV_55:	 lis_not port map( A => II178, Z => G94_temp );
INV_56:	 lis_not port map( A => G360, Z => G110 );
INV_57:	 lis_not port map( A => G360, Z => G114 );
INV_58:	 lis_not port map( A => G360, Z => G118 );
INV_59:	 lis_not port map( A => G360, Z => G216 );
INV_60:	 lis_not port map( A => G360, Z => G218 );
INV_61:	 lis_not port map( A => G360, Z => G220 );
INV_62:	 lis_not port map( A => G360, Z => G222 );
INV_63:	 lis_not port map( A => G364, Z => G365 );
INV_64:	 lis_not port map( A => G367, Z => G368 );
INV_65:	 lis_not port map( A => G386, Z => G387 );
INV_66:	 lis_not port map( A => G388, Z => G225 );
INV_67:	 lis_not port map( A => G389, Z => G390 );
INV_68:	 lis_not port map( A => G289, Z => I356 );
INV_69:	 lis_not port map( A => G324, Z => I254 );
INV_70:	 lis_not port map( A => I254, Z => G166 );
INV_71:	 lis_not port map( A => G324, Z => I257 );
INV_72:	 lis_not port map( A => I257, Z => G325 );
INV_73:	 lis_not port map( A => G338, Z => I260 );
INV_74:	 lis_not port map( A => I260, Z => G194 );
INV_75:	 lis_not port map( A => G338, Z => I263 );
INV_76:	 lis_not port map( A => I263, Z => G339 );
INV_77:	 lis_not port map( A => G344, Z => I266 );
INV_78:	 lis_not port map( A => I266, Z => G202 );
INV_79:	 lis_not port map( A => G344, Z => I269 );
INV_80:	 lis_not port map( A => I269, Z => G345 );
INV_81:	 lis_not port map( A => G312, Z => I272 );
INV_82:	 lis_not port map( A => I272, Z => G313 );
INV_83:	 lis_not port map( A => G315, Z => I275 );
INV_84:	 lis_not port map( A => I275, Z => G316 );
INV_85:	 lis_not port map( A => G318, Z => I278 );
INV_86:	 lis_not port map( A => I278, Z => G319 );
INV_87:	 lis_not port map( A => G321, Z => I281 );
INV_88:	 lis_not port map( A => I281, Z => G322 );
INV_89:	 lis_not port map( A => I356, Z => G143 );
INV_90:	 lis_not port map( A => G166, Z => I287 );
INV_91:	 lis_not port map( A => I287, Z => G381 );
INV_92:	 lis_not port map( A => G194, Z => I291 );
INV_93:	 lis_not port map( A => I291, Z => G375 );
INV_94:	 lis_not port map( A => G202, Z => I295 );
INV_95:	 lis_not port map( A => I295, Z => G371 );
INV_96:	 lis_not port map( A => G143, Z => I303 );
INV_97:	 lis_not port map( A => I303, Z => G350 );
INV_98:	 lis_not port map( A => G281, Z => I299 );
INV_99:	 lis_not port map( A => G283, Z => I313 );
INV_100:	 lis_not port map( A => G381, Z => G382 );
INV_101:	 lis_not port map( A => G100, Z => G100BF_temp );
INV_102:	 lis_not port map( A => G375, Z => G376 );
INV_103:	 lis_not port map( A => G98, Z => G98BF_temp );
INV_104:	 lis_not port map( A => G371, Z => G372 );
INV_105:	 lis_not port map( A => G96, Z => G96BF_temp );
INV_106:	 lis_not port map( A => I299, Z => I301 );
INV_107:	 lis_not port map( A => I313, Z => I315 );
INV_108:	 lis_not port map( A => G135, Z => I321 );
INV_109:	 lis_not port map( A => I321, Z => G329 );
INV_110:	 lis_not port map( A => G137, Z => I324 );
INV_111:	 lis_not port map( A => I324, Z => G333 );
INV_112:	 lis_not port map( A => G87, Z => G87BF_temp );
INV_113:	 lis_not port map( A => G87, Z => I406 );
INV_114:	 lis_not port map( A => G89, Z => G89BF_temp );
INV_115:	 lis_not port map( A => G89, Z => I422 );
INV_116:	 lis_not port map( A => I406, Z => G173 );
INV_117:	 lis_not port map( A => I422, Z => G183 );
INV_118:	 lis_not port map( A => G173, Z => I335 );
INV_119:	 lis_not port map( A => I335, Z => G174 );
INV_120:	 lis_not port map( A => G183, Z => I338 );
INV_121:	 lis_not port map( A => I338, Z => G184 );
INV_122:	 lis_not port map( A => G174, Z => I341 );
INV_123:	 lis_not port map( A => I341, Z => G355 );
INV_124:	 lis_not port map( A => G184, Z => G359 );
INV_125:	 lis_not port map( A => G355, Z => G356 );
INV_126:	 lis_not port map( A => G359, Z => G108 );
INV_127:	 lis_not port map( A => G356, Z => G116 );
INV_128:	 lis_not port map( A => G293, Z => I354 );
INV_129:	 lis_not port map( A => I354, Z => G146 );
INV_130:	 lis_not port map( A => G293, Z => I357 );
INV_131:	 lis_not port map( A => I357, Z => G294 );
INV_132:	 lis_not port map( A => G309, Z => I360 );
INV_133:	 lis_not port map( A => I360, Z => G162 );
INV_134:	 lis_not port map( A => G309, Z => I363 );
INV_135:	 lis_not port map( A => I363, Z => G310 );
INV_136:	 lis_not port map( A => G341, Z => I366 );
INV_137:	 lis_not port map( A => I366, Z => G198 );
INV_138:	 lis_not port map( A => G341, Z => I369 );
INV_139:	 lis_not port map( A => I369, Z => G342 );
INV_140:	 lis_not port map( A => G303, Z => I372 );
INV_141:	 lis_not port map( A => I372, Z => G154 );
INV_142:	 lis_not port map( A => G303, Z => I375 );
INV_143:	 lis_not port map( A => I375, Z => G304 );
INV_144:	 lis_not port map( A => G146, Z => I378 );
INV_145:	 lis_not port map( A => I378, Z => G383 );
INV_146:	 lis_not port map( A => G162, Z => I382 );
INV_147:	 lis_not port map( A => I382, Z => G396 );
INV_148:	 lis_not port map( A => G198, Z => I386 );
INV_149:	 lis_not port map( A => I386, Z => G373 );
INV_150:	 lis_not port map( A => G154, Z => I390 );
INV_151:	 lis_not port map( A => I390, Z => G392 );
INV_152:	 lis_not port map( A => G383, Z => G384 );
INV_153:	 lis_not port map( A => G101, Z => G101BF_temp );
INV_154:	 lis_not port map( A => G396, Z => G397 );
INV_155:	 lis_not port map( A => G106, Z => G106BF_temp );
INV_156:	 lis_not port map( A => G373, Z => G374 );
INV_157:	 lis_not port map( A => G97, Z => G97BF_temp );
INV_158:	 lis_not port map( A => G392, Z => G393 );
INV_159:	 lis_not port map( A => G104, Z => G104BF_temp );
INV_160:	 lis_not port map( A => G384, Z => II476 );
INV_161:	 lis_not port map( A => G278, Z => I279 );
INV_162:	 lis_not port map( A => II476, Z => G224 );
INV_163:	 lis_not port map( A => I279, Z => G132 );
INV_164:	 lis_not port map( A => G282, Z => I306 );
INV_165:	 lis_not port map( A => G286, Z => I334 );
INV_166:	 lis_not port map( A => G285, Z => I327 );
INV_167:	 lis_not port map( A => G268, Z => II208 );
INV_168:	 lis_not port map( A => I306, Z => I308 );
INV_169:	 lis_not port map( A => I334, Z => I336 );
INV_170:	 lis_not port map( A => I327, Z => I329 );
INV_171:	 lis_not port map( A => II208, Z => I210 );
INV_172:	 lis_not port map( A => G136, Z => I442 );
INV_173:	 lis_not port map( A => I442, Z => G331 );
INV_174:	 lis_not port map( A => G88, Z => G88BF_temp );
INV_175:	 lis_not port map( A => G88, Z => I414 );
INV_176:	 lis_not port map( A => I414, Z => G178 );
INV_177:	 lis_not port map( A => G178, Z => I449 );
INV_178:	 lis_not port map( A => I449, Z => G179 );
INV_179:	 lis_not port map( A => G179, Z => I452 );
INV_180:	 lis_not port map( A => I452, Z => G357 );
INV_181:	 lis_not port map( A => G357, Z => G358 );
INV_182:	 lis_not port map( A => G358, Z => G112 );
INV_183:	 lis_not port map( A => G335, Z => I460 );
INV_184:	 lis_not port map( A => I460, Z => G190 );
INV_185:	 lis_not port map( A => G335, Z => I463 );
INV_186:	 lis_not port map( A => I463, Z => G336 );
INV_187:	 lis_not port map( A => G306, Z => I466 );
INV_188:	 lis_not port map( A => I466, Z => G158 );
INV_189:	 lis_not port map( A => G306, Z => I469 );
INV_190:	 lis_not port map( A => I469, Z => G307 );
INV_191:	 lis_not port map( A => G190, Z => I472 );
INV_192:	 lis_not port map( A => I472, Z => G377 );
INV_193:	 lis_not port map( A => G158, Z => I476 );
INV_194:	 lis_not port map( A => I476, Z => G394 );
INV_195:	 lis_not port map( A => G377, Z => G378 );
INV_196:	 lis_not port map( A => G99, Z => G99BF_temp );
INV_197:	 lis_not port map( A => G158, Z => G395 );
INV_198:	 lis_not port map( A => G105, Z => G105BF_temp );
INV_199:	 lis_not port map( A => G277, Z => II272 );
INV_200:	 lis_not port map( A => II272, Z => G131 );
INV_201:	 lis_not port map( A => G276, Z => I265 );
INV_202:	 lis_not port map( A => G284, Z => I320 );
INV_203:	 lis_not port map( A => G279, Z => I285 );
INV_204:	 lis_not port map( A => G280, Z => I292 );
INV_205:	 lis_not port map( A => I265, Z => G130 );
INV_206:	 lis_not port map( A => I320, Z => I322 );
INV_207:	 lis_not port map( A => I285, Z => II287 );
INV_208:	 lis_not port map( A => I292, Z => I294 );
INV_209:	 lis_not port map( A => G134, Z => I517 );
INV_210:	 lis_not port map( A => I517, Z => G327 );
INV_211:	 lis_not port map( A => G86, Z => G86BF_temp );
INV_212:	 lis_not port map( A => G86, Z => I398 );
INV_213:	 lis_not port map( A => I398, Z => G168 );
INV_214:	 lis_not port map( A => G168, Z => I524 );
INV_215:	 lis_not port map( A => I524, Z => G169 );
INV_216:	 lis_not port map( A => G169, Z => I527 );
INV_217:	 lis_not port map( A => I527, Z => G353 );
INV_218:	 lis_not port map( A => G353, Z => G354 );
INV_219:	 lis_not port map( A => G354, Z => G120 );
INV_220:	 lis_not port map( A => G347, Z => I535 );
INV_221:	 lis_not port map( A => I535, Z => G206 );
INV_222:	 lis_not port map( A => G347, Z => I538 );
INV_223:	 lis_not port map( A => I538, Z => G348 );
INV_224:	 lis_not port map( A => G300, Z => I541 );
INV_225:	 lis_not port map( A => I541, Z => G150 );
INV_226:	 lis_not port map( A => G300, Z => I544 );
INV_227:	 lis_not port map( A => I544, Z => G301 );
INV_228:	 lis_not port map( A => G206, Z => I547 );
INV_229:	 lis_not port map( A => I547, Z => G369 );
INV_230:	 lis_not port map( A => G150, Z => I551 );
INV_231:	 lis_not port map( A => I551, Z => G380 );
INV_232:	 lis_not port map( A => G369, Z => G370 );
INV_233:	 lis_not port map( A => G95, Z => G95BF_temp );
INV_234:	 lis_not port map( A => G150, Z => G391 );
INV_235:	 lis_not port map( A => G103, Z => G103BF_temp );
INV_236:	 lis_not port map( A => G271, Z => I230 );
INV_237:	 lis_not port map( A => G275, Z => I258 );
INV_238:	 lis_not port map( A => G288, Z => I348 );
INV_239:	 lis_not port map( A => G287, Z => II341 );
INV_240:	 lis_not port map( A => I230, Z => G125 );
INV_241:	 lis_not port map( A => I258, Z => G129 );
INV_242:	 lis_not port map( A => G270, Z => I222 );
INV_243:	 lis_not port map( A => I348, Z => I350 );
INV_244:	 lis_not port map( A => II341, Z => I343 );
INV_245:	 lis_not port map( A => G272, Z => I237 );
INV_246:	 lis_not port map( A => G273, Z => I244 );
INV_247:	 lis_not port map( A => G274, Z => I251 );
INV_248:	 lis_not port map( A => I222, Z => I224 );
INV_249:	 lis_not port map( A => I237, Z => G126 );
INV_250:	 lis_not port map( A => I244, Z => G127 );
INV_251:	 lis_not port map( A => I251, Z => G128 );
INV_252:	 lis_not port map( A => G124, Z => I608 );
INV_253:	 lis_not port map( A => I608, Z => G298 );

--AND-gates (total number: 94)
AND3_0:	 LIS_AND3 port map( A => G386, B => G388, C => G389, Z => G289 );
AND2_0:	 LIS_AND2 port map( A => G110, B => G111, Z => G324);
AND2_1:	 LIS_AND2 port map( A => G114, B => G115, Z => G338);
AND2_2:	 LIS_AND2 port map( A => G118, B => G119, Z => G344);
AND2_3:	 LIS_AND2 port map( A => G216, B => G217, Z => G312);
AND2_4:	 LIS_AND2 port map( A => G218, B => G219, Z => G315);
AND2_5:	 LIS_AND2 port map( A => G220, B => G221, Z => G318);
AND2_6:	 LIS_AND2 port map( A => G222, B => G223, Z => G321);
AND2_7:	 LIS_AND2 port map( A => G379, B => G387, Z => G231);
AND2_8:	 LIS_AND2 port map( A => G379, B => G387, Z => G232);
AND2_9:	 LIS_AND2 port map( A => G379, B => G387, Z => G233);
AND2_10:	 LIS_AND2 port map( A => G379, B => G387, Z => G234);
AND4_0:	 LIS_AND4 port map( A => G379, B => G365, C => G368, D => G390, Z => G247 );
AND4_1:	 LIS_AND4 port map( A => G379, B => G365, C => G367, D => G390, Z => G248 );
AND4_2:	 LIS_AND4 port map( A => G379, B => G364, C => G368, D => G390, Z => G263 );
AND4_3:	 LIS_AND4 port map( A => G379, B => G364, C => G367, D => G390, Z => G264 );
AND2_11:	 LIS_AND2 port map( A => G325, B => G35_muxed, Z => G100);
AND2_12:	 LIS_AND2 port map( A => G339, B => G33_muxed, Z => G98);
AND2_13:	 LIS_AND2 port map( A => G345, B => G31_muxed, Z => G96);
AND2_14:	 LIS_AND2 port map( A => G313, B => G18_muxed, Z => G107_temp);
AND2_15:	 LIS_AND2 port map( A => G316, B => G19_muxed, Z => G83_temp);
AND2_16:	 LIS_AND2 port map( A => G319, B => G20_muxed, Z => G84_temp);
AND2_17:	 LIS_AND2 port map( A => G322, B => G21_muxed, Z => G85_temp);
AND2_18:	 LIS_AND2 port map( A => G350, B => G28_muxed, Z => G92_temp);
AND2_19:	 LIS_AND2 port map( A => G329, B => G23_muxed, Z => G87);
AND2_20:	 LIS_AND2 port map( A => G333, B => G25_muxed, Z => G89);
AND2_21:	 LIS_AND2 port map( A => G108, B => G109, Z => G293);
AND2_22:	 LIS_AND2 port map( A => G214, B => G215, Z => G309);
AND2_23:	 LIS_AND2 port map( A => G116, B => G117, Z => G341);
AND2_24:	 LIS_AND2 port map( A => G210, B => G211, Z => G303);
AND2_25:	 LIS_AND2 port map( A => G294, B => G36_muxed, Z => G101);
AND2_26:	 LIS_AND2 port map( A => G310, B => G17_muxed, Z => G106);
AND2_27:	 LIS_AND2 port map( A => G342, B => G32_muxed, Z => G97);
AND2_28:	 LIS_AND2 port map( A => G304, B => G15_muxed, Z => G104);
AND2_29:	 LIS_AND2 port map( A => G359, B => G383, Z => G240);
AND4_4:	 LIS_AND4 port map( A => G364, B => G367, C => G383, D => G390, Z => G266 );
AND2_30:	 LIS_AND2 port map( A => G366, B => G396, Z => G229);
AND2_31:	 LIS_AND2 port map( A => G352, B => G396, Z => G245);
AND2_32:	 LIS_AND2 port map( A => G366, B => G396, Z => G250);
AND2_33:	 LIS_AND2 port map( A => G366, B => G396, Z => G278);
AND3_1:	 LIS_AND3 port map( A => G356, B => G373, C => G375, Z => G253 );
AND3_2:	 LIS_AND3 port map( A => G365, B => G367, C => G373, Z => I533 );
AND2_34:	 LIS_AND2 port map( A => G366, B => G392, Z => G227);
AND2_35:	 LIS_AND2 port map( A => G392, B => G361, Z => G243);
AND3_3:	 LIS_AND3 port map( A => G366, B => G66, C => G397, Z => G249 );
AND3_4:	 LIS_AND3 port map( A => G375, B => G390, C => I533, Z => G265 );
AND2_36:	 LIS_AND2 port map( A => G374, B => G376, Z => G236);
AND2_37:	 LIS_AND2 port map( A => G374, B => G375, Z => G237);
AND3_5:	 LIS_AND3 port map( A => G355, B => G374, C => G375, Z => G252 );
AND3_6:	 LIS_AND3 port map( A => G366, B => G64, C => G393, Z => II527 );
AND2_38:	 LIS_AND2 port map( A => G331, B => G24_muxed, Z => G88);
AND2_39:	 LIS_AND2 port map( A => G112, B => G113, Z => G335);
AND2_40:	 LIS_AND2 port map( A => G212, B => G213, Z => G306);
AND2_41:	 LIS_AND2 port map( A => G336, B => G34_muxed, Z => G99);
AND2_42:	 LIS_AND2 port map( A => G307, B => G16_muxed, Z => G105);
AND3_7:	 LIS_AND3 port map( A => G358, B => G377, C => G381, Z => G251 );
AND3_8:	 LIS_AND3 port map( A => G364, B => G368, C => G377, Z => I512 );
AND4_5:	 LIS_AND4 port map( A => G377, B => G381, C => G383, D => G387, Z => II538 );
AND2_43:	 LIS_AND2 port map( A => G366, B => G158, Z => G228);
AND2_44:	 LIS_AND2 port map( A => G158, B => G362, Z => G244);
AND3_9:	 LIS_AND3 port map( A => G366, B => G158, C => G397, Z => G277 );
AND3_10:	 LIS_AND3 port map( A => G381, B => G390, C => I512, Z => G256 );
AND2_45:	 LIS_AND2 port map( A => G378, B => G382, Z => G230);
AND2_46:	 LIS_AND2 port map( A => G378, B => G381, Z => G235);
AND3_11:	 LIS_AND3 port map( A => G357, B => G378, C => G381, Z => G246 );
AND3_12:	 LIS_AND3 port map( A => G393, B => G395, C => G397, Z => I515 );
AND3_13:	 LIS_AND3 port map( A => G395, B => G397, C => II527, Z => G261 );
AND4_6:	 LIS_AND4 port map( A => G366, B => G392, C => G395, D => G397, Z => G262 );
AND4_7:	 LIS_AND4 port map( A => G366, B => G392, C => G395, D => G397, Z => G276 );
AND2_47:	 LIS_AND2 port map( A => G327, B => G22_muxed, Z => G86);
AND2_48:	 LIS_AND2 port map( A => G120, B => G121, Z => G347);
AND2_49:	 LIS_AND2 port map( A => G208, B => G209, Z => G300);
AND2_50:	 LIS_AND2 port map( A => G348, B => G30_muxed, Z => G95);
AND2_51:	 LIS_AND2 port map( A => G301, B => G14_muxed, Z => G103);
AND3_14:	 LIS_AND3 port map( A => G365, B => G368, C => G369, Z => I495 );
AND3_15:	 LIS_AND3 port map( A => G354, B => G369, C => G371, Z => G255 );
AND4_8:	 LIS_AND4 port map( A => G363, B => G369, C => G371, D => I515, Z => G257 );
AND4_9:	 LIS_AND4 port map( A => G369, B => G371, C => G373, D => G375, Z => I537 );
AND2_52:	 LIS_AND2 port map( A => G366, B => G150, Z => G226);
AND2_53:	 LIS_AND2 port map( A => G150, B => G363, Z => G242);
AND3_16:	 LIS_AND3 port map( A => G366, B => G150, C => G393, Z => I553 );
AND3_17:	 LIS_AND3 port map( A => G371, B => G390, C => I495, Z => G241 );
AND2_54:	 LIS_AND2 port map( A => I537, B => II538, Z => G267);
AND2_55:	 LIS_AND2 port map( A => G370, B => G372, Z => G238);
AND2_56:	 LIS_AND2 port map( A => G370, B => G371, Z => G239);
AND3_18:	 LIS_AND3 port map( A => G353, B => G370, C => G371, Z => G254 );
AND3_19:	 LIS_AND3 port map( A => G395, B => G397, C => I553, Z => G275 );
AND3_20:	 LIS_AND3 port map( A => G391, B => G395, C => G397, Z => I518 );
AND3_21:	 LIS_AND3 port map( A => G391, B => G393, C => G397, Z => I521 );
AND3_22:	 LIS_AND3 port map( A => G352, B => G391, C => G393, Z => II524 );
AND4_10:	 LIS_AND4 port map( A => G361, B => G373, C => G375, D => I518, Z => G258 );
AND4_11:	 LIS_AND4 port map( A => G362, B => G377, C => G381, D => I521, Z => G259 );
AND3_23:	 LIS_AND3 port map( A => G395, B => G383, C => II524, Z => G260 );
AND2_57:	 LIS_AND2 port map( A => G298, B => G26_muxed, Z => G90_temp);

--OR-gates (total number: 17)
OR3_0:	 LIS_OR3 port map( A => G232, B => G248, C => G65, Z => G281 );
OR3_1:	 LIS_OR3 port map( A => G234, B => G67, C => G264, Z => G283 );
OR3_2:	 LIS_OR3 port map( A => G233, B => G249, C => G263, Z => G282 );
OR2_0:	 LIS_OR2 port map( A => G237, B => G253, Z => G286 );
OR2_1:	 LIS_OR2 port map( A => G236, B => G252, Z => G285 );
OR2_2:	 LIS_OR2 port map( A => G224, B => G240, Z => G268 );
OR2_3:	 LIS_OR2 port map( A => G235, B => G251, Z => G284 );
OR2_4:	 LIS_OR2 port map( A => G230, B => G246, Z => G279 );
OR3_3:	 LIS_OR3 port map( A => G231, B => G247, C => G261, Z => G280 );
OR3_4:	 LIS_OR3 port map( A => G226, B => G242, C => G257, Z => G271 );
OR3_5:	 LIS_OR3 port map( A => G225, B => G241, C => G256, Z => I546 );
OR2_5:	 LIS_OR2 port map( A => G239, B => G255, Z => G288 );
OR2_6:	 LIS_OR2 port map( A => G238, B => G254, Z => G287 );
OR4_0:	 LIS_OR4 port map( A => G265, B => G266, C => G267, D => I546, Z => G270 );
OR3_6:	 LIS_OR3 port map( A => G227, B => G243, C => G258, Z => G272 );
OR3_7:	 LIS_OR3 port map( A => G228, B => G244, C => G259, Z => G273 );
OR3_8:	 LIS_OR3 port map( A => G229, B => G245, C => G260, Z => G274 );

--NAND-gates (total number: 28)
NAND2_0: LIS_NAND2 port map( A => G281, B => I299, Z => I300 );
NAND2_1: LIS_NAND2 port map( A => G283, B => I313, Z => I314 );
NAND2_2: LIS_NAND2 port map( A => I300, B => I301, Z => G135 );
NAND2_3: LIS_NAND2 port map( A => I314, B => I315, Z => G137 );
NAND2_4: LIS_NAND2 port map( A => G379, B => G359, Z => G214 );
NAND2_5: LIS_NAND2 port map( A => G379, B => G356, Z => G210 );
NAND2_6: LIS_NAND2 port map( A => G282, B => I306, Z => I307 );
NAND2_7: LIS_NAND2 port map( A => G286, B => I334, Z => II335 );
NAND2_8: LIS_NAND2 port map( A => G285, B => I327, Z => I328 );
NAND2_9: LIS_NAND2 port map( A => G268, B => II208, Z => I209 );
NAND2_10: LIS_NAND2 port map( A => I307, B => I308, Z => G136 );
NAND2_11: LIS_NAND2 port map( A => II335, B => I336, Z => G140 );
NAND2_12: LIS_NAND2 port map( A => I328, B => I329, Z => G139 );
NAND2_13: LIS_NAND2 port map( A => I209, B => I210, Z => G122 );
NAND2_14: LIS_NAND2 port map( A => G379, B => G358, Z => G212 );
NAND2_15: LIS_NAND2 port map( A => G284, B => I320, Z => II321 );
NAND2_16: LIS_NAND2 port map( A => G279, B => I285, Z => I286 );
NAND2_17: LIS_NAND2 port map( A => G280, B => I292, Z => I293 );
NAND2_18: LIS_NAND2 port map( A => II321, B => I322, Z => G138 );
NAND2_19: LIS_NAND2 port map( A => I286, B => II287, Z => G133 );
NAND2_20: LIS_NAND2 port map( A => I293, B => I294, Z => G134 );
NAND2_21: LIS_NAND2 port map( A => G379, B => G354, Z => G208 );
NAND2_22: LIS_NAND2 port map( A => G288, B => I348, Z => I349 );
NAND2_23: LIS_NAND2 port map( A => G287, B => II341, Z => I342 );
NAND2_24: LIS_NAND2 port map( A => G270, B => I222, Z => I223 );
NAND2_25: LIS_NAND2 port map( A => I349, B => I350, Z => G142 );
NAND2_26: LIS_NAND2 port map( A => I342, B => I343, Z => G141 );
NAND2_27: LIS_NAND2 port map( A => I223, B => I224, Z => G124 );

--NOR-gates (total number: 0)

end architecture;
