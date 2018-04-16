library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
    Port ( NUM1 : in  STD_LOGIC_VECTOR (4 downto 0);-- 5-bit number
           NUM2 : in  STD_LOGIC_VECTOR (4 downto 0);-- 5-bit number
           SUM : out  STD_LOGIC_VECTOR (4 downto 0));-- 5 bit result
			  
end alu;

architecture Behavioral of alu is
begin
		
		SUM <= NUM1+NUM2;
	

end Behavioral;