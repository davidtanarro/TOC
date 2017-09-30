library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity registro_cuenta is
	PORT (clk, reset, cuenta, load_contador: in std_logic;
			 entrada: in std_logic_vector(5 downto 0);
			 salida: out std_logic_vector(5 downto 0));
end registro_cuenta;

architecture Behavioral of registro_cuenta is

	SIGNAL salidaAux : std_logic_vector(5 downto	0);

begin
	
	process(clk, reset, cuenta, load_contador, entrada, salidaAux)
		begin
			if reset = '1' then
				salidaAux <= (OTHERS => '0');
			elsif clk'event and clk = '1' and load_contador = '1' then				
				if cuenta = '1' then 				-- "cuenta" siempre tiene que ser '1'
					salidaAux <= salidaAux + '1';
					if salidaAux = "110011"  then		-- cuando el contador llega 51, vuelve a ser 0
						salidaAux <= (OTHERS => '0');
					end if;
				else
					salidaAux <= entrada; -- No cuento, saco la entrada
				end if;
			end if;		
		salida <= salidaAux;
	end process;

end Behavioral;