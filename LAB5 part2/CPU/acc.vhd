library IEEE;
use IEEE.std_logic_1164.all;

--This is the code for an Accumulator

entity acc is
	
	
		port (D : in std_logic_vector(3 downto 0);	--This port gets the output from the alu
				clk, rst : in std_logic;					
				Q : out std_logic_vector(3 downto 0));	-- accumulator output
				
end entity acc;


architecture Behaviour of acc is

begin
	p0: process (clk,rst) is

			begin
			
				if (rst = '0') then			--This code for accumulator is basically
					Q <= (others => '0');	--a code for a 4 bit D flip-flop register
													--it stores the input value and displays it
				elsif rising_edge(clk) then--on output ports when a clock pulse is given.
					Q <= D;						--the reset forves Q to 0 when used.
				
				end if;
				
	end process p0;

end Behaviour;