----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:18:54 01/06/2019 
-- Design Name: 
-- Module Name:    relu - Behavioral 
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
use WORk.types.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity relu is
	PORT
	(
		input : IN fixed_point;
		output: out fixed_point
	);
end relu;

architecture Behavioral of relu is

begin
	PROCESS (input)
	BEGIN
		IF (input.sign = '1') THEN
			output.sign <= '0';
			output.absolute_value <= "000000000000000";
		ELSE
			output.sign <= input.sign;
			output.absolute_value <= input.absolute_value;
		END IF;
	END PROCESS;

end Behavioral;

