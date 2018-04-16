library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity piso is
	
	port ( clk,rst,load : in std_logic;
			inp : in unsigned(3 downto 0);
			q : out std_logic);
			
end entity piso;

architecture behavior of piso is

begin 

		p0: process(clk,rst,load) is
		
		variable reg : unsigned ( 3 downto 0) :="0000";
		
		begin
		
			
				
			if (rising_edge (clk)) then 
			
				if (rst = '1') then
				reg := (others => '0');
				
				elsif (load = '1') then
				reg := inp;
				
				else				
				reg := shift_right (reg,1);	
				
				end if;
			end if;
			
			q <= reg(0);	
			
		end process p0;

end behavior;
			