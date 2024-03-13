module randnum(
  input  CLK,
  input  reset,
  output reg [8:0] random
);
reg [8:0] temp;
reg count;

initial
begin
count=0;
end

wire feedback = temp[8] ^ temp[4] ;

always @(posedge CLK)
begin
	if (!reset) 
    temp = 4'd20;
	else
		begin if(count==0)
		begin
			temp = {temp[7:0], feedback};
			random = temp;
			
		
			if (random > 9'b101111100 && count==0)
			begin
				random = random - 200;
				count <= 1'b1;
				
				end
				else if (random < 9'b0000001010 && count==0)
				begin
				random = random + 90;
				count <= 1'b1;
				end
			else if(count==0)
			begin
			
				random = random;
				count <= 1'b1;
				
				end
		end		
				
	end
		
end
endmodule
