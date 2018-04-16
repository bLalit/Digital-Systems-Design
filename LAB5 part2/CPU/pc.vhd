library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--THis is the code for the program counter

entity pc is 

 port(
		din	: in	std_logic_vector(3 downto 0); --data input
		accip : in std_logic_vector (3 downto 0); --accumulator output is connected to this port
		JMPZ	: in	std_logic;
		JIFZ	: in	std_logic;
		JIFN	: in	std_logic;	
		clk	: in	std_logic;	--clock
		rst	: in	std_logic;	--reset
		dout	: out	unsigned);	--output of count

end pc;

architecture behavior of pc is

begin
  	
  	clk_proc:process(clk,rst)
	
  	variable COUNT:unsigned(3 downto 0) := "0000"; --declared a terporary variable an initiated it to 0.
	
  	begin 
		if rst = '0' then		--asynchronous reset (active low).
			COUNT := "0000";
			
  		elsif rising_edge (clk) then
			
			if (JMPZ = '1') then	--logic for JMPZ operation.
				COUNT := "0000";
				
			elsif (accip = "0000" and JIFZ ='1') then --logic for JIFZ operation.
				COUNT := "0000";
				
			elsif (accip = "1111" and JIFN = '1') then --logic for JIFN operation.
				COUNT := "0000";
  			
			else
				COUNT := COUNT + 1;	-- logic for the counter to count up at every clock.
 		
			end if;
			
		end if;
		
  		dout <= COUNT after 50 ns; -- The output of the counter is updated here.
		
  	end process clk_proc;

end behavior;