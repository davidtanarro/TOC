
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;



entity registro_cociente_B is
generic (n : natural := 8;
			m : natural := 4);

	port	(clk,	reset, load, despl_izqda, entradaSerie: in std_logic;	
			 salida : out std_logic_vector(n - 1 downto 0));

end registro_cociente_B;

architecture Behavioral of registro_cociente_B is

signal salidaAux : std_logic_vector(n - 1 downto 0);

begin

	
	PROCESS (clk,	reset, load, despl_izqda, salidaAux) 
	begin 
		if reset = '1' then 
			salidaAux <= (others => '0'); 
		elsif clk'event and clk='1' then 
			if load = '1' then 
				salidaAux <= (others => '0'); --cociente; 
			elsif despl_izqda = '1' then 
				salidaAux <= salidaAux (n - 2 downto 0) & entradaSerie; -- rotacion izquierda
			end if; 
		end if; 
		salida <= salidaAux;
	end process;

end Behavioral;

