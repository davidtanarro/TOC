library ieee;
use ieee.std_logic_1164.all;

entity controller is
   port(
   	   clk : in std_logic;
   	   rst_n : in std_logic;
   	   start : in std_logic;
   	   status : in std_logic_vector(1 downto 0);
   	   ready : out std_logic;
   	   ctrl : out std_logic_vector(10 downto 0)
   	   );
end controller;

architecture rtl of controller is
  type t_estados is (s0, s1, s2, s3, s4, s5, s6);
  signal estado_act, estado_sig : t_estados;
  constant c_mux : std_logic_vector(10 downto 0) := "10000000000";
  constant c_add : std_logic_vector(10 downto 0) := "01000000000";
  constant c_cntr_d1_ld : std_logic_vector(10 downto 0) := "00100000000";
  constant c_cntr_ld : std_logic_vector(10 downto 0) := "00010000000";
  constant c_cntr_cu : std_logic_vector(10 downto 0) := "00001000000";
  constant c_dsor_ld : std_logic_vector(10 downto 0) := "00000100000";
  constant c_dsor_sh : std_logic_vector(10 downto 0) := "00000010000";
  constant c_dndo_ld : std_logic_vector(10 downto 0) := "00000001000";
  constant c_coc_ld : std_logic_vector(10 downto 0) := "00000000100";
  constant c_coc_sh : std_logic_vector(10 downto 0) := "00000000010";
  constant c_coc_sh_e : std_logic_vector(10 downto 0) := "00000000001";
begin


  p_actualizarestado : process(start, estado_act,status)
  begin
    case estado_act is
      -------------------------------------------------------------------------
      -- when estado => 
      -- dar valor a todas las señales que se
      -- modifican alguna vez en el case
      -- +
      -- valor a las salidas
      -- +
      -- condiciones para el cambio de estado
      -------------------------------------------------------------------------

      when s0 =>
        ctrl <= "00000000000";
        ready <= '1';
        if start = '0' then
          estado_sig <= s0;
        else
          estado_sig <= s1;
        end if;
        
      when s1 =>
        ctrl <= c_cntr_ld or c_dsor_ld or c_dndo_ld or c_coc_ld;
        ready <= '0';
        estado_sig <= s2;
        
      when s2 =>
        ctrl <= c_mux or c_cntr_d1_ld or c_dndo_ld;
        ready <= '0';
        estado_sig <= s3;
        
      when s3 =>
        ctrl <= c_cntr_ld or c_cntr_cu;
        ready <= '0';
        if status(1)='0' then
        	estado_sig <= s5;
        else
        	estado_sig <= s4;
        end if;
        
      when s4 =>
        ctrl <= c_mux or c_add or c_dndo_ld or c_coc_ld or c_coc_sh;
        ready <= '0';
        estado_sig <= s6;
        
      when s5 =>
        ctrl <= c_coc_ld or c_coc_sh or c_coc_sh_e;
        ready <= '0';
        estado_sig <= s6;
        
      when s6 =>
        ctrl <= c_dsor_ld or c_dsor_sh;
        ready <= '0';
        if status(0)='0' then
          estado_sig <= s0;
        else
          estado_sig <= s2;
        end if;

      when others =>
		  ctrl <= "00000000000";
		  ready <= '0';
        estado_sig <= s0;
        
    end case;
  end process p_actualizarestado;

  estado_reg : process(clk, rst_n)
  begin
    if rst_n = '0' then                 -- asynchronous reset (active low)
      estado_act <= s0;
    elsif clk'event and clk = '1' then
      estado_act <= estado_sig;
    end if;
  end process estado_reg;

end rtl;