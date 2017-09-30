
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity counter is

port (	clk: in std_logic;
			rst: in std_logic;
			count: in std_logic;
			O: out std_logic_vector(5 downto 0)
);

end counter;

architecture Behavioral of counter is

component adder
port (A, B: in std_logic_vector(3 downto 0); 
		C: out std_logic_vector(3 downto 0)); 
end component;

component reg_paralelo
    port (rst, clk_100MHz, load: in std_logic;
			 E: in std_logic_vector(3 downto 0);
	       S: out std_logic_vector(3 downto 0));
end component;

component divider
    port (
        rst: in STD_LOGIC;
        clk_in: in STD_LOGIC; 
        clk_out: out STD_LOGIC
    );
end component;

signal reg_paralelo_O: std_logic_vector(3 downto 0);
signal adder_O: std_logic_vector(3 downto 0);
signal clk_intermediate: std_logic;

begin

-- COMMENT/UNCOMMENT FOR REMOVING/ADDING THE DIVIDER
--	divider_1: divider port map ( rst => rst,
--											clk_in => clk,
--											clk_out => clk_intermediate);

-- COMMENT/UNCOMMENT FOR ADDING/REMOVING THE DIVIDER
	clk_intermediate <= clk;

	adder_1: adder port map( A => reg_paralelo_O,
									 B => "0001",
									 C => adder_O);
									 
	register_1: reg_paralelo port map (
									rst => rst,
									clk_100MHz => clk_intermediate,
									load => count,
									E => adder_O,
									S => reg_paralelo_O
									);

-- SEQUENCE TRANSLATOR
	with reg_paralelo_O select 
			O <= "000100" when "0000",
				  "001000" when "0001",
				  "001111" when "0010",
				  "010000" when "0011",
				  "010111" when "0100",
				  "101010" when others;

end Behavioral;

