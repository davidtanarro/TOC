--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:27:04 01/18/2015
-- Design Name:   
-- Module Name:   C:/CORREGIR2/test.vhd
-- Project Name:  CORREGIR2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparador
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

ENTITY sim_asm IS
END sim_asm;
 
ARCHITECTURE behavior OF sim_asm IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT asm
    PORT(
         clk : IN  std_logic;
         rst_n : IN  std_logic;
         ini : IN  std_logic;
         escribir : IN  std_logic;
         clave : IN  std_logic_vector(3 downto 0);
         nueva_clave : IN  std_logic_vector(3 downto 0);
         fin : OUT  std_logic;
         dir : OUT  std_logic_vector(4 downto 0);
         error_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal ini : std_logic := '0';
   signal escribir : std_logic := '0';
   signal clave : std_logic_vector(3 downto 0) := (others => '0');
   signal nueva_clave : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal fin : std_logic;
   signal dir : std_logic_vector(4 downto 0);
   signal error_o : std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: asm PORT MAP (
          clk => clk,
          rst_n => rst_n,
          ini => ini,
          escribir => escribir,
          clave => clave,
          nueva_clave => nueva_clave,
          fin => fin,
          dir => dir,
          error_o => error_o
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	-- Condiciones iniciales: 
	-- 1) La clave "1100" situada en la posicion 31 de memoria
	-- 2) No existen las claves "1111" ni "0011" en la memoria
	-- 3) El reset es activo a ALTA
   stim_proc: process
   begin

	-- Testbench profesor
		-- reset
		rst_n <= '1';
		ini <= '0';
		escribir <= '0';
		clave <= (others => '0');
		nueva_clave <= (others => '0');
		wait for 190 ns;
		
		-- lectura de la clave 1111, que no esta en la memoria
		rst_n <= '0';
		ini <= '1';
		clave <= "1111";
		wait for 100 ns;
		ini <= '0';
		wait for 20000 ns;
		assert (fin = '1' and error_o = '1') report "ERROR EN TESTBENCH (1)" severity error;
		
		-- lectura de la clave 1100, que esta en la memoria
		rst_n <= '1';
		wait for 100 ns;
		rst_n <= '0';
		ini <= '1';
		clave <= "1100";
		wait for 100 ns;
		ini <= '0';
		wait for 20000 ns;
		assert (fin = '1' and error_o = '0' and dir = "11111") report "ERROR EN TESTBENCH (2)" severity error;
		
		-- lectura de la clave 1100 y escritura de la nueva clave 1111 en la posicion de memoria 5(31)
		rst_n <= '1';
		wait for 100 ns;
		rst_n <= '0';
		ini <= '1';
		escribir <= '1';
		nueva_clave <= "1111";
		wait for 100 ns;
		ini <= '0';
		wait for 20000 ns;
		escribir <= '0';
		assert (fin = '1' and error_o = '0' and dir = "11111") report "ERROR EN TESTBENCH (3)" severity error;
		
		-- lectura de la clave 1111, que ahora si esta en la memoria
		rst_n <= '1';
		wait for 100 ns;
		rst_n <= '0';
		ini <= '1';
		clave <= "1111";
		wait for 100 ns;
		ini <= '0';
		wait for 20000 ns;
		assert (fin = '1' and error_o = '0' and dir = "11111") report "ERROR EN TESTBENCH (4)" severity error;
     		
      wait;
   end process;

END;
