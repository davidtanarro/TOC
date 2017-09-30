library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_card is
	port(
		clk: in std_logic;
		load: in std_logic;
		rst: in std_logic;
		input: in std_logic_vector (3 downto 0);
		output: out std_logic_vector (3 downto 0));
end reg_card;

architecture Behavioral of reg_card is

begin
	p_output: process (rst, clk, load)
	begin
		if rst = '1' then
			output <= (others => '0');
		else
			if rising_edge(clk) and load = '1' then
				output <= input(3 downto 0);
			end if;
		end if;
	end process p_output;
end Behavioral;

