library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_16_bits_v3 is
	generic(n:natural:=16);
	port (cin: in std_logic;
			op1: in std_logic_vector(n-1 downto 0);
			op2: in std_logic_vector(n-1 downto 0);
			add: out std_logic_vector(n-1 downto 0);
			cout: out std_logic);
end adder_16_bits_v3;

architecture Behavioral of adder_16_bits_v3 is

component adder_4bits_v3
	port (cin: in std_logic;
			op1: in std_logic_vector(3 downto 0);
			op2: in std_logic_vector(3 downto 0);
			add: out std_logic_vector(3 downto 0);
			g, p: out std_logic;
			cout: out std_logic);
		end component;
		
	component UAA
	port (cin: in std_logic;
			g: in std_logic_vector(3 downto 0);
			p: in std_logic_vector(3 downto 0);
			c: out std_logic_vector(3 downto 0));
	end component;

	signal carry: std_logic_vector(4 downto 0);
	signal p,g: std_logic_vector(3 downto 0);
	signal result: std_logic_vector(n-1 downto 0);


begin

	carry(0) <= cin;
	gen1: for i in 0 to 3 generate
		add: adder_4bits_v3 port map(carry(i), op1(i*4 + 3 downto i*4), op2(i*4 + 3 downto i*4), result(i*4 + 3 downto i*4), g(i), p(i), open);
	end generate gen1;
	
	UAA_mod: UAA port map(cin, g, p, carry(4 downto 1));
	
	cout <= carry(4);
	add <= result;

end Behavioral;

