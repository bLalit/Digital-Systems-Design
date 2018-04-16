library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--THis is the code for the ALU.

entity alu is 

 port(
		dina	: in	std_logic_vector(3 downto 0); -- Output from the accumulator will be sent to this input port.
		dinb	: in	std_logic_vector(3 downto 0);	-- Output from the mux will be sent to this input port.
		sel	: in	std_logic_vector(4 downto 0);	-- The input for this port comes from the insreg(instruction register).
																--	sel contains the opcodes for selecting and performing one of the operations
																-- described in the architecture of this code
		dout	: out	std_logic_vector(3 downto 0));-- this output is sent the input of the accumulator.

end alu;

architecture behavior of alu is

begin
  	
  	with sel select
	
		dout <=  dina 					when "11111", --NOP
					(not dina)			when "10000", --INV
					(dina + dina)		when "01100", --SHIFT
					dinb					when "11010", --LDI --LOAD -- STORE
					(dina + dinb)		when "01001", --ADD --ADDI 
					(dina - dinb - 1) when "00110", --SUB --SUBI
					(dina and dinb)	when "11011", --AND --ANDI
					(dina or dinb)		when "11110", --OR  --ORI
					"0000"			when others;
					
					
	
	
	

end behavior;