--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:35:56 12/15/2014
-- Design Name:   
-- Module Name:   C:/Users/david/Desktop/UNI-DAVID/Asignaturas/Segundo/TOC - Tecnologia y Organizacion de Computadores/Practicas/practica5/sumador_6bits/sim_sum_6bits.vhd
-- Project Name:  sumador_6bits
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder_6bits
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
 
ENTITY sim_sum_6bits IS
END sim_sum_6bits;
 
ARCHITECTURE behavior OF sim_sum_6bits IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder_6bits
    PORT(
         x : IN  std_logic_vector(5 downto 0);
         y : IN  std_logic_vector(5 downto 0);
         cin : IN  std_logic;
         load : IN  std_logic;
         s : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(5 downto 0) := (others => '0');
   signal y : std_logic_vector(5 downto 0) := (others => '0');
   signal cin : std_logic := '0';
   signal load : std_logic := '0';

 	--Outputs
   signal s : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder_6bits PORT MAP (
          x => x,
          y => y,
          cin => cin,
          load => load,
          s => s
        );

   -- Clock process definitions
   <clock>_process :process
   begin
		<clock> <= '0';
		wait for <clock>_period/2;
		<clock> <= '1';
		wait for <clock>_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		load <= '0';
      wait for 100 ns;
		load <= '0';
		x <= "000001";
		y <= "000000";
		cin <= '0';
		wait until rising_edge(clock);
		load <= '1';
		--wait until rising_edge(clk);
		--x <= "000001";
		--y <= "000011";
		--wait until rising_edge(clk);


      wait;
   end process;

END;
