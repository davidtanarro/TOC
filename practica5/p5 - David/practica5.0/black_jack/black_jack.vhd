library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity black_jack is

	port	(clk,	reset: in std_logic;
			start, juego, plantarse: in std_logic;
			perder, carta_repetida: out std_logic;
			suma_total: out std_logic_vector(5 downto 0));	

end black_jack;

architecture Behavioral of black_jack is

	COMPONENT data_path is
		PORT(clk, reset, start: in std_logic;
			suma_acumulada_entrada: in std_logic_vector(5 downto 0);
			suma_acumulada_salida: out std_logic_vector(5 downto 0);
			control:	in std_logic_vector(5 downto 0));
	END COMPONENT;

	COMPONENT controller is
		PORT(clk, reset, start, juego, plantarse:	in std_logic;
			suma_acumulada: in std_logic_vector(5 downto	0);
			control:	out std_logic_vector(5 downto	0);	
			perder, carta_repetida:	out std_logic);
	END COMPONENT;
	
	signal suma_acumulada_salida: std_logic_vector(5 downto 0);
	signal suma_acumulada_entrada: std_logic_vector(5 downto 0);
	signal control: std_logic_vector(5 downto 0);

begin

	Ruta_de_Datos: data_path port map(clk, reset, start,
												suma_acumulada_entrada,
												suma_acumulada_salida,
												control);
	
	suma_total <= suma_acumulada_salida;
	suma_acumulada_entrada <= suma_acumulada_salida;

	Controlador: controller port map(clk, reset, start, juego, plantarse,
												suma_acumulada_entrada,
												control,
												perder,
												carta_repetida);
												
	
end Behavioral;

