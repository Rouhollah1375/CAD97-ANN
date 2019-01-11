----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:26:56 01/06/2019 
-- Design Name: 
-- Module Name:    ann_controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.types.all;
use ieee.std_logic_misc.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ann_controller is
	PORT (
		clk, rst, global_start: in std_logic;
		done_hidden_layer: in std_logic_vector(19 downto 0);
		done_output_layer: in std_logic_vector(9 downto 0);
		global_done: out std_logic;
		start_input_layer, start_hidden_layer, start_output_layer: out std_logic;
		image_index, neuron_index: out std_logic_vector(7 downto 0);
		in_size: out std_logic_vector(7 downto 0);
		read_input, throw_output: out std_logic
	);
end ann_controller;

architecture Behavioral of ann_controller is
	signal input_counter: std_logic_vector(7 downto 0);
	signal ps, ns: fsm_state;
	signal neuron_index_signal: std_logic_vector(7 downto 0);
begin

	process (clk)
	begin
		IF rising_edge(clk) then
			IF (rst) then
				ps <= idle;
				ns <= idle;
			else
				ps <= ns;
			end if;
		end if;
	end process;

	
	process (global_start, done_input_layer, done_output_layer)
	begin
		if ps = idle and global_start then
			ns <= input_layer;
		elsif ps = input_layer then
			ns <= hidden_layer_start;
		elsif ps = hidden_layer_start then
			ns <= hidden_layer_working;
		elsif ps = hidden_layer_working and neuron_index_signal = "00010100" then
			ns <= output_layer_start;
		elsif ps = output_layer_start then
			ns <= output_layer_working;
		elsif ps = output_layer_working and neuron_index_signal = "00001010" then
			ns <= count_up;
		elsif ps = count_up then
			ns <= local_done;
		elsif ps = local_done and input_counter < 100 then
			ns <= global_done;
		elsif ps = local_done and input_counter = 100 then
			ns <= input_layer;
		elsif ps = global_done then
			ns <= idle;
		end if;
		
	end process;

	
	process (ps)
	begin
		-- todo: set all signals to zero
		read_input <= '0';
		start_hidden_layer <= (others => '0');
		start_output_layer <= (others => '0');
		throw_output <= '0';
		global_done <= '0';
		case ps is 
			when idle => input_counter <= (others => '0');
			when input_layer => read_input <= '1';
			-- when hidden_layer_start => start_hidden_layer <= (others => '1');
			when hidden_layer_start => 
				neuron_index_signal <= (others => '0');
				in_size <= "00111111";
				-- neuron_index <= hidden_layer_counter;
				
			when hidden_layer_working =>
				neuron_index_signal <= neuron_index_signal + 1;
				-- neuron_index <= hidden_layer_counter;
				
			-- when output_layer_start => start_output_layer <= (others => '1');
			when output_layer_start =>
				neuron_index_signal <= (others => '0');
				in_size <= "00010101";
				-- neuron_index <= output_layer_counter;
				
			when output_layer_working =>
				neuron_index_signal <= neuron_index_signal + 1;
				-- neuron_index <= output_layer_counter;
				
			when count_up => input_counter <= input_counter + 1;
			when local_done => throw_output <= '1';
			when global_done => global_done <= '1'; 
		end case;
	end process;
	
	image_index <= input_counter;
	neuron_index <= neuron_index_signal;
	
end Behavioral;

