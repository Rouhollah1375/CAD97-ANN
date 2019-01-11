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
	generic (input_size: natural := 63);
	port (
		input_vector: in matrix1d(0 to input_size);		-- the last element of this matrix is for the bias
		weight_vector: in matrix1d(0 to input_size);		-- the last element of this matrix is for the bias
		in_size: in std_logic_vector(7 downto 0);
		clk, rst, start: in std_logic;
		output: out fixed_point;
		done: out std_logic
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
		clk, rst, en : IN STD_LOGIC;
		input : IN fixed_point;
		output : OUT fixed_point
	);
	END COMPONENT;
	for all: reg use entity work.reg(behavarioal);
	
	COMPONENT in_sel
	port(
		input_matrix: in matrix1d(0 to input_size);
		weight_matrix: in matrix1d(0 to input_size);
		in_size: in std_logic_vector(7 downto 0);
		clk, rst, start: in std_logic;
		input, weight: out fixed_point;
		done, reg_enable, mac_rst: out std_logic
	);
	END COMPONENT;
	for all: in_sel use entity work.input_selector(Behavioral);
	
	signal a, b, macout: fixed_point;
	signal get_input_done, reg_enable, mac_rst, done_signal: std_logic;
begin
	my_mac: mac port map(
		clk, mac_rst, a, b, macout
	);
	
	
	my_in_sel: in_sel port map(
		input_vector, weight_vector, in_size, clk, rst, start, a, b, get_input_done, reg_enable, mac_rst
	);
	
	output_register : reg PORT MAP
	(
		clk => clk,
		rst => rst,
		en => done_signal,
		input => macout,
		output => output
	);

	done_signal <= not reg_enable;
	done <= done_signal;

end Behavioral;














