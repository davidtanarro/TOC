library ieee;
use ieee.std_logic_1164.all;


entity divisor is
   port(
   	   clk :   in std_logic;                               --Input Clock
   	   rst_n : in std_logic;                               --general Reset
   	   start :   in std_logic;                               --Entrada para startciar
   	   dndo :  in std_logic_vector(7 downto 0);            --Entrada dividendo
   	   dsor :  in std_logic_vector(7 downto 0);            --Entrada divisor
   	   coc :   out std_logic_vector(7 downto 0);           --Salida cociente
   	   res :   out std_logic_vector(8 downto 0);           --Salida resto
   	   fin : out std_logic                               --Salida terminar
   	   );
end divisor;

architecture strdata_patht of divisor is
  signal ctrl     : std_logic_vector(10 downto 0);   -- Control signals
  signal status   : std_logic_vector(1 downto 0);   -- Status signal


  component data_path
    port (
      clk :   in std_logic;                                --Input Clock
      rst_n : in std_logic;                                --general reset
      dndo :  in std_logic_vector(7 downto 0);             --Entrada dividendo
      dsor :  in std_logic_vector(7 downto 0);             --Entrada divisor
      ctrl :  in std_logic_vector(10 downto 0);             --Entrada Se�al de control
      coc :   out std_logic_vector(7 downto 0);            --Salida cociente
      res :   out std_logic_vector(8 downto 0);            --Salida resto
      status :out std_logic_vector(1 downto 0)             --Salida se�al de estado
      );
  end component;

  component controller
    port (
   	   clk :   in std_logic;                               --Input clock
   	   rst_n : in std_logic;                               --general reset
   	   start :   in std_logic;                               --Entrada inicio
   	   status :in std_logic_vector(1 downto 0);            --Entrada se�al de estado
   	   ready :   out std_logic;                              --Salida ready
   	   ctrl :  out std_logic_vector(10 downto 0)            --Salida se�al de control
   	   );
  end component;
  
begin

  dp : data_path port map
    (clk    => clk,                          --Reloj general    
    rst_n   => rst_n,                        --Reset general        
    dndo    => dndo,                         --Dividendo
    dsor    => dsor,                         --Divisor            
    ctrl    => ctrl,                         --Se�al de control  
    coc     => coc,                          --Cociente        
    res     => res,                          --Resto           
    status  => status                        --Se�al de estado
    );


  cu : controller port map (
    clk      => clk,                         --Reloj general              
    rst_n    => rst_n,                       --Reset general               
    start      => start,                         --inicio        
    status   => status,                      --Se�al de estado           
    ready      => fin,                       --ready                
    ctrl     => ctrl                         --Se�al de control
    );

end strdata_patht;