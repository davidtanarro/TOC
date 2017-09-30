
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity registro_k_B is
generic (n : natural := 8;
			m : natural := 4);

	port	(clk,	reset, cuenta:	in std_logic;	
			 A : in std_logic_vector(n	downto	0);
			 salida : out std_logic_vector(n	downto	0));

end registro_k_B;

architecture Behavioral of registro_k_B is

SIGNAL salidaAux : std_logic_vector(n downto	0);

begin

	
	PROCESS(clk,reset,cuenta,salidaAux,A)
		begin
			if reset = '1' then
				salidaAux <= (OTHERS => '0');
			elsif clk'event and clk = '1' then
				if cuenta = '1' then
					salidaAux <= salidaAux + A + '1';
				end if;
			end if;
		salida <= salidaAux;
		end process;


end Behavioral;