library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_4bits_v3 is
	generic(n:natural:=4);
	port (cin: in std_logic;
			op1: in std_logic_vector(n-1 downto 0);
			op2: in std_logic_vector(n-1 downto 0);
			add: out std_logic_vector(n-1 downto 0);
			g, p: out std_logic;
			cout: out std_logic);
end adder_4bits_v3;

architecture Behavioral of adder_4bits_v3 is

component adder_1bit_v3
	port(x: in std_logic; 
			  y: in std_logic; 
			  cin: in std_logic;
			  g,p:out std_logic;
			  cout:out std_logic;
			  s: out std_logic);
	end component;
	
	signal result: std_logic_vector(n-1 downto 0);
	signal carry: std_logic_vector(n downto 0);
	signal g_i, p_i: std_logic_vector(n-1 downto 0);

begin
	carry(0) <= cin;
	gen1: for i in 0 to n-1 generate
		add: adder_1bit_v3 port map(op1(i), op2(i), carry(i), g_i(i), p_i(i), carry(i+1), result(i));
	end generate gen1;
	
	g <= g_i(3) or (g_i(2) and p_i(3)) or (g_i(1) and p_i(2) and p_i(3)) or (g_i(0) and p_i(1) and p_i(2) and p_i(3));
	p <= p_i(3) and p_i(2) and p_i(1) and p_i(0);
	
	cout <= carry(n);	
	add <= result;


end Behavioral;

