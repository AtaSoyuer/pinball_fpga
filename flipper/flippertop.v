module flippertop( input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,         // reset button
	 input wire BUTTONL,
	 input wire BUTTONR,
	 input wire BUTTONlaunch,

    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [7:0] VGA_R,    // 4-bit VGA red output
    output wire [7:0] VGA_G,    // 4-bit VGA green output
    output wire [7:0] VGA_B,
	 output vgaclk );     // 4-bit VGA blue output 
	 
	
	 wire rst = ~RST_BTN;// reset is active low on Arty & Nexys Video
   

	 wire launchbutton = ~ BUTTONlaunch;
	 
    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511
    wire animate;  // high when we're ready to animate at end of drawing

    // generate a 25 MHz enable
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

    vga640x480 display (
        .i_clk(CLK),
        .i_clkenable(clkenable),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y),
        .o_animate(animate)
    );
//!!!!TARgets

wire hex1, hex2, circ1, circ2, circ3, circ4; 
hexagon H1 ( .x(x), .xcenter(32'd220), .y(y), .ycenter(32'd100), .hexagon(hex1), .CLK(CLK));
	
	hexagon H2 ( .x(x), .xcenter(32'd470), .y(y), .ycenter(32'd230), .hexagon(hex2), .CLK(CLK));
	
	
    
	 
	 //Green circle
	 circle C1 ( .x(x), .xcenter(10'd270), .y(y), .ycenter(10'd180), .circle(circ1), .CLK(CLK));
	 circle C2 ( .x(x), .xcenter(10'd380), .y(y), .ycenter(10'd140), .circle(circ2), .CLK(CLK));
	 
	  
	  
		  // Red circle
	circle C3 ( .x(x), .xcenter(10'd200), .y(y), .ycenter(10'd245), .circle(circ3), .CLK(CLK));
	circle C4 ( .x(x), .xcenter(10'd390), .y(y), .ycenter(10'd210), .circle(circ4), .CLK(CLK));
	 
	  
	  

	  
	    assign VGA_R[6:0]=0;
		  assign VGA_B[6:0]=0;
		   assign VGA_G[5:0]=0;
			
	 
	 //TARGETS 
	 
/// !!!!! COUNTERS !!!!!!!!/////
wire k0,k1,k2,k3,k4,k5,k6,l0,l1,l2,l3,l4,l5,l6,m0,m1,m2,m3,m4,m5,m6,finish ;
counter T (.x(x), .y(y), .i_clk(CLK), .i_animate(animate), .k0(k0),.k1(k1),.k2(k2),.k3(k3),.k4(k4),.k5(k5), .k6(k6),
.l0(l0),.l1(l1),.l2(l2),.l3(l3),.l4(l4),.l5(l5),.l6(l6),
.m0(m0),.m1(m1),.m2(m2),.m3(m3),.m4(m4),.m5(m5),.m6(m6), .i_rst(rst), .finish(finish) ) ;





//// !!!! COUNTERS !!!!!!!!!////////	
	 
	 
/////!!!! SCORE !!!!!

/*wire a0,a1,a2,a3,a4,a5,a6,b0,b1,b2,b3,b4,b5,b6,c0,c1,c2,c3,c4,c5,c6;
score Y (.x(x), .y(y), .i_clk(CLK), .i_animate(animate), .a0(a0),.a1(a1),.a2(a2),.a3(a3),.a4(a4),.a5(a5), .a6(a6),
.b0(b0),.b1(b1),.b2(b2),.b3(b3),.b4(b4),.b5(b5),.b6(b6),
.c0(c0),.c1(c1),.c2(c2),.c3(c3),.c4(c4),.c5(c5),.c6(c6),.score(score) ) ; */	 
	 
/////////////!!!SCORE!!!!!!!!!////////////	 
	 
// define arena //
wire borderleft, borderright, bordertop, borderleftincline,plunger_leftcorner,plunger_bottom,plunger_top, borderrightincline; 

//make arena assigments//
  	assign borderleft = ((x > 115) & (y >=  40) & (x < 120) & (y < 280)) ? 1 : 0;
    assign borderright = ((x > 520) & (y >= 40) & (x < 525) & (y < 280)) ? 1 : 0;
    assign bordertop = ((x > 115) & (y > 35) & (x < 525) & (y <= 40)) ? 1 : 0;
    assign borderleftincline = ((x >=120) & (y >= 280) & (x < 200) & (y < 360) & ((x-120)==(y-280)) ) ? 1 : 0;
	 assign borderrightincline = ((x > 440) & (y >= 280) & (x <= 520) & (y < 360) & ((520-x)==(y-280)) ) ? 1 : 0;
	 // end of arena assigments
	 
// plunger ///
assign plunger_leftcorner= ((x == 515) & (y >= 70) & (y <= 100)) ? 1 : 0;
assign plunger_bottom =  (((x > 515) & (y == 100) & (x < 520))) ? 1 : 0;	 
assign plunger_top =  (((x > 515) & (y == 70) & (x < 520))) ? 1 : 0;		 
// plunger ///


