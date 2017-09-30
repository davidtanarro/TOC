
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_divider is

end tb_divider;

architecture beh of tb_divider is
  component divisor
    port (clk  : in std_logic;
			reset : in std_logic;
			start   : in std_logic;
			ready 	: out std_logic;
			dividendo  : in std_logic_vector(5 downto 0);
			divisor  : in std_logic_vector(2 downto 0);
			--estado : out std_logic_vector(2 downto 0);
			--status1 : out std_logic;
			quotient   : out std_logic_vector(5 downto 0)
		--	res   : out std_logic_vector(8 downto 0)
          );
  end component;

  constant c_m                     : natural := 3;
  constant c_n                     : natural := 6;
  signal clk, rst_n, inicio, ready : std_logic;
  signal dsor                   : std_logic_vector(2 downto 0);
  signal dndo       : std_logic_vector(5 downto 0);
  signal cociente : std_logic_vector(5 downto 0);
  --signal estado :  std_logic_vector(2 downto 0);
  --signal status1 :  std_logic;
  --signal resto : std_logic_vector(8 downto 0);
begin


  -------------------------------------------------------------------------------
  -- Component instantiation
  -------------------------------------------------------------------------------

  i_dut : divisor
    port map (
      clk       => clk,
      reset     => rst_n,
      start       => inicio,
      divisor      => dsor,
      dividendo      => dndo,
      quotient       => cociente,
		--estado => estado,
		--status1 => status1,
      --res       => resto,
      ready     => ready
      );

  -----------------------------------------------------------------------------
  -- Process declaration
  -----------------------------------------------------------------------------
  -- Input clock
  p_clk : process
  begin
    clk <= '0', '1' after 5 ns;
    wait for 10 ns;
  end process p_clk;

  -- External reset
  p_rst : process
  begin
    rst_n <= '0';
    wait for 250 ns;
    rst_n <= '1';
    wait;
  end process p_rst;

  p_driver : process
    variable v_i, v_j    : natural := 0;
    variable v_calculo   : std_logic_vector(5 downto 0);
    variable v_correctas : natural := 0;

  begin
    inicio <= '1';
    wait for 250 ns;
    dndo_loop : for v_i in 1 to 255 loop
      dndo <= "010001";
      dsor_loop : for v_j in 1 to v_i loop
        dsor <= "010";
        wait until rising_edge(clk);
        inicio    <= '1';
        wait until rising_edge(clk);
        inicio    <= '0';
        wait until ready = '1';
        wait until rising_edge(clk);
        v_calculo := std_logic_vector(unsigned(dndo)/unsigned(dsor));
        assert v_calculo = cociente
          report "Error en la division"
          severity error;
     --   if v_calculo = cociente then
     --     v_correctas := v_correctas +1;
     --   end if;
        wait until rising_edge(clk);
      end loop dsor_loop;
    end loop dndo_loop;
    -- assert false report "Divisiones v_correctas: "& integer'image(v_correctas)
    --   severity note;
    wait;
  end process p_driver;

end beh;
