--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:44:16 12/16/2014
-- Design Name:   
-- Module Name:   C:/hlocal/practica5/tb_black_jack.vhd
-- Project Name:  practica5
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: black_jack
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
 
ENTITY tb_black_jack IS
END tb_black_jack;
 
ARCHITECTURE behavior OF tb_black_jack IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT black_jack
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         inicio : IN  std_logic;
         jugar : IN  std_logic;
         plantarse : IN  std_logic;
         pierdo : OUT  std_logic;
         display : OUT  std_logic_vector(6 downto 0);
         puntuacion : OUT  std_logic_vector(4 downto 0);
         fin : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal inicio : std_logic := '0';
   signal jugar : std_logic := '0';
   signal plantarse : std_logic := '0';

 	--Outputs
   signal pierdo : std_logic;
   signal display : std_logic_vector(6 downto 0);
   signal puntuacion : std_logic_vector(4 downto 0);
   signal fin : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: black_jack PORT MAP (
          rst => rst,
          clk => clk,
          inicio => inicio,
          jugar => jugar,
          plantarse => plantarse,
          pierdo => pierdo,
          display => display,
          puntuacion => puntuacion,
          fin => fin
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

      wait for clk_period*10;

      -- insert stimulus here 
		wait for 100 ns;
		rst <= '0';		
		inicio <= '0';
		wait for 100 ns;
		rst <= '1';
		wait for 100 ns;
		inicio <= '1';
		plantarse <= '1';
		wait for 100 ns;
		jugar <= '1';
		wait for 100 ns;
		jugar <= '0';
		wait for 100 ns;
		jugar <= '1';
		wait for 100 ns;
		jugar <= '0';
		wait for 100 ns;
		plantarse <= '0';
		wait for 100 ns;

      wait;
   end process;

END;
