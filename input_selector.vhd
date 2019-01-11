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
	generic (input_size: natural := 63); -- TODO remove this part
	port(
		input_matrix: in matrix1d(0 to input_size);
		weight_matrix: in matrix1d(0 to input_size);
		in_size: in std_logic_vector(7 downto 0);
		clk, rst, start: in std_logic;
		input, weight: out fixed_point;
		done, reg_enable, mac_rst: out std_logic
	);
end input_selector;

architecture Behavioral of input_selector is	
	signal working: std_logic;

begin
	process(clk, rst)
		VARIABLE counter: integer := 0;
	BEGIN
		IF RISING_EDGE(clk) THEN
			mac_rst <= '0';
			IF start = '1' THEN
				working <= '1';
				mac_rst <= '1';
				counter := 0;
			END IF;
			IF rst = '1' THEN
				mac_rst <= '1';
				counter := 0;
			ELSE
				done <= '0';
				reg_enable <= '1';
				-- counter := counter WHEN working = '0' else counter + 1;
				IF (working = '0') THEN
					counter := 0;
				ELSE
					counter := counter + 1;
				END IF;
				
				IF counter < in_size + 1 THEN
					input.sign <= input_matrix(counter)(15);
					input.absolute_value <= input_matrix(counter)(14 downto 0);
					weight.sign <= weight_matrix(counter)(15);
					weight.absolute_value <= weight_matrix(counter)(14 downto 0);				
				ELSIF counter = in_size + 1 THEN
					reg_enable <= '0';
					done <= '1';
				ELSIF counter = in_size + 2 THEN
					mac_rst <= '1';
				ELSIF counter = in_size + 3 THEN
					counter := 0;
					working <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
end Behavioral;

