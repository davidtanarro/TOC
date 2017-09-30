----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:42:33 12/15/2014 
-- Design Name: 
-- Module Name:    uc_black_jack - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uc_black_jack is


  port (
    clk    : in  std_logic;                      
    rst  : in  std_logic;                      
	 ini : in std_logic;
	 jugar : in std_logic;
	 ctrl   : out std_logic_vector(4 downto 0);   -- Control vector
    mayor : in  std_logic; 
	 plantarse : in std_logic;
	 pierdo : out std_logic;
	 fin : out std_logic
	 );

end uc_black_jack;

architecture rtl of uc_black_jack is
  type t_st is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
  signal current_state, next_state : t_st;
  
  
begin

  -----------------------------------------------------------------------------
  -- Proceso estado siguiente.
  -----------------------------------------------------------------------------
  p_next_state : process (current_state, ini, mayor, jugar,plantarse) is

  begin  -- process p_next_state
    case current_state is
      when s0 =>
        if ini = '0' then
          next_state <= s0;
        else
          next_state <= s1;
        end if;
      when s1 => 
			next_state <= s2;
      when s2 =>
			if mayor = '0' then
				next_state <= s6;
			elsif plantarse = '0' then --falling_edge(plantarse) then -- logica inversa
				next_state <= s7;
			elsif	jugar = '0' then -- falling_edge(jugar) then --para que no se pase estados al pulsarlo,solo lo coja cuando lo pulsa
				next_state <= s8;
			else
				next_state <= s2;
			end if;
      when s3 =>
          next_state <= s4;
      when s4 =>
			 next_state <= s5;
      when s5 =>
			 next_state <= s2;
      when s6 =>
			 next_state <= s0;
      when s7 =>
			 next_state <= s0;
		when s8 =>
			 next_state <= s3;
      when others => null;
    end case;
  end process p_next_state;

  p_outputs : process (current_state)

    constant c_r_auxiliar_ld  : std_logic_vector(4 downto 0) := "00001"; --direccion de memoria
    constant c_r_carta_ld   	: std_logic_vector(4 downto 0) := "00010"; --registro puntuacion load
    constant c_r_punt_ld  		: std_logic_vector(4 downto 0) := "00100"; -- registro contador load
    constant c_r_addr_ld    	: std_logic_vector(4 downto 0) := "01000";--write enable(a 1 si escribimos en memoria),si no esta a 1 lee.
	 constant c_init				: std_logic_vector(4 downto 0) := "10000";
	 
  begin
    ctrl <= (others => '0');
    case current_state is
      when s0 =>
        ctrl <= c_init or c_r_auxiliar_ld;
		  pierdo <= '0';
		  fin <= '1';
      when s1 =>
        ctrl <= c_init;
		  pierdo <= '0';
		  fin <= '0';
      when s2 =>
        ctrl <= (others => '0');
		  pierdo <= '0';
		  fin <= '0';
      when s3 =>
        ctrl <= c_r_addr_ld;
		  pierdo <= '0';
		  fin <= '0';
      when s4 =>
		  ctrl <= c_r_carta_ld or c_r_auxiliar_ld;
		  pierdo <= '0';
		  fin <= '0';
      when s5 =>
		  ctrl <= c_r_punt_ld;
		  pierdo <= '0';
		  fin <= '0';
      when s6 =>
        ctrl <= (others => '0');
		  pierdo <= '1';
		  fin <= '0';
      when s7 =>
        ctrl <= (others => '0');
		  pierdo <= '0';		  
		  fin <= '0';
		when s8 =>
		  ctrl <= c_r_addr_ld;
		  pierdo <= '0';
		  fin <= '0';
      when others => null;
    end case;
  end process p_outputs;

  p_status_reg : process (clk, rst) is
  begin
    if rst = '0' then
      current_state <= s0;
    elsif rising_edge(clk) then
      current_state <= next_state;
    end if;
  end process p_status_reg;

end architecture rtl;

