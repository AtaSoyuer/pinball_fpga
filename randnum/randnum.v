module randnum(
  input  CLK,
  input  reset,
  output reg [8:0] random
);
reg [8:0] temp;




wire feedback = temp[8] ^ temp[4] ;

always @(posedge CLK)
begin
	if (!reset) 
    temp = 4'd20;
	else
		
		begin
			temp = {temp[7:0], feedback};
			random = temp;
			
		
			if (random > 9'b101111100)
			begin
				random = random - 200;
				
				
				end
				else if (random < 9'b0000001010)
				begin
				random = random + 90;
				
				end
			else 
			begin
			
				random = random;
				
				
				end
		end		
				
	end
		
endmodule
