library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_path_B is

generic (n : natural := 8;
			m : natural := 4);

	port(clk, reset : in std_logic;
		  dividendo : in std_logic_vector(n - 1 downto 0);
		  divisor : in std_logic_vector(m - 1 downto 0);
		  control:	in std_logic_vector(7 downto 0);	
		  quotient: out std_logic_vector(n - 1 downto 0);
		  bitCociente : out std_logic;
		  menor_o_igual:	out std_logic);	

end data_path_B;

architecture Behavioral of data_path_B is

COMPONENT registro_cociente_B is
GENERIC(n : natural;
		  m : natural);
	port	(clk,	reset, load, despl_izqda, entradaSerie: in std_logic;	
			 salida : out std_logic_vector(n - 1 downto 0));
END COMPONENT registro_cociente_B;


COMPONENT registro_dividendo_B is
GENERIC(n : natural;
		  m : natural);
	port	(clk,	reset, load:	in std_logic;	
			 dividendo : in std_logic_vector(n - 1 downto 0);
			 salida : out std_logic_vector(n downto 0));
END COMPONENT registro_dividendo_B;


COMPONENT registro_divisor_B is
GENERIC(n : natural;
		  m : natural);
	port	(clk,	reset, load, despl_derecha,entradaSerie: in std_logic;	
			 divisor : in std_logic_vector(m - 1 downto 0);
			 salida : out std_logic_vector(n	downto 0));
END COMPONENT registro_divisor_B;


COMPONENT registro_k_B is
GENERIC(n : natural;
		  m : natural);
	port	(clk,	reset, cuenta:	in std_logic;	
			 A : in std_logic_vector(n downto 0);
			 salida : out std_logic_vector(n downto 0));
END COMPONENT registro_k_B;


signal control_aux: std_logic_vector(7	downto 0);	

	alias	load_dividendo : std_logic is control_aux(0);	
	alias	load_divisor :	std_logic is control_aux(1);	
	alias	desplazamiento_derecha_divisor : std_logic is control_aux(2);	
	alias	load_cociente : std_logic is control_aux(3);	
	alias	desplazamiento_izquierda_cociente : std_logic is control_aux(4);
	alias cuenta_k : std_logic is control_aux(5);
	alias mux_dividendo : std_logic is control_aux(6);
	alias opera : std_logic is control_aux(7);	


--DIVIDENDO
SIGNAL salidaRegistroDividendo, salidaMuxDividendo, salidaDividendo : std_logic_vector(n downto 0);
SIGNAL dividendoAux : std_logic_vector(n - 1 downto 0);

--DIVISOR
SIGNAL divisorAux : std_logic_vector(m - 1 downto 0);
SIGNAL salidaRegistroDivisor : std_logic_vector(n downto 0);
SIGNAL salidaDivisor : std_logic_vector(n downto 0);
SIGNAL entradaSerieDivisor : std_logic;

--COCIENTE
SIGNAL salidaCociente : std_logic_vector(n - 1 downto 0);
SIGNAL entradaSerieCociente : std_logic;


--K
SIGNAL  A_Aux, salidaK : std_logic_vector (n downto 0);



SIGNAL salidaALU : std_logic_vector(n downto 0);
SIGNAL entradaRegistroKACeros: std_logic_vector(n downto 0);
SIGNAL entradaRegistroKADontCare: std_logic_vector(n downto 0);

SIGNAL n_i, m_i : std_logic_vector(n - 1 downto 0);
SIGNAL n_m :  std_logic_vector(n - 1 downto 0);


begin
	RDividendo : registro_dividendo_B GENERIC MAP(n, m) PORT MAP(clk,	
																					reset, 
																					load_dividendo,
																					salidaMuxDividendo(n - 1 downto 0),
																					salidaDividendo);
									
	Rdivisor : registro_divisor_B GENERIC MAP(n, m)PORT MAP(clk,		
																				reset, 
																				load_divisor, 
																				desplazamiento_derecha_divisor,	
																				entradaSerieDivisor,
																				divisorAux, 
																				salidaDivisor);
													 
	Rc : registro_cociente_B GENERIC MAP(n, m) PORT MAP(clk,	
																		reset, 
																		load_cociente, 
																		desplazamiento_izquierda_cociente,
																		entradaSerieCociente,
																		salidaCociente);
											  
	Rk : registro_k_B GENERIC MAP(n, m) PORT MAP(clk,	
																reset, 
																cuenta_k,
																A_Aux,
																salidaK);
	
	control_aux <= control;
	dividendoAux <= dividendo;
	divisorAux <= divisor ;
	quotient <= salidaCociente;
	
	salidaRegistroDividendo <= salidaDividendo;
	salidaRegistroDivisor <= salidaDivisor;
	
	
	
	
	with opera select salidaALU <= (salidaRegistroDividendo - salidaRegistroDivisor) when '0',
											 (salidaRegistroDividendo + salidaRegistroDivisor) when others;
											 											 
	with mux_dividendo select salidaMuxDividendo <= '0' & dividendoAux when '0', salidaALU when others;
	
	-- CAMBIAR ESTO PARA QUE LA TEMPORIZACION DEL NUEVO ESTADO S2 SEA CORRECTA
	entradaSerieCociente <= '0' when opera='1' else '1';	
--	entradaSerieCociente <=  not salidaRegistroDividendo(n);

	-- CAMBIAR ESTO PARA QUE LA TEMPORIZACION DEL NUEVO ESTADO S2 SEA CORRECTA
-- bitCociente <= entradaSerieCociente;
	bitCociente <= not salidaALU(n);

	with desplazamiento_derecha_divisor select  entradaSerieDivisor <= '0' when '1',
																							 '1' when others;
																							 
	
	entradaRegistroKACeros <= (others => '0');	
	entradaRegistroKADontCare <= (others => '-');
	with cuenta_k select A_Aux <= entradaRegistroKACeros when '1',
											entradaRegistroKADontCare when others;					
	
	n_i <= conv_std_logic_vector(dividendo'length,n);
	m_i <= conv_std_logic_vector(divisor'length,n);
	
	-- CAMBIAR ESTO PARA QUE LA TEMPORIZACION DEL NUEVO ESTADO S6 SEA CORRECTA
	n_m <= n_i - m_i - 1;
--	n_m <= n_i - m_i;
	
	menor_o_igual	<=	 '1'	when salidaK = (n_m + 1)	else	'0';
 
end Behavioral;


