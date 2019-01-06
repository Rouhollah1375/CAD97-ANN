----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:33:26 11/24/2018 
-- Design Name: 
-- Module Name:    activation_function - Behavioral 
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
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.TYPES.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity activation_function is
	port
	(
		input: in fixed_point;
		output: out std_logic_vector(15 downto 0)
	);
end activation_function;

architecture Behavioral of activation_function is
begin
	output <= (16 => '0') when
	(input.absolute_value < "010000000000000" or input.sign = '1') else (input.sign & input.absolute_value);
--	output <= (16 => '0') when (input.absolute_value < "010000000000000") else (input.sign & input.absolute_value);
end Behavioral;

