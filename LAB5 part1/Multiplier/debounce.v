module debounce(
	CLK,
	RST,
	sw,
	outp,
	invoutp);

parameter bouncetime = 50000;
parameter clkwidth = $clog2(bouncetime);

input CLK;
input RST; 

input sw;
output reg outp;
output reg invoutp;

reg [(clkwidth-1):0] count;
reg lsw; //last switch state

always@(posedge CLK or negedge RST)
begin
		if(RST==0) begin
			count <= bouncetime;
		end
		else begin
			lsw<=sw;
			
			if(lsw != sw) begin
				count <= bouncetime;
			end
			else 
			
			if (count == 0) begin
				outp <= sw;
				invoutp <= ~sw;
			end 
			else begin
				count <= count - 1;
			end;
			
		end
end
	
endmodule
