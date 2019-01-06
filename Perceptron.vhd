----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:14:32 11/21/2018 
-- Design Name: 
-- Module Name:    Perceptron - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use WORk.types.all;
use work.mac;
use WORK.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--type vector is array(integer range <>) of std_logic_vector(15 downto 0);

entity Perceptron is
	generic (input_size: natural := 4);
	port (
		input_vector: in matrix1d(0 to input_size);		-- the last element of this matrix is for the bias
		weight_vector: in matrix1d(0 to input_size);		-- the last element of this matrix is for the bias
		clk, rst: in std_logic;
		output: out fixed_point
	);
end Perceptron;

architecture Behavioral of Perceptron is
	COMPONENT mac PORT
	(
		clk, rst : IN STD_LOGIC;
		a, b : IN fixed_point; 
		output : OUT fixed_point
	);
	END COMPONENT;  
	for all: mac use entity work.mac(behavioral);
	
	COMPONENT reg PORT
	(
		clk, rst : IN STD_LOGIC;
		input : IN fixed_point;
		output : OUT fixed_point
	);
	END COMPONENT;
	for all: reg use entity work.reg(behavarioal);
	
	COMPONENT in_sel PORT
	(
		input_matrix: in matrix1d(0 to input_size);
		weight_matrix: in matrix1d(0 to input_size);
		clk, rst: in std_logic;
		input, weight: out fixed_point;
		done: out std_logic
	);
	END COMPONENT;
	for all: in_sel use entity work.input_selector(Behavioral);
	
	signal a, b, macout, relu: fixed_point;
	signal get_input_done: std_logic;
begin
	c1: mac port map(
		clk, rst, a, b, macout
	);
	
	c2: in_sel port map(
		input_vector, weight_vector, clk, rst, a, b, get_input_done
	);
				
	PROCESS (macout)
		variable relu_out : fixed_point;
	BEGIN
		IF (macout.sign = '1') THEN
			relu_out.sign := '0';
			relu_out.absolute_value := "000000000000000";
		ELSE
			relu_out := macout;
		END IF;
		relu.sign <= relu_out.sign;
		relu.absolute_value <= relu_out.absolute_value;
	END PROCESS;
	
	output_register : reg PORT MAP
	(
		clk => get_input_done,
		rst => rst,
		input => relu,
		output => output
	);

end Behavioral;














