module hexagon (input [9:0] x,xcenter,y,ycenter, d, output hexagon );

wire [0:20] x1,x2,x3,x4,x5,x6,y1,y2,y3,y4,y5,y6;

wire [0:20] x_large,y_large,q2x,q2y;

assign x_large = 10'd100 * x;
assign y_large = 10'd100 * y;

assign x1 = 10'd100*xcenter;
assign y1 = 10'd100*ycenter + 10'd200*d; //top vertice

assign x2 = 10'd100*xcenter + 10'd173*d; //top right
assign y2 = 10'd100*ycenter +10'd100* d;

assign x3 = 10'd100*xcenter + 10'd173*d; //bottom right
assign y3 = 10'd100*ycenter - 10'd100*d; 

assign x4 = 10'd100*xcenter;					//bottom
assign y4 = 10'd100*ycenter - 10'd200*d;

assign x5 = 10'd100*xcenter - 10'd173*d;	//bottom left
assign y5 = 10'd100*ycenter - 10'd100*d;

assign x6 = 10'd100*xcenter - 10'd173*d; //top left
assign y6 = 10'd100*ycenter + 10'd100*d;
 
assign q2x = (x_large-10'd100*xcenter >= 0)? x_large-10'd100*xcenter : -(x_large-10'd100*xcenter);
assign q2y = (y_large-10'd100*ycenter >= 0)? y_large-10'd100*ycenter : -(y_large-10'd100*ycenter);


assign hexagon = !(q2x > 2*10'd100*d || q2y > 2*10'd100*d) && ( 2*10'd100*d * d * 173- 100 * d * q2x - 173 * d * q2y >= 0);

endmodule 