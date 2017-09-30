LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reflejo
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         boton : IN  std_logic;
         switch : IN  std_logic;
         luces : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal boton : std_logic := '0';
   signal switch : std_logic := '0';

 	--Outputs
   signal luces : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reflejo PORT MAP (
          clk => clk,
          rst => rst,
          boton => boton,
          switch => switch,
          luces => luces
        );

--reloj<=clk;	
--	Simulacion	de	un	reloj	de	100MHz	
clk_process	:process	
begin	
		clk	<=	'0';	
	wait	for	5	ns;	
		clk	<=	'1';	
	wait	for	5	ns;	
end	process;

   -- Clock process definitions
--   clk_process :process
 --  begin
--clk <= '0';
--		wait for clk_period/2;
--		clk <= '1';
--		wait for clk_period/2;
 --  end process;
 



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
 
      -- insert stimulus here 
			rst <= '1';
			wait for 50 ns;
			rst <= '0';
			wait for 20 ns;
			boton <= '1';
			wait for 40 ns;
			switch <= '1';
      wait;
   end process;

END;
