library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity controller is
   port(
		 clk	  : in std_logic;
		 start  : in std_logic;
		 hit    : in std_logic;
		 stand  : in std_logic;
		 status : in std_logic_vector (1 downto 0);
		 loser  : out std_logic;
		 wrong  : out std_logic;
		 ctrl   : out std_logic_vector(5 downto 0));
end controller;

architecture rtl of controller is
  type t_estados is (s0, s1, s2, s3, s4, s5, s6, s7);
  signal estado, estado_sig : t_estados;
  
  constant rst			: std_logic_vector(5 downto 0) := "100000";
  constant cntr_ld   : std_logic_vector(5 downto 0) := "010000";
  constant mem_we    : std_logic_vector(5 downto 0) := "001000";
  constant card_ld   : std_logic_vector(5 downto 0) := "000100";
  constant card_rst	: std_logic_vector(5 downto 0) := "000010";
  constant points_ld : std_logic_vector(5 downto 0) := "000001";
	 
begin
  p_actualizarestado : process(start, estado, stand, hit, status)
  begin
  
	 wrong <= '0';
	 loser <= '0';
	
    case estado is
      when s0 => --RESET
			ctrl <= (rst or card_ld or points_ld or cntr_ld or card_rst);
        if start = '1' then
          estado_sig <= s0;
        else
          estado_sig <= s1;
        end if; 
        
      when s1 => --COUNTER
			ctrl <= cntr_ld or card_rst;
			if stand='0' then
				estado_sig <= s0;
			elsif hit='1' then
				estado_sig <=s1;
			else
				estado_sig <= s2;
			end if;

      when s2 => --RELEASE HIT BUTTON
			ctrl <= (others=>'0');
			if hit = '1' then
				if status (0)='1' then --Error. La carta leida es 0.
					estado_sig <= s3;
				else
					estado_sig <= s4;
				end if;
			else
				estado_sig <= s2;
			end if;
		
      when s3 => --WRONG CARD
			ctrl <= (others=>'0');
			wrong <= '1';
			estado_sig <= s7;
        
      when s4 => --GET CARD
        ctrl <= card_ld or mem_we;
        estado_sig <= s5;
        
      when s5 => --LOSER
			ctrl <= (others=>'0');
			if status (1) = '1' then --Loser. Puntuacion mayor que 21.
				loser <= '1';
				estado_sig <= s7;
			else
				estado_sig <= s6;
			end if;
			
		when s6 => --SUM POINTS
         ctrl <= mem_we or points_ld;
			estado_sig <= s1;
        
		when others => --KEEP LED ON
			ctrl <= (others => '0');
			if start ='0' then
				estado_sig <=s0;
			else
				if status (1) = '1' then
					loser <= '1';
					estado_sig <= s7;
				else --status (0) = '1'
					wrong <= '1';
					estado_sig <= s7;
				end if;
			end if;
    end case;
  end process p_actualizarestado;

  estado_reg : process(clk)
  begin
    if rising_edge (clk) then
      estado <= estado_sig;
    end if;
  end process estado_reg;

end rtl;
