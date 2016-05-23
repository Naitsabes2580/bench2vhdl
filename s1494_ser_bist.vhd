------------------------------------------------------------------------
--#LIS#
--Author: Sebastian Kroesche
--Date: 23.05.2016 - 11:21:48  
--Description: Implementation of ISCAS89 s1494_ser_bist circuit with
--             (4) Combined SER/BIST flip-flop (merges option 2 and 3) 
--             generated with bench2vhdl_complete
--Circuit statistics
--# s1494
--# 8 inputs
--# 19 outputs
--# 6 D-type flipflops
--# 89 inverters
--# 558 gates (354 ANDs + 0 NANDs + 204 ORs + 0 NORs)
------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
 
library lis_lib;
use lis_lib.ser_bist.all; 
 
entity s1494_ser_bist is
	generic (
		NUM_FF : integer := 33;
		BIST_LENGTH : integer := 5000
	);
	port (
		clk : in std_logic; 
		reset : in std_logic; 
		CLR: in std_logic; 
		v6: in std_logic; 
		v5: in std_logic; 
		v4: in std_logic; 
		v3: in std_logic; 
		v2: in std_logic; 
		v1: in std_logic; 
		v0: in std_logic; 
		BIST_start_in: in std_logic; 
		Capture_in : in std_logic;
		Capture_out : out std_logic;
		err_code : out std_logic_vector(2 downto 0);
		v13_D_24: out std_logic; 
		v13_D_23: out std_logic; 
		v13_D_22: out std_logic; 
		v13_D_21: out std_logic; 
		v13_D_20: out std_logic; 
		v13_D_19: out std_logic; 
		v13_D_18: out std_logic; 
		v13_D_17: out std_logic; 
		v13_D_16: out std_logic; 
		v13_D_15: out std_logic; 
		v13_D_14: out std_logic; 
		v13_D_13: out std_logic; 
		v13_D_12: out std_logic; 
		v13_D_11: out std_logic; 
		v13_D_10: out std_logic; 
		v13_D_9: out std_logic; 
		v13_D_8: out std_logic; 
		v13_D_7: out std_logic; 
		v13_D_6: out std_logic; 
		BIST_done_out: out std_logic; 
		BIST_result_out: out std_logic 
	);
end entity; 

architecture rtl of s1494_ser_bist is

	signal v13_D_5C, v12, v13_D_4C, v11, v13_D_3C, v10, v13_D_2C, v9, v13_D_1C, v8, v13_D_0C, v7, v4E, C70D, C70DE, C104D, C104DE, C141D, C141DE, C191D, C191DE, C218D, C218DE, C180D, C180DE, C90D, C90DE, v3E, v1E, C30D, C30DE, C194D, C194DE, C117D, C117DE, C195D, C195DE, C208D, C208DE, C118D, C118DE, C138D, C138DE, C220D, C220DE, C166D, C166DE, C49D, C49DE, v5E, C81D, C81DE, C131D, C131DE, v0E, C144D, C144DE, C157D, C157DE, v11E, v6E, C129D, C129DE, v9E, v2E, v10E, v12E, C165D, C165DE, C83D, C83DE, C108D, C108DE, C124D, C124DE, v8E, v7E, Av13_D_24B, I650, Av13_D_23B, I653, Av13_D_22B, I656, Av13_D_21B, I659, Av13_D_20B, I662, Av13_D_19B, I665, Av13_D_18B, I668, Av13_D_17B, I671, Av13_D_16B, I674, Av13_D_15B, I677, Av13_D_14B, I680, Av13_D_13B, I683, Av13_D_12B, I686, Av13_D_11B, I689, Av13_D_10B, I692, Av13_D_9B, I695, Av13_D_8B, I698, Av13_D_7B, I701, Av13_D_6B, I704, Av13_D_5B, I707, v13_D_5, Av13_D_4B, I710, v13_D_4, Av13_D_3B, I713, v13_D_3, Av13_D_2B, I716, v13_D_2, Av13_D_1B, I719, v13_D_1, Av13_D_0B, I722, v13_D_0, I560, I559, I555, I554, I547, I546, I538, I537, I534, I533, I528, I524, I520, I518, I516, I514, I142, I513, I510, I508, I506, I505, I503, I501, I500, I498, II497, I495, I494, I492, II491, I489, I486, I485, I483, I482, I479, I478, I476, I475, I473, I471, I470, I468, I466, I464, I463, I461, I460, I457, I456, I453, I452, I450, I449, I447, I446, I444, I442, I441, I439, I438, I436, I435, I433, I432, I430, I429, I427, I425, I423, I420, I419, I417, I415, I414, I412, I409, I406, I405, I254, I403, I402, I399, I398, I396, I395, I393, I392, I390, I389, I387, I386, I384, I383, I381, I380, I378, I377, I375, C86D, I374, I372, I371, I369, II368, I366, I365, C56D, I363, C178D, I362, I360, C59D, I359, I357, I356, C50D, I354, I352, I350, I349, I347, I346, I344, I342, C159D, I341, I339, I338, I336, I335, I333, I332, I329, II329, I328, I326, I325, I323, C127D, I321, C33D, I320, I318, I317, I315, C155D, I314, I311, C71D, I310, I308, C111D, I306, I305, I303, C172D, I302, I300, C105D, I299, I297, C209D, I296, I294, C211D, I368, I293, I291, C142D, C213D, I288, C203D, I287, I285, C222D, I284, I282, C36D, I281, C29D, I280, C26D, I278, I276, C27D, I275, I273, C201D, I272, I270, C55D, I269, I267, C214D, I266, C200D, I263, C41D, I262, C42D, I260, C78D, I259, I257, C215D, I256, II254, C39D, I253, I251, I250, C77D, I248, C45D, I247, I245, C185D, I243, I242, C130D, I240, C125D, I239, I237, C221D, I236, C219D, I234, C167D, I233, C168D, I232, I230, C109D, I229, I227, C139D, I226, I224, C163D, I223, C160D, I222, C156D, I220, C51D, I219, I218, C44D, I216, C189D, I215, I213, C57D, I212, I210, C120D, I209, C119D, I208, C122D, I206, C150D, I205, I203, C34D, I202, I200, I199, C63D, I197, C158D, I196, C161D, I194, I192, I191, I189, I188, C175D, I186, I185, I183, C183D, I182, I180, C173D, I179, I177, C137D, I176, C145D, I175, I174, C143D, I173, C146D, I171, C193D, I170, I169, I167, I166, C205D, I164, C133D, I163, I161, I160, C65D, I158, C84D, I157, C82D, I156, C80D, I154, C40D, I153, C52D, I152, I151, I149, C112D, I148, I146, C223D, I145, C216D, II142, C169D, I141, C170D, I140, C210D, I137, C46D, I136, C47D, I134, C151D, I133, C152D, I131, I130, C60D, I129, C72D, I128, C69D, I127, C73D, I126, C58D, I124, C164D, I123, C162D, I548, C199D, I120, C123D, I119, C126D, I117, C35D, I116, C37D, I114, C97D, I113, C93D, I112, I111, C98D, I109, C179D, I108, C181D, I106, C114D, I105, C113D, I104, C107D, I103, C115D, I101, C128D, I100, C134D, I98, C87D, I97, C88D, I96, C85D, I95, C76D, I93, C147D, I92, C140D, I91, C148D, I89, C48D, I88, C43D, I87, C53D, I86, C54D, I84, C224D, I83, C225D, I82, C217D, I80, C192D, I79, I78, C196D, I76, C174D, I75, I73, C31D, I72, C38D, I71, C28D, I69, C202D, I68, C206D, I66, C100D, I65, I64, I63, C99D, I62, C95D, I60, C74D, I59, C67D, I58, C75D, C153D, I55, C187D, I54, C186D, I52, C135D, I51, C132D, I49, C176D, I48, C177D, I46, C110D, I45, C116D, I44, C106D, I43, I41, C96D, I40, C92D, I39, C103D, I38, C102D, I36, C89D, I35, C79D, I34, C91D, I32, C207D, I642, I31, I29, C190D, I28, C188D, I27, C184D, I491, I497, I542, I610 : std_logic;

	signal input_mux_sel, SER_BIST_FF_0_ERR_out, SER_BIST_FF_0_Scan_out, SER_BIST_FF_1_ERR_out, SER_BIST_FF_1_Scan_out, SER_BIST_FF_2_ERR_out, SER_BIST_FF_2_Scan_out, SER_BIST_FF_3_ERR_out, SER_BIST_FF_3_Scan_out, SER_BIST_FF_4_ERR_out, SER_BIST_FF_4_Scan_out, SER_BIST_FF_5_ERR_out, SER_BIST_FF_5_Scan_out, MUX_CLR_chain_out, CLR_muxed, MUX_CLR_ERR_out, MUX_CLR_Scan_out, MUX_v6_chain_out, v6_muxed, MUX_v6_ERR_out, MUX_v6_Scan_out, MUX_v5_chain_out, v5_muxed, MUX_v5_ERR_out, MUX_v5_Scan_out, MUX_v4_chain_out, v4_muxed, MUX_v4_ERR_out, MUX_v4_Scan_out, MUX_v3_chain_out, v3_muxed, MUX_v3_ERR_out, MUX_v3_Scan_out, MUX_v2_chain_out, v2_muxed, MUX_v2_ERR_out, MUX_v2_Scan_out, MUX_v1_chain_out, v1_muxed, MUX_v1_ERR_out, MUX_v1_Scan_out, MUX_v0_chain_out, v0_muxed, MUX_v0_ERR_out, MUX_v0_Scan_out : std_logic;

	signal v13_D_24_temp, PO_DFF_0_out, PO_DFF_0_ERR_out, PO_DFF_0_Scan_out, v13_D_23_temp, PO_DFF_1_out, PO_DFF_1_ERR_out, PO_DFF_1_Scan_out, v13_D_22_temp, PO_DFF_2_out, PO_DFF_2_ERR_out, PO_DFF_2_Scan_out, v13_D_21_temp, PO_DFF_3_out, PO_DFF_3_ERR_out, PO_DFF_3_Scan_out, v13_D_20_temp, PO_DFF_4_out, PO_DFF_4_ERR_out, PO_DFF_4_Scan_out, v13_D_19_temp, PO_DFF_5_out, PO_DFF_5_ERR_out, PO_DFF_5_Scan_out, v13_D_18_temp, PO_DFF_6_out, PO_DFF_6_ERR_out, PO_DFF_6_Scan_out, v13_D_17_temp, PO_DFF_7_out, PO_DFF_7_ERR_out, PO_DFF_7_Scan_out, v13_D_16_temp, PO_DFF_8_out, PO_DFF_8_ERR_out, PO_DFF_8_Scan_out, v13_D_15_temp, PO_DFF_9_out, PO_DFF_9_ERR_out, PO_DFF_9_Scan_out, v13_D_14_temp, PO_DFF_10_out, PO_DFF_10_ERR_out, PO_DFF_10_Scan_out, v13_D_13_temp, PO_DFF_11_out, PO_DFF_11_ERR_out, PO_DFF_11_Scan_out, v13_D_12_temp, PO_DFF_12_out, PO_DFF_12_ERR_out, PO_DFF_12_Scan_out, v13_D_11_temp, PO_DFF_13_out, PO_DFF_13_ERR_out, PO_DFF_13_Scan_out, v13_D_10_temp, PO_DFF_14_out, PO_DFF_14_ERR_out, PO_DFF_14_Scan_out, v13_D_9_temp, PO_DFF_15_out, PO_DFF_15_ERR_out, PO_DFF_15_Scan_out, v13_D_8_temp, PO_DFF_16_out, PO_DFF_16_ERR_out, PO_DFF_16_Scan_out, v13_D_7_temp, PO_DFF_17_out, PO_DFF_17_ERR_out, PO_DFF_17_Scan_out, v13_D_6_temp, PO_DFF_18_out, PO_DFF_18_ERR_out, PO_DFF_18_Scan_out : std_logic;

	signal OR_tree_out, spc_par_ok_out, ctrl_read_memory_out, ctrl_Hold_out, ctrl_par_hold_out, ctrl_par_reset_out, ctrl_Rollback_out, ctrl_BIST_eval_out, ctrl_B0_out, ctrl_B1_out, ctrl_Capture_out, ctrl_Scan_out, ctrl_AFF_scan_out, HFF_mux_sel : std_logic;
	signal ctrl_err_code_out : std_logic_vector(2 downto 0);
	signal ctrl_read_address_out : std_logic_vector(TBA downto 0);

	signal memory_serializer_reset, mem_pattern_out, mem_response_out : std_ulogic := '0';
	signal AFF_chain_input, AFF_chain_input_MUX_sel : std_ulogic := '0';

	COMPONENT s1494_ser_bist_memory 
		PORT( 
			clk : IN std_logic; 
 			reset : IN std_logic; 
 			start : IN std_logic; 
 			read_address : IN std_logic_vector(TBA downto 0); 
 			pattern_out : OUT std_logic; 
 			response_out : OUT std_logic 
 		);
 	END COMPONENT;

