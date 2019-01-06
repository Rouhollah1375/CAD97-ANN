LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY WORK;
USE WORK.ALL;
USE WORK.TYPES.ALL;

ENTITY mac IS
	PORT
	(
		clk, rst : IN STD_LOGIC;
		a, b : IN fixed_point; 
		output : OUT fixed_point
		-- overflow : OUT STD_LOGIC
	);
END ENTITY mac;
 
ARCHITECTURE behavioral OF mac IS
	COMPONENT reg PORT
	(
		clk, rst : IN STD_LOGIC;
		input : IN fixed_point;
		output : OUT fixed_point
	);
	END COMPONENT;
--	FOR ALL : reg USE ENTITY WORK.reg(behavioral);
	
	COMPONENT multiplier PORT
	(
		a : IN fixed_point;
		b : IN fixed_point;
		output : OUT fixed_point
		-- overflow : OUT STD_LOGIC
	);
	END COMPONENT;
--	FOR ALL : multiplier USE ENTITY WORK.multiplier(behavioral);
	
	COMPONENT adder PORT
	(
		a : IN fixed_point;
		b : IN fixed_point;
		sum	: OUT fixed_point
	);
	END COMPONENT;
--	FOR ALL : adder USE ENTITY WORK.adder(behavioral);

	SIGNAL multiplier_out : fixed_point;
	SIGNAL adder_out : fixed_point;
	SIGNAL accumulator_out : fixed_point;
	SIGNAL carry_out : STD_LOGIC;
	-- SIGNAL mul_overflow : STD_LOGIC;
	
BEGIN

	my_multiplier : multiplier PORT MAP
	(
		a => a,
		b => b,
		output => multiplier_out
		-- overflow => mul_overflow
	);

	my_adder : adder PORT MAP
	(
		a => multiplier_out,
		b => accumulator_out,
		sum => adder_out
	);
	
	my_register : reg PORT MAP
	(
		clk => clk,
		rst => rst,
		input => adder_out,
		output => accumulator_out
	);
	
	output <= accumulator_out;
	-- overflow <= carry_out OR mul_overflow;
	
END ARCHITECTURE behavioral;