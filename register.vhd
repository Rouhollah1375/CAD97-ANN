LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.TYPES.ALL;

ENTITY reg IS
	PORT
	(
		clk, rst, en : IN STD_LOGIC;
		input : IN fixed_point;
		output : OUT fixed_point
	);
END reg;

ARCHITECTURE behavarioal OF reg IS
BEGIN
	PROCESS (clk, rst)
		variable default_val : fixed_point;
	BEGIN
		IF RISING_EDGE(clk) and en = '1' THEN
			output <= input;
		END IF;
		IF rst = '1' THEN
			output.sign <= '0';
			output.absolute_value <= (14 downto 0 => '0');
		END IF;
	END PROCESS;
END ARCHITECTURE behavarioal;