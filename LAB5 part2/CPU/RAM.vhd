library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity RAM is

	port (we : in std_logic;	-- READ/WRITE slect port
			address : in std_logic_vector(3 downto 0);  --4 bit RAM address from odd byte
			datain : in std_logic_vector(3 downto 0);  --4 bit RAM data from accumulator
			dataout : out std_logic_vector(3 downto 0)); --4 bit output given to the MUX
			
end entity RAM;

architecture Behavior of RAM is

	type myram is array (15 downto 0) of std_logic_vector(3 downto 0); --array 16 slots of address space
	signal memory : myram;															-- each of 4 bit word length.
	signal addr : integer range 0 to 15;
	
	begin 
	
	p0: process(address, datain,we)

		begin
			
			addr <= conv_integer(address);
			if (we ='0') then 					--when we=0 --> we write data to RAM
				memory(addr)<=datain;			-- data is written  from accumulator to specified address.
			elsif (we = '1') then 				--when we=1 --> we read data from RAM
				dataout<=memory(addr);			-- dafta from specific address to the output read.
			else 
				dataout <="0000";	--default contition
			end if;
		
		end process p0;
		
end architecture Behavior;