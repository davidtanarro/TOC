library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity cd is
generic(n: natural:=6;
				m: natural:=3);
   port(
      clk : in std_logic;
      rst_n : in std_logic;
      dndo : in std_logic_vector(n-1 downto 0);
      dsor : in std_logic_vector(m-1 downto 0);
      ctrl : in std_logic_vector(9 downto 0);
      coc : out std_logic_vector(n-1 downto 0);
      status : out std_logic;
		msb : out std_logic
      );
end cd;



architecture rtl of cd is
	
   signal dsor_r : std_logic_vector(n downto 0);
   signal cntr : std_logic_vector(2 downto 0);
	signal aux : std_logic_vector (2 downto 0);
   signal coc_r: std_logic_vector(n-1 downto 0);
   signal dndo_r: std_logic_vector(n downto 0);
	
	 signal control: std_logic_vector(9 downto 0);
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

	control <= ctrl;
	aux <= "011";

  p_dsor_r: process(clk,rst_n)
  begin
    if rst_n = '0' then
      dsor_r <= (others => '0');
    elsif rising_edge(clk) and dsor_ld='1' then
	 
      if dsor_sh ='1' then  
				dsor_r(5 downto 0) <= dsor_r(6 downto 1);
				dsor_r(6) <= '0';
      else
         dsor_r(6 downto 3) <= '0'& dsor(m-1 downto 0);
			dsor_r(2 downto 0) <= "000";
      end if;
	else
			dsor_r <= dsor_r;
    end if;
  end process;

  p_cntr: process(clk,rst_n)
  begin
    if rst_n = '0' then
      cntr <= (others => '0');
    elsif rising_edge(clk) and cntr_ld ='1' then
      if cntr_cu ='1' then
        cntr <= cntr + "001";
      end if;
    end if;
  end process; 


  p_coc_r: process(clk,rst_n)
  begin
    if rst_n = '0' then
      coc_r <= (others => '0');
    elsif rising_edge(clk) and coc_ld = '1' then

      if coc_sh ='1' then           
			if coc_sh_e ='1' then
				  coc_r(n-1 downto 1) <= coc_r(n-2 downto 0);
				  coc_r(0) <= '1';
			elsif coc_sh_e ='0' then           
				  coc_r(n-1 downto 1) <= coc_r(n-2 downto 0);
				  coc_r(0) <= '0';
        
        end if;
      else
      	coc_r <= (others => '0');

      end if;

    end if;      
  end process;

  
  

  p_dndo_r: process(clk,rst_n)
  begin
    if rst_n = '0' then
      dndo_r <= (others => '0');
    elsif rising_edge(clk) and dndo_ld ='1' then
      if mux ='1' then
        if add = '1' then
           dndo_r <= dndo_r + dsor_r;
        else 
           dndo_r <= dndo_r - dsor_r;
        end if;
      else
      	dndo_r <= '0' & dndo(n-1 downto 0)  ;
      end if;
		
    end if;     

  end process;
		
  p_salidas: process ( dndo_r, coc_r, cntr)
  begin
	
		msb <= dndo_r(6);
	 if cntr <= aux then
		status <= '1';
	 else
		status <= '0'; 
		
	 end if;

    coc <= coc_r;
    
    end process;

end rtl;