begin

	memory_serializer_reset <= reset OR BIST_start_in;

MEM: s1494_ser_bist_memory 
		port map( 
			clk				=> clk, 
 			reset			=> memory_serializer_reset, 
 			start			=> ctrl_read_memory_out, 
 			read_address	=> ctrl_read_address_out, 
 			pattern_out		=> mem_pattern_out, 
 			response_out	=> mem_response_out 
 		);



CTRL:	lis_ser_bist_controller
			generic map( 
				NUM_FF				=> NUM_FF,
				BIST_LENGTH			=> BIST_LENGTH,
				MEM_ADDR_WIDTH		=> TBA!,
				MEM_ADDR_OFFSET		=> TBA!,
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
				input_mux_sel		=> input_mux_sel,
				AFF_chain_input_MUX_sel		=> AFF_chain_input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_out		=> ctrl_Scan_out,
				AFF_Scan_out	=> ctrl_AFF_scan_out
			);


	 err_code		<= ctrl_err_code_out;
	 HFF_MUX_sel	<= ctrl_B1_out OR ctrl_Capture_out ;
--------------------------------------------------------------------------------
--                    START INPUT ISOLATION MUXES                             --
--------------------------------------------------------------------------------
AFF_chain_input_MUX: lis_mux
port map (
	A_in	=> PO_DFF_18_out,
	B_in	=> ctrl_AFF_scan_out,
	sel_in	=> AFF_chain_input_MUX_sel,
	C_out	=> AFF_chain_input
);

MUX_CLR:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> reset,
 				PI_in			=> CLR,
				chain_in		=> AFF_chain_input,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> ctrl_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_CLR_ERR_out,
				Scan_out		=> MUX_CLR_Scan_out,
				mux_out			=> CLR_muxed,
				chain_out		=> MUX_CLR_chain_out 
			);

MUX_v6:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> reset,
 				PI_in			=> v6,
				chain_in		=> MUX_CLR_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_CLR_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_v6_ERR_out,
				Scan_out		=> MUX_v6_Scan_out,
				mux_out			=> v6_muxed,
				chain_out		=> MUX_v6_chain_out 
			);

MUX_v5:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> reset,
 				PI_in			=> v5,
				chain_in		=> MUX_v6_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_v6_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_v5_ERR_out,
				Scan_out		=> MUX_v5_Scan_out,
				mux_out			=> v5_muxed,
				chain_out		=> MUX_v5_chain_out 
			);

MUX_v4:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> reset,
 				PI_in			=> v4,
				chain_in		=> MUX_v5_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_v5_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_v4_ERR_out,
				Scan_out		=> MUX_v4_Scan_out,
				mux_out			=> v4_muxed,
				chain_out		=> MUX_v4_chain_out 
			);

MUX_v3:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> reset,
 				PI_in			=> v3,
				chain_in		=> MUX_v4_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_v4_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_v3_ERR_out,
				Scan_out		=> MUX_v3_Scan_out,
				mux_out			=> v3_muxed,
				chain_out		=> MUX_v3_chain_out 
			);

MUX_v2:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> reset,
 				PI_in			=> v2,
				chain_in		=> MUX_v3_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_v3_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_v2_ERR_out,
				Scan_out		=> MUX_v2_Scan_out,
				mux_out			=> v2_muxed,
				chain_out		=> MUX_v2_chain_out 
			);

MUX_v1:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> reset,
 				PI_in			=> v1,
				chain_in		=> MUX_v2_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_v2_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_v1_ERR_out,
				Scan_out		=> MUX_v1_Scan_out,
				mux_out			=> v1_muxed,
				chain_out		=> MUX_v1_chain_out 
			);

MUX_v0:	lis_ser_bist_input_isol_sr 
			port map( 
				clk				=> clk,
				reset			=> reset,
 				PI_in			=> v0,
				chain_in		=> MUX_v1_chain_out,
				sel_in			=> input_mux_sel,
				HFF_MUX_sel		=> HFF_MUX_sel,
				Scan_in			=> MUX_v1_Scan_out,
				Test_Done_in	=> ctrl_BIST_eval_out,
				Hold_in			=> ctrl_Hold_out,
				Rollback_in		=> ctrl_Rollback_out,
				ERR_out			=> MUX_v0_ERR_out,
				Scan_out		=> MUX_v0_Scan_out,
				mux_out			=> v0_muxed,
				chain_out		=> MUX_v0_chain_out 
			);

--------------------------------------------------------------------------------
--                      END INPUT ISOLATION MUXES                             --
--------------------------------------------------------------------------------

--Flip-flops (total number: 6)
SER_BIST_FF_0:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> v13_D_5C, 
 			Q_in		=> MUX_v0_chain_out, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> MUX_v0_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_0_ERR_out, 
 			Scan_out	=> SER_BIST_FF_0_Scan_out, 
 			Q_out		=> v12 
 		);

SER_BIST_FF_1:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> v13_D_4C, 
 			Q_in		=> v12, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_0_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_1_ERR_out, 
 			Scan_out	=> SER_BIST_FF_1_Scan_out, 
 			Q_out		=> v11 
 		);

SER_BIST_FF_2:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> v13_D_3C, 
 			Q_in		=> v11, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_1_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_2_ERR_out, 
 			Scan_out	=> SER_BIST_FF_2_Scan_out, 
 			Q_out		=> v10 
 		);

SER_BIST_FF_3:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> v13_D_2C, 
 			Q_in		=> v10, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_2_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_3_ERR_out, 
 			Scan_out	=> SER_BIST_FF_3_Scan_out, 
 			Q_out		=> v9 
 		);

SER_BIST_FF_4:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> v13_D_1C, 
 			Q_in		=> v9, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_3_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_4_ERR_out, 
 			Scan_out	=> SER_BIST_FF_4_Scan_out, 
 			Q_out		=> v8 
 		);

SER_BIST_FF_5:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> v13_D_0C, 
 			Q_in		=> v8, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_4_Scan_out, 
 			Test_Done	=> ctrl_BIST_eval_out, 
 			Hold_in		=> ctrl_Hold_out, 
 			Rollback_in	=> ctrl_Rollback_out, 
 			ERR_out		=> SER_BIST_FF_5_ERR_out, 
 			Scan_out	=> SER_BIST_FF_5_Scan_out, 
 			Q_out		=> v7 
 		);

------------------------------------------------------------------------
--                 START PRIMARY OUTPUT HANDLING                      --
------------------------------------------------------------------------
PO_DFF_0:	lis_ser_bist_ff 
		port map( 
			clk			=> clk, 
 			reset		=> reset, 
 			D_in		=> v13_D_24_temp, 
 			Q_in		=> v7, 
 			B0_in		=> ctrl_B0_out, 
 			B1_in		=> ctrl_B1_out,
			HFF_MUX_sel => HFF_MUX_sel, 
 			Scan_in		=> SER_BIST_FF_5_Scan_out, 
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
 			D_in		=> v13_D_23_temp, 
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
 			D_in		=> v13_D_22_temp, 
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
 			D_in		=> v13_D_21_temp, 
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
 			D_in		=> v13_D_20_temp, 
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
 			D_in		=> v13_D_19_temp, 
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
 			D_in		=> v13_D_18_temp, 
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
 			D_in		=> v13_D_17_temp, 
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
 			D_in		=> v13_D_16_temp, 
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
 			D_in		=> v13_D_15_temp, 
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
 			D_in		=> v13_D_14_temp, 
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
 			D_in		=> v13_D_13_temp, 
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
 			D_in		=> v13_D_12_temp, 
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
 			D_in		=> v13_D_11_temp, 
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
 			D_in		=> v13_D_10_temp, 
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
 			D_in		=> v13_D_9_temp, 
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
 			D_in		=> v13_D_8_temp, 
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
 			D_in		=> v13_D_7_temp, 
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
 			D_in		=> v13_D_6_temp, 
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

Capture_out	 <= PO_DFF_18_Scan_out;

output_temp_proc: process(v13_D_24_temp, v13_D_23_temp, v13_D_22_temp, v13_D_21_temp, v13_D_20_temp, v13_D_19_temp, v13_D_18_temp, v13_D_17_temp, v13_D_16_temp, v13_D_15_temp, v13_D_14_temp, v13_D_13_temp, v13_D_12_temp, v13_D_11_temp, v13_D_10_temp, v13_D_9_temp, v13_D_8_temp, v13_D_7_temp, v13_D_6_temp)
begin
	v13_D_24 <= v13_D_24_temp;
	v13_D_23 <= v13_D_23_temp;
	v13_D_22 <= v13_D_22_temp;
	v13_D_21 <= v13_D_21_temp;
	v13_D_20 <= v13_D_20_temp;
	v13_D_19 <= v13_D_19_temp;
	v13_D_18 <= v13_D_18_temp;
	v13_D_17 <= v13_D_17_temp;
	v13_D_16 <= v13_D_16_temp;
	v13_D_15 <= v13_D_15_temp;
	v13_D_14 <= v13_D_14_temp;
	v13_D_13 <= v13_D_13_temp;
	v13_D_12 <= v13_D_12_temp;
	v13_D_11 <= v13_D_11_temp;
	v13_D_10 <= v13_D_10_temp;
	v13_D_9 <= v13_D_9_temp;
	v13_D_8 <= v13_D_8_temp;
	v13_D_7 <= v13_D_7_temp;
	v13_D_6 <= v13_D_6_temp;
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
				scan_hffs_in	=> PO_DFF_18_Scan_out,
				par_hold		=> ctrl_par_hold_out,
				par_ok			=> spc_par_ok_out
			);
