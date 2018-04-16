LIBRARY ieee;
USE ieee.std_logic_1164.all;
 
ENTITY cpu IS

        PORT ( SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);    --|
               LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0); --|
					LEDG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);  --|
               HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);		--|
					HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);		--|
					HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);		--|
					HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6);		--|---> Here we declare all the hardware ports we will be using for our code.
					HEX4 : OUT STD_LOGIC_VECTOR(0 TO 6);		--|
					HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6);		--|
					HEX6 : OUT STD_LOGIC_VECTOR(0 TO 6);		--|
					HEX7 : OUT STD_LOGIC_VECTOR(0 TO 6);		--|
					CLOCK_50 : IN  STD_LOGIC;						--|
					KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0));	--|
					
END cpu;



ARCHITECTURE Behavior OF cpu IS
 
		COMPONENT sevsegdecoder
		
			port	(input0: in std_logic_vector(3 downto 0);--| Here we describe the components of seven segment decoder.
					display: out std_logic_vector(0 to 6));  --|
					
		END COMPONENT;
		
		COMPONENT mux is
			
			Port (datain0 	: in  STD_LOGIC_VECTOR (3 downto 0); --|
					datain1 	: in  STD_LOGIC_VECTOR (3 downto 0); --|
					sel 	: in  STD_LOGIC;								 --|--> Here we describe the components of MUX.
					opt 		: out STD_LOGIC_VECTOR (3 downto 0));--|

		END COMPONENT;
		
		COMPONENT acc is
		
		port (D : in std_logic_vector(3 downto 0);  --|
				clk, rst : in std_logic;				  --|-->Here we describe the components of accumulator.
				Q : out std_logic_vector(3 downto 0));--|
				
		END COMPONENT acc;
		
		
		COMPONENT insrg is
		
		port (D : in std_logic_vector(6 downto 0);  --|
				clk : in std_logic;						  --|-->Here we describe the components of instruction register.
				Q : out std_logic_vector(6 downto 0));--|
				
		END COMPONENT insrg;
		
		COMPONENT pc is 

		port (din	: in	std_logic_vector(3 downto 0); --|
				accip : in std_logic_vector (3 downto 0); --|
				JMPZ	: in	std_logic;							--|
				JIFZ	: in	std_logic;							--|-->>Here we describe the components of program counter.
				JIFN	: in	std_logic;							--|
				clk	: in	std_logic;							--|
				rst	: in	std_logic;							--|
				dout	: out	std_logic_vector(3 downto 0));--|

		END COMPONENT pc;
		
		COMPONENT alu is 

		port( dina	: in	std_logic_vector(3 downto 0); --|
				dinb	: in	std_logic_vector(3 downto 0); --|-->Here we describe the components of alu.
				sel	: in	std_logic_vector(4 downto 0); --|
				dout	: out	std_logic_vector(3 downto 0));--|
		
		END COMPONENT alu;
		
		 COMPONENT RAM is
 
			port( address: in std_logic_vector(3 downto 0); --|
					datain : in std_logic_vector(3 downto 0); --|-->Here we describe the components of RAM
					dataout: out std_logic_vector(3 downto 0);--|
					we : in std_logic);								--|
 
		END COMPONENT RAM;
		
		COMPONENT debounce
		
			GENERIC (bouncetime 	: INTEGER := 50000);--|
			PORT (CLK, RST, sw  : IN STD_LOGIC;		  --|-->Here we describe the componenents used in debounce.
					outp, invoutp : OUT STD_LOGIC );	  --|
					
		END COMPONENT;


		
		
signal write_enable,clk,not_clk :					std_logic;	
signal ram_out,mux_out,acc_out,alu_out,pc_out:	std_logic_vector(3 downto 0);
signal insreg :											std_logic_vector(6 downto 0);
signal aluin0,regout0 :									std_logic_vector(4 downto 0);	
Signal display :											std_logic_vector(7 downto 0);



begin 

LEDR <= SW;

	insrg0:		insrg port map (SW(14 downto 8),pc_out(0),insreg);
	mux0:			mux port map (SW(3 downto 0),ram_out,insreg(6),mux_out);
	acc0:			acc port map (alu_out,pc_out(0),KEY(1),acc_out);
	alu0:			alu port map (acc_out,mux_out,insreg(4 downto 0),alu_out);
	pc0:			pc port map (acc_out,acc_out,SW(17),SW(16),SW(15),clk,KEY(1),pc_out);
	ram0:			RAM port map (SW(7 downto 4),acc_out,ram_out,insreg(5));
	debounce0:	debounce generic map (bouncetime => 100000) port map (CLOCK_50,KEY(1),KEY(0),clk,not_clk);
										--default is 50000 (1ms@50MHz)
	LEDG(0) <= clk;
	LEDG(1) <= not_clk;
										
	disp0: sevsegdecoder port map (acc_out,HEX0); --Displaying the accumulator.
	disp1: sevsegdecoder port map (pc_out,HEX1);	 --Displaying the program counter.
	disp2: sevsegdecoder port map (alu_out,HEX2); --Displaying alu output.
	disp3: sevsegdecoder port map (mux_out,HEX3); --Displaying MUX output.
	disp4: sevsegdecoder port map (ram_out,HEX4); --Displaying RAM dataout.
	disp5: sevsegdecoder port map (insreg(3 downto 0),HEX5);
	disp6: sevsegdecoder port map (SW(3 downto 0),HEX6);--Displaying DATAin of odd byte.
	disp7: sevsegdecoder port map (SW(7 downto 4),HEX7);--Displaying  RAM address of odd byte.

END Behavior;
