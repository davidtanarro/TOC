library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity UAA is

port (cin: in std_logic;
		g: in std_logic_vector(3 downto 0);
		p: in std_logic_vector(3 downto 0);
		c: out std_logic_vector(3 downto 0));
end UAA;

architecture Behavioral of UAA is

begin

	c(0) <= g(0) OR (p(0) AND cin);
	c(1) <= g(1) OR (p(1) AND g(0)) OR (p(1) AND p(0) AND cin);
	c(2) <= g(2) OR (p(2) AND g(1)) OR (p(2) AND p(1) AND g(0)) OR (p(2) AND p(1) AND p(0) AND cin); 
	c(3) <= g(3) OR (p(3) AND g(2)) OR (p(3) AND p(2) AND g(1)) OR (p(3) AND p(2) AND p(1) AND g(0)) OR (p(3) AND p(2) AND p(1) AND p(0) and cin); 

end Behavioral;

