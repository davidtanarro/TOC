library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_1bit_v3 is
		port(x: in std_logic; 
			  y: in std_logic; 
			  cin: in std_logic;
			  g,p:out std_logic;
			  cout:out std_logic;
			  s: out std_logic);
end adder_1bit_v3;

architecture Behavioral of adder_1bit_v3 is

begin
	g <= x and y; 
	p <= x xor y; 
	cout <= (x and y) or (x and cin) or (y and cin);
	s <= (x xor y) xor cin; 

end Behavioral;