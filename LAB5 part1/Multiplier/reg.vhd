library IEEE;
use IEEE.std_logic_1164.all;


entity reg is
	
	
		port (D : in std_logic_vector(3 downto 0);
				clk, rst : in std_logic;
				Q : out std_logic_vector(3 downto 0));
				
end entity reg;


architecture Behaviour of reg is

begin
	p0: process (clk,rst) is

			begin
				if rising_edge(clk) then
					if (rst = '1') then
						Q <= (others => '0');
					else
						Q <= D;
					end if;
				end if;
				
	end process p0;

end Behaviour;