------------------------------------------------------------------------
--             END PARITY CHECKING OF EXPECTED RESPONSE               --
------------------------------------------------------------------------
------------------------------------------------------------------------
--                          START OR-TREE                             --
------------------------------------------------------------------------
OR_tree_out <= MUX_CLR_ERR_out OR MUX_v6_ERR_out OR MUX_v5_ERR_out OR MUX_v4_ERR_out OR MUX_v3_ERR_out OR MUX_v2_ERR_out OR MUX_v1_ERR_out OR MUX_v0_ERR_out OR SER_BIST_FF_0_ERR_out OR SER_BIST_FF_1_ERR_out OR SER_BIST_FF_2_ERR_out OR SER_BIST_FF_3_ERR_out OR SER_BIST_FF_4_ERR_out OR SER_BIST_FF_5_ERR_out OR PO_DFF_0_ERR_out OR PO_DFF_1_ERR_out OR PO_DFF_2_ERR_out OR PO_DFF_3_ERR_out OR PO_DFF_4_ERR_out OR PO_DFF_5_ERR_out OR PO_DFF_6_ERR_out OR PO_DFF_7_ERR_out OR PO_DFF_8_ERR_out OR PO_DFF_9_ERR_out OR PO_DFF_10_ERR_out OR PO_DFF_11_ERR_out OR PO_DFF_12_ERR_out OR PO_DFF_13_ERR_out OR PO_DFF_14_ERR_out OR PO_DFF_15_ERR_out OR PO_DFF_16_ERR_out OR PO_DFF_17_ERR_out OR PO_DFF_18_ERR_out;
------------------------------------------------------------------------
--                           END OR-TREE                              --
------------------------------------------------------------------------

--Inverters (total number: 89)
INV_0:	 lis_not port map( A => v4_muxed, Z => v4E );
INV_1:	 lis_not port map( A => C70D, Z => C70DE );
INV_2:	 lis_not port map( A => C104D, Z => C104DE );
INV_3:	 lis_not port map( A => C141D, Z => C141DE );
INV_4:	 lis_not port map( A => C191D, Z => C191DE );
INV_5:	 lis_not port map( A => C218D, Z => C218DE );
INV_6:	 lis_not port map( A => C180D, Z => C180DE );
INV_7:	 lis_not port map( A => C90D, Z => C90DE );
INV_8:	 lis_not port map( A => v3_muxed, Z => v3E );
INV_9:	 lis_not port map( A => v1_muxed, Z => v1E );
INV_10:	 lis_not port map( A => C30D, Z => C30DE );
INV_11:	 lis_not port map( A => C194D, Z => C194DE );
INV_12:	 lis_not port map( A => C117D, Z => C117DE );
INV_13:	 lis_not port map( A => C195D, Z => C195DE );
INV_14:	 lis_not port map( A => C208D, Z => C208DE );
INV_15:	 lis_not port map( A => C118D, Z => C118DE );
INV_16:	 lis_not port map( A => C138D, Z => C138DE );
INV_17:	 lis_not port map( A => C220D, Z => C220DE );
INV_18:	 lis_not port map( A => C166D, Z => C166DE );
INV_19:	 lis_not port map( A => C49D, Z => C49DE );
INV_20:	 lis_not port map( A => v5_muxed, Z => v5E );
INV_21:	 lis_not port map( A => C81D, Z => C81DE );
INV_22:	 lis_not port map( A => C131D, Z => C131DE );
INV_23:	 lis_not port map( A => v0_muxed, Z => v0E );
INV_24:	 lis_not port map( A => C144D, Z => C144DE );
INV_25:	 lis_not port map( A => C157D, Z => C157DE );
INV_26:	 lis_not port map( A => v11, Z => v11E );
INV_27:	 lis_not port map( A => v6_muxed, Z => v6E );
INV_28:	 lis_not port map( A => C129D, Z => C129DE );
INV_29:	 lis_not port map( A => v9, Z => v9E );
INV_30:	 lis_not port map( A => v2_muxed, Z => v2E );
INV_31:	 lis_not port map( A => v10, Z => v10E );
INV_32:	 lis_not port map( A => v12, Z => v12E );
INV_33:	 lis_not port map( A => C165D, Z => C165DE );
INV_34:	 lis_not port map( A => C83D, Z => C83DE );
INV_35:	 lis_not port map( A => C108D, Z => C108DE );
INV_36:	 lis_not port map( A => C124D, Z => C124DE );
INV_37:	 lis_not port map( A => v8, Z => v8E );
INV_38:	 lis_not port map( A => v7, Z => v7E );
INV_39:	 lis_not port map( A => Av13_D_24B, Z => I650 );
INV_40:	 lis_not port map( A => I650, Z => v13_D_24_temp );
INV_41:	 lis_not port map( A => Av13_D_23B, Z => I653 );
INV_42:	 lis_not port map( A => I653, Z => v13_D_23_temp );
INV_43:	 lis_not port map( A => Av13_D_22B, Z => I656 );
INV_44:	 lis_not port map( A => I656, Z => v13_D_22_temp );
INV_45:	 lis_not port map( A => Av13_D_21B, Z => I659 );
INV_46:	 lis_not port map( A => I659, Z => v13_D_21_temp );
INV_47:	 lis_not port map( A => Av13_D_20B, Z => I662 );
INV_48:	 lis_not port map( A => I662, Z => v13_D_20_temp );
INV_49:	 lis_not port map( A => Av13_D_19B, Z => I665 );
INV_50:	 lis_not port map( A => I665, Z => v13_D_19_temp );
INV_51:	 lis_not port map( A => Av13_D_18B, Z => I668 );
INV_52:	 lis_not port map( A => I668, Z => v13_D_18_temp );
INV_53:	 lis_not port map( A => Av13_D_17B, Z => I671 );
INV_54:	 lis_not port map( A => I671, Z => v13_D_17_temp );
INV_55:	 lis_not port map( A => Av13_D_16B, Z => I674 );
INV_56:	 lis_not port map( A => I674, Z => v13_D_16_temp );
INV_57:	 lis_not port map( A => Av13_D_15B, Z => I677 );
INV_58:	 lis_not port map( A => I677, Z => v13_D_15_temp );
INV_59:	 lis_not port map( A => Av13_D_14B, Z => I680 );
INV_60:	 lis_not port map( A => I680, Z => v13_D_14_temp );
INV_61:	 lis_not port map( A => Av13_D_13B, Z => I683 );
INV_62:	 lis_not port map( A => I683, Z => v13_D_13_temp );
INV_63:	 lis_not port map( A => Av13_D_12B, Z => I686 );
INV_64:	 lis_not port map( A => I686, Z => v13_D_12_temp );
INV_65:	 lis_not port map( A => Av13_D_11B, Z => I689 );
INV_66:	 lis_not port map( A => I689, Z => v13_D_11_temp );
INV_67:	 lis_not port map( A => Av13_D_10B, Z => I692 );
INV_68:	 lis_not port map( A => I692, Z => v13_D_10_temp );
INV_69:	 lis_not port map( A => Av13_D_9B, Z => I695 );
INV_70:	 lis_not port map( A => I695, Z => v13_D_9_temp );
INV_71:	 lis_not port map( A => Av13_D_8B, Z => I698 );
INV_72:	 lis_not port map( A => I698, Z => v13_D_8_temp );
INV_73:	 lis_not port map( A => Av13_D_7B, Z => I701 );
INV_74:	 lis_not port map( A => I701, Z => v13_D_7_temp );
INV_75:	 lis_not port map( A => Av13_D_6B, Z => I704 );
INV_76:	 lis_not port map( A => I704, Z => v13_D_6_temp );
INV_77:	 lis_not port map( A => Av13_D_5B, Z => I707 );
INV_78:	 lis_not port map( A => I707, Z => v13_D_5 );
INV_79:	 lis_not port map( A => Av13_D_4B, Z => I710 );
INV_80:	 lis_not port map( A => I710, Z => v13_D_4 );
INV_81:	 lis_not port map( A => Av13_D_3B, Z => I713 );
INV_82:	 lis_not port map( A => I713, Z => v13_D_3 );
INV_83:	 lis_not port map( A => Av13_D_2B, Z => I716 );
INV_84:	 lis_not port map( A => I716, Z => v13_D_2 );
INV_85:	 lis_not port map( A => Av13_D_1B, Z => I719 );
INV_86:	 lis_not port map( A => I719, Z => v13_D_1 );
INV_87:	 lis_not port map( A => Av13_D_0B, Z => I722 );
INV_88:	 lis_not port map( A => I722, Z => v13_D_0 );

