LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY sim_black_jack IS
END sim_black_jack;
 
ARCHITECTURE behavior OF sim_black_jack IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT black_jack
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         juego : IN  std_logic;
         plantarse : IN  std_logic;
         perder : OUT  std_logic;
         carta_repetida : OUT  std_logic;
         suma_total : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal juego : std_logic := '0';
   signal plantarse : std_logic := '0';

 	--Outputs
   signal perder : std_logic;
   signal carta_repetida : std_logic;
   signal suma_total : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: black_jack PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          juego => juego,
          plantarse => plantarse,
          perder => perder,
          carta_repetida => carta_repetida,
          suma_total => suma_total
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
      -- Inputs: clk reset start juego plantarse
		reset <= '1';
      wait for 100 ns;
		reset <= '0';
		start <= '0';
		juego <= '0';
		plantarse <= '0';
      wait for 20 ns;
		start <= '1';
		wait for 10 ns;
		juego <= '1';
		wait for 10 ns;
		start <= '0';
		wait for 10 ns;
		juego <= '0'; -- Dejo de pulsar el boton
		plantarse <= '1';
		
																						--	wait until rising_edge(clk);
      wait;
   end process;

END;
