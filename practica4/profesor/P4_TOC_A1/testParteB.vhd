--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY testParteB IS
generic (n : natural := 8;
			m : natural := 4);
END testParteB;
 
ARCHITECTURE behavior OF testParteB IS 
 

 
    COMPONENT divider_B
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         dividendo : IN  std_logic_vector(n - 1 downto 0);
         divisor : IN  std_logic_vector(m - 1 downto 0);
         start : IN  std_logic;
         ready : OUT  std_logic;
         quotient : OUT  std_logic_vector(n - 1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal dividendo : std_logic_vector(n - 1 downto 0) := (others => '0');
   signal divisor : std_logic_vector(m - 1 downto 0) := (others => '0');
   signal start : std_logic := '0';

 	--Outputs
   signal ready : std_logic;
   signal quotient : std_logic_vector(n - 1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: divider_B PORT MAP (
          clk => clk,
          reset => reset,
          dividendo => dividendo,
          divisor => divisor,
          start => start,
          ready => ready,
          quotient => quotient
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
	  reset<='1';
     wait for 50 ns; --80ns
		reset<='0';
		start <= '0';
     wait for 50 ns;
		start<='1';
		divisor<="1101";
		dividendo<="11101101"; 
	  wait for 20 ns;
		start <= '0';
	  wait until ready = '1';
	--	divisor<="1111";
	--	dividendo<="11111111"; 
	--  wait for 20 ns;
	--	start <= '1';
	--  wait for 20 ns;
	--	start<='0';
	--  wait until ready = '1';
	--	reset<='1';
	  
		
	  
		wait;
   end process;

END;
