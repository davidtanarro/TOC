library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_6bits is
	port( clk, reset: in std_logic;
			x: in std_logic_vector(5 downto 0); 
			y: in std_logic_vector(5 downto 0); 
			cin: in std_logic;
			load:	in std_logic;
			s: out std_logic_vector(5 downto 0)); 
end adder_6bits;

architecture Behavioral of adder_6bits is

	signal aux_carry: std_logic_vector(4 downto 0);
	signal s_aux: std_logic_vector(5 downto 0);

begin
	process (clk, reset, x, y, cin, load)
	begin
	
		if reset = '1' then
				s_aux <= (OTHERS => '0');
		elsif clk'event and clk = '1' and load = '1' then
		
			s_aux(0) <= x(0) xor y(0) xor cin;
			aux_carry(0) <= (x(0) and y(0)) or (cin and y(0)) or (x(0) and cin);
			
			s_aux(1) <= x(1) xor y(1) xor aux_carry(0);
			aux_carry(1) <= (x(1) and y(1)) or (aux_carry(0) and y(1)) or (x(1) and aux_carry(0));
			
			s_aux(2) <= x(2) xor y(2) xor aux_carry(1);
			aux_carry(2) <= (x(2) and y(2)) or (aux_carry(1) and y(2)) or (x(2) and aux_carry(1));
			
			s_aux(3) <= x(3) xor y(3) xor aux_carry(2);
			aux_carry(3) <= (x(3) and y(3)) or (aux_carry(2) and y(3)) or (x(3) and aux_carry(2));
			
			s_aux(4) <= x(4) xor y(4) xor aux_carry(3);
			aux_carry(4) <= (x(4) and y(4)) or (aux_carry(3) and y(4)) or (x(4) and aux_carry(3));
			
			s_aux(5) <= x(5) xor y(5) xor aux_carry(4);
			-- nunca va a haber acarreo de salida, suma maxima = 31
			
			s <= s_aux;
		end if;
	end process;
end Behavioral;



			--------------------------------------------------------------------------------------
			-- Otra forma de sumar dos numeros
			--------------------------------------------------------------------------------------

		--	s_aux(0) <= x(0) xor y(0) xor cin;
		--	aux_carry(0) <= ((x(0) xor y(0)) nand cin) nand (x(0) nand y(0));
			
		--	s_aux(1) <= x(1) xor y(1) xor aux_carry(0);
		--	aux_carry(1) <= ((x(1) xor y(1)) nand aux_carry(0)) nand (x(1) nand y(1));
			
		--	s_aux(2) <= x(2) xor y(2) xor aux_carry(1);
		--	aux_carry(2) <= ((x(2) xor y(2)) nand aux_carry(1)) nand (x(2) nand y(2));
			
		--	s_aux(3) <= x(3) xor y(3) xor aux_carry(2);
		--	aux_carry(3) <= ((x(3) xor y(3)) nand aux_carry(2)) nand (x(3) nand y(3));
			
		--	s_aux(4) <= x(4) xor y(4) xor aux_carry(3);
		--	aux_carry(4) <= ((x(4) xor y(4)) nand aux_carry(3)) nand (x(4) nand y(4));
			
		--	s_aux(5) <= x(5) xor y(5) xor aux_carry(4);
			-- nunca va a haber acarreo de salida, suma maxima = 31
