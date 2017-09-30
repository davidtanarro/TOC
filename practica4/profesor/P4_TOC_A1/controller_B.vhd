library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;



entity controller_B is

	port(clk,	reset, start:	in std_logic;
		menor_o_igual:	in std_logic;
		bitCociente:	in std_logic;
		control:	out std_logic_vector(7 downto	0);
	   ready: out std_logic);
		
end controller_B;

architecture Behavioral of controller_B is

	type	ESTADOS	is	(S0, S1, S2, S4, S5, S6);	-- Eliminados S3 y S7
	signal ESTADO,	SIG_ESTADO:	ESTADOS;

	signal control_aux: std_logic_vector(7	downto 0);	

	alias	load_dividendo : std_logic is control_aux(0);	
	alias	load_divisor :	std_logic is control_aux(1);	
	alias	desplazamiento_derecha_divisor : std_logic is control_aux(2);	
	alias	load_cociente : std_logic is control_aux(3);	
	alias	desplazamiento_izquierda_cociente : std_logic is control_aux(4);
	alias cuenta_k : std_logic is control_aux(5);
	alias mux_dividendo : std_logic is control_aux(6);
	alias opera : std_logic is control_aux(7);

signal reloj: std_logic;


begin

	reloj<=clk;

	control <= control_aux;
	
	SINCRONO:process(reloj, reset)
	begin
		if reset = '1' then
			ESTADO <= S0;
		elsif reloj'event and reloj = '1' then
			ESTADO <= SIG_ESTADO;
		end if;
	end process SINCRONO;
	
	COMB : process(reloj,reset, ESTADO, start, menor_o_igual, bitCociente)
	begin
	
		load_dividendo <= '0';
		load_divisor <= '0';
		desplazamiento_derecha_divisor <= '0'; 
		load_cociente <= '0'; 
		desplazamiento_izquierda_cociente <= '0';  
		cuenta_k <= '0'; 
		mux_dividendo <= '0'; 
		opera <= '0';
		ready <= '0';
		
		case ESTADO is 
			WHEN S0 => 
				ready <= '1';
				if (start = '0') then 
					SIG_ESTADO <= S0;
				else
					SIG_ESTADO <= S1;
				end if;
			
			WHEN S1 => 
				load_dividendo <= '1';
				load_divisor <= '1';
				load_cociente <= '1'; 
				SIG_ESTADO <= S2;
				
			WHEN S2 =>
				opera <= '0';
				load_dividendo <= '1';
				mux_dividendo <= '1'; 
				if (bitCociente = '0') then
					SIG_ESTADO <= S4;
				else 
					SIG_ESTADO <= S5;
				end if;
				
--			WHEN S3 => 
--				if (bitCociente = '0') then
--					SIG_ESTADO <= S4;
--				else 
--					SIG_ESTADO <= S5;
--				end if;

			WHEN S4 => 
				load_dividendo <= '1';
				mux_dividendo <= '1'; 
				opera <= '1';	
				desplazamiento_izquierda_cociente <= '1';			
				SIG_ESTADO <= S6;
				
			WHEN S5 => 
				desplazamiento_izquierda_cociente <= '1';			
				SIG_ESTADO <= S6;
				
			WHEN S6 => 

				desplazamiento_derecha_divisor <= '1'; 
				cuenta_k <= '1';
				if(menor_o_igual = '0') then 
					SIG_ESTADO <= S2;
				else
					SIG_ESTADO <= S0;
				end if;
			
--			WHEN S7 =>  
--				if(menor_o_igual = '0') then 
--					SIG_ESTADO <= S2;
--				else
--					SIG_ESTADO <= S0;
--				end if;
				
		END CASE;	
	end process COMB;

end Behavioral;