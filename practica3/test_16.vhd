--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:44:58 11/13/2014
-- Design Name:   
-- Module Name:   C:/P3_Francisco/test_16.vhd
-- Project Name:  P3_Francisco
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder_16_bits_v3
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_16 IS
END test_16;
 
ARCHITECTURE behavior OF test_16 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder_16_bits_v3
    PORT(
         cin : IN  std_logic;
         op1 : IN  std_logic_vector(15 downto 0);
         op2 : IN  std_logic_vector(15 downto 0);
         add : OUT  std_logic_vector(15 downto 0);
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal cin : std_logic := '0';
   signal op1 : std_logic_vector(15 downto 0) := (others => '0');
   signal op2 : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal add : std_logic_vector(15 downto 0);
   signal cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder_16_bits_v3 PORT MAP (
          cin => cin,
          op1 => op1,
          op2 => op2,
          add => add,
          cout => cout
        );


   -- Stimulus process
   stim_proc: process
   begin		


		cin <= '0';
		op1 <= "0000000000100000";
		op2 <= "0000000000110000";
		wait for 50 ns;
		op1 <= "0010000011110000";
		op2 <= "0111000011111110";
		wait for 50 ns;
		op1 <= "0000011111100000";
		op2 <= "0010111001010000";
		wait for 50 ns;
		op1 <= "1111000011101010";
		op2 <= "1111001000111101";
		wait for 50 ns;
		op1 <= "0000010000011110";
		op2 <= "1010010101111000";		
      wait;
   end process;

END;
