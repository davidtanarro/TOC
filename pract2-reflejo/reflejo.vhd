library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reflejo is
	port (clk, rst, boton, switch : in std_logic;
			luces : out std_logic_vector(4 downto 0);
			reloj_o : out std_logic);
end reflejo;

architecture Behavioral of reflejo is

type ESTADOS is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9);
signal ESTADO, SIG_ESTADO : ESTADOS; 

	signal clk_1hz: std_logic; -- señal para el divisor
	
	
	-- DIVISOR DE FRECUENCIAS PARA LA FPGA
	------------------------------------------------------------
	
    component divisor is 
  port (
        rst: in STD_LOGIC;
        clk_entrada: in STD_LOGIC; -- reloj de entrada de la entity superior
        clk_salida: out STD_LOGIC -- reloj que se utiliza en los process del programa principal
    );
	end component;
	-------------------------------------------------------------
	
	
	
	

begin

  
	reloj: divisor port map(rst,clk,clk_1hz);
	reloj_o <= clk_1hz;
	
	FSM_reflejo: process(clk_1hz, rst)
	begin
		if rst = '1' then
			ESTADO <= S0; -- Estado espera.
		elsif clk_1hz'event and clk_1hz = '1' then
			ESTADO <= SIG_ESTADO;
		end if;
	end process FSM_reflejo;
	
	FSM_combinacional: process(ESTADO, boton, switch)
	begin
		--Inicializar a "0" luces para que no cree un latch (borrar si no enciende las luces al pasar al estado con leds encendidos)
		luces <= "00000";
		case ESTADO is
		
		when S0 =>
			SIG_ESTADO <= S1;
			luces <= "00000";
		when S1 =>
			SIG_ESTADO <= S2;
			luces <= "10000";    -- Led estimulo.
		when S2 =>
			luces <= "00000";
			if (boton = '0') then
				SIG_ESTADO <= S6; -- Led resp. rapida.
			else
				SIG_ESTADO <= S3;
			end if;
		when S3 =>
				luces <= "00000";
			if (boton = '0') then
				SIG_ESTADO <= S7; -- Led resp. media
			else
				SIG_ESTADO <= S4;
			end if;
		when S4 =>
				luces <= "00000";
			if (boton = '0') then
				SIG_ESTADO <= S8; -- Led resp. lenta.
			else
				SIG_ESTADO <= S5;
			end if;
		when S5 =>
			SIG_ESTADO <= S9;  
			luces <= "00000";
		when S6 =>
			luces <= "00001";
			if (switch = '1') then
				SIG_ESTADO <= S0;   -- Led resp. rapida.
			else 
				SIG_ESTADO <= ESTADO;
			end if;
						
		when S7 =>
			luces <= "00010";	
			if (switch = '1') then
				SIG_ESTADO <= S0;   -- Led resp. media.
			else 
				SIG_ESTADO <= ESTADO;
			end if;
			
		when S8 =>
			luces <= "00100";	
			if (switch = '1') then
				SIG_ESTADO <= S0;   -- Led resp. lenta.
			else 
				SIG_ESTADO <= ESTADO;
			end if;
			
		when S9 =>
			luces <= "01000";	
			if (switch = '1') then
				SIG_ESTADO <= S0;   -- Led resp. error.
			else 
				SIG_ESTADO <= ESTADO;
			end if;
		when others =>
			SIG_ESTADO <= ESTADO;
		end case;
	end process FSM_combinacional;
end Behavioral;

