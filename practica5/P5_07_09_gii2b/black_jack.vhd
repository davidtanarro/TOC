----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:42:15 12/15/2014 
-- Design Name: 
-- Module Name:    black_jack - Behavioral 
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

entity black_jack is

  port (rst : in std_logic;
		  clk : in std_logic;
		  inicio : in std_logic;
		  jugar : in std_logic;
		  plantarse : in std_logic;
		  pierdo : out std_logic;
		  display : out std_logic_vector(6 downto 0);
		  puntuacion : out std_logic_vector(4 downto 0);
		  fin : out std_logic 
        );
end black_jack;

architecture struct of black_jack is
	
	component rd_black_jack is
		 port (
			clk    : in  std_logic;                      
			rst  : in  std_logic;  
			valor_carta : out std_logic_vector(3 downto 0);
			ctrl : in std_logic_vector(4 downto 0);
			mayor : out  std_logic;
			puntuacion : out std_logic_vector(4 downto 0)
			); 
	end component rd_black_jack;
			
	component uc_black_jack is
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
	end component uc_black_jack;
	
	component divisor is
	 port (
			rst   : in  std_logic;         -- asynch reset
			clk_100mhz : in  std_logic;         -- 100 MHz input clock
			clk_1hz    : out std_logic          -- 1 Hz output clock
			);
	end component divisor;
	
	component conv_7seg is
    port ( 
		x : in  std_logic_vector (3 downto 0);
      display : out  std_logic_vector (6 downto 0)
		);
	end component conv_7seg;
	
	signal mayor : std_logic;
	signal control : std_logic_vector(4 downto 0);
	signal disp : std_logic_vector(6 downto 0);
	signal carta : std_logic_vector (3 downto 0);
	
	signal clk_new : std_logic;
			
begin
	--display <= disp;
	
	i_divisor : divisor port map ( 
		rst    => rst,
		clk_100mhz => clk,
		clk_1hz    => clk_new
		);	
	
  i_rd_black_jack : rd_black_jack port map (
		clk  => clk_new,          --clk          
		rst  => rst,  
		valor_carta => carta,
		ctrl => control,
		mayor => mayor,
		puntuacion => puntuacion
		);

  i_uc_black_jack : uc_black_jack port map (                 
	 ini => inicio,
	 ctrl  => control,
    mayor => mayor,	 
    clk    => clk_new,	 --clk 
    pierdo   => pierdo,
    plantarse    => plantarse,
    jugar   => jugar,
    rst => rst,
	 fin => fin
	 );
	 
	 i_conv_7seg : conv_7seg port map (
		x => carta,
      display => display
		);
	
--	disp <= 	"0000110" when carta = "0001" else
--					"1011011" when carta = "0010" else
--					"1001111" when carta = "0011" else
--					"1100110" when carta = "0100" else
--					"1101101" when carta = "0101" else
--					"1111101" when carta = "0110" else
--					"0000111" when carta = "0111" else
--					"1111111" when carta = "1000" else
--					"1101111" when carta = "1001" else
--					"1110111" when carta = "1010" else
--					"0111111";
		
--	with carta select
--	disp <= "0000110" when "0001",
--	      	"1011011" when "0010",
--	      	"1001111" when "0011",
--	      	"1100110" when "0100",
--	      	"1101101" when "0101",
--	      	"1111101" when "0110",
--	      	"0000111" when "0111",
--	      	"1111111" when "1000",
--	      	"1101111" when "1001",
--	      	"1110111" when "1010",
--	      	"1111100" when "1011",
--	      	"0111001" when "1100",
--	      	"1011110" when "1101",
--	      	"1111001" when "1110",
--	      	"1110001" when "1111",
--	      	"0111111" when others;
end struct;

