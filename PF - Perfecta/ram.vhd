library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;	

entity ram is
	port (clk : in std_logic;
			enable_ram : in std_logic;
			din : in std_logic_vector (3 downto 0);
			addr : in std_logic_vector(4 downto 0) ;
			we : in std_logic ;
			dout : out std_logic_vector (3 downto 0));
end ram;

architecture circuito  of ram is
    type ram_type is array (0 to 31) of std_logic_vector (3 downto 0);
		signal RAM : ram_type:= (	X"0", X"0", X"0", X"0", X"0", X"0", X"0",X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0",
											X"0", X"0", X"0", X"0", X"0", X"0", X"0",X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"C");
--		signal RAM : ram_type:= (	X"0", X"1", X"2", X"3", X"4", X"5", X"6",X"7", X"8", X"9", X"A", X"B", X"C", X"D", X"E", X"F",
--											X"0", X"1", X"2", X"3", X"4", X"5", X"6",X"7", X"8", X"9", X"A", X"B", X"C", X"D", X"E", X"F");
	-- Condiciones iniciales: 
	-- 1) La clave "1100" situada en la posicion 31 de memoria
	-- 2) No existen las claves "1111" ni "0011" en la memoria
	-- 3) El reset es activo a ALTA
begin

    puerto: process (clk)
    begin
		if rising_edge(clk) and enable_ram = '1' then
			if we = '1' then
				RAM(conv_integer(addr)) <= din;
			else 
				dout <= RAM(conv_integer(addr));
			end if;
		else
		end if;
	end process puerto;

end circuito;
