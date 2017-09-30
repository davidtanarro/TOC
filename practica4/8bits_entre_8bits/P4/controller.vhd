library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity data_path is
   port(
      clk : in std_logic;
      rst_n : in std_logic;
      dndo : in std_logic_vector(7 downto 0);
      dsor : in std_logic_vector(7 downto 0);
      ctrl : in std_logic_vector(10 downto 0);
      coc : out std_logic_vector(7 downto 0);
      res : out std_logic_vector(8 downto 0);
      status : out std_logic_vector(1 downto 0)
      );
end data_path;



architecture rtl of data_path is
   signal dsor_r : std_logic_vector(8 downto 0);
   signal cntr : std_logic_vector(2 downto 0);
   signal cntr_d1 : std_logic_vector(2 downto 0);
   signal coc_r: std_logic_vector(7 downto 0);
   signal dndo_r: std_logic_vector(8 downto 0);
   
   signal desp : std_logic_vector(2 downto 0);
   signal alineado: std_logic_vector(7 downto 0);
   
begin


  p_alinear : process(dsor)
  begin
    if dsor(7)='1' then
       desp <="000";
       alineado(7 downto 0) <= dsor(7 downto 0);
    elsif dsor(6)='1' then
       desp <="001";
       alineado(7 downto 1) <= dsor(6 downto 0);
		 alineado(0) <= '0';
    elsif dsor(5)='1' then
       desp <="010";
       alineado(7 downto 2) <= dsor(5 downto 0);
		 alineado(1 downto 0) <= "00";
    elsif dsor(4)='1' then
       desp <="011";
       alineado(7 downto 3) <= dsor(4 downto 0);
		 alineado(2 downto 0) <= "000";
    elsif dsor(3)='1' then
       desp <="100";
       alineado(7 downto 4) <= dsor(3 downto 0);
		 alineado(3 downto 0) <= "0000";
    elsif dsor(2)='1' then
       desp <="101";
       alineado(7 downto 5) <= dsor(2 downto 0);
		 alineado(4 downto 0) <= "00000";
    elsif dsor(1)='1' then
       desp <="110";
       alineado(7 downto 6) <= dsor(1 downto 0);
		 alineado(5 downto 0) <= "000000";
    else
       desp <="111";
       alineado(7 downto 7) <= dsor(0 downto 0);
		 alineado(6 downto 0) <= "0000000";
    end if;
  end process p_alinear;


  p_dsor_r: process(clk,rst_n)
  begin
    if rst_n = '0' then
      dsor_r <= (others => '0');
    elsif rising_edge(clk) and ctrl(5)='1' then
      if ctrl(4)='1' then
         dsor_r(6 downto 0) <= dsor_r(7 downto 1);
         dsor_r(7) <= '0';
      else
         dsor_r <= '0'&alineado(7 downto 0);
      end if;
    end if;
  end process;

  p_cntr: process(clk,rst_n)
  begin
    if rst_n = '0' then
      cntr <= (others => '0');
    elsif rising_edge(clk) and ctrl(7)='1' then
      if ctrl(6)='1' then
        cntr <= cntr-"001";
      else 
        cntr <= desp;
      end if;
    end if;
  end process;

  p_cntr_d1: process(clk,rst_n)
  begin
    if rst_n = '0' then
      cntr_d1 <= (others => '0');
    elsif rising_edge(clk) and ctrl(8)='1' then
      cntr_d1 <= cntr;
    end if;      
  end process;


  p_coc_r: process(clk,rst_n)
  begin
    if rst_n = '0' then
      coc_r <= (others => '0');
    elsif rising_edge(clk) and ctrl(2)='1' then

      if ctrl(1)='1' then

        if ctrl(0)='1' then
           coc_r(7 downto 1) <= coc_r(6 downto 0);
           coc_r(0) <= '1';
        else            
           coc_r(7 downto 1) <= coc_r(6 downto 0);
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
    elsif rising_edge(clk) and ctrl(3)='1' then
      if ctrl(10)='1' then
        if ctrl(9)='1' then
           dndo_r <= dndo_r + dsor_r;
        else 
           dndo_r <= dndo_r - dsor_r;
        end if;
      else
      	dndo_r <= '0'&dndo(7 downto 0);
      end if;
    end if;     

  end process;

  p_salidas: process ( dndo_r, coc_r, cntr_d1 )
  begin
    status(1) <= dndo_r(8);
    if cntr_d1 = "000" then
       status(0) <= '0';
    else
    	status(0) <= '1';
    end if;

    coc <= coc_r;
    res <= dndo_r;
    
    end process;

end rtl;