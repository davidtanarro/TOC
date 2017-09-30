library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ram_memory is
	PORT(clk: in std_logic;
			we: in std_logic;
			addr: in std_logic_vector(5 downto 0);
			din: in std_logic_vector(3 downto 0);
			dout: out std_logic_vector(3 downto 0));
end ram_memory;

architecture Behavioral of ram_memory is

	type ram_type is array (0 to 63) of std_logic_vector (3 downto 0);
	signal RAM: ram_type:= (X"1", X"2", X"3", X"4", X"5", X"6", X"7", X"8", X"9", X"A", X"A", X"A", X"A",
									X"1", X"2", X"3", X"4", X"5", X"6", X"7", X"8", X"9", X"A", X"A", X"A", X"A",
									X"1", X"2", X"3", X"4", X"5", X"6", X"7", X"8", X"9", X"A", X"A", X"A", X"A",
									X"1", X"2", X"3", X"4", X"5", X"6", X"7", X"8", X"9", X"A", X"A", X"A", X"A",
									X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0", X"0");

begin
	memory_update: process (clk) -- ,we, addr, din
	begin
		if rising_edge(clk) then
			if we = '1' then 			-- write enable. we='1': indica escritura; we='0': indica lectura
				RAM(conv_integer(addr)) <= din;
			else
				dout <= RAM(conv_integer(addr));
			end if;
		end if;
	end process memory_update;

end Behavioral;

