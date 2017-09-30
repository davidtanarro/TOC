library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity contador is
	port (clk, reset, e: in std_logic;
			S: out std_logic_vector(3 downto 0)
			);
end contador;

architecture Behavioral of contador is
	signal cont : std_logic_vector(3 downto 0);
begin
	process(clk, reset) 
	begin
		if reset = '0' then
			cont <= "0000";
		elsif (clk'event and clk = '1') then
			if e = '1' then
				cont <= cont + 1;
			else
				cont <= cont;
			end if;
		end if;
	end process;
	
	S <= cont;
end Behavioral;

