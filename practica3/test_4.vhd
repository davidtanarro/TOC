--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:37:29 11/13/2014
-- Design Name:   
-- Module Name:   C:/P3_Francisco/test_4.vhd
-- Project Name:  P3_Francisco
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder_4bits_v3
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
 
ENTITY test_4 IS
END test_4;
 
ARCHITECTURE behavior OF test_4 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder_4bits_v3
    PORT(
         cin : IN  std_logic;
         op1 : IN  std_logic_vector(3 downto 0);
         op2 : IN  std_logic_vector(3 downto 0);
         add : OUT  std_logic_vector(3 downto 0);
         g : OUT  std_logic;
         p : OUT  std_logic;
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal cin : std_logic := '0';
   signal op1 : std_logic_vector(3 downto 0) := (others => '0');
   signal op2 : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal add : std_logic_vector(3 downto 0);
   signal g : std_logic;
   signal p : std_logic;
   signal cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder_4bits_v3 PORT MAP (
          cin => cin,
          op1 => op1,
          op2 => op2,
          add => add,
          g => g,
          p => p,
          cout => cout
        );
 

   -- Stimulus process
   stim_proc: process
   begin
		cin <= '0';
		op1 <= "0010";
		op2 <= "0011";
		wait for 50 ns;
		op1 <= "0010";
		op2 <= "0111";
		wait for 50 ns;
		op1 <= "0110";
		op2 <= "0011";
		wait for 50 ns;
		op1 <= "1010";
		op2 <= "0011";
		wait for 50 ns;
		op1 <= "0010";
		op2 <= "1011";	
		wait for 50 ns;
		op1 <= "1010";
		op2 <= "1011";	
		wait for 50 ns;
		op1 <= "0110";
		op2 <= "1111";		
      wait;
   end process;

END;
