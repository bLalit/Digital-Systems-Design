LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--This is the code for a 3 bit --> 2:1 MUX

entity mux is
			
	Port ( 
		datain0 	: in  STD_LOGIC_VECTOR (3 downto 0); -- 3 bit input a.
		datain1 	: in  STD_LOGIC_VECTOR (3 downto 0); -- 3 bit input b .
		sel 	: in  STD_LOGIC;								-- select line.
		opt 		: out STD_LOGIC_VECTOR (3 downto 0));-- output.

end mux;

architecture behavior of mux is

begin

	with sel select
	
		opt <= datain0 when '0',  -- with select = 0 --> datain0(data of odd-byte) is the output.
				datain1 when others;-- with select = 1 --> datain1(data output of ram) is the output.
			
end behavior;