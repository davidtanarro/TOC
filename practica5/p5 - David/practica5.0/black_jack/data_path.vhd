library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_path is
	PORT(clk, reset, start: in std_logic;
			suma_acumulada_entrada: in std_logic_vector(5 downto 0);
			suma_acumulada_salida: out std_logic_vector(5 downto 0);
			control:	in std_logic_vector(5 downto 0));			
end data_path;

architecture Behavioral of data_path is

	COMPONENT registro_cuenta is
		PORT (clk,	reset, cuenta, load_contador:	in std_logic;	
				entrada : in std_logic_vector(5 downto 0);
				salida : out std_logic_vector(5 downto 0));
	END COMPONENT;
	
	COMPONENT registro_iddle1 is
		PORT (clk,	reset, load:	in std_logic;	
			 entrada : in std_logic_vector(5 downto 0);
			 salida : out std_logic_vector(5 downto 0));
	END COMPONENT;

	COMPONENT ram_memory is
		PORT(clk: in std_logic;
				we: in std_logic;
				addr: in std_logic_vector(5 downto 0);
				din: in std_logic_vector(3 downto 0);
				dout: out std_logic_vector(3 downto 0));
	END COMPONENT;
	
	COMPONENT adder_6bits is
		PORT( clk, reset: in std_logic;
			  x: in std_logic_vector(5 downto 0);
			  y: in std_logic_vector(5 downto 0);
			  cin: in std_logic;
			  load:	in std_logic;
			  s: out std_logic_vector(5 downto 0));
	END COMPONENT;

	signal cuenta, we, cin: std_logic;
	signal ceros: std_logic_vector(5 downto 0);
	signal aux_addr, addr: std_logic_vector(5 downto 0);
	signal dout, suma_i, aux_suma_acumulada: std_logic_vector(5 downto 0);
	signal aux_din, aux_dout: std_logic_vector(3 downto 0);

	signal control_aux: std_logic_vector(5	downto 0);	
	alias load_we: std_logic is control_aux(0);
	alias	load_sumador : std_logic is control_aux(1);
	alias	load_addle1 : std_logic is control_aux(2);	
	alias	load_contador :	std_logic is control_aux(3);
	alias	load_perder :	std_logic is control_aux(4);
	alias	load_carta_repetida : std_logic is control_aux(5);
	
begin

	control_aux <= control;
	cuenta <= '1';
	ceros <= "000000";
	aux_din <= "0000";
	
	Contador: registro_cuenta PORT MAP (clk, reset, cuenta, load_contador, ceros, aux_addr);
	
	Iddle1: registro_iddle1 PORT MAP (clk,	reset, load_addle1, aux_addr, addr);

	-- multiplexor
	with load_we select we <= '1' when '1', '0' when others;
	Memoria_Ram: ram_memory PORT MAP(clk,	
											   we,	
												addr,
												aux_din,
												aux_dout);
	dout <= "00" & aux_dout; --Lo que devuelve la RAM al leer
	cin <= '0';

	-- multiplexor
	with start select aux_suma_acumulada <= "000000" when '1', suma_acumulada_entrada when others;
	
	Sumador_6bits: adder_6bits PORT MAP (clk, reset, aux_suma_acumulada, dout, cin, load_sumador, suma_i);

	suma_acumulada_salida <= suma_i(5 downto 0);

end Behavioral;

