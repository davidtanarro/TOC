
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity divider_B is

	generic (n : natural := 8;
				m : natural := 4);
	port	(clk,	reset: in std_logic;	
			dividendo: in	std_logic_vector(n - 1 downto 0);	
			divisor: in	std_logic_vector(m - 1	downto 0);	
			start: in std_logic;	
			ready: out std_logic;
			quotient: out std_logic_vector(n-1	downto	0));	
	
end divider_B;

architecture Behavioral of divider_B is
COMPONENT controller_B is
	PORT(clk,	reset, start:	in std_logic;
		  menor_o_igual:	in std_logic;	
		  bitCociente:	in std_logic;
		  control:	out std_logic_vector(7 downto	0);	
		  ready:	out std_logic);
END COMPONENT;

COMPONENT data_path_B is
GENERIC(n : natural;
		  m : natural);
	PORT(clk, reset : in std_logic;
		  dividendo : in std_logic_vector(n - 1 downto 0);
		  divisor : in std_logic_vector(m - 1 downto 0);
		  control:	in std_logic_vector(7 downto 0);	
		  quotient: out std_logic_vector(n - 1 downto 0);
		  bitCociente:	out std_logic;
		  menor_o_igual:	out std_logic);	
end COMPONENT;

signal	 menor_o_igual, bitCociente:	std_logic;
signal	control: std_logic_vector(7 downto 0);
begin

	Ruta_de_Datos_B: data_path_B GENERIC MAP(n, m) PORT MAP(clk, 
												 reset,
												 dividendo,
												 divisor,
												 control,
											    quotient,
												 bitCociente,
												 menor_o_igual);
												 
	Controlador_B: controller_B PORT MAP(clk,	
											   reset,	
												start,
											   menor_o_igual,
												bitCociente,
												control,
												ready);
												
end Behavioral;


