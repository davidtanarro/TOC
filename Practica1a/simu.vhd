library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
use IEEE.STD_LOGIC_TEXTIO.ALL; 
use STD.TEXTIO.ALL;

--entidad
entity simsum is 
end simsum;

--arquitectura
architecture testbench_arch of simsum is
	-- Declaracion del componente que vamos a simular
	component sumador
		port( A : in std_logic_vector(3 downto 0);
				B : in  std_logic_vector(3 downto 0);
				C : out  std_logic_vector(3 downto 0)
		);
	end component; 
	
	--Entradas
	signal A : std_logic_vector(3 downto 0) := (others => '0');
	signal B : std_logic_vector(3 downto 0) := (others => '0'); 
	--signal A, B : std_logic_vector(3 downto 0);
	 
	--Salidas
	signal C : std_logic_vector(3 downto 0);

Begin
	-- Instanciacion de la unidad a simular
	uut: sumador port map ( 
		A => A,
		B => B,
		C => C 
	);
   -- Proceso de estimulos
	stim_proc: process 
	begin
			A <= "0000";
			B <= "0000"; 
		wait for 100 ns;
			A <= "0101";
			B <= "0100"; 
		wait for 100 ns; 
			A <= "0000"; 
			B <= "0111";
		wait for 100 ns;
			A <= "0011"; 
			B <= "1000";
		wait for 100 ns; 
			A <= "1011"; 
			B <= "1111";
		wait for 100 ns; 
			A <= "1001"; 
			B <= "0110";
		wait;
	end process;
end testbench_arch;