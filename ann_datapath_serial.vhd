----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:26:21 01/06/2019 
-- Design Name: 
-- Module Name:    ann_datapath - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ann_datapath_serial is
	port (
		clk, rst: in std_logic;
		start_input_layer, start_hidden_layer, start_output_layer: in std_logic;
		in_size: in std_logic_vector(7 downto 0);
		output: out std_logic_vector(3 downto 0);
		done_hidden_layer: out std_logic_vector(19 downto 0);
		done_output_layer: out std_logic_vector(9 downto 0)
	);
end ann_datapath_serial;

architecture Behavioral of ann_datapath_serial is
	COMPONENT Perceptron
		PORT(
			input_vector: in matrix1d(0 to max_input_size - 1);		-- the last element of this matrix is for the bias
			weight_vector: in matrix1d(0 to max_input_size - 1);		-- the last element of this matrix is for the bias
			in_size: in std_logic_vector(7 downto 0);
			clk, rst, start: in std_logic;
			output: out fixed_point
		);
	END COMPONENT;
	
	COMPONENT Relu
		PORT(
			input : IN fixed_point;
			output: out fixed_point
		);
	END COMPONENT;
	
	COMPONENT max_index
		PORT(
			input_vector : in matrix1d(0 to 9);
			output : out std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	signal hidden_weight_vector : matrix2d(19 downto 0, 0 to 61 + 1);
	signal output_weight_vector : matrix2d(9 downto 0, 0 to 19 + 1);
	
	signal hidden_layer_input_vector : matrix1d(0 to 61 + 1);
	signal hidden_layer_output_vector : matrix1d(0 to 19 + 1);
	signal output_layer_input_vector : matrix1d(0 to 19 + 1);
	
	signal output_vector : matrix1d(0 to 9);
	
	-- signal layer1weigths: matrix2d()();
begin
		-- hidden layer
	p : Perceptron PORT MAP (
	 input_vector => hidden_layer_input_vector,
	 weight_vector => hidden_weight_vector(I),
	 in_size => in_size,
	 clk => clk,
	 rst => rst,
	 start => start_hidden_layer(I),
	 done => done_hidden_layer(I),
	 output => hidden_layer_output_vector(I)
	);
		  
	-- apply relu function
	rI : Relu PORT MAP(
		input => hidden_layer_output_vector(I),
		output => output_layer_input_vector(I)
	);  

	
	get_max_idx : max_index
	PORT MAP(
		input_vector => output_vector,
		output => output
	);

end Behavioral;

