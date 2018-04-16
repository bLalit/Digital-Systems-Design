LIBRARY ieee;
USE ieee.std_logic_1164.all;
 
ENTITY multiplier IS

        PORT ( SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
					CLOCK_50 : IN  STD_LOGIC;
               LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
               HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
					HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
			--		HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);
					HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6);
					HEX4 : OUT STD_LOGIC_VECTOR(0 TO 6);
					HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6);
					HEX6 : OUT STD_LOGIC_VECTOR(0 TO 6);
					HEX7 : OUT STD_LOGIC_VECTOR(0 TO 6);
					KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0));
					
END multiplier;



ARCHITECTURE Behavior OF multiplier IS
 
		COMPONENT sevsegdecoder		
			port	(input0: in std_logic_vector(3 downto 0);
					display: out std_logic_vector(0 to 6));							 
		END COMPONENT;
		
		
		COMPONENT piso				
			port ( clk,rst,load : in std_logic;
					inp : in std_logic_vector(3 downto 0);
					q : out std_logic);								
		END COMPONENT;
		
		
		COMPONENT sipo		
			port(clk0,rst0 : in std_logic;
					a : in std_logic;
					op : out std_logic_vector(7 downto 0));		
		END COMPONENT;
		
		
		COMPONENT alu
			Port ( NUM1 : in  STD_LOGIC_VECTOR (4 downto 0);   
					NUM2 : in  STD_LOGIC_VECTOR (4 downto 0);    
					SUM : out  STD_LOGIC_VECTOR (4 downto 0));
			     
		END COMPONENT;
		
		
		COMPONENT andgates
			Port ( a : in std_logic_vector (3 downto 0);
					b : in std_logic;
					ab : out std_logic_vector (3 downto 0));
		END COMPONENT;
		
		
		COMPONENT reg
			port (D : in std_logic_vector(3 downto 0);
					clk, rst : in std_logic;
					Q : out std_logic_vector(3 downto 0));
		END COMPONENT;
		
		COMPONENT debounce
		
			GENERIC (bouncetime 	: INTEGER := 50000);
			PORT (CLK, RST, sw  : IN STD_LOGIC;
					outp, invoutp : OUT STD_LOGIC);
					
	END COMPONENT;
		
signal b0,x0,clk0,clk_not :						std_logic;	
signal aluin,regout,regin0 :	std_logic_vector(3 downto 0);
signal SUM0,aluin0,regout0 :	std_logic_vector(4 downto 0);	
Signal display :			std_logic_vector(7 downto 0);


begin 

 piso0: 								piso port map (clk0,SW(0),SW(1),SW(13 downto 10),b0);
 andgates0: 						andgates port map (SW(17 downto 14),b0,aluin);
										aluin0 <= "00000" OR aluin;
 alu0 :								alu port map (aluin0,regout0,SUM0);
 reg0 :								reg port map (SUM0(4 downto 1),clk0,SW(0),regout);
										regout0 <= "00000" OR regout;
 sipo0 :								sipo port map (clk0,SW(0),SUM0(0),display);

-- sipo0:							sipo port map (KEY(0),SW(0),x,y);
debounce0:							debounce GENERIC MAP (bouncetime => 100000) PORT MAP (CLOCK_50,KEY(1),KEY(0),clk0,clk_not);
												--default is 50000 (1ms@50MHz)
	



disp0: sevsegdecoder port map (SW(17 downto 14),HEX7);
disp1: sevsegdecoder port map (SW(13 downto 10),HEX6);
disp2: sevsegdecoder port map (aluin,HEX5);
disp3: sevsegdecoder port map (SUM0(4 downto 1),HEX4);
disp4: sevsegdecoder port map (regout,HEX3);
--disp5: singlebit port map (SUM0(0),HEX2);
disp6: sevsegdecoder port map (display(7 downto 4),HEX1);
disp7: sevsegdecoder port map (display(3 downto 0),HEX0);


END Behavior;

