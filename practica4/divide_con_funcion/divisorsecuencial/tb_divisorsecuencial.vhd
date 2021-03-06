LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_divisorsecuencial IS
END tb_divisorsecuencial;
 
ARCHITECTURE behavior OF tb_divisorsecuencial IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT divisorsecuencial
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         dividend : IN  std_logic_vector(7 downto 0);
         divisor : IN  std_logic_vector(7 downto 0);
         start : IN  std_logic;
         ready : OUT  std_logic;
         quotient : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal dividend : std_logic_vector(7 downto 0) := (others => '0');
   signal divisor : std_logic_vector(7 downto 0) := (others => '0');
   signal start : std_logic := '0';

 	--Outputs
   signal ready : std_logic;
   signal quotient : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: divisorsecuencial PORT MAP (
          clk => clk,
          reset => reset,
          dividend => dividend,
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
      -- hold reset state for 100 ns.
      --wait for 100 ns;	
      --wait for clk_period*10;

      -- insert stimulus here 

		dividend <= "00000110";
		divisor <= "00000010";
      wait for 100 ns;
		dividend <= "00001011";
		divisor <= "00000010";
      wait for 100 ns;
		dividend <= "00001101";
		divisor <= "00000011";	
		wait;
   end process;

END;
