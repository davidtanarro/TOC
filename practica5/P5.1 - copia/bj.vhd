library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bj is
	port(
		clk : in std_logic;
		--reset: in std_logic;
		start: in std_logic;
		hit : in std_logic;
		stand: in std_logic;
		wrong: out std_logic;
		loser: out std_logic;
		card: out std_logic_vector(3 downto 0);
		points: out std_logic_vector(5 downto 0);
		display: out std_logic_vector(6 downto 0));
end  bj;

architecture Behavioral of bj is
	
	signal ctrl : std_logic_vector (5 downto 0);
	signal status : std_logic_vector (1 downto 0);
	
	component controller is 
   port(
   	   clk : in std_logic;
   	   start : in std_logic;
			hit : in std_logic;
			stand : in std_logic;
			status : in std_logic_vector (1 downto 0);
   	   loser : out std_logic;
			wrong : out std_logic;
   	   ctrl : out std_logic_vector(5 downto 0));
	end component controller;
	
	component data_path is
		port (
			clk: in std_logic;
			ctrl: in std_logic_vector (5 downto 0);
			status: out std_logic_vector(1 downto 0);
			card: out std_logic_vector (3 downto 0);
			points: out std_logic_vector (5 downto 0);
			display: out std_logic_vector (6 downto 0));
	end component data_path;

begin		

	dp: data_path port map(
		clk 		=> clk,
		ctrl		=> ctrl,
		status	=> status,
		card 		=> card,
		points 	=> points,
		display	=> display);
		
		cu : controller port map(
		clk 		=> clk,
		start		=> start,
		hit 		=> hit,
		stand 	=> stand,
		status	=> status,
		loser 	=> loser,
		wrong 	=> wrong,
		ctrl 		=> ctrl);

		
end Behavioral;

