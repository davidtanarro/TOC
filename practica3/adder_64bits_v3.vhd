library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_64bits_v3 is
	generic(n:natural:=64);
	port(cin: in std_logic; 
		  op1: in std_logic_vector(n-1 downto 0); 
		  op2: in std_logic_vector(n-1 downto 0); 
		  add: out std_logic_vector(n-1 downto 0); 
		  cout: out std_logic);
end adder_64bits_v3;

architecture Behavioral of adder_64bits_v3 is

	component adder_16_bits_v3 
	port (cin: in std_logic;
			op1: in std_logic_vector(15 downto 0);
			op2: in std_logic_vector(15 downto 0);
			add: out std_logic_vector(15 downto 0);
			cout: out std_logic);
end component;

	signal carry: std_logic_vector(4 downto 0);
	signal result: std_logic_vector(n-1 downto 0);

begin
	carry(0) <= cin;
	gen1: for i in 0 to 3 generate
		add: adder_16_bits_v3 port map(carry(i), op1(i*16 + 15 downto i*16), op2(i*16 + 15 downto i*16), result(i*16 + 15 downto i*16), carry(i+1));
	end generate gen1;
	
	cout <= carry(4);
	add <= result;

end Behavioral;

