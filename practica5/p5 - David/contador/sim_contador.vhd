LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY sim_contador IS
END sim_contador;
 
ARCHITECTURE behavior OF sim_contador IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contador
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         cuenta : IN  std_logic;
         load_contador : IN  std_logic;
         entrada : IN  std_logic_vector(5 downto 0);
         salida : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal cuenta : std_logic := '0';
   signal load_contador : std_logic := '0';
   signal entrada : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal salida : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contador PORT MAP (
          clk => clk,
          reset => reset,
          cuenta => cuenta,
          load_contador => load_contador,
          entrada => entrada,
          salida => salida
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
		reset <= '1';
      wait for 100 ns;
      -- insert stimulus here 
		reset <= '0';
		load_contador <= '1';
		cuenta <= '1';
		entrada <= "000000";
      wait for 200 ns;
		reset <= '1';
      wait for 20 ns;
		reset <= '0';
		entrada <= "110100";
		

      wait;
   end process;

END;
