library IEEE;
use IEEE.std_logic_1164.all,ieee.numeric_std.all;


entity sipo is
		
		port(clk0,rst0 : in std_logic;
			a : in std_logic;
			op : out unsigned(7 downto 0));
		
		
end entity sipo;

architecture Behavior of sipo is

begin
	p1: process (clk0,rst0) is
	variable temp: unsigned(7 downto 0) :="00000000";
	begin
	
		if rising_edge(clk0) then
		
			if (rst0 = '1') then
				temp := "00000000";
				op<= temp;
			else
				temp := temp(6 downto 0) & a;
				op(0) <= temp(7);
				op(1) <= temp(6);
				op(2) <= temp(5);
				op(3) <= temp(4);
				op(4) <= temp(3);
				op(5) <= temp(2);
				op(6) <= temp(1);
				op(7) <= temp(0);
			end if;
		end if;
		
		
		
	end process p1;
	
end architecture Behavior;