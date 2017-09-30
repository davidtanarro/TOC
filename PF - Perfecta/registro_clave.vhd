library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;	

entity registro_clave is
	port( clk : in std_logic ;
			load: in std_logic;
			rst_n: in std_logic;
			input: in std_logic_vector (3 downto 0);
			output: out std_logic_vector (3 downto 0));
end registro_clave;

architecture Behavioral of registro_clave is

	signal salidaAux : std_logic_vector(3 downto 0);

begin
	
	process (clk, rst_n, load, input, salidaAux)
	begin
		if rst_n = '1' then
			salidaAux <= (others => '0');
		elsif rising_edge (clk) then
			if load = '1' then
				salidaAux <= input;
			end if;
		end if;
		output <= salidaAux;
	end process;

end Behavioral;

