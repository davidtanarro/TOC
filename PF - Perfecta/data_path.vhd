library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;	

entity data_path is
	port( clk: in std_logic;
			rst_n : in std_logic;
			enable_ram : in std_logic;
			clave : in std_logic_vector (3 downto 0);
			nueva_clave : in std_logic_vector(3 downto 0);
			control: in std_logic_vector (8 downto 0);
			esmenor: out std_logic;
			soniguales: out std_logic;
			dir : out std_logic_vector (4 downto 0));
end data_path;

architecture Behavioral of data_path is

	component ram is
		port( clk : in std_logic ;
				enable_ram : in std_logic;
				din : in std_logic_vector (3 downto 0);
				addr : in std_logic_vector(4 downto 0) ;
				we : in std_logic ;
				dout: out std_logic_vector (3 downto 0));
	end component ram;
	
	component registro_clave is
		port( clk : in std_logic ;
				load: in std_logic;
				rst_n: in std_logic;
				input: in std_logic_vector (3 downto 0);
				output: out std_logic_vector (3 downto 0));
	end component registro_clave;
	
	component registro_dir is
		port( clk : in std_logic ;
				load: in std_logic;
				rst_n: in std_logic;
				input: in std_logic_vector (4 downto 0);
				output: out std_logic_vector (4 downto 0));
	end component registro_dir;

	signal aux_clave : std_logic_vector (3 downto 0);
	signal aux_nueva_clave : std_logic_vector(3 downto 0);
	signal aux_dir : std_logic_vector (4 downto 0);
	signal i : std_logic_vector(4 downto 0);
	signal dout : std_logic_vector (3 downto 0);
	

	alias ud_i: std_logic is control(0);
	alias ld_i: std_logic is control(1);
	alias cmp_igual_ld: std_logic is control(2);
	alias cmp_menor_ld: std_logic is control(3);
	alias rst_cntr: std_logic is control(4);
	alias ld_clave_reg: std_logic is control(5);
	alias ld_nueva_clave_reg: std_logic is control(6);
	alias ld_dir_reg: std_logic is control(7);
	alias we: std_logic is control(8);
	
begin

	mem_ram: ram port map (
		clk => clk,
		enable_ram => enable_ram,
		din => aux_nueva_clave,
		addr => i,
		we => we,
		dout => dout
	);
	
	clave_reg: registro_clave port map(
		clk => clk,
		load => ld_clave_reg,
		rst_n => rst_n,
		input => clave,
		output => aux_clave
	);
	
	nueva_clave_reg: registro_clave port map(
		clk => clk,
		load => ld_nueva_clave_reg,
		rst_n => rst_n,
		input => nueva_clave,
		output => aux_nueva_clave
	);
	
	dir_reg: registro_dir port map(
		clk => clk,
		load => ld_dir_reg,
		rst_n => rst_n,
		input => aux_dir,
		output => dir
	);

	
	cntr: process(clk)
	begin
		if rising_edge (clk) then
			if rst_n = '1' or rst_cntr = '1' then
				i <= (others=>'0');
			else
				if ld_i = '1' then
					if ud_i = '1' then
						i <= i+"00001";
					else
						i <= i-"00001";
					end if;
				else
				end if;
			end if;
		end if;
	end process cntr;
	
	
	cmp_igual:  process(clk, rst_cntr)
	begin
		if rst_cntr = '1' then
			soniguales <= '0';
		elsif rising_edge (clk) and cmp_igual_ld = '1' then
			if aux_clave = dout then -- mem(i) = clave
				soniguales <= '1';
				aux_dir <= i;
			else
				soniguales <= '0';	
			end if;
		end if;
	end process cmp_igual;
	
	
	cmp_menor:  process(clk, rst_cntr)
	begin
		if rst_cntr = '1' then
				esmenor <= '1';
		elsif rising_edge (clk) and cmp_menor_ld = '1' then
			if i = "11111" then -- (i = 31)
				esmenor <= '0';
			else
				esmenor <= '1'; -- (i < 31)
			end if;
		end if;
	end process cmp_menor;

end Behavioral;

