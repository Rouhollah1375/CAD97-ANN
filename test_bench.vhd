--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:04:17 11/29/2018
-- Design Name:   
-- Module Name:   C:/Users/Rooholah/Desktop/CAD_Project/CNN/test_bench.vhd
-- Project Name:  CNN
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Perceptron
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.types.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_bench IS
END test_bench;
 
ARCHITECTURE behavior OF test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Perceptron
    PORT(
         input_vector : IN  matrix1d(0 to 4);
         weight_vector : IN  matrix1d(0 to 4);
         clk : IN  std_logic;
         rst : IN  std_logic;
         output : OUT  fixed_point
        );
    END COMPONENT;
    

   --Inputs
   signal input_vector : matrix1d(0 to 4) := ("0100000000000000","0010000000000000","0001000000000000","1100000000000000","0100000000000000");
   signal weight_vector : matrix1d(0 to 4) := ("0111111111111111","0111111111111111","0111111111111111","0111111111111111","0111111111111111");
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal output : fixed_point;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Perceptron PORT MAP (
          input_vector => input_vector,
          weight_vector => weight_vector,
          clk => clk,
          rst => rst,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		rst <= '0';
		wait for 50 ns;
		rst <= '1';
		wait for 50 ns;
		rst <= '0';
		
      wait;
   end process;

END;
