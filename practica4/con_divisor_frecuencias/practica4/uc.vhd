library ieee;
use ieee.std_logic_1164.all;

entity uc is
   port(
   	   clk : in std_logic;
   	   rst_n : in std_logic;
   	   ini : in std_logic;
   	   status : in std_logic;
   	   ready : out std_logic;
			msb: in std_logic;
   	   ctrl : out std_logic_vector(9 downto 0)
   	   );
end uc;

architecture rtl of uc is
  type t_estados is (s0, s1, s2, s3, s4, s5, s6,s7);
  signal control: std_logic_vector(9 downto 0);
  signal estado_act, estado_sig : t_estados;
  alias mux : std_logic is control (9);
  alias add :  std_logic is control (8);
  alias cntr_ld :  std_logic is control (7);
  alias cntr_cu :  std_logic is control (6);
  alias dsor_ld :  std_logic is control (5);
  alias dsor_sh :  std_logic is control (4);
  alias dndo_ld :  std_logic is control (3);
  alias coc_ld :  std_logic is control (2);
  alias coc_sh :  std_logic is control (1);
  alias coc_sh_e :  std_logic is control (0);
begin

	ctrl <= control;
  p_actualizarestado : process(ini, estado_act,status,msb)
  begin
	mux <= '0';
	add <= '0';
	cntr_ld <= '0';
	cntr_cu <= '0';
	dsor_ld <= '0';
	dsor_sh <= '0';
	dndo_ld <= '0';
	coc_ld <= '0';
	coc_sh <= '0';
	coc_sh_e <= '0';
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
        ready <= '1';
        if ini = '0' then
          estado_sig <= s0;
        else
          estado_sig <= s1;
        end if;
        
      when s1 =>
			cntr_ld <= '1';
			dsor_ld <= '1';
			dndo_ld <= '1';
			coc_ld <= '1';
			mux <= '0';
			add <= '0';
			cntr_cu <= '0';
			dsor_sh <= '0';
			coc_sh <= '0';
			coc_sh_e <= '0';
		  ready <= '0';
        estado_sig <= s2;
        
      when s2 =>
			mux <= '1';
			dsor_ld <= '0';
			dndo_ld <= '1';
			add <= '0';
			cntr_ld <= '0';
			cntr_cu <= '0';
			dsor_sh <= '0';
			coc_ld <= '0';
			coc_sh <= '0';
			coc_sh_e <= '0';
        ready <= '0';
        estado_sig <= s3;
        
      when s3 =>
			mux <= '0';
			add <= '0';
			cntr_ld <= '0';
			cntr_cu <= '0';
			dsor_ld <= '0';
			dsor_sh <= '0';
			dndo_ld <= '0';
			coc_ld <= '0';
			coc_sh <= '0';
			coc_sh_e <= '0';
        ready <= '0';
        if msb = '1' then
        	estado_sig <= s4;
        elsif msb = '0' then
        	estado_sig <= s5;
        end if;
        
      when s4 =>
			mux <= '1';
			add <= '1';
			dndo_ld <= '1';
			coc_ld <= '1';
			coc_sh <= '1';
			cntr_ld <= '0';
			cntr_cu <= '0';
			dsor_ld <= '0';
			dsor_sh <= '0';
			coc_sh_e <= '0';
		  ready <= '0';
        estado_sig <= s6;
        
      when s5 =>
			mux <= '0';
			add <= '0';
			dndo_ld <= '0';
			coc_ld <= '1';
			coc_sh <= '1';
			cntr_cu <= '0';
			cntr_ld <= '0';
			dsor_ld <= '0';
			dsor_sh <= '0';
			coc_sh_e <= '1';
        ready <= '0';
        estado_sig <= s6;
        
      when s6 =>
			cntr_ld <= '1';
			cntr_cu <= '1';
			dsor_ld <= '1';
			dsor_sh <= '1';
			mux <= '0';
			add <= '0';
			dndo_ld <= '0';
			coc_ld <= '0';
			coc_sh <= '0';
			coc_sh_e <= '0';
		  ready <= '0';
		  estado_sig <= s7;
		  
		  when s7 =>
		  mux <= '0';
			add <= '0';
			cntr_ld <= '0';
			cntr_cu <= '0';
			dsor_ld <= '0';
			dsor_sh <= '0';
			dndo_ld <= '0';
			coc_ld <= '0';
			coc_sh <= '0';
			coc_sh_e <= '0';
        ready <= '0';
        if status ='0' then
          estado_sig <= s0;
        elsif status = '1' then
          estado_sig <= s2;
        end if;

      when others =>
		   mux <= '0';
			add <= '0';
			cntr_ld <= '0';
			cntr_cu <= '0';
			dsor_ld <= '0';
			dsor_sh <= '0';
			dndo_ld <= '0';
			coc_ld <= '0';
			coc_sh <= '0';
			coc_sh_e <= '0';
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