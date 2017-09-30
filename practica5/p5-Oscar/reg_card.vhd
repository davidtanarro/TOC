----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:47:15 12/16/2014 
-- Design Name: 
-- Module Name:    reg_card - Behavioral 
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

entity reg_card is
	port(
		load: in std_logic;
		rst: in std_logic;
		input: in std_logic_vector (4 downto 0);
		output: out std_logic_vector (3 downto 0));
end reg_card;

architecture Behavioral of reg_card is

begin
	p_output: process (rst, input, load)
	begin
		if rst = '1' then
			output <= (others => '0');
		else
			output <= input(3 downto 0);
		end if;
	end process p_output;
end Behavioral;

