library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity controller is
	PORT(clk, reset, start, juego, plantarse:	in std_logic;
				suma_acumulada: in std_logic_vector(5 downto	0);
				control:	out std_logic_vector(5 downto	0);	
				perder, carta_repetida:	out std_logic);
end controller;

architecture Behavioral of controller is

	type	ESTADOS	is	(S0, S1, S2, S3, S4, S5, S6, S7, S8);
	signal ESTADO,	SIG_ESTADO:	ESTADOS;

	signal suma_acumulada_anterior: std_logic_vector(5	downto 0);
	
	signal control_aux: std_logic_vector(5	downto 0);	
	alias load_we :	std_logic is control_aux(0);
	alias load_sumador :	std_logic is control_aux(1);
	alias load_iddle1 :	std_logic is control_aux(2);
	alias load_contador :	std_logic is control_aux(3);	
	alias	load_perder :	std_logic is control_aux(4);
	alias	load_carta_repetida : std_logic is control_aux(5);

begin

	control <= control_aux;
--------------------------------------------------------------------------------------------------
	SINCRONO: process(clk, reset, start, juego, plantarse, suma_acumulada)
	begin
		if reset = '1' then
			ESTADO <= S0;
		elsif clk'event and clk = '1' then
			ESTADO <= SIG_ESTADO;
		end if;
	end process SINCRONO;	
--------------------------------------------------------------------------------------------------
	COMB : process(clk, reset, ESTADO, start, juego, plantarse, suma_acumulada, load_perder, load_carta_repetida)
	begin

		--suma_acumulada_anterior <= "000000";
		--perder <= '0';
	--	load_we 					(0);
	-- load_sumador			(1);
	-- load_iddle1				(2);
	-- load_contador			(3);	
	-- load_perder				(4);
	-- load_carta_repetida	(5);
		
		case ESTADO is 
			WHEN S0 => -- Estado inicial
				control_aux <= "000000";
				suma_acumulada_anterior <= "000000";
				
				if load_carta_repetida = '1' then
					carta_repetida <= '1'; -- LED => carta_repetida
				else
					carta_repetida <= '0';
				end if;
				
				if load_perder = '1' then
					perder <= '1'; -- LED => perder
				else
					perder <= '0';
				end if;
				
				if (start = '0') then -- Switch => start
					SIG_ESTADO <= S0;
				else
					SIG_ESTADO <= S1;
				end if;
			
			WHEN S1 => -- Estado cuenta
				control_aux <= "000000";
				perder <= '0';
				carta_repetida <= '0';
				suma_acumulada_anterior <= suma_acumulada;
				if (juego = '1') then -- Boton => juego
					SIG_ESTADO <= S2;
				elsif (plantarse = '1') then -- Boton => plantarse
					SIG_ESTADO <= S0;
				else
					SIG_ESTADO <= S1;
				end if;
				
			WHEN S2 => -- Estado Iddle
				control_aux <= "000000";
				perder <= '0';
				carta_repetida <= '0';
				suma_acumulada_anterior <= suma_acumulada_anterior;
				if (juego = '0') then -- Espero a que se suelte el boton de juego
					load_contador <= '1'; -- Quiero tener calculada la suma acumulada en el siguiente estado	
					load_iddle1 <= '1';		--Cargo
					SIG_ESTADO <= S3;
				else 
					SIG_ESTADO <= S2;
				end if;
				
			WHEN S3 =>
				control_aux <= "000110";
				perder <= '0';
				carta_repetida <= '0';
				suma_acumulada_anterior <= suma_acumulada_anterior;
				--load_contador <= '0';		--Apago
				--load_iddle1 <= '1';		--Cargo
				--load_we <= '0';				--Leo
				--load_sumador <= '1';		--Sumo
				SIG_ESTADO <= S4;
				
			WHEN S4 =>
				control_aux <= "000100";
				--load_iddle1 <= '1';
				--load_sumador <= '0';
				--load_perder <= '0';
				perder <= '0';
				carta_repetida <= '0';
				suma_acumulada_anterior <= suma_acumulada_anterior;
			
				if (suma_acumulada = "10110") then -- suma_acumulada = 22
					load_perder <= '1';
					SIG_ESTADO <= S0;
				elsif (suma_acumulada = "10111") then -- suma_acumulada = 23
					load_perder <= '1';
					SIG_ESTADO <= S0;
				elsif (suma_acumulada = "11000") then -- suma_acumulada = 24
					load_perder <= '1';
					SIG_ESTADO <= S0;
				elsif (suma_acumulada = "11001") then -- suma_acumulada = 25
					load_perder <= '1';
					SIG_ESTADO <= S0;
				elsif (suma_acumulada = "11010") then -- suma_acumulada = 26
					load_perder <= '1';
					SIG_ESTADO <= S0;
				elsif (suma_acumulada = "11011") then -- suma_acumulada = 27
					load_perder <= '1';
					SIG_ESTADO <= S0;
				elsif (suma_acumulada = "11100") then -- suma_acumulada = 28
					load_perder <= '1';
					SIG_ESTADO <= S0;
				elsif (suma_acumulada = "11101") then -- suma_acumulada = 29
					load_perder <= '1';
					SIG_ESTADO <= S0;
				elsif (suma_acumulada = "11110") then -- suma_acumulada = 30
					load_perder <= '1';
					SIG_ESTADO <= S0;
				elsif (suma_acumulada = "11111") then -- suma_acumulada = 31
					load_perder <= '1';
					SIG_ESTADO <= S0;
				else
					-- Display 7-seg => suma_acumulada
					SIG_ESTADO <= S5;
				end if;
			
			-- actualizar memoria: carta incorrecta, puntuacion acumulada
			WHEN S5 =>
				control_aux <= "000101";
				perder <= '0';
				carta_repetida <= '0';
				suma_acumulada_anterior <= suma_acumulada_anterior;
				--load_iddle1 <= '1';
				--load_we <= '1'; -- Escribo en memoria
				SIG_ESTADO <= S6;
			
			WHEN S6 =>
				control_aux <= "000001";
				perder <= '0';
				carta_repetida <= '0';
				suma_acumulada_anterior <= suma_acumulada_anterior;
				--load_iddle1 <= '0';
				SIG_ESTADO <= S7;
				
			WHEN S7 => -- Carta Repetida
				perder <= '0';
				carta_repetida <= '0';
				suma_acumulada_anterior <= suma_acumulada_anterior;
				control_aux <= "000000";
				if (suma_acumulada = suma_acumulada_anterior) then
					load_carta_repetida <= '1';
					SIG_ESTADO <= S1;
				else
					SIG_ESTADO <= S8;
				end if;
			
			WHEN S8 => -- suma_acumulada <= 21
				control_aux <= "000000";
				perder <= '0';
				carta_repetida <= '0';
				suma_acumulada_anterior <= suma_acumulada_anterior;
				SIG_ESTADO <= S1;
				
		end case;	
	end process COMB;
--------------------------------------------------------------------------------------------------

end Behavioral;

