library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;



entity registro_divisor_B is
generic (n : natural := 8;
			m : natural := 4);

	port	(clk,	reset, load, despl_derecha, entradaSerie: in std_logic;	
			 divisor : in std_logic_vector(m - 1	downto 0);
			 salida : out std_logic_vector(n	downto 0));

end registro_divisor_B;

architecture Behavioral of registro_divisor_B is

signal salidaAux : std_logic_vector(n downto 0);
SIGNAL rellenaCeros : std_logic_vector(n-m-1 downto 0);

begin


		

	PROCESS (reset, clk, load, despl_derecha,divisor,salidaAux) 
		begin 
			rellenaCeros <= (others => '0');
			if reset = '1' then 
				salidaAux <= (others => '0'); 
			elsif clk'event and clk='1' then 
		
				if load = '1' then 
					salidaAux <= '0' & divisor & rellenaCeros; 
				elsif despl_derecha = '1' then 
				
					  salidaAux <= entradaSerie & salidaAux(n downto 1);

				end if; 
			end if; 
			salida <= salidaAux;
end process;


end Behavioral;