--AND-gates (total number: 354)
AND2_0:	 LIS_AND2 port map( A => v13_D_5, B => CLR_muxed, Z => v13_D_5C);
AND2_1:	 LIS_AND2 port map( A => v13_D_4, B => CLR_muxed, Z => v13_D_4C);
AND2_2:	 LIS_AND2 port map( A => v13_D_3, B => CLR_muxed, Z => v13_D_3C);
AND2_3:	 LIS_AND2 port map( A => v13_D_2, B => CLR_muxed, Z => v13_D_2C);
AND2_4:	 LIS_AND2 port map( A => v13_D_1, B => CLR_muxed, Z => v13_D_1C);
AND2_5:	 LIS_AND2 port map( A => v13_D_0, B => CLR_muxed, Z => v13_D_0C);
AND2_6:	 LIS_AND2 port map( A => v7E, B => v12E, Z => I560);
AND2_7:	 LIS_AND2 port map( A => v8, B => v11, Z => I559);
AND3_0:	 LIS_AND3 port map( A => v0_muxed, B => v8E, C => v11, Z => I555 );
AND3_1:	 LIS_AND3 port map( A => v2E, B => v8, C => v9E, Z => I554 );
AND2_8:	 LIS_AND2 port map( A => v10, B => v11E, Z => I547);
AND2_9:	 LIS_AND2 port map( A => v0_muxed, B => v11, Z => I546);
AND2_10:	 LIS_AND2 port map( A => v8, B => v12E, Z => I538);
AND4_0:	 LIS_AND4 port map( A => v6E, B => v7E, C => v8E, D => v12, Z => I537 );
AND2_11:	 LIS_AND2 port map( A => v8E, B => v10E, Z => I534);
AND2_12:	 LIS_AND2 port map( A => v9, B => v10, Z => I533);
AND2_13:	 LIS_AND2 port map( A => v9E, B => v11, Z => I528);
AND2_14:	 LIS_AND2 port map( A => v6_muxed, B => v11E, Z => I524);
AND2_15:	 LIS_AND2 port map( A => v3E, B => v6E, Z => I520);
AND2_16:	 LIS_AND2 port map( A => v9, B => v10E, Z => I518);
AND2_17:	 LIS_AND2 port map( A => v1_muxed, B => v12, Z => I516);
AND4_1:	 LIS_AND4 port map( A => v2_muxed, B => v7, C => v9E, D => C138DE, Z => I514 );
AND3_2:	 LIS_AND3 port map( A => v7E, B => v9, C => v11E, Z => I142 );
AND3_3:	 LIS_AND3 port map( A => v12E, B => C166DE, C => I142, Z => I513 );
AND2_18:	 LIS_AND2 port map( A => v9, B => v10, Z => I510);
AND2_19:	 LIS_AND2 port map( A => v9E, B => v11E, Z => I508);
AND4_2:	 LIS_AND4 port map( A => v7E, B => v9, C => v10E, D => v12E, Z => I506 );
AND4_3:	 LIS_AND4 port map( A => v7, B => v8, C => C138DE, D => C191DE, Z => I505 );
AND2_20:	 LIS_AND2 port map( A => v9E, B => C30DE, Z => I503);
AND2_21:	 LIS_AND2 port map( A => v8E, B => v11E, Z => I501);
AND3_4:	 LIS_AND3 port map( A => v8, B => v11, C => C83DE, Z => I500 );
AND2_22:	 LIS_AND2 port map( A => v8, B => C117DE, Z => I498);
AND3_5:	 LIS_AND3 port map( A => v8E, B => v9E, C => C194DE, Z => II497 );
AND3_6:	 LIS_AND3 port map( A => v9, B => v11, C => C131DE, Z => I495 );
AND3_7:	 LIS_AND3 port map( A => v8E, B => v10, C => C108DE, Z => I494 );
AND2_23:	 LIS_AND2 port map( A => v10, B => v11E, Z => I492);
AND2_24:	 LIS_AND2 port map( A => v10E, B => C138DE, Z => II491);
AND2_25:	 LIS_AND2 port map( A => v8E, B => v11, Z => I489);
AND4_4:	 LIS_AND4 port map( A => v6E, B => v8E, C => v12, D => C129DE, Z => I486 );
AND3_8:	 LIS_AND3 port map( A => v6_muxed, B => C141DE, C => C220DE, Z => I485 );
AND4_5:	 LIS_AND4 port map( A => v8E, B => v9E, C => v11E, D => C83DE, Z => I483 );
AND2_26:	 LIS_AND2 port map( A => v2_muxed, B => C220DE, Z => I482);
AND2_27:	 LIS_AND2 port map( A => v0_muxed, B => v11, Z => I479);
AND2_28:	 LIS_AND2 port map( A => v10E, B => C83DE, Z => I478);
AND4_6:	 LIS_AND4 port map( A => v8E, B => v9, C => v11E, D => v12E, Z => I476 );
AND3_9:	 LIS_AND3 port map( A => v2E, B => v8, C => C138DE, Z => I475 );
AND2_29:	 LIS_AND2 port map( A => v0E, B => C30DE, Z => I473);
AND3_10:	 LIS_AND3 port map( A => v1_muxed, B => v10E, C => v12, Z => I471 );
AND3_11:	 LIS_AND3 port map( A => v8, B => v12E, C => C83DE, Z => I470 );
AND2_30:	 LIS_AND2 port map( A => v9, B => C83DE, Z => I468);
AND3_12:	 LIS_AND3 port map( A => v8E, B => v11E, C => v12E, Z => I466 );
AND3_13:	 LIS_AND3 port map( A => v8E, B => v10E, C => v11, Z => I464 );
AND2_31:	 LIS_AND2 port map( A => C165DE, B => C191DE, Z => I463);
AND3_14:	 LIS_AND3 port map( A => v8E, B => v9, C => v12, Z => I461 );
AND3_15:	 LIS_AND3 port map( A => v2E, B => v12E, C => C165DE, Z => I460 );
AND3_16:	 LIS_AND3 port map( A => v6_muxed, B => C124DE, C => C90DE, Z => I457 );
AND2_32:	 LIS_AND2 port map( A => v9, B => C30DE, Z => I456);
AND3_17:	 LIS_AND3 port map( A => v8E, B => v10E, C => v12, Z => I453 );
AND2_33:	 LIS_AND2 port map( A => v12E, B => C220DE, Z => I452);
AND4_7:	 LIS_AND4 port map( A => v3_muxed, B => v8, C => C138DE, D => C104DE, Z => I450 );
AND2_34:	 LIS_AND2 port map( A => C108DE, B => C83DE, Z => I449);
AND4_8:	 LIS_AND4 port map( A => v8E, B => v9, C => v10E, D => v12E, Z => I447 );
AND2_35:	 LIS_AND2 port map( A => v11E, B => C90DE, Z => I446);
AND2_36:	 LIS_AND2 port map( A => v3E, B => v9E, Z => I444);
AND3_18:	 LIS_AND3 port map( A => v7E, B => v8E, C => v9E, Z => I442 );
AND2_37:	 LIS_AND2 port map( A => v11, B => C220DE, Z => I441);
AND3_19:	 LIS_AND3 port map( A => v6_muxed, B => v12, C => C124DE, Z => I439 );
AND3_20:	 LIS_AND3 port map( A => v0_muxed, B => v10, C => C144DE, Z => I438 );
AND3_21:	 LIS_AND3 port map( A => v8E, B => v9, C => C144DE, Z => I436 );
AND2_38:	 LIS_AND2 port map( A => v12, B => C165DE, Z => I435);
AND2_39:	 LIS_AND2 port map( A => v10, B => C144DE, Z => I433);
AND2_40:	 LIS_AND2 port map( A => v7, B => C90DE, Z => I432);
AND3_22:	 LIS_AND3 port map( A => v1E, B => v9, C => v10E, Z => I430 );
AND2_41:	 LIS_AND2 port map( A => v9E, B => C30DE, Z => I429);
AND3_23:	 LIS_AND3 port map( A => v8E, B => v9, C => v10, Z => I427 );
AND2_42:	 LIS_AND2 port map( A => v8E, B => v10E, Z => I425);
AND2_43:	 LIS_AND2 port map( A => v3E, B => C157DE, Z => I423);
AND3_24:	 LIS_AND3 port map( A => v2E, B => v7, C => C131DE, Z => I420 );
AND4_9:	 LIS_AND4 port map( A => v5E, B => v7E, C => v8E, D => C30DE, Z => I419 );
AND3_25:	 LIS_AND3 port map( A => v5E, B => v11E, C => v12E, Z => I417 );
AND3_26:	 LIS_AND3 port map( A => v8E, B => v11E, C => v12E, Z => I415 );
AND2_44:	 LIS_AND2 port map( A => v6_muxed, B => C138DE, Z => I414);
AND3_27:	 LIS_AND3 port map( A => v3_muxed, B => v10E, C => v12E, Z => I412 );
AND2_45:	 LIS_AND2 port map( A => v9, B => v11E, Z => I409);
AND3_28:	 LIS_AND3 port map( A => v8, B => v11, C => C117DE, Z => I406 );
AND3_29:	 LIS_AND3 port map( A => v8E, B => v9E, C => C194DE, Z => I405 );
AND4_10:	 LIS_AND4 port map( A => v1_muxed, B => v6_muxed, C => v7E, D => v8E, Z => I254 );
AND4_11:	 LIS_AND4 port map( A => v9, B => v12E, C => C124DE, D => I254, Z => I403 );
AND3_30:	 LIS_AND3 port map( A => v8, B => v9E, C => C30DE, Z => I402 );
AND2_46:	 LIS_AND2 port map( A => v8, B => C141D, Z => I399);
AND2_47:	 LIS_AND2 port map( A => v12E, B => C118DE, Z => I398);
AND2_48:	 LIS_AND2 port map( A => v10E, B => v12E, Z => I396);
AND2_49:	 LIS_AND2 port map( A => C157D, B => v9E, Z => I395);
AND2_50:	 LIS_AND2 port map( A => v10E, B => v12E, Z => I393);
AND2_51:	 LIS_AND2 port map( A => C81D, B => v11E, Z => I392);
AND2_52:	 LIS_AND2 port map( A => C220D, B => v10E, Z => I390);
AND3_31:	 LIS_AND3 port map( A => v8, B => v9, C => v10, Z => I389 );
AND3_32:	 LIS_AND3 port map( A => v8E, B => v9E, C => C124DE, Z => I387 );
AND4_12:	 LIS_AND4 port map( A => v0_muxed, B => C104D, C => v8, D => C30DE, Z => I386 );
AND2_53:	 LIS_AND2 port map( A => v10E, B => C138DE, Z => I384);
AND2_54:	 LIS_AND2 port map( A => C70D, B => C141DE, Z => I383);
AND2_55:	 LIS_AND2 port map( A => C166D, B => v11E, Z => I381);
AND2_56:	 LIS_AND2 port map( A => v2_muxed, B => v11, Z => I380);
AND4_13:	 LIS_AND4 port map( A => C218D, B => v5E, C => v9, D => v12E, Z => I378 );
AND3_33:	 LIS_AND3 port map( A => v7, B => v10, C => C90DE, Z => I377 );
AND2_57:	 LIS_AND2 port map( A => C86D, B => v10E, Z => I375);
AND2_58:	 LIS_AND2 port map( A => v9E, B => C30DE, Z => I374);
AND2_59:	 LIS_AND2 port map( A => C129D, B => v12E, Z => I372);
AND2_60:	 LIS_AND2 port map( A => v10E, B => C90DE, Z => I371);
AND2_61:	 LIS_AND2 port map( A => v9, B => C124DE, Z => I369);
AND2_62:	 LIS_AND2 port map( A => C30D, B => C90DE, Z => II368);
AND4_14:	 LIS_AND4 port map( A => v8E, B => v9, C => v11E, D => v12E, Z => I366 );
AND3_34:	 LIS_AND3 port map( A => C56D, B => v8, C => v11, Z => I365 );
AND2_63:	 LIS_AND2 port map( A => v1E, B => C178D, Z => I363);
AND2_64:	 LIS_AND2 port map( A => v8, B => C138DE, Z => I362);
AND2_65:	 LIS_AND2 port map( A => v3E, B => C59D, Z => I360);
AND2_66:	 LIS_AND2 port map( A => v12E, B => C165DE, Z => I359);
AND2_67:	 LIS_AND2 port map( A => v10, B => v11E, Z => I357);
AND2_68:	 LIS_AND2 port map( A => C50D, B => v10E, Z => I356);
AND2_69:	 LIS_AND2 port map( A => C191D, B => v11, Z => I354);
AND2_70:	 LIS_AND2 port map( A => v8, B => C124D, Z => I352);
AND2_71:	 LIS_AND2 port map( A => v11, B => C117D, Z => I350);
AND2_72:	 LIS_AND2 port map( A => C118D, B => v11E, Z => I349);
AND2_73:	 LIS_AND2 port map( A => C90D, B => v10E, Z => I347);
AND2_74:	 LIS_AND2 port map( A => v12, B => C191DE, Z => I346);
AND2_75:	 LIS_AND2 port map( A => C83D, B => v12E, Z => I344);
AND2_76:	 LIS_AND2 port map( A => C159D, B => v8E, Z => I342);
AND2_77:	 LIS_AND2 port map( A => v11E, B => C118DE, Z => I341);
AND2_78:	 LIS_AND2 port map( A => v8E, B => C144DE, Z => I339);
AND2_79:	 LIS_AND2 port map( A => C108D, B => C165DE, Z => I338);
AND2_80:	 LIS_AND2 port map( A => C124D, B => v12, Z => I336);
AND2_81:	 LIS_AND2 port map( A => v12E, B => C218DE, Z => I335);
AND2_82:	 LIS_AND2 port map( A => v11E, B => v12E, Z => I333);
AND2_83:	 LIS_AND2 port map( A => C138D, B => v9E, Z => I332);
AND3_35:	 LIS_AND3 port map( A => v3_muxed, B => v7E, C => v10, Z => I329 );
AND4_15:	 LIS_AND4 port map( A => C138DE, B => C220DE, C => C104D, D => I329, Z => Av13_D_20B );
AND3_36:	 LIS_AND3 port map( A => v9, B => v12, C => C30D, Z => II329 );
AND3_37:	 LIS_AND3 port map( A => v3_muxed, B => v12E, C => C124DE, Z => I328 );
AND2_84:	 LIS_AND2 port map( A => C81DE, B => C129D, Z => I326);
AND2_85:	 LIS_AND2 port map( A => v10, B => C90DE, Z => I325);
AND2_86:	 LIS_AND2 port map( A => v10E, B => C127D, Z => I323);
AND3_38:	 LIS_AND3 port map( A => C33D, B => v11E, C => v12E, Z => I321 );
AND2_87:	 LIS_AND2 port map( A => v11, B => C141D, Z => I320);
AND2_88:	 LIS_AND2 port map( A => v11, B => C118D, Z => I318);
AND2_89:	 LIS_AND2 port map( A => v10, B => v11E, Z => I317);
AND3_39:	 LIS_AND3 port map( A => C155D, B => v12E, C => C129D, Z => I315 );
AND2_90:	 LIS_AND2 port map( A => v10, B => C90DE, Z => I314);
AND2_91:	 LIS_AND2 port map( A => C71D, B => v9E, Z => I311);
AND4_16:	 LIS_AND4 port map( A => v6E, B => v9, C => v12E, D => C124DE, Z => I310 );
AND2_92:	 LIS_AND2 port map( A => C111D, B => C144DE, Z => I308);
AND2_93:	 LIS_AND2 port map( A => C129DE, B => C138D, Z => I306);
AND2_94:	 LIS_AND2 port map( A => v9, B => C49DE, Z => I305);
AND2_95:	 LIS_AND2 port map( A => C172D, B => v12E, Z => I303);
AND2_96:	 LIS_AND2 port map( A => v11E, B => C157DE, Z => I302);
AND2_97:	 LIS_AND2 port map( A => v0E, B => C105D, Z => I300);
AND2_98:	 LIS_AND2 port map( A => v11E, B => C108DE, Z => I299);
AND3_40:	 LIS_AND3 port map( A => C209D, B => C208D, C => v11, Z => I297 );
AND4_17:	 LIS_AND4 port map( A => v8E, B => v9E, C => C124DE, D => C83DE, Z => I296 );
AND4_18:	 LIS_AND4 port map( A => C211D, B => v3_muxed, C => v7E, D => v11E, Z => I294 );
AND3_41:	 LIS_AND3 port map( A => v7, B => v8, C => v9E, Z => I368 );
AND3_42:	 LIS_AND3 port map( A => C138DE, B => C118DE, C => I368, Z => I293 );
AND2_99:	 LIS_AND2 port map( A => C142D, B => v11, Z => I291);
AND4_19:	 LIS_AND4 port map( A => C213D, B => v7E, C => v10E, D => v12E, Z => Av13_D_21B );
AND2_100:	 LIS_AND2 port map( A => v7E, B => C203D, Z => I288);
AND2_101:	 LIS_AND2 port map( A => v9, B => v11, Z => I287);
AND2_102:	 LIS_AND2 port map( A => C222D, B => v10E, Z => I285);
AND2_103:	 LIS_AND2 port map( A => v11E, B => C157DE, Z => I284);
AND2_104:	 LIS_AND2 port map( A => C36D, B => v12, Z => I282);
AND2_105:	 LIS_AND2 port map( A => v3E, B => C29D, Z => I281);
AND2_106:	 LIS_AND2 port map( A => v1E, B => C26D, Z => I280);
AND2_107:	 LIS_AND2 port map( A => v10E, B => C138DE, Z => I278);
AND4_20:	 LIS_AND4 port map( A => C27D, B => v7E, C => v9, D => v12E, Z => I276 );
AND3_43:	 LIS_AND3 port map( A => v7, B => v8, C => C90DE, Z => I275 );
AND2_108:	 LIS_AND2 port map( A => C201D, B => v8, Z => I273);
AND2_109:	 LIS_AND2 port map( A => v10E, B => C144DE, Z => I272);
AND2_110:	 LIS_AND2 port map( A => v1E, B => C55D, Z => I270);
AND3_44:	 LIS_AND3 port map( A => v11E, B => C108DE, C => C83DE, Z => I269 );
AND3_45:	 LIS_AND3 port map( A => C214D, B => v7E, C => v10E, Z => I267 );
AND3_46:	 LIS_AND3 port map( A => v7, B => C49DE, C => C220DE, Z => I266 );
AND3_47:	 LIS_AND3 port map( A => C200D, B => v8, C => v10, Z => Av13_D_16B );
AND3_48:	 LIS_AND3 port map( A => v7E, B => v11, C => C41D, Z => I263 );
AND2_111:	 LIS_AND2 port map( A => C42D, B => v8, Z => I262);
AND2_112:	 LIS_AND2 port map( A => v3E, B => C78D, Z => I260);
AND3_49:	 LIS_AND3 port map( A => v12E, B => C129DE, C => C83DE, Z => I259 );
AND2_113:	 LIS_AND2 port map( A => C215D, B => v9E, Z => I257);
AND3_50:	 LIS_AND3 port map( A => v9, B => v10, C => C138DE, Z => I256 );
AND2_114:	 LIS_AND2 port map( A => C39D, B => v8E, Z => II254);
AND3_51:	 LIS_AND3 port map( A => v1E, B => v10E, C => C138DE, Z => I253 );
AND3_52:	 LIS_AND3 port map( A => v6E, B => v11E, C => v12E, Z => I251 );
AND3_53:	 LIS_AND3 port map( A => C77D, B => v3_muxed, C => C138DE, Z => I250 );
AND2_115:	 LIS_AND2 port map( A => C45D, B => v10E, Z => I248);
AND2_116:	 LIS_AND2 port map( A => v10, B => C144DE, Z => I247);
AND2_117:	 LIS_AND2 port map( A => C185D, B => v8E, Z => I245);
AND3_54:	 LIS_AND3 port map( A => C131D, B => v9, C => C144DE, Z => I243 );
AND2_118:	 LIS_AND2 port map( A => C130D, B => C165DE, Z => I242);
AND2_119:	 LIS_AND2 port map( A => C125D, B => v9E, Z => I240);
AND3_55:	 LIS_AND3 port map( A => v9, B => v12, C => C124DE, Z => I239 );
AND3_56:	 LIS_AND3 port map( A => v7, B => v12E, C => C221D, Z => I237 );
AND3_57:	 LIS_AND3 port map( A => v2E, B => v8, C => C219D, Z => I236 );
AND2_120:	 LIS_AND2 port map( A => v8, B => C167D, Z => I234);
AND2_121:	 LIS_AND2 port map( A => C168D, B => v8E, Z => I233);
AND2_122:	 LIS_AND2 port map( A => C165D, B => C83DE, Z => I232);
AND2_123:	 LIS_AND2 port map( A => C109D, B => v10E, Z => I230);
AND3_58:	 LIS_AND3 port map( A => v9, B => v10, C => C144DE, Z => I229 );
AND3_59:	 LIS_AND3 port map( A => C139D, B => v8, C => v10, Z => I227 );
AND3_60:	 LIS_AND3 port map( A => v8E, B => v10E, C => C144DE, Z => I226 );
AND3_61:	 LIS_AND3 port map( A => C163D, B => v8E, C => v11, Z => I224 );
AND3_62:	 LIS_AND3 port map( A => v7E, B => C160D, C => v9E, Z => I223 );
AND2_124:	 LIS_AND2 port map( A => C156D, B => C83DE, Z => I222);
AND2_125:	 LIS_AND2 port map( A => C51D, B => v12, Z => I220);
AND2_126:	 LIS_AND2 port map( A => C49D, B => v9, Z => I219);
AND3_63:	 LIS_AND3 port map( A => v12E, B => C44D, C => C83DE, Z => I218 );
AND2_127:	 LIS_AND2 port map( A => C189D, B => v9E, Z => I216);
AND3_64:	 LIS_AND3 port map( A => v1_muxed, B => v9, C => C144DE, Z => I215 );
AND2_128:	 LIS_AND2 port map( A => C57D, B => v10E, Z => I213);
AND2_129:	 LIS_AND2 port map( A => v9E, B => C49DE, Z => I212);
AND2_130:	 LIS_AND2 port map( A => v9, B => C120D, Z => I210);
AND2_131:	 LIS_AND2 port map( A => v8, B => C119D, Z => I209);
AND2_132:	 LIS_AND2 port map( A => C122D, B => v11E, Z => I208);
AND2_133:	 LIS_AND2 port map( A => v7, B => C150D, Z => I206);
AND2_134:	 LIS_AND2 port map( A => v8E, B => C30DE, Z => I205);
AND2_135:	 LIS_AND2 port map( A => C34D, B => v9, Z => I203);
AND4_21:	 LIS_AND4 port map( A => v9E, B => C144DE, C => C83DE, D => C194DE, Z => I202 );
AND2_136:	 LIS_AND2 port map( A => v12E, B => C124D, Z => I200);
AND2_137:	 LIS_AND2 port map( A => v9E, B => C63D, Z => I199);
AND3_65:	 LIS_AND3 port map( A => C158D, B => v7, C => v11E, Z => I197 );
AND2_138:	 LIS_AND2 port map( A => C161D, B => v11, Z => I196);
AND3_66:	 LIS_AND3 port map( A => v3_muxed, B => v12, C => C77D, Z => I194 );
AND3_67:	 LIS_AND3 port map( A => v8E, B => v9E, C => C44D, Z => I192 );
AND3_68:	 LIS_AND3 port map( A => v8, B => v11, C => C117DE, Z => I191 );
AND2_139:	 LIS_AND2 port map( A => v7, B => v12E, Z => I189);
AND2_140:	 LIS_AND2 port map( A => C175D, B => v11, Z => I188);
AND3_69:	 LIS_AND3 port map( A => v8, B => v11, C => C117DE, Z => I186 );
AND2_141:	 LIS_AND2 port map( A => v8E, B => C195DE, Z => I185);
AND2_142:	 LIS_AND2 port map( A => C183D, B => v8, Z => I183);
AND3_70:	 LIS_AND3 port map( A => v8E, B => v10E, C => C144DE, Z => I182 );
AND2_143:	 LIS_AND2 port map( A => C173D, B => v9E, Z => I180);
AND3_71:	 LIS_AND3 port map( A => v9, B => v10, C => C144DE, Z => I179 );
AND2_144:	 LIS_AND2 port map( A => C137D, B => C127D, Z => I177);
AND2_145:	 LIS_AND2 port map( A => v10E, B => C145D, Z => I176);
AND2_146:	 LIS_AND2 port map( A => v9, B => C144D, Z => I175);
AND2_147:	 LIS_AND2 port map( A => v8E, B => C143D, Z => I174);
AND2_148:	 LIS_AND2 port map( A => C146D, B => v11E, Z => I173);
AND2_149:	 LIS_AND2 port map( A => v8, B => C193D, Z => I171);
AND2_150:	 LIS_AND2 port map( A => v10, B => v11E, Z => I170);
AND2_151:	 LIS_AND2 port map( A => C195D, B => v8E, Z => I169);
AND3_72:	 LIS_AND3 port map( A => v8, B => v11, C => C129D, Z => I167 );
AND2_152:	 LIS_AND2 port map( A => C205D, B => v10, Z => I166);
AND2_153:	 LIS_AND2 port map( A => C133D, B => v8E, Z => I164);
AND3_73:	 LIS_AND3 port map( A => v11E, B => v12E, C => C118DE, Z => I163 );
AND2_154:	 LIS_AND2 port map( A => C144DE, B => C191D, Z => I161);
AND2_155:	 LIS_AND2 port map( A => v8, B => C65D, Z => I160);
AND2_156:	 LIS_AND2 port map( A => C84D, B => v10E, Z => I158);
AND2_157:	 LIS_AND2 port map( A => C82D, B => v9E, Z => I157);
AND2_158:	 LIS_AND2 port map( A => C80D, B => v9, Z => I156);
AND2_159:	 LIS_AND2 port map( A => v2_muxed, B => C40D, Z => I154);
AND2_160:	 LIS_AND2 port map( A => C52D, B => v8E, Z => I153);
AND3_74:	 LIS_AND3 port map( A => v8, B => v12E, C => C129DE, Z => I152 );
AND2_161:	 LIS_AND2 port map( A => v9, B => C138DE, Z => I151);
AND2_162:	 LIS_AND2 port map( A => C112D, B => v10, Z => I149);
AND3_75:	 LIS_AND3 port map( A => v9, B => v10E, C => C144DE, Z => I148 );
AND3_76:	 LIS_AND3 port map( A => C223D, B => v8E, C => v9E, Z => I146 );
AND3_77:	 LIS_AND3 port map( A => C49DE, B => C166DE, C => C220DE, Z => I145 );
AND3_78:	 LIS_AND3 port map( A => C216D, B => v7E, C => v8E, Z => Av13_D_23B );
AND2_163:	 LIS_AND2 port map( A => v7E, B => C169D, Z => II142);
AND2_164:	 LIS_AND2 port map( A => C170D, B => v8, Z => I141);
AND3_79:	 LIS_AND3 port map( A => v8E, B => v10E, C => C144DE, Z => I140 );
AND3_80:	 LIS_AND3 port map( A => C210D, B => v7E, C => v12E, Z => Av13_D_18B );
AND2_165:	 LIS_AND2 port map( A => v8, B => C46D, Z => I137);
AND2_166:	 LIS_AND2 port map( A => C47D, B => C144DE, Z => I136);
AND3_81:	 LIS_AND3 port map( A => v7E, B => v10, C => C151D, Z => I134 );
AND2_167:	 LIS_AND2 port map( A => C152D, B => v9, Z => I133);
AND3_82:	 LIS_AND3 port map( A => v9, B => v11E, C => C157DE, Z => I131 );
AND2_168:	 LIS_AND2 port map( A => C60D, B => C83D, Z => I130);
AND2_169:	 LIS_AND2 port map( A => v8E, B => C72D, Z => I129);
AND2_170:	 LIS_AND2 port map( A => v8, B => C69D, Z => I128);
AND2_171:	 LIS_AND2 port map( A => C73D, B => v10E, Z => I127);
AND2_172:	 LIS_AND2 port map( A => v2_muxed, B => C58D, Z => I126);
AND2_173:	 LIS_AND2 port map( A => C164D, B => v12E, Z => I124);
AND2_174:	 LIS_AND2 port map( A => v8, B => C162D, Z => I123);
AND3_83:	 LIS_AND3 port map( A => C199D, B => v4_muxed, C => v5E, Z => I548 );
AND3_84:	 LIS_AND3 port map( A => v7E, B => v12E, C => I548, Z => Av13_D_15B );
AND2_175:	 LIS_AND2 port map( A => v7E, B => C123D, Z => I120);
AND2_176:	 LIS_AND2 port map( A => C126D, B => v8, Z => I119);
AND2_177:	 LIS_AND2 port map( A => v8E, B => C35D, Z => I117);
AND2_178:	 LIS_AND2 port map( A => C37D, B => v9, Z => I116);
AND2_179:	 LIS_AND2 port map( A => v9, B => C97D, Z => I114);
AND3_85:	 LIS_AND3 port map( A => v2E, B => v12E, C => C93D, Z => I113 );
AND2_180:	 LIS_AND2 port map( A => v11E, B => v12, Z => I112);
AND2_181:	 LIS_AND2 port map( A => C98D, B => v10E, Z => I111);
AND4_22:	 LIS_AND4 port map( A => C179D, B => v2_muxed, C => v8, D => v11, Z => I109 );
AND2_182:	 LIS_AND2 port map( A => C181D, B => C83DE, Z => I108);
AND2_183:	 LIS_AND2 port map( A => v8E, B => C114D, Z => I106);
AND2_184:	 LIS_AND2 port map( A => v8, B => C113D, Z => I105);
AND3_86:	 LIS_AND3 port map( A => v3_muxed, B => C107D, C => v12, Z => I104 );
AND2_185:	 LIS_AND2 port map( A => C115D, B => v10, Z => I103);
AND3_87:	 LIS_AND3 port map( A => C127D, B => C128D, C => v12E, Z => I101 );
AND2_186:	 LIS_AND2 port map( A => C134D, B => v9E, Z => I100);
AND3_88:	 LIS_AND3 port map( A => v8E, B => v12, C => C87D, Z => I98 );
AND2_187:	 LIS_AND2 port map( A => C88D, B => v11E, Z => I97);
AND2_188:	 LIS_AND2 port map( A => v8, B => C85D, Z => I96);
AND2_189:	 LIS_AND2 port map( A => C76D, B => C81DE, Z => I95);
AND2_190:	 LIS_AND2 port map( A => v7E, B => C147D, Z => I93);
AND2_191:	 LIS_AND2 port map( A => v7, B => C140D, Z => I92);
AND2_192:	 LIS_AND2 port map( A => C148D, B => C131DE, Z => I91);
AND2_193:	 LIS_AND2 port map( A => v7, B => C48D, Z => I89);
AND2_194:	 LIS_AND2 port map( A => v2E, B => C43D, Z => I88);
AND2_195:	 LIS_AND2 port map( A => C53D, B => v7E, Z => I87);
AND2_196:	 LIS_AND2 port map( A => C54D, B => C165DE, Z => I86);
AND2_197:	 LIS_AND2 port map( A => v7E, B => C224D, Z => I84);
AND2_198:	 LIS_AND2 port map( A => C225D, B => v11, Z => I83);
AND3_89:	 LIS_AND3 port map( A => v0E, B => C217D, C => C108DE, Z => I82 );
AND3_90:	 LIS_AND3 port map( A => v7, B => v12E, C => C192D, Z => I80 );
AND2_199:	 LIS_AND2 port map( A => v8, B => C170D, Z => I79);
AND2_200:	 LIS_AND2 port map( A => v7E, B => C196D, Z => I78);
AND2_201:	 LIS_AND2 port map( A => v7E, B => C174D, Z => I76);
AND2_202:	 LIS_AND2 port map( A => C129DE, B => C144DE, Z => I75);
AND3_91:	 LIS_AND3 port map( A => v7, B => C31D, C => v8, Z => I73 );
AND2_203:	 LIS_AND2 port map( A => C38D, B => v7E, Z => I72);
AND2_204:	 LIS_AND2 port map( A => v2E, B => C28D, Z => I71);
AND2_205:	 LIS_AND2 port map( A => v7, B => C202D, Z => I69);
AND2_206:	 LIS_AND2 port map( A => C206D, B => v12E, Z => I68);
AND3_92:	 LIS_AND3 port map( A => v8E, B => v12E, C => C100D, Z => I66 );
AND2_207:	 LIS_AND2 port map( A => v9, B => C185D, Z => I65);
AND2_208:	 LIS_AND2 port map( A => v11E, B => C157DE, Z => I64);
AND2_209:	 LIS_AND2 port map( A => v8, B => C99D, Z => I63);
AND2_210:	 LIS_AND2 port map( A => v6E, B => C95D, Z => I62);
AND2_211:	 LIS_AND2 port map( A => v7E, B => C74D, Z => I60);
AND2_212:	 LIS_AND2 port map( A => v7, B => C67D, Z => I59);
AND2_213:	 LIS_AND2 port map( A => C75D, B => C129DE, Z => I58);
AND2_214:	 LIS_AND2 port map( A => C153D, B => v12E, Z => Av13_D_9B);
AND2_215:	 LIS_AND2 port map( A => C187D, B => v12E, Z => I55);
AND2_216:	 LIS_AND2 port map( A => C186D, B => v9E, Z => I54);
AND2_217:	 LIS_AND2 port map( A => C135D, B => v7E, Z => I52);
AND2_218:	 LIS_AND2 port map( A => C132D, B => v7, Z => I51);
AND2_219:	 LIS_AND2 port map( A => v8, B => C176D, Z => I49);
AND2_220:	 LIS_AND2 port map( A => C177D, B => v8E, Z => I48);
AND2_221:	 LIS_AND2 port map( A => v7, B => C110D, Z => I46);
AND2_222:	 LIS_AND2 port map( A => C116D, B => v7E, Z => I45);
AND2_223:	 LIS_AND2 port map( A => v2E, B => C106D, Z => I44);
AND3_93:	 LIS_AND3 port map( A => v8, B => v10, C => C108DE, Z => I43 );
AND3_94:	 LIS_AND3 port map( A => v7, B => v12E, C => C96D, Z => I41 );
AND2_224:	 LIS_AND2 port map( A => v2_muxed, B => C92D, Z => I40);
AND2_225:	 LIS_AND2 port map( A => C103D, B => v10E, Z => I39);
AND2_226:	 LIS_AND2 port map( A => C102D, B => v7E, Z => I38);
AND2_227:	 LIS_AND2 port map( A => v7E, B => C89D, Z => I36);
AND4_23:	 LIS_AND4 port map( A => C79D, B => v7, C => v9, D => v12E, Z => I35 );
AND2_228:	 LIS_AND2 port map( A => C91D, B => C165DE, Z => I34);
AND2_229:	 LIS_AND2 port map( A => C207D, B => v2_muxed, Z => I32);
AND3_95:	 LIS_AND3 port map( A => v7E, B => v8E, C => C124DE, Z => I642 );
AND3_96:	 LIS_AND3 port map( A => C108DE, B => C83DE, C => I642, Z => I31 );
AND2_230:	 LIS_AND2 port map( A => C190D, B => v10, Z => I29);
AND2_231:	 LIS_AND2 port map( A => v7E, B => C188D, Z => I28);
AND2_232:	 LIS_AND2 port map( A => C184D, B => v7, Z => I27);

