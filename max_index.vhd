----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:08:53 01/06/2019 
-- Design Name: 
-- Module Name:    max_index - Behavioral 
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
use WORK.types.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity max_index is
	PORT(
		input_vector : in matrix1d(0 to 9);
		output : out std_logic_vector(3 downto 0)
	);
end max_index;

architecture Behavioral of max_index is

begin
	process(input_vector)
		variable max_value : std_logic_vector(15 downto 0);
		variable max_index : std_logic_vector(3 downto 0);
	begin
		max_value := input_vector(0);
		max_index := "0000";
		
		for i in 1 to 9 loop
			if (input_vector(i) > max_value) then
				max_value := input_vector(i);
				max_index := std_logic_vector(i);
			end if;
		end loop;
		output <= max_index;
	end process;
	

end Behavioral;

