----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:27:20 11/24/2018 
-- Design Name: 
-- Module Name:    input_selector - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity input_selector is
	generic (input_size: natural := 4); -- TODO remove this part
	port(
		input_matrix: in matrix1d(0 to input_size);
		weight_matrix: in matrix1d(0 to input_size);
		clk, rst: in std_logic;
		input, weight: out fixed_point;
		done: out std_logic
	);
end input_selector;

architecture Behavioral of input_selector is	

begin
	process(clk, rst)
		VARIABLE counter: integer := 0;
	BEGIN
		IF RISING_EDGE(clk) THEN
			IF rst = '1' THEN
				counter := 0;
			ELSE
				done <= '0';
				counter := counter + 1;
				IF counter = input_size + 1 THEN
					done <= '1';
					counter := 0;
				END IF;
				input.sign <= input_matrix(counter)(15);
				input.absolute_value <= input_matrix(counter)(14 downto 0);
				weight.sign <= weight_matrix(counter)(15);
				weight.absolute_value <= weight_matrix(counter)(14 downto 0);
			END IF;
		END IF;
	END PROCESS;
end Behavioral;

