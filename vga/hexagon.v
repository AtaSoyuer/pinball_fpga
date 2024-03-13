module hexagon (input [9:0] x,xcenter,y,ycenter, input wire CLK, output reg hexagon );



reg [0:20] q2x,q2y, x_large,y_large;
reg [0:8] d;

initial
begin
d=8'b00001011;
end

always @(posedge CLK)
begin
x_large <= 10'd100 * x;
y_large <= 10'd100 * y;


 
q2x <= (x_large >= 10'd100*xcenter )? x_large-10'd100*xcenter : (10'd100*xcenter -x_large);
q2y <= (y_large >= 10'd100*ycenter)? y_large-10'd100*ycenter : (10'd100*ycenter-y_large);



hexagon <= !(q2x > 10'd173*d || q2y > 2*10'd100*d) && ( 2*10'd100*d * d * 10'd173>=(100 * d * q2x + 10'd173 * d * q2y) );

end
endmodule 