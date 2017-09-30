--Librerias necesarias
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;
 
 
ENTITY simreg IS
END simreg;
 
ARCHITECTURE behavior OF simreg IS 
 
-- Declaración del componente que vamos a simular
 
    COMPONENT reg_paralelo
    PORT(
         rst : IN  std_logic;
         clk_100MHz : IN  std_logic;
			load: IN  std_logic;
         EP : IN  std_logic_vector(3 downto 0);
         SP : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;

--Entradas
    signal rst : std_logic;
    signal clk_100MHz : std_logic;
	 signal load : std_logic;
    signal EP : std_logic_vector(3 downto 0);
		
--Salidas
    signal SP : std_logic_vector(3 downto 0);
   
--Se define el periodo de reloj 
    constant clk_100MHz_period : time := 50 ns;
 
BEGIN
 
-- Instanciacion de la unidad a simular 

   uut: reg_paralelo PORT MAP (
          rst => rst,
          clk_100MHz => clk_100MHz,
			 load=> load,
          EP => EP,
          SP => SP
        );

-- Definicion del process de reloj
reloj_process :process
   begin
	clk_100MHz <= '0';
	wait for clk_100MHz_period/2;
	clk_100MHz <= '1';
	wait for clk_100MHz_period/2;
end process;
 

--Proceso de estimulos
stim_proc: process
   begin		
-- Se mantiene el rst activado durante 50 ns.
	rst<='1';
	load<='0';
	EP<="0000";
      wait for 50 ns;	
	rst<='0';
	load<='1';
	EP<="0010";
      wait for 50 ns;	
	EP<="0101";
      wait for 50 ns;	
	load<='0';
      wait for 50 ns;	
	load<='1';
	EP<="1101";
      wait for 50 ns;	
	EP<="0011";
      wait for 50 ns;	
	EP<="1010";
      wait for 50 ns;	
	load<='0';
	EP<="0001";
      wait for 50 ns;	
	load<='1';
      wait for 50 ns;	
	EP<="0111";
      wait for 50 ns;	
	rst<='1';
	EP<="0011";
      wait;
end process;

END;
