LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY test_64 IS
END test_64;
 
ARCHITECTURE behavior OF test_64 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder_64bits_v3
    PORT(
         cin : in  std_logic;
         op1 : in  std_logic_vector(63 downto 0);
         op2 : in  std_logic_vector(63 downto 0);
         add : out  std_logic_vector(63 downto 0);
         cout : out  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal cin : std_logic := '0';
   signal op1 : std_logic_vector(63 downto 0) := (others => '0');
   signal op2 : std_logic_vector(63 downto 0) := (others => '0');

 	--Outputs
   signal add : std_logic_vector(63 downto 0);
   signal cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder_64bits_v3 PORT MAP (
          cin => cin,
          op1 => op1,
          op2 => op2,
          add => add,
          cout => cout
        );



   -- Stimulus process
   stim_proc: process
   begin		
      cin <= '0';
		op1 <= "1110110101010101010101011010100101010100101010010101001010101001";
		op2 <= "0000011110101011000001111010101100000111101010110000011110101011";
		
		wait for 50 ns;
		op1 <= "0000011110101011000001111010101100010111101010110000011110101011";
		op2 <= "0000000000000000000000000000000000000000000000000000000000000000";

		wait for 50 ns;
		op1 <= "1111111111000000111111111100000011111111110000001111111111000000";
		op2 <= "0000000000111111000000000011111100000000001111110000000000111111";
		
		wait for 50 ns;
		op1 <= "1111111111111111111111111111111111111111111111111111111111111111";
		op2 <= "1000000000000000000000000000000000000000000000000000000000000001";

      wait;
   end process;

END;
