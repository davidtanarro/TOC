----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:42:55 12/15/2014 
-- Design Name: 
-- Module Name:    rd_black_jack - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rd_black_jack is

	  port (
		clk    : in  std_logic;                      
		rst  : in  std_logic;  
		valor_carta : out std_logic_vector(3 downto 0);
		ctrl : in std_logic_vector(4 downto 0);
		mayor : out  std_logic;
		puntuacion : out std_logic_vector(4 downto 0)
		); 

end rd_black_jack;

architecture Behavioral of rd_black_jack is

	component bj_mem is
		port (
			 clka : in std_logic;
			 wea : in std_logic_vector(0 downto 0);
			 addra : in std_logic_vector(5 downto 0);
			 dina : in std_logic_vector(3 downto 0);
			 douta : out std_logic_vector(3 downto 0)
		  );
	end component;

	signal cont	: unsigned(5 downto 0); -- 2elevado5 porque hay 52 cartas
	signal punt	: std_logic_vector(4 downto 0); -- puntuacion anterior
	signal suma	: std_logic_vector(4 downto 0); -- puntuacion nueva
	signal addr : std_logic_vector(5 downto 0); -- direccion(addr <= cont)
   signal v_carta : std_logic_vector(3 downto 0); -- valor de la carta que sale del registro de carta
	signal carta_mem : std_logic_vector(3 downto 0); -- valor de la carta que sale de memoria
	signal r_auxiliar : std_logic_vector(51 downto 0);
	signal indice: integer;
	
	signal init : std_logic;
	signal r_addr_ld : std_logic;
	signal r_punt_ld : std_logic;
	signal r_carta_ld : std_logic;
	signal we : std_logic_vector(0 downto 0);
	signal r_auxiliar_ld : std_logic_vector(0 downto 0);
	signal dummy : std_logic_vector(3 downto 0);

begin

	i_bj_mem : bj_mem port map (
		clka => clk,
		wea => we,
		addra => addr,
		dina => dummy,
		douta => carta_mem
		);
	
	dummy <= "0000";
	
	suma <= std_logic_vector(unsigned(punt) + unsigned(v_carta));
	
	puntuacion <= punt;
	
	valor_carta <= v_carta;
	
	(init,
	 r_addr_ld,
	 r_punt_ld,
	 r_carta_ld) <= ctrl(4 downto 1);
	
	 r_auxiliar_ld(0) <= ctrl(0);

 p_cont : process (clk, rst) is
	
  constant c_cartas : std_logic_vector(5 downto 0) := "110100";
  begin
 
    if rst = '0' then
      cont <= (others => '0');
    elsif rising_edge(clk) then
		if cont = 51 then
			cont <= (others => '0'); 
		else 
			cont <= cont + 1;
		end if;
    end if;
  end process p_cont;
  
 p_addr : process (clk, init) is
  begin
 
    if init = '1' then
      addr <= (others => '0');
    elsif rising_edge(clk) then
		if r_addr_ld = '1' then
			addr <= std_logic_vector(cont);
			indice <= to_integer (cont);
		end if;
    end if;
  end process p_addr;
  
 
 p_punt : process (clk, init) is
  begin
 
    if init = '1' then
		r_auxiliar <= (others => '1');
      punt <= (others => '0');
    elsif rising_edge(clk) then
		if r_punt_ld = '1' then
			punt <= suma;
		end if;
    end if;
  end process p_punt;
  
  
  p_carta : process (clk, init) is
  begin
 
    if init = '1' then
      v_carta <= (others => '0');
    elsif rising_edge(clk) then
		if r_carta_ld = '1' then
			if r_auxiliar(indice) = '1' then
				if r_auxiliar_ld(0) = '1' then
					v_carta <= carta_mem;
					r_auxiliar(indice) <= '0';
				end if;
			end if;
		end if;
    end if;
  end process p_carta;
  
  p_mayor : process (punt)
  constant c_21 : std_logic_vector(4 downto 0) := "10101";
  begin
	if punt > c_21 then
		mayor <= '0';
	else
		mayor <= '1';
	end if;
  end process p_mayor;

end Behavioral;

