library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;	

entity data_path is
	generic (M: natural:=6; N: natural:=4);
	port (clk: 		in std_logic;
			start: 	in std_logic;
			hit: 		in std_logic;
			stand:	in std_logic;
			ctrl:		in std_logic_vector  (5 downto 0);
			status: 	out std_logic_vector (1 downto 0);
			card: 	out std_logic_vector (3 downto 0);
			points:	out std_logic_vector (5 downto 0));
end data_path;
architecture Behavioral of data_path is

alias rst : std_logic is ctrl (5);
alias cntr_ld: std_logic is ctrl(4);
alias mem_we: std_logic is ctrl(3);
alias card_ld: std_logic is ctrl(2);
alias card_rst: std_logic is ctrl (1);
alias points_ld: std_logic is ctrl(0);

signal cntr: std_logic_vector (5 downto 0);
signal points_r: std_logic_vector(4 downto 0);
signal card_i: std_logic_vector (4 downto 0);
signal card_i2: std_logic_vector (3 downto 0);
	 
component rams is
	port(clk,we: in std_logic;
	     addr: in std_logic_vector (M-1 downto 0);
		  di: in std_logic_vector (N-1 downto 0);
		  do: out std_logic_vector (N-1 downto 0));
end component rams;
	
component reg_card is
	port (
		load: in std_logic;
		rst: in std_logic;
		input: in std_logic_vector (4 downto 0);
		output: out std_logic_vector (3 downto 0)
	);
end component reg_card;
			

begin

	mem_ram: rams port map (
		clk => clk,
		we => mem_we,
		addr => cntr,
		di => "0000",
		do => card_i (N-1 downto 0)
	); 
	
	card_r: reg_card port map(
		load => card_ld,
		rst => card_rst,
		input => card_i,
		output => card_i2
	);
	
	p_cntr: process(clk)
	begin
		if rising_edge (clk) and cntr_ld ='1' then
			if rst = '1' then
				cntr <= (others=>'0');
			else
				if cntr = "110011" then
					cntr <= "000000";
				else
					cntr <= cntr+"000001";
				end if;
			end if;
		end if;
	end process p_cntr;
	
	p_points: process(clk)
	begin
		if rising_edge(clk)then 
			if rst = '1' then
				points_r <=(others => '0');
				status (1)<= '0';
			elsif points_ld ='1' then
				points_r <= points_r + card_i2;
				if points_r > "10101" then
						status(1) <='1';
				else
					status(1) <='0';
				end if;
			end if;
		end if;
	end process p_points;

	p_wrong: process(clk)
	begin
		if rising_edge(clk) and card_ld='1' then
			if rst = '1' then
				status (0) <= '0';
			else
				--card_r <= points_r + cntr;
				if card_i2 = "00000" then
					status (0) <= '1';
				else
					status (0) <= '0';
				end if;
			end if;
		end if;
	end process p_wrong;

	points <= '0' & points_r;
	card <= card_i2;
	
end Behavioral;