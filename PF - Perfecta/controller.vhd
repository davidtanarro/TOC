library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;	

entity controller is
		port(
   	   clk : in std_logic;
			rst_n : in std_logic;
   	   ini : in std_logic;
			esmenor: in std_logic;
			soniguales: in std_logic;
			escribir : in std_logic;
   	   control : out std_logic_vector(8 downto 0);
			enable_ram: out std_logic;
			fin : out std_logic;
			error_o : out std_logic);
end controller;

architecture Behavioral of controller is

	type ESTADOS is (s0, s1, s2, s3, s4, s5, s6);
	signal estado, estado_sig : ESTADOS;
	
	signal aux_error_o: std_logic;
	signal aux_error_o_mantener: std_logic;

	alias ud_i: std_logic is control(0);
	alias ld_i: std_logic is control(1);
	alias cmp_igual_ld: std_logic is control(2);
	alias cmp_menor_ld: std_logic is control(3);
	alias rst_cntr: std_logic is control(4);
	alias ld_clave_reg: std_logic is control(5);
	alias ld_nueva_clave_reg: std_logic is control(6);
	alias ld_dir_reg: std_logic is control(7);
	alias we: std_logic is control(8);
	
begin
 
	SINCRONO : process(clk, rst_n)
	begin
		if rst_n = '1' then
			estado <= S0;
		elsif rising_edge (clk) then
			estado <= estado_sig;
		end if;
	end process SINCRONO;



	COMB : process(ini, rst_n, estado, ini, esmenor, soniguales, escribir)
	begin
	fin <= '0';
	enable_ram <= '0';
	aux_error_o <= '1';
	aux_error_o_mantener <= '0';
	
	-- Señales de control
	ud_i <= '1';
	ld_i <= '0';
	cmp_igual_ld <= '0';
	cmp_menor_ld <= '1';
	rst_cntr <= '0';
	ld_clave_reg <= '0';
	ld_nueva_clave_reg <= '0';
	ld_dir_reg <= '0';
	we <= '0'; -- Leemos
	
	case estado is
      when s0 =>
			fin <= '1';
			ld_clave_reg <= '1';			-- Cargo los valores
			ld_nueva_clave_reg <= '1';	-- Cargo los valores

			if ini = '0' then
				error_o <= aux_error_o;
				aux_error_o_mantener <= aux_error_o;
				estado_sig <= s0;
			else
				error_o <= aux_error_o_mantener;
				estado_sig <= s1;
			end if;
			
      when s1 =>
			rst_cntr <= '1';	-- i <= '0'
			error_o <= '1';
			aux_error_o <= '1';
			cmp_igual_ld <= '1';
			enable_ram <= '1';
			we <= '0'; -- Leemos
			estado_sig <= s2;
			
		when s2 =>
			error_o <= '1';
			aux_error_o <= '1';
			cmp_igual_ld <= '1';
			
			if esmenor = '1' then			-- (i < 32?)
				if soniguales = '1' then	-- (mem(i) = clave)
					ld_i <= '0'; -- no habilito contador
					estado_sig <= s4;
				else
					ld_i <= '1';	-- cargo la señal del contador y en sig_estado hara (i <= i+1;)
					estado_sig <= s3;
				end if;
			else
				if soniguales = '1' then	-- (mem(i) = clave)
					ld_i <= '0'; -- no habilito contador
					estado_sig <= s4;
				else
					ld_i <= '0'; -- no habilito contador
					estado_sig <= s6;
				end if;
			end if;
			
		when s3 =>
			-- i <= i+1;
			error_o <= '1';
			aux_error_o <= '1';
			enable_ram <= '1';
			we <= '0'; -- Leemos
			estado_sig <= s2;
			
		when s4 =>
			-- dir <= i;
			ld_dir_reg <= '1'; -- Cargo el valor de la direcion
			error_o <= '0';
			aux_error_o <= '0';
			if escribir = '1' then
				ld_i <= '1'; -- resto "00001" para volver a tener el valor correcto del contador "i"
				ud_i <= '0'; -- y pasarselo bien a la direccion de la ram
				estado_sig <= s5;
			else
				estado_sig <= s0;
			end if;
			
		when s5 =>
			error_o <= '0';
			aux_error_o <= '0';
			-- mem(i) <= nueva_clave
			enable_ram <= '1';
			we <= '1'; -- Escribimos
			estado_sig <= s0;
			
		when s6 => -- Iria entre medias de s3 y s4
			if soniguales = '1' then	-- (mem(i) = clave)
				ld_i <= '1'; -- sumo "00001" para volver a tener el valor correcto cuando vaya a restar
				error_o <= '0';
				aux_error_o <= '0';
				estado_sig <= s4; -- solo se mete por aqui cuando (i = 31)
			else
				error_o <= '1';
				aux_error_o <= '1';
				estado_sig <= s0;
			end if;
			
    end case;
  end process COMB;

end Behavioral;