// BALL //
wire ball,score, xcenterball, ycenterball ;
ball Z ( .x(x), .y(y), .i_clk(CLK), .i_animate(animate), .ball(ball) , .i_rst(rst),
 .launchbutton(launchbutton), .i_ani_stb(clkenable), .BUTTONL(BUTTONL), .BUTTONR(BUTTONR),.a0(a0),.a1(a1),.a2(a2),.a3(a3),
.a4(a4),.a5(a5), .a6(a6),
.b0(b0),.b1(b1),.b2(b2),.b3(b3),.b4(b4),.b5(b5),.b6(b6),
.c0(c0),.c1(c1),.c2(c2),.c3(c3),.c4(c4),.c5(c5),.c6(c6),.finish(finish) ) ;







// BALL //
	 
//!!!!!!!!!!!!! FLIPPERS !!!!!!!!!!!!!!!!!!!!!!!!!	 
    reg flipperleft, flipperright;
    wire [31:0] tantetal,tantetar, ycenterleft,ycenterright, xcenterleft, xcenterright,anglel,angler;  
 // define center points  !!!!!!!!!!!!!! ///////   
    assign xcenterleft = 200;
	 assign ycenterleft = 360;
    assign xcenterright = 440;
	 assign ycenterright = 360;
    flipper left ( .i_clk(CLK),         
						 .flipperbutton(BUTTONL),
						 .i_ani_stb(clkenable),
						 .i_rst(rst),       
						 .i_animate(animate),    
						 
						 .tantetavar(tantetal), 
						
						 .angle(anglel)
						);
						
						
	flipper right ( .i_clk(CLK),         
						 .flipperbutton(BUTTONR),
						 .i_ani_stb(clkenable),
						 .i_rst(rst),       
						 .i_animate(animate),    
						 
						 .tantetavar(tantetar), 
						
						 .angle(angler)
						);

reg radiuscondleft,radiuscondright, xcondleft, xcondright, anglecondleft, anglecondright, ytest;
				
reg [31:0] radii  = 32'd100; 

always @ (posedge CLK)
 begin
 radiuscondleft = (((y-ycenterleft)*(y-ycenterleft)+(x-xcenterleft)*(x-xcenterleft)) <= radii*radii);
 radiuscondright = (((y-ycenterright)*(y-ycenterright)+(xcenterright-x)*(xcenterright-x)) <= radii*radii);

 xcondleft = (x >= xcenterleft);

 xcondright = (x <= xcenterright);





 anglecondleft = (anglel >= 8'd45) ?  (((ycenterleft - y)*32'd10000000) <= (11*(x-xcenterleft)*tantetal)) && (((ycenterleft - y)*32'd10000000) >= (9*(x-xcenterleft)*tantetal))
: (((y - ycenterleft)*32'd10000000) <= (11*(x-xcenterleft)*tantetal)) && (((y - ycenterleft)*32'd10000000) >= (9*(x-xcenterleft)*tantetal))   ;

 anglecondright = (angler >= 8'd45) ?  (((ycenterright - y)*32'd10000000) <= (11*(xcenterright-x)*tantetar)) && (((ycenterright-y)*32'd10000000) >= (9*(xcenterright-x)*tantetar))
: ((((y - ycenterright)*32'd10000000) <= (11*(xcenterright-x))*tantetar)) && (((y - ycenterright)*32'd10000000) >= (9*(xcenterright-x)*tantetar))   ;



      flipperleft = (radiuscondleft && xcondleft && anglecondleft) ;  // sflipperleft is red
	 flipperright = (radiuscondright && xcondright && anglecondright) ; 
end		
		
		
		
		assign VGA_R[7] = flipperleft || flipperright | borderleft | borderright | bordertop |
		borderleftincline | borderrightincline | circ3 | circ4 | k0 | k1 | k2 | | k3 | k4 | k5 | k6 | l0 | l1 | l2 | l3 | l4 | l5 | l6 | m0 | m1 | m2 | m3 | m4 | m5| m6 |
		a0 | a1 | a2 | a3 | a4 | a5 | a6 | b0 | b1 | b2 | b3 | b4 | b5 | b6 | c0 | c1 | c2 | c3 | c4 | c5 | c6 |
		plunger_leftcorner | plunger_bottom | plunger_top | ball;
    assign VGA_G[7] = borderleft | borderright | bordertop | borderleftincline | borderrightincline | circ1 | circ2 | k0 | k1 | k2 | | k3 | k4 | k5 | k6 | l0 | l1 | l2 | l3 | l4 | l5 | l6 | m0 | m1 | m2 | m3 | m4 | m5| m6 |
		a0 | a1 | a2 | a3 | a4 | a5 | a6 | b0 | b1 | b2 | b3 | b4 | b5 | b6 | c0 | c1 | c2 | c3 | c4 | c5 | c6 | ball;
    assign VGA_B[7] = borderleft | borderright | bordertop | borderleftincline | borderrightincline | hex1 | hex2| k0 | k1 | k2 | | k3 | k4 | k5 | k6 | l0 | l1 | l2 | l3 | l4 | l5 | l6 |  m0 | m1 | m2 | m3 | m4 | m5| m6 |
		a0 | a1 | a2 | a3 | a4 | a5 | a6 | b0 | b1 | b2 | b3 | b4 | b5 | b6 | c0 | c1 | c2 | c3 | c4 | c5 | c6 ;
	  assign VGA_G[6] = plunger_leftcorner | plunger_bottom | plunger_top ;

	assign vgaclk = clkenable;
endmodule


						