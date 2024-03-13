module circle (input [9:0] x,xcenter,y,ycenter, input wire CLK, output reg circle );


wire [31:0] r;
reg [31:0] xfinal;
reg [31:0] yfinal;

assign r= 32'd15;

always @(posedge CLK)
begin

 xfinal <=(x-xcenter)*(x-xcenter);
 yfinal <=(y-ycenter)*(y-ycenter);




 circle  <= ((xfinal+yfinal) <= r*r);
end

endmodule 