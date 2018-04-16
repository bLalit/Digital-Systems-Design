library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity andgates is
    Port ( a : in std_logic_vector (3 downto 0);
           b : in std_logic;
           ab : out std_logic_vector (3 downto 0));
end andgates;

architecture Behavior of andgates is

	begin
	
		ab(0) <=a (0) and b;
		ab(1) <=a (1) and b;
		ab(2) <=a (2) and b;
		ab(3) <=a (3) and b;
		
	end Behavior;
