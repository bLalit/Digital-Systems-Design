library IEEE;
use IEEE.std_logic_1164.all;

--This is the code for an Instruction register

entity insrg is 
	
	
		port (D : in std_logic_vector(6 downto 0); --7 bit instrucion register input from the even byte
				clk : in std_logic;	-- clock input
				Q : out std_logic_vector(6 downto 0));--output instruction registers include --> MUX,W',M,S3,S2,S1,S0.
				
end entity insrg;


architecture Behaviour of insrg is

begin
	p0: process (clk) is

			begin
				if (clk='1') then  --This instruction register gives output only
					Q <="-------";	 --as long as the user gives the clock pulse
				else					 --after the clk goes to '0' then the instruction
					Q <= D;			 --register goes to a dont care mode.
				end if;
		
	end process p0;

end Behaviour;