--OR-gates (total number: 204)
OR2_0:	 LIS_OR2 port map( A => v11E, B => v12E, Z => C138D );
OR2_1:	 LIS_OR2 port map( A => v7E, B => v10, Z => C218D );
OR2_2:	 LIS_OR2 port map( A => v8E, B => v10, Z => C131D );
OR2_3:	 LIS_OR2 port map( A => v8E, B => v9E, Z => C220D );
OR2_4:	 LIS_OR2 port map( A => v2_muxed, B => v7, Z => C155D );
OR2_5:	 LIS_OR2 port map( A => v4E, B => v5E, Z => C83D );
OR2_6:	 LIS_OR2 port map( A => v9E, B => v2_muxed, Z => C117D );
OR2_7:	 LIS_OR2 port map( A => I559, B => I560, Z => C178D );
OR2_8:	 LIS_OR2 port map( A => v0_muxed, B => v11E, Z => C70D );
OR2_9:	 LIS_OR2 port map( A => v10E, B => v12E, Z => C157D );
OR2_10:	 LIS_OR2 port map( A => I554, B => I555, Z => C151D );
OR2_11:	 LIS_OR2 port map( A => v5E, B => v4_muxed, Z => C127D );
OR2_12:	 LIS_OR2 port map( A => v0_muxed, B => v12, Z => C142D );
OR2_13:	 LIS_OR2 port map( A => v3E, B => v6E, Z => C166D );
OR2_14:	 LIS_OR2 port map( A => v8E, B => v11, Z => C165D );
OR2_15:	 LIS_OR2 port map( A => v10E, B => v11E, Z => C30D );
OR2_16:	 LIS_OR2 port map( A => I546, B => I547, Z => C159D );
OR2_17:	 LIS_OR2 port map( A => v0_muxed, B => v10E, Z => C194D );
OR2_18:	 LIS_OR2 port map( A => v2_muxed, B => v11E, Z => C193D );
OR2_19:	 LIS_OR2 port map( A => v2E, B => v12, Z => C81D );
OR2_20:	 LIS_OR2 port map( A => v10, B => v11, Z => C124D );
OR2_21:	 LIS_OR2 port map( A => v5_muxed, B => v4_muxed, Z => C208D );
OR2_22:	 LIS_OR2 port map( A => v10E, B => v9, Z => C191D );
OR2_23:	 LIS_OR2 port map( A => I537, B => I538, Z => C59D );
OR2_24:	 LIS_OR2 port map( A => v9, B => v12, Z => C108D );
OR2_25:	 LIS_OR2 port map( A => I533, B => I534, Z => C47D );
OR2_26:	 LIS_OR2 port map( A => v6E, B => v10, Z => C33D );
OR2_27:	 LIS_OR2 port map( A => v1_muxed, B => v6E, Z => C104D );
OR2_28:	 LIS_OR2 port map( A => v11E, B => v12, Z => C144D );
OR2_29:	 LIS_OR2 port map( A => I528, B => v12, Z => C145D );
OR2_30:	 LIS_OR2 port map( A => v9, B => v12E, Z => C90D );
OR2_31:	 LIS_OR2 port map( A => v10E, B => v12, Z => C141D );
OR2_32:	 LIS_OR2 port map( A => v9, B => I524, Z => C86D );
OR2_33:	 LIS_OR2 port map( A => v2E, B => v10E, Z => C118D );
OR2_34:	 LIS_OR2 port map( A => v9, B => v10, Z => C129D );
OR2_35:	 LIS_OR2 port map( A => I520, B => v11, Z => C50D );
OR2_36:	 LIS_OR2 port map( A => v10, B => I518, Z => C179D );
OR2_37:	 LIS_OR2 port map( A => v9, B => I516, Z => C56D );
OR2_38:	 LIS_OR2 port map( A => I513, B => I514, Z => C200D );
OR2_39:	 LIS_OR2 port map( A => C165DE, B => v10E, Z => C36D );
OR2_40:	 LIS_OR2 port map( A => C129DE, B => I510, Z => C163D );
OR2_41:	 LIS_OR2 port map( A => C70DE, B => I508, Z => C203D );
OR2_42:	 LIS_OR2 port map( A => I505, B => I506, Z => C92D );
OR2_43:	 LIS_OR2 port map( A => I503, B => v12E, Z => C201D );
OR2_44:	 LIS_OR2 port map( A => I500, B => I501, Z => C27D );
OR2_45:	 LIS_OR2 port map( A => II497, B => I498, Z => C209D );
OR2_46:	 LIS_OR2 port map( A => I494, B => I495, Z => C60D );
OR2_47:	 LIS_OR2 port map( A => II491, B => I492, Z => C185D );
OR2_48:	 LIS_OR2 port map( A => C117DE, B => I489, Z => C137D );
OR2_49:	 LIS_OR2 port map( A => C90DE, B => v11E, Z => C45D );
OR2_50:	 LIS_OR2 port map( A => I485, B => I486, Z => C211D );
OR2_51:	 LIS_OR2 port map( A => I482, B => I483, Z => C213D );
OR2_52:	 LIS_OR2 port map( A => C131DE, B => v11, Z => C79D );
OR2_53:	 LIS_OR2 port map( A => I478, B => I479, Z => C172D );
OR2_54:	 LIS_OR2 port map( A => I475, B => I476, Z => C55D );
OR2_55:	 LIS_OR2 port map( A => I473, B => C124DE, Z => C44D );
OR2_56:	 LIS_OR2 port map( A => I470, B => I471, Z => C41D );
OR2_57:	 LIS_OR2 port map( A => C191DE, B => I468, Z => C93D );
OR2_58:	 LIS_OR2 port map( A => C138DE, B => I466, Z => C29D );
OR2_59:	 LIS_OR2 port map( A => I463, B => I464, Z => C96D );
OR2_60:	 LIS_OR2 port map( A => I460, B => I461, Z => C214D );
OR2_61:	 LIS_OR2 port map( A => C159D, B => v9, Z => C168D );
OR2_62:	 LIS_OR2 port map( A => I456, B => I457, Z => C114D );
OR2_63:	 LIS_OR2 port map( A => C124DE, B => v9E, Z => C170D );
OR2_64:	 LIS_OR2 port map( A => I452, B => I453, Z => C78D );
OR2_65:	 LIS_OR2 port map( A => I449, B => I450, Z => C105D );
OR2_66:	 LIS_OR2 port map( A => I446, B => I447, Z => C95D );
OR2_67:	 LIS_OR2 port map( A => C144D, B => I444, Z => C98D );
OR2_68:	 LIS_OR2 port map( A => I441, B => I442, Z => C156D );
OR2_69:	 LIS_OR2 port map( A => I438, B => I439, Z => C215D );
OR2_70:	 LIS_OR2 port map( A => I435, B => I436, Z => C103D );
OR2_71:	 LIS_OR2 port map( A => I432, B => I433, Z => C42D );
OR2_72:	 LIS_OR2 port map( A => I429, B => I430, Z => C100D );
OR2_73:	 LIS_OR2 port map( A => C131DE, B => I427, Z => C76D );
OR2_74:	 LIS_OR2 port map( A => C144D, B => I425, Z => C120D );
OR2_75:	 LIS_OR2 port map( A => I423, B => v9, Z => C39D );
OR2_76:	 LIS_OR2 port map( A => C141D, B => v11, Z => C49D );
OR2_77:	 LIS_OR2 port map( A => I419, B => I420, Z => C217D );
OR2_78:	 LIS_OR2 port map( A => C138DE, B => I417, Z => C222D );
OR2_79:	 LIS_OR2 port map( A => I414, B => I415, Z => C26D );
OR2_80:	 LIS_OR2 port map( A => C90DE, B => I412, Z => C54D );
OR2_81:	 LIS_OR2 port map( A => C104D, B => v0E, Z => C77D );
OR2_82:	 LIS_OR2 port map( A => C90DE, B => I409, Z => C148D );
OR2_83:	 LIS_OR2 port map( A => C194DE, B => v11E, Z => C180D );
OR2_84:	 LIS_OR2 port map( A => I405, B => I406, Z => C128D );
OR2_85:	 LIS_OR2 port map( A => I402, B => I403, Z => C106D );
OR2_86:	 LIS_OR2 port map( A => C83DE, B => v2_muxed, Z => C111D );
OR2_87:	 LIS_OR2 port map( A => I398, B => I399, Z => C146D );
OR2_88:	 LIS_OR2 port map( A => I395, B => I396, Z => C158D );
OR2_89:	 LIS_OR2 port map( A => I392, B => I393, Z => C82D );
OR2_90:	 LIS_OR2 port map( A => I389, B => I390, Z => C221D );
OR2_91:	 LIS_OR2 port map( A => I386, B => I387, Z => C107D );
OR2_92:	 LIS_OR2 port map( A => I383, B => I384, Z => C71D );
OR2_93:	 LIS_OR2 port map( A => I380, B => I381, Z => C167D );
OR2_94:	 LIS_OR2 port map( A => I377, B => I378, Z => C219D );
OR2_95:	 LIS_OR2 port map( A => I374, B => I375, Z => C87D );
OR2_96:	 LIS_OR2 port map( A => I371, B => I372, Z => C130D );
OR2_97:	 LIS_OR2 port map( A => II368, B => I369, Z => C31D );
OR2_98:	 LIS_OR2 port map( A => I365, B => I366, Z => C57D );
OR2_99:	 LIS_OR2 port map( A => I362, B => I363, Z => C189D );
OR2_100:	 LIS_OR2 port map( A => I359, B => I360, Z => C75D );
OR2_101:	 LIS_OR2 port map( A => I356, B => I357, Z => C51D );
OR2_102:	 LIS_OR2 port map( A => v8, B => I354, Z => C192D );
OR2_103:	 LIS_OR2 port map( A => C30DE, B => I352, Z => C150D );
OR3_0:	 LIS_OR3 port map( A => I349, B => v12, C => I350, Z => C119D );
OR2_104:	 LIS_OR2 port map( A => I346, B => I347, Z => C91D );
OR2_105:	 LIS_OR2 port map( A => C138DE, B => I344, Z => C84D );
OR2_106:	 LIS_OR2 port map( A => I341, B => I342, Z => C160D );
OR2_107:	 LIS_OR2 port map( A => I338, B => I339, Z => C109D );
OR2_108:	 LIS_OR2 port map( A => I335, B => I336, Z => C125D );
OR2_109:	 LIS_OR2 port map( A => I332, B => I333, Z => C139D );
OR2_110:	 LIS_OR2 port map( A => I328, B => II329, Z => C69D );
OR2_111:	 LIS_OR2 port map( A => I325, B => I326, Z => C175D );
OR2_112:	 LIS_OR2 port map( A => v12, B => I323, Z => C122D );
OR2_113:	 LIS_OR2 port map( A => I320, B => I321, Z => C34D );
OR3_1:	 LIS_OR3 port map( A => v12E, B => I317, C => I318, Z => C63D );
OR2_114:	 LIS_OR2 port map( A => I314, B => I315, Z => C161D );
OR2_115:	 LIS_OR2 port map( A => C180DE, B => v9, Z => C195D );
OR2_116:	 LIS_OR2 port map( A => I310, B => I311, Z => C72D );
OR2_117:	 LIS_OR2 port map( A => I308, B => v9E, Z => C112D );
OR2_118:	 LIS_OR2 port map( A => I305, B => I306, Z => C183D );
OR2_119:	 LIS_OR2 port map( A => I302, B => I303, Z => C173D );
OR2_120:	 LIS_OR2 port map( A => I299, B => I300, Z => C115D );
OR2_121:	 LIS_OR2 port map( A => I296, B => I297, Z => C210D );
OR2_122:	 LIS_OR2 port map( A => I293, B => I294, Z => Av13_D_19B );
OR3_2:	 LIS_OR3 port map( A => C49DE, B => v9, C => I291, Z => C143D );
OR2_123:	 LIS_OR2 port map( A => I287, B => I288, Z => C205D );
OR2_124:	 LIS_OR2 port map( A => I284, B => I285, Z => C223D );
OR3_3:	 LIS_OR3 port map( A => I280, B => I281, C => I282, Z => C37D );
OR2_125:	 LIS_OR2 port map( A => C49DE, B => I278, Z => C133D );
OR2_126:	 LIS_OR2 port map( A => I275, B => I276, Z => C28D );
OR2_127:	 LIS_OR2 port map( A => I272, B => I273, Z => C202D );
OR2_128:	 LIS_OR2 port map( A => I269, B => I270, Z => C73D );
OR2_129:	 LIS_OR2 port map( A => I266, B => I267, Z => Av13_D_22B );
OR2_130:	 LIS_OR2 port map( A => I262, B => I263, Z => C43D );
OR2_131:	 LIS_OR2 port map( A => I259, B => I260, Z => C88D );
OR2_132:	 LIS_OR2 port map( A => I256, B => I257, Z => C216D );
OR2_133:	 LIS_OR2 port map( A => I253, B => II254, Z => C40D );
OR2_134:	 LIS_OR2 port map( A => I250, B => I251, Z => C80D );
OR2_135:	 LIS_OR2 port map( A => I247, B => I248, Z => C46D );
OR2_136:	 LIS_OR2 port map( A => C49DE, B => I245, Z => C186D );
OR2_137:	 LIS_OR2 port map( A => I242, B => I243, Z => C132D );
OR2_138:	 LIS_OR2 port map( A => I239, B => I240, Z => C126D );
OR2_139:	 LIS_OR2 port map( A => I236, B => I237, Z => C225D );
OR4_0:	 LIS_OR4 port map( A => I232, B => I233, C => v12, D => I234, Z => C169D );
OR2_140:	 LIS_OR2 port map( A => I229, B => I230, Z => C110D );
OR2_141:	 LIS_OR2 port map( A => I226, B => I227, Z => C140D );
OR3_4:	 LIS_OR3 port map( A => I222, B => I223, C => I224, Z => C164D );
OR3_5:	 LIS_OR3 port map( A => I218, B => I219, C => I220, Z => C52D );
OR2_142:	 LIS_OR2 port map( A => I215, B => I216, Z => C190D );
OR2_143:	 LIS_OR2 port map( A => I212, B => I213, Z => C58D );
OR4_1:	 LIS_OR4 port map( A => C157DE, B => I208, C => I209, D => I210, Z => C123D );
OR2_144:	 LIS_OR2 port map( A => I205, B => I206, Z => C152D );
OR2_145:	 LIS_OR2 port map( A => I202, B => I203, Z => C35D );
OR2_146:	 LIS_OR2 port map( A => I199, B => I200, Z => C65D );
OR2_147:	 LIS_OR2 port map( A => I196, B => I197, Z => C162D );
OR2_148:	 LIS_OR2 port map( A => v11E, B => I194, Z => C97D );
OR2_149:	 LIS_OR2 port map( A => I191, B => I192, Z => C199D );
OR2_150:	 LIS_OR2 port map( A => I188, B => I189, Z => C176D );
OR2_151:	 LIS_OR2 port map( A => I185, B => I186, Z => C181D );
OR2_152:	 LIS_OR2 port map( A => I182, B => I183, Z => C184D );
OR2_153:	 LIS_OR2 port map( A => I179, B => I180, Z => C174D );
OR3_6:	 LIS_OR3 port map( A => I173, B => I174, C => I175, Z => I491 );
OR3_7:	 LIS_OR3 port map( A => I176, B => I177, C => I491, Z => C147D );
OR3_8:	 LIS_OR3 port map( A => C208DE, B => C83DE, C => I169, Z => I497 );
OR4_2:	 LIS_OR4 port map( A => I170, B => v12, C => I171, D => I497, Z => C196D );
OR2_154:	 LIS_OR2 port map( A => I166, B => I167, Z => C206D );
OR2_155:	 LIS_OR2 port map( A => I163, B => I164, Z => C134D );
OR2_156:	 LIS_OR2 port map( A => I160, B => I161, Z => C67D );
OR3_9:	 LIS_OR3 port map( A => I156, B => I157, C => I158, Z => C85D );
OR4_3:	 LIS_OR4 port map( A => I151, B => I152, C => I153, D => I154, Z => C53D );
OR2_157:	 LIS_OR2 port map( A => I148, B => I149, Z => C113D );
OR2_158:	 LIS_OR2 port map( A => I145, B => I146, Z => C224D );
OR3_10:	 LIS_OR3 port map( A => I140, B => I141, C => II142, Z => Av13_D_11B );
OR2_159:	 LIS_OR2 port map( A => I136, B => I137, Z => C48D );
OR2_160:	 LIS_OR2 port map( A => I133, B => I134, Z => C153D );
OR3_11:	 LIS_OR3 port map( A => I126, B => I127, C => I128, Z => I542 );
OR4_4:	 LIS_OR4 port map( A => I129, B => I130, C => I131, D => I542, Z => C74D );
OR2_161:	 LIS_OR2 port map( A => I123, B => I124, Z => Av13_D_10B );
OR2_162:	 LIS_OR2 port map( A => I119, B => I120, Z => Av13_D_6B );
OR2_163:	 LIS_OR2 port map( A => I116, B => I117, Z => C38D );
OR4_5:	 LIS_OR4 port map( A => I111, B => I112, C => I113, D => I114, Z => C99D );
OR2_164:	 LIS_OR2 port map( A => I108, B => I109, Z => C187D );
OR4_6:	 LIS_OR4 port map( A => I103, B => I104, C => I105, D => I106, Z => C116D );
OR2_165:	 LIS_OR2 port map( A => I100, B => I101, Z => C135D );
OR4_7:	 LIS_OR4 port map( A => I95, B => I96, C => I97, D => I98, Z => C89D );
OR3_12:	 LIS_OR3 port map( A => I91, B => I92, C => I93, Z => Av13_D_8B );
OR4_8:	 LIS_OR4 port map( A => I86, B => I87, C => I88, D => I89, Z => Av13_D_1B );
OR3_13:	 LIS_OR3 port map( A => I82, B => I83, C => I84, Z => Av13_D_24B );
OR3_14:	 LIS_OR3 port map( A => I78, B => I79, C => I80, Z => Av13_D_14B );
OR2_166:	 LIS_OR2 port map( A => I75, B => I76, Z => C177D );
OR3_15:	 LIS_OR3 port map( A => I71, B => I72, C => I73, Z => Av13_D_0B );
OR2_167:	 LIS_OR2 port map( A => I68, B => I69, Z => C207D );
OR3_16:	 LIS_OR3 port map( A => I62, B => I63, C => I64, Z => I610 );
OR3_17:	 LIS_OR3 port map( A => I65, B => I66, C => I610, Z => C102D );
OR3_18:	 LIS_OR3 port map( A => I58, B => I59, C => I60, Z => Av13_D_2B );
OR2_168:	 LIS_OR2 port map( A => I54, B => I55, Z => C188D );
OR2_169:	 LIS_OR2 port map( A => I51, B => I52, Z => Av13_D_7B );
OR2_170:	 LIS_OR2 port map( A => I48, B => I49, Z => Av13_D_12B );
OR4_9:	 LIS_OR4 port map( A => I43, B => I44, C => I45, D => I46, Z => Av13_D_5B );
OR4_10:	 LIS_OR4 port map( A => I38, B => I39, C => I40, D => I41, Z => Av13_D_4B );
OR3_19:	 LIS_OR3 port map( A => I34, B => I35, C => I36, Z => Av13_D_3B );
OR2_171:	 LIS_OR2 port map( A => I31, B => I32, Z => Av13_D_17B );
OR3_20:	 LIS_OR3 port map( A => I27, B => I28, C => I29, Z => Av13_D_13B );

--NAND-gates (total number: 0)

--NOR-gates (total number: 0)

end architecture;
