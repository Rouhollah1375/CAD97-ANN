LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE WORK.types.all;

ENTITY multiplier IS
	PORT
	(
		a : IN fixed_point;
		b : IN fixed_point;
		output : OUT fixed_point
		-- overflow : OUT STD_LOGIC
	);
END ENTITY multiplier;

ARCHITECTURE behavioral OF multiplier IS

	SIGNAL result : STD_LOGIC_VECTOR(29 DOWNTO 0);
	SIGNAL out_res : fixed_point;
	
--	FUNCTION or_vector(a : STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
--		VARIABLE ret : STD_LOGIC := '0';
--	BEGIN
--		FOR i IN a'RANGE LOOP
--			ret := ret OR a(i);
--		END LOOP;
--
--		RETURN ret;
--	END FUNCTION or_vector;

BEGIN
	result <= (a.absolute_value or "000000000000001") * (b.absolute_value or "000000000000001");
	-- result <= (a.absolute_value) * (b.absolute_value);
	out_res.absolute_value <= result(20 downto 6);
	out_res.sign <= '0' when a.sign = b.sign else '1';
	output <= out_res;
	-- overflow <= or_vector(result(a'LENGTH * 2 - 1 DOWNTO a'LENGTH));

END behavioral;