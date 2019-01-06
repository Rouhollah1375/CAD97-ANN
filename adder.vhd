LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.TYPES.ALL;

ENTITY adder IS
	PORT
	(
		a : IN fixed_point;
		b : IN fixed_point;
		sum	: OUT fixed_point
	);
END adder;

ARCHITECTURE behavioral OF adder IS
	SIGNAL result : STD_LOGIC_VECTOR(a.absolute_value'LENGTH DOWNTO 0);
BEGIN
	result <= ('0' & a.absolute_value) + ('0' & b.absolute_value) when (a.sign = b.sign) else
					('0' & a.absolute_value) - ('0' & b.absolute_value) when (a.sign = '0' and b.sign = '1') else
					('0' & b.absolute_value) - ('0' & a.absolute_value) when (a.sign = '1' and b.sign = '0');

	sum.absolute_value <= result(a.absolute_value'LENGTH - 1 DOWNTO 0);
	sum.sign <= a.sign when (a.sign = b.sign) else
					a.sign when (a.absolute_value > b.absolute_value) else
					b.sign when (b.absolute_value > a.absolute_value) else '0';	
END behavioral;
