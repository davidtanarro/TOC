library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity adder is
port (A, B: in std_logic_vector(3 downto 0); 
		C: out std_logic_vector(3 downto 0)); 
end adder;

Architecture behavioral of adder is
-- No intermediate signals are needed
begin

C <= A + B;

end behavioral;
