module vga(
    input wire CLK,             // board clock: 50 MHz 
    input wire RST_BTN,         // reset button
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [7:0] VGA_R,    // 4-bit VGA red output
    output wire [7:0] VGA_G,    // 4-bit VGA green output
    output wire [7:0] VGA_B,     // 4-bit VGA blue output
	 output vgaclk   

	);

    wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video
    // wire rst = RST_BTN;  // reset is active high on Basys3 (BTNC)

    // generate a 25 MHz clk en
reg tempclk;
wire clkenable;
initial
begin
	tempclk=1'b0;
end

   always @ (posedge CLK)
begin
	tempclk <= ~tempclk;
end

assign clkenable = tempclk;

wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
wire [8:0] y;  // current pixel y position:  9-bit value: 0-511

    vga640x480 display (
        .i_clk(CLK),
        .i_clkenable(clkenable),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y)
    );
	 
	 //random center generator
	 
	 wire reset;
	 wire [8:0] randx1, randx2, randy1, randy2, randc1, randc2, randc3, randc4, randc5, randc6, randc7, randc8;
	
	 
	 randnum R1 (.CLK(clkenable), .random(randx1));
	 randnum R2 (.CLK(clkenable), .random(randx2));
	 randnum R3 (.CLK(clkenable), .random(randy1));
	 randnum R4 (.CLK(clkenable), .random(randy2));
	 
	 randnum R5 (.CLK(clkenable), .random(randc1));
	 randnum R6 (.CLK(clkenable), .random(randc2));
	 randnum R7 (.CLK(clkenable), .random(randc3));
	 randnum R8 (.CLK(clkenable), .random(randc4));
	 randnum R9 (.CLK(clkenable), .random(randc5));
	 randnum R10 (.CLK(clkenable), .random(randc6));
	 randnum R11 (.CLK(clkenable), .random(randc7));
	 randnum R12 (.CLK(clkenable), .random(randc8));

    // Hexagon
	 
    wire hex1;
	 wire hex2, circ1, circ2, circ3, circ4;
	 
	
   
	hexagon H1 ( .x(x), .xcenter(9'b100000000), .y(y), .ycenter(9'b100000000), .hexagon(hex1));
	
	hexagon H2 ( .x(x), .xcenter(9'b001100100), .y(y), .ycenter(9'b001100100), .hexagon(hex2));
	
	  assign VGA_B[7] = hex1 | hex2;  // hexagon1 is blue
    
	 
	 //Green circle
	 circle C1 ( .x(x), .xcenter(10'd50), .y(y), .ycenter(10'd50), .circle(circ1));
	 circle C2 ( .x(x), .xcenter(10'd150), .y(y), .ycenter(10'd150), .circle(circ2));
	 
	  assign VGA_G[7] = circ1 | circ2;
	  
		  // Red circle
	circle C3 ( .x(x), .xcenter(10'd250), .y(y), .ycenter(10'd250), .circle(circ3));
	circle C4 ( .x(x), .xcenter(10'd320), .y(y), .ycenter(10'd320), .circle(circ4));
	 
	  assign VGA_R[7] = circ3 | circ4;  
	  

	  
	    assign VGA_R[6:0]=0;
		  assign VGA_B[6:0]=0;
		   assign VGA_G[6:0]=0;
	  
	assign  vgaclk = clkenable ;
	 
endmodule
