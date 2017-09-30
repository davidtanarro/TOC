library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;	

entity asm is
	port (clk : in std_logic;
			rst_n : in std_logic;
			ini : in std_logic;
			escribir : in std_logic;
			clave : in std_logic_vector (3 downto 0);
			nueva_clave : in std_logic_vector(3 downto 0);
			fin : out std_logic;
			dir : out std_logic_vector (4 downto 0);
			error_o : out std_logic);
end asm;

architecture Behavioral of asm is

	component data_path is
		port(	clk: in std_logic;
				rst_n : in std_logic;
				enable_ram : in std_logic;
				clave : in std_logic_vector (3 downto 0);
				nueva_clave : in std_logic_vector(3 downto 0);
				control: in std_logic_vector (8 downto 0);
				esmenor: out std_logic;
				soniguales: out std_logic;
				dir : out std_logic_vector (4 downto 0));
	end component data_path;
	
	component controller is 
		port(	clk : in std_logic;
				rst_n : in std_logic;
				ini : in std_logic;
				esmenor: in std_logic;
				soniguales: in std_logic;
				escribir : in std_logic;
				enable_ram : out std_logic;
				control : out std_logic_vector(8 downto 0);
				fin : out std_logic;
				error_o : out std_logic);
	end component controller;

	signal control : std_logic_vector (8 downto 0);
	signal esmenor : std_logic;
	signal soniguales : std_logic;
	signal enable_ram : std_logic;

begin

	dp: data_path port map(
		clk 	=> clk,
		rst_n => rst_n,
		enable_ram => enable_ram,
		clave => clave,
		nueva_clave => nueva_clave,
		control	=> control,
		esmenor => esmenor,
		soniguales => soniguales,
		dir => dir);
		
	cu : controller port map(
		clk 	=> clk,
		rst_n => rst_n,
		ini	=> ini,
		esmenor => esmenor,
		soniguales => soniguales,
		escribir => escribir,
		enable_ram => enable_ram,
		control 	=> control,
		fin => fin,
		error_o => error_o);

end Behavioral;

