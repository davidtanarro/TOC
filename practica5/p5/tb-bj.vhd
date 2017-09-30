
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bj
    PORT(
         clk	 : IN  std_logic;
         reset  : IN  std_logic;
         start  : IN  std_logic;
         hit 	 : IN  std_logic;
         stand  : IN  std_logic;
         wrong  : OUT  std_logic;
         loser  : OUT  std_logic;
         card 	 : OUT  std_logic_vector(3 downto 0);
         points : OUT  std_logic_vector(5 downto 0);
			display: OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
     

   --Inputs
   signal clk 	 : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal hit 	 : std_logic := '0';
   signal stand : std_logic := '0';

 	--Outputs
   signal wrong  : std_logic;
   signal loser  : std_logic;
   signal card   : std_logic_vector(3 downto 0);
   signal points : std_logic_vector(5 downto 0);
	signal display: std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bj PORT MAP (
          clk 	  => clk,
          reset  => reset,
          start  => start,
          hit 	  => hit,
          stand  => stand,
          wrong  => wrong,
          loser  => loser,
          card   => card,
          points => points,
			 display=> display
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
      wait for 100 ns;	

      wait for clk_period*10;

      start <= '1';
		wait for clk_period;
		start <= '0';
		stand <= '0';
		wait for clk_period;
		start<='1';
		stand <= '1';
		wait for clk_period*10;
		start<='0';
		hit <='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit<='1';
		wait for clk_period*50;
		hit<='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		start <= '1';
		wait for clk_period;
		hit <='1';
		wait for clk_period;
		hit <='0';
		
		wait for clk_period*20;
		start<='1';
		stand <= '1';
		wait for clk_period*10;
		start<='0';
		hit <='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit<='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		start <= '1';
		wait for clk_period;
		hit <='1';
		wait for clk_period;
		hit <='0';
		
		wait for clk_period;
		start<='1';
		stand <= '1';
		wait for clk_period*10;
		start<='0';
		hit <='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit<='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		start <= '1';
		wait for clk_period;
		hit <='1';
		wait for clk_period;
		hit <='0';
		
		wait for clk_period;
		start<='1';
		stand <= '0';
		wait for clk_period*10;
		start<='0';
		hit <='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit<='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		start <= '1';
		wait for clk_period;
		hit <='1';
		wait for clk_period;
		hit <='0';
		
		wait for clk_period;
		start<='1';
		stand <= '0';
		wait for clk_period*10;
		start<='0';
		hit <='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit<='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		start <= '1';
		wait for clk_period;
		hit <='1';
		wait for clk_period;
		hit <='0';
		
		wait for clk_period;
		start<='1';
		stand <= '0';
		wait for clk_period*10;
		start<='0';
		hit <='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit<='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		start <= '1';
		wait for clk_period;
		hit <='1';
		wait for clk_period;
		hit <='0';
		
		wait for clk_period;
		start<='1';
		stand <= '0';
		wait for clk_period*10;
		start<='0';
		hit <='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit<='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		start <= '1';
		wait for clk_period;
		hit <='1';
		wait for clk_period;
		hit <='0';
		
		wait for clk_period;
		start<='1';
		stand <= '0';
		wait for clk_period*10;
		start<='0';
		hit <='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit<='1';
		wait for clk_period;
		hit<='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		hit <='1';
		wait for clk_period;
		hit <='0';
		wait for clk_period*10;
		start <= '1';
		wait for clk_period;
		hit <='1';
		wait for clk_period;
		hit <='0';
		
      wait;
   end process;

END;
