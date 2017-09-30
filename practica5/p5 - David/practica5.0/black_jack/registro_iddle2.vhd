library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registro_iddle2 is
		port (clk,	reset, load:	in std_logic;	
			 entrada : in std_logic_vector(5 downto 0);
			 salida : out std_logic_vector(5 downto 0));
end registro_iddle2;

architecture Behavioral of registro_iddle2 is

	signal salidaAux : std_logic_vector(5 downto 0);
	
begin
	
	process(clk,reset,load,entrada)
		begin
			if reset = '1' then
				salidaAux <= (OTHERS => '0');
			elsif clk'event and clk = '1' then
				if load = '1' then
					salidaAux <= entrada;
				end if;
			end if;
			salida <= salidaAux;
	end process;


end Behavioral;

