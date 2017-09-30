----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:19:07 11/27/2014 
-- Design Name: 
-- Module Name:    divisor - Behavioral 
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

entity divisor is
	generic(n: natural:=6;
				m: natural:=3);
   port(
   	   clk :   in std_logic;                               --Input Clock
   	   reset : in std_logic;                               --general Reset
   	   start :   in std_logic;                               --Entrada para iniciar
   	   dividendo :  in std_logic_vector(n-1 downto 0);            --Entrada dividendo
   	   divisor :  in std_logic_vector(m-1 downto 0);            --Entrada divisor
   	   quotient :   out std_logic_vector(n-1 downto 0);           --Salida cociente
   	   ready : out std_logic                               --Salida terminar
   	   );
end divisor;

architecture struct of divisor is
	signal ctrl     : std_logic_vector(9 downto 0);   -- Control signals
	signal status   : std_logic;   -- Status signal
	signal msb : std_logic;	
  component cd
    port (
      clk :   in std_logic;                                --Input Clock
      rst_n : in std_logic;                                --general reset
      dndo :  in std_logic_vector(n-1 downto 0);             --Entrada dividendo
      dsor :  in std_logic_vector(m-1 downto 0);             --Entrada divisor
      ctrl :  in std_logic_vector(9 downto 0);             --Entrada Señal de control
      coc :   out std_logic_vector(n-1 downto 0);            --Salida cociente
		msb: out std_logic;
      status :out std_logic  		--Salida señal de estado
      );
  end component;

  component uc
    port (
   	   clk :   in std_logic;                               --Input clock
   	   rst_n : in std_logic;                               --general reset
   	   ini :   in std_logic;                               --Entrada inicio
   	   status :in std_logic;            --Entrada señal de estado
   	   ready :   out std_logic;     			--Salida ready
			msb: in std_logic;
   	   ctrl :  out std_logic_vector(9 downto 0)            --Salida señal de control
   	   );
  end component;
begin
  

  dp : cd port map
    (clk    => clk,                          --Reloj general    
    rst_n   => reset,                        --Reset general        
    dndo    => dividendo,                         --Dividendo
    dsor    => divisor,                         --Divisor            
    ctrl    => ctrl,                         --Señal de control  
    coc     => quotient,                          --Cociente  
	 msb => msb,	 
    status  => status                       --Señal de estado
    );


  cu : uc port map (
    clk      => clk,                         --Reloj general              
    rst_n    => reset,                       --Reset general               
    ini      => start,                         --Inicio        
    status   => status,                      --Señal de estado   
    ready      => ready,                       --ready       
msb => msb,	 	 
    ctrl     => ctrl                         --Señal de control
    );

end struct;