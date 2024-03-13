module ball (
input wire i_clk,         // base clock
						input launchbutton,
						input wire i_ani_stb,     // animation clock: pixel clock is 1 pix/frame
						input wire i_rst,         // reset: returns animation to starting position
						input wire i_animate,     // animate when input is high
						input [9:0] x, y, 
						input BUTTONL, BUTTONR,
	
						
						output ball,
						output reg finish,
						output reg [9:0] xcenter, ycenter,
						output reg a0,a1,a2,a3,a4,a5,a6,
						output reg b0,b1,b2,b3,b4,b5,b6,
						output reg c0,c1,c2,c3,c4,c5,c6
						
);
reg [9:0] score;
wire [31:0] r;
reg [8:0] xspeed, yspeed;
reg x_dir = 1;  
reg y_dir = 1;
reg [8:0] countacc;
reg [9:0] temp;
reg activate;
reg [32:0] counter, counter3;
wire borderleftincline;
wire borderrightincline;
assign r= 32'd8;
reg circ1, circ2, circ3, circ4; 
reg  hex1, hex2; 
reg flipperleft, flipperright;
initial

begin

score = 8'd0;
countacc = 0;
activate <= 0;
xcenter <= 10'd507;
ycenter <= 10'd85;
end



//callings


assign borderleftincline = ((x >=120) & (y >= 280) & (x < 200) & (y < 360) & ((x-120)==(y-280)) ) ? 1 : 0;
assign borderrightincline = ((x > 440) & (y >= 280) & (x <= 520) & (y < 360) & ((520-x)==(y-280)) ) ? 1 : 0;

//circle callings

wire [31:0] rgreen1;
reg [31:0] xfinalgreen1;
reg [31:0] yfinalgreen1;

assign rgreen1= 32'd15;

always @(posedge i_clk)
begin

 xfinalgreen1 <=(x-10'd270)*(x-10'd270);
 yfinalgreen1 <=(y-10'd180)*(y-10'd180);




 circ1  <= ((xfinalgreen1+yfinalgreen1) <= rgreen1*rgreen1);
end


wire [31:0] rgreen2;
reg [31:0] xfinalgreen2;
reg [31:0] yfinalgreen2;

assign rgreen2= 32'd15;

always @(posedge i_clk)
begin

 xfinalgreen2 <=(x-10'd380)*(x-10'd380);
 yfinalgreen2 <=(y-10'd140)*(y-10'd140);




 circ2  <= ((xfinalgreen2+yfinalgreen2) <= rgreen2*rgreen2);
end



wire [31:0] rred1;
reg [31:0] xfinalred1;
reg [31:0] yfinalred1;

assign rred1= 32'd15;

always @(posedge i_clk)
begin

 xfinalred1 <=(x-10'd200)*(x-10'd200);
 yfinalred1 <=(y-10'd245)*(y-10'd245);




 circ3  <= ((xfinalred1+yfinalred1) <= rred1*rred1);
end



wire [31:0] rred2;
reg [31:0] xfinalred2;
reg [31:0] yfinalred2;

assign rred2= 32'd15;

always @(posedge i_clk)
begin

 xfinalred2 <=(x-10'd390)*(x-10'd390);
 yfinalred2 <=(y-10'd210)*(y-10'd210);




 circ4  <= ((xfinalred2+yfinalred2) <= rred2*rred2);
end




wire [31:0] rhex1;
reg [31:0] xfinalhex1;
reg [31:0] yfinalhex1;

assign rhex1= 32'd8;

always @(posedge i_clk)
begin

 xfinalhex1 <=(x-32'd220)*(x-32'd220);
 yfinalhex1 <=(y-32'd100)*(y-32'd100);




 hex1  <= ((xfinalhex1+yfinalhex1) <= rhex1*rhex1);
end



wire [31:0] rhex2;
reg [31:0] xfinalhex2;
reg [31:0] yfinalhex2;

assign rhex2= 32'd8;

always @(posedge i_clk)
begin

 xfinalhex2 <=(x-32'd470)*(x-32'd470);
 yfinalhex2 <=(y-32'd230)*(y-32'd230);




 hex2  <= ((xfinalhex2+yfinalhex2) <= rhex2*rhex2);
end




//circle calling end


/*hexagon H1 ( .x(x), .xcenter(32'd220), .y(y), .ycenter(32'd100), .hexagon(hex1), .CLK(i_clk));
hexagon H2 ( .x(x), .xcenter(32'd470), .y(y), .ycenter(32'd110), .hexagon(hex2), .CLK(i_clk)); */
	// flip

    wire [31:0] tantetal,tantetar, ycenterleft,ycenterright, xcenterleft, xcenterright,anglel,angler;  
 // define center points  !!!!!!!!!!!!!! ///////   
    assign xcenterleft = 200;
	 assign ycenterleft = 360;
    assign xcenterright = 440;
	 assign ycenterright = 360;
    flipper left ( .i_clk(i_clk),         
						 .flipperbutton(BUTTONL),
						 .i_ani_stb(i_ani_stb),
						 .i_rst(rst),       
						 .i_animate(i_animate),    
						 
						 .tantetavar(tantetal), 
						
						 .angle(anglel)
						);
						
						
	flipper right ( .i_clk(i_clk),         
						 .flipperbutton(BUTTONR),
						 .i_ani_stb(i_ani_stb),
						 .i_rst(rst),       
						 .i_animate(i_animate),    
						 
						 .tantetavar(tantetar), 
						
						 .angle(angler)
						);

reg radiuscondleft,radiuscondright, xcondleft, xcondright, anglecondleft, anglecondright, ytest;
				
reg [31:0] radii  = 32'd100; 

always @ (posedge i_clk)
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
		






/////


always @ (posedge i_clk)
begin
if(i_ani_stb)
begin
	 begin
        if (i_rst)  // on reset return to starting position
        begin
            xcenter <= 10'd507;
				ycenter <= 10'd85;
				activate <= 0;

				score <= 8'd0;
				xspeed <= 8'd0;
				yspeed <= 8'd0;
         end  
			
			
 if (launchbutton)  // on reset return to starting position
        begin
            xspeed <= 8'd4;
				yspeed <= 8'd3;
				x_dir <= 1;  
				y_dir <= 1;
				activate <= 1;
      end 
if(activate)	
	  
begin
	
	
	if (i_animate)
	countacc <= countacc +1;
	if (countacc == 10)
	begin
	begin
	countacc <= 0;
	if(yspeed <= 12)
	begin
		if (y_dir == 1)
		begin 
		yspeed <= yspeed +2;
		end
		else
		if (yspeed > 1)
		begin
		yspeed <= yspeed -2 ;
		end
		else
		begin
		yspeed <= 0;
		y_dir <= 1;
		end
		end
		else
		yspeed <= 12;
	 end
	 end
	 
if ((((ycenter-10'd40)*(ycenter-10'd40)) <= r*r)) //border top
begin
y_dir <= 1;
end

if ((((xcenter-10'd520)*(xcenter-10'd520)) <= r*r)) //borderright
begin
x_dir <= 1;
end

if ((((xcenter-10'd120)*(xcenter-10'd120)) <= r*r)) //borderleft
begin
x_dir <= 0;
end

if (borderrightincline && ball && (!counter)) //borderrightinc
begin
y_dir <= 0;
x_dir <= 1;
temp <= xspeed;
xspeed <= yspeed;
yspeed <= temp;
counter <= 1;

end

if (((borderleftincline) && (ball) && (!counter))) //borderleftinc
begin
y_dir <= 0;
x_dir <= 0;
temp <= xspeed;
xspeed <= yspeed;
yspeed <= temp;
counter <= 1;

end

if ((circ1) && (ball) && (!counter))
begin 
if(xcenter < 10'd270)
begin
x_dir <= 1;
end
if(xcenter > 10'd270)
begin
x_dir <= 0;
end
if(ycenter < 10'd180)
begin
y_dir <= 0;
end
if(ycenter > 10'd180)
begin
y_dir <= 1;
end
counter <= 1;
if(score <= 8'd15)
score <= 0;
else
score <= score - 8'd15;
end
                              //// ====> Green circ. deduct point
if ((circ2) && (ball) && (!counter))
begin 
if(xcenter < 10'd380)
begin
x_dir <= 1;
end
if(x > 10'd380)
begin
x_dir <= 0;
end
if(ycenter < 10'd150)
begin
y_dir <= 0;
end
if(ycenter > 10'd150)
begin
y_dir <= 1;
end
counter <= 1;
if(score <= 8'd15)
score <= 0;
else
score <= score - 8'd15;
end

if ((circ3) && (ball) && (!counter))
begin 
if(xcenter < 10'd250)
begin
x_dir <= 1;
end
if(xcenter > 10'd250)
begin
x_dir <= 0;
end
if(ycenter < 10'd250)
begin
y_dir <= 0;
end
if(ycenter >10'd250)
begin
y_dir <= 1;
end
counter <= 1;
if(score >= 10'd999)
score <= 10'd999;
else
score <= score + 8'd10;
end
                               ///// ====> Red circ. add pnt.
if ((circ4) && (ball) && (!counter))
begin 
if(xcenter < 10'd390)
begin
x_dir <= 1;
end
if(xcenter > 10'd390)
begin
x_dir <= 0;
end
if(ycenter <10'd210)
begin
y_dir <= 0;
end
if(ycenter >10'd210)
begin
y_dir <= 1;
end
counter <= 1;
if(score >= 10'd999)
score <= 10'd999;
else
score <= score + 8'd10;
end

if ((hex1) && (ball)&&(!counter)&& (!counter3))
begin 
		if((C>=0)&&(C<3))
		begin
		y_dir <= 0;
		x_dir <= 0;
		yspeed<=7;
		end
		
		if((C>=3)&&(C<5))
		begin
		y_dir <= 0;
		x_dir <= 1;
		yspeed<=7;
		end
		
		if((C>=5)&&(C<7))
		begin
		y_dir <= 1;
		x_dir <= 1;
		yspeed<=7;
		end

		if((C>=7)&&(C<=9))
		begin
		y_dir <= 1;
		x_dir <= 0;
		yspeed<=7;
		end
		counter <= 1;
		score <= score +20;
if(score >= 10'd999)
score <= 10'd999;		
end
                          ///// ========== > hexagons 
if ((hex2) && (ball)&&(!counter) && (!counter3))
begin 
		if((C>=0)&&(C<3))
		begin
		y_dir <= 0;
		x_dir <= 0;
		yspeed<=7;
		end
		
		if((C>=3)&&(C<5))
		begin
		y_dir <= 0;
		x_dir <= 1;
		yspeed<=7;
		end
		
		if((C>=5)&&(C<7))
		begin
		y_dir <= 1;
		x_dir <= 1;
		yspeed<=7;
		end

		if((C>=7)&&(C<=9))
		begin
		y_dir <= 1;
		x_dir <= 0;
		yspeed<=7;
		end
		counter <= 1;
		score <= score +20;
if(score >= 10'd999)
score <= 10'd999;		
end

if ((flipperright) && (ball) && (!counter) )

begin
if(angler < 45)
begin
y_dir <= 0;
x_dir <= 1;
xspeed <= 11;
yspeed <= (tantetar * xspeed) >> 20;
counter <= 1;
end
if(angler > 45)
begin
y_dir <= 0;
x_dir <= 0;
xspeed <= 11;
yspeed <= (tantetar * xspeed) >> 20;
end
if(angler == 45)
begin
y_dir <= 0;
xspeed <= 0;
yspeed <= 11;
end
counter <= 1;
end

if ((flipperleft) && (ball)&& (!counter))

begin
if(anglel < 45)
begin
y_dir <= 0;
x_dir <= 0;
xspeed <= 11;
yspeed <= (tantetar * xspeed) >> 20;
counter <= 1;
end
if(anglel > 45)
begin
y_dir <= 0;
x_dir <= 1;
xspeed <= 11;
yspeed <= (tantetar * xspeed) >> 20;
end
if(angler == 45)
begin 
y_dir <= 0;
yspeed <= 11;
end
counter <= 1;
end




end
end

if (i_animate && i_ani_stb)
begin
xcenter <= (x_dir) ? (xcenter - xspeed) : (xcenter + xspeed);
ycenter <= (y_dir) ? (ycenter + yspeed) : (ycenter - yspeed);
counter <= 0;
counter3 <= counter;
if (ycenter >= 460)
begin
            xcenter <= 10'd507;
				ycenter <= 10'd85;
				activate <= 0;
				finish <=1;
				score <= 8'd0;
				xspeed <= 8'd0;
				yspeed <= 8'd0;
end
else
finish <=0;

end

end
end
assign ball = ((x-xcenter)*(x-xcenter) +  (y-ycenter)*(y-ycenter)) <= (64);


// BCD Conversion Score UPDATE

reg [3:0] hundreds, tens, ones ;

initial
begin
hundreds=0;
tens=0;
ones=0;

end


reg [8:0] o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10;
reg [8:0] onestemp, tenstemp, hundredstemp, carry1, carry2;

always @(score)

begin

o1 <= (score[0])? 4'd1:0;
o2 <= (score[1])? 4'd2:0;
o3 <= (score[2])? 4'd4:0;
o4 <= (score[3])? 4'd8:0;
o5 <= (score[4])? 4'd6:0;
o6 <= (score[5])? 4'd2:0;
o7 <= (score[6])? 4'd4:0;
o8 <= (score[7])? 4'd8:0;
o9 <= (score[8])? 4'd6:0;
o10 <= (score[9])? 4'd2:0;

onestemp <= (o1 + o2 + o3 + o4 + o5 + o6 + o7 + o8 + o9 + o10);
 if (onestemp < 10)
 begin
 ones <= onestemp;
 carry1 <= 0;
 end
 else if((onestemp >= 10) && (onestemp < 20))
 begin
 ones <= onestemp -10;
 carry1 <= 1;
 end
 else if ((onestemp >= 20) && (onestemp < 30))
 begin
 ones <= onestemp -20;
 carry1 <= 2;
 end
 else if ((onestemp >= 30) && (onestemp < 40))
 begin
 ones <= onestemp -30;
 carry1 <= 3;
 end
 else if (onestemp >= 40)
 begin
 ones <= onestemp -40;
 carry1 <= 4;
 end


t5 <= score[4]?1:0;
t6 <= score[5]?3:0;
t7 <= score[6]?6:0;
t8 <= score[7]?2:0;
t9 <= score[8]?5:0;
t10 <= score[9]?1:0;

tenstemp <=( t5+t6 + t7 + t8 + t9 + t10);
 if ((tenstemp < 7))
	begin
	tens <= tenstemp + carry1;
	carry2 <= 0;
	end
 else if((tenstemp == 7) && carry1==0)
	begin
	tens <= tenstemp;
	carry2 <= 0;
	end
else if((tenstemp == 7) && carry1==1)
	begin
	tens <= 7+carry1;
	carry2 <= 0;
	end
else if((tenstemp == 7) && carry1==2)
	begin
	tens <= 9;
	carry2 <= 0;
	end
else if((tenstemp == 7) && carry1==3)
	begin
	tens <= 0;
	carry2 <= 1;
	end
else if((tenstemp == 7) && carry1==4)
	begin
	tens <= 1;
	carry2 <= 1;
	end
else if ((tenstemp == 8)&& ((carry1==0) || (carry1==1)))
	begin
	tens <= tenstemp + carry1;
	carry2 <= 0;
	end
else if ((tenstemp == 8)&& (carry1==2))
	begin
	tens <= tenstemp + carry1-10;
	carry2 <= 1;
	end
else if ((tenstemp == 8)&& (carry1==3))
	begin
	tens <= tenstemp + carry1-10;
	carry2 <= 1;
	end
else if ((tenstemp == 9) &&(carry1==0))
	begin
	tens <= tenstemp + carry1;
	carry2 <= 0;
	end
else if ((tenstemp == 9) &&((carry1==1) || (carry1==2) || (carry1==3) )  )
	begin
	tens <= tenstemp + carry1-10;
	carry2 <= 1;
	end
else if ((tenstemp > 9) && (tenstemp < 16) && ((carry1==2)||(carry1==3) || (carry1==4) || (carry1==1)))
	begin
	tens <= tenstemp + carry1-10;
	carry2 <= 1;
	end
else if ((tenstemp == 16) && (carry1==0))
	begin
	tens <= 6;
	carry2 <= 1;
	end
else if ((tenstemp == 16) && carry1==1)
	begin
	tens <= 7;
	carry2 <= 1;
	end
else if ((tenstemp == 16) && carry1==2)
	begin
	tens <= 8;
	carry2 <= 1;
	end
else if ((tenstemp == 16) && carry1==3)
	begin
	tens <= 9;
	carry2 <= 1;
	end
else if ((tenstemp == 16) && carry1==4)
	begin
	tens <= 0;
	carry2 <= 2;
	end
else if ((tenstemp > 16) && ((carry1==3)||(carry1==4)))
	begin
	tens <= tenstemp + carry1-20;
	carry2 <= 2;
	end
else if ((tenstemp > 16) && ((carry1==0)||(carry1==1)|| (carry1==2)))
	begin
	tens <= tenstemp + carry1-10;
	carry2 <= 1;
	end
 

h8 <= score[7]?1:0;
h9 <= score[8]?2:0;
h10 <= score[9]?5:0;

hundredstemp <=( h5 + h6 + h7 + h8 + h9 + h10);
 if ((hundredstemp < 8))
	begin
	hundreds <= hundredstemp + carry2;
	end
 else if((hundredstemp == 8) && carry2!=0)
	begin
	hundreds <= 9;
	end

end
						 
// Seven segment creation	
always @ (posedge i_clk)
begin
case (hundreds)
0:
begin 
a0=((x>=10)&&(x<=35)&&(y==50));
a1=((y>=50)&&(y<=75)&&(x==35));
a2=((y>=75)&&(y<=100)&&(x==35));
a3=((x>=10)&&(x<=35)&&(y==100));
a4=((y>=75)&&(y<=100)&&(x==10));
a5=((y>=50)&&(y<=75)&&(x==10));
a6=0;
end
1:
begin 
a0=0;
a1=((y>=50)&&(y<=75)&&(x==35));
a2=((y>=75)&&(y<=100)&&(x==35));
a3=0;
a4=0;
a5=0;
a6=0;
end
2:
begin 
a0=((x>=10)&&(x<=35)&&(y==50));
a1=((y>=50)&&(y<=75)&&(x==35));
a2=0;
a3=((x>=10)&&(x<=35)&&(y==100));
a4=((y>=75)&&(y<=100)&&(x==10));
a5=0;
a6=((x>=10)&&(x<=35)&&(y==75));
end
3:
begin 
a0=((x>=10)&&(x<=35)&&(y==50));
a1=((y>=50)&&(y<=75)&&(x==35));
a2=((y>=75)&&(y<=100)&&(x==35));
a3=((x>=10)&&(x<=35)&&(y==100));
a4=0;
a5=0;
a6=((x>=10)&&(x<=35)&&(y==75));
end
4:
begin 
a0=0;
a1=((y>=50)&&(y<=75)&&(x==35));
a2=((y>=75)&&(y<=100)&&(x==35));
a3=0;
a4=0;
a5=((y>=50)&&(y<=75)&&(x==10));
a6=((x>=10)&&(x<=35)&&(y==75));
end
5:
begin 
a0=((x>=10)&&(x<=35)&&(y==50));
a1=0;
a2=((y>=75)&&(y<=100)&&(x==35));
a3=((x>=10)&&(x<=35)&&(y==100));
a4=0;
a5=((y>=50)&&(y<=75)&&(x==10));
a6=((x>=10)&&(x<=35)&&(y==75));
end
6:
begin 
a0=((x>=10)&&(x<=35)&&(y==50));
a1=0;
a2=((y>=75)&&(y<=100)&&(x==35));
a3=((x>=10)&&(x<=35)&&(y==100));
a4=((y>=75)&&(y<=100)&&(x==10));
a5=((y>=50)&&(y<=75)&&(x==10));
a6=((x>=10)&&(x<=35)&&(y==75));
end
7:
begin 
a0=((x>=10)&&(x<=35)&&(y==50));
a1=((y>=50)&&(y<=75)&&(x==35));
a2=((y>=75)&&(y<=100)&&(x==35));
a3=0;
a4=0;
a5=0;
a6=0;
end
8:
begin 
a0=((x>=10)&&(x<=35)&&(y==50));
a1=((y>=50)&&(y<=75)&&(x==35));
a2=((y>=75)&&(y<=100)&&(x==35));
a3=((x>=10)&&(x<=35)&&(y==100));
a4=((y>=75)&&(y<=100)&&(x==10));
a5=((y>=50)&&(y<=75)&&(x==10));
a6=((x>=10)&&(x<=35)&&(y==75));
end
9:
begin 
a0=((x>=10)&&(x<=35)&&(y==50));
a1=((y>=50)&&(y<=75)&&(x==35));
a2=((y>=75)&&(y<=100)&&(x==35));
a3=((x>=10)&&(x<=35)&&(y==100));
a4=0;
a5=((y>=50)&&(y<=75)&&(x==10));
a6=((x>=10)&&(x<=35)&&(y==75));
end
endcase
end


						 
always @ (posedge i_clk)
begin


case (tens)
0:
begin 
b0=((x>=45)&&(x<=70)&&(y==50));
b1=((y>=50)&&(y<=75)&&(x==70));
b2=((y>=75)&&(y<=100)&&(x==70));
b3=((x>=45)&&(x<=70)&&(y==100));
b4=((y>=75)&&(y<=100)&&(x==45));
b5=((y>=50)&&(y<=75)&&(x==45));
b6=0;
end
1:
begin 
b0=0;
b1=((y>=50)&&(y<=75)&&(x==70));
b2=((y>=75)&&(y<=100)&&(x==70));
b3=0;
b4=0;
b5=0;
b6=0;
end
2:
begin 
b0=((x>=45)&&(x<=70)&&(y==50));
b1=((y>=50)&&(y<=75)&&(x==70));
b2=0;
b3=((x>=45)&&(x<=70)&&(y==100));
b4=((y>=75)&&(y<=100)&&(x==45));
b5=0;
b6=((x>=45)&&(x<=70)&&(y==75));
end
3:
begin 
b0=((x>=45)&&(x<=70)&&(y==50));
b1=((y>=50)&&(y<=75)&&(x==70));
b2=((y>=75)&&(y<=100)&&(x==70));
b3=((x>=45)&&(x<=70)&&(y==100));
b4=0;
b5=0;
b6=((x>=45)&&(x<=70)&&(y==75));
end
4:
begin 
b0=0;
b1=((y>=50)&&(y<=75)&&(x==70));
b2=((y>=75)&&(y<=100)&&(x==70));
b3=0;
b4=0;
b5=((y>=50)&&(y<=75)&&(x==45));
b6=((x>=45)&&(x<=70)&&(y==75));
end
5:
begin 
b0=((x>=45)&&(x<=70)&&(y==50));
b1=0;
b2=((y>=75)&&(y<=100)&&(x==70));
b3=((x>=45)&&(x<=70)&&(y==100));
b4=0;
b5=((y>=50)&&(y<=75)&&(x==45));
b6=((x>=45)&&(x<=70)&&(y==75));
end
6:
begin 
b0=((x>=45)&&(x<=70)&&(y==50));
b1=0;
b2=((y>=75)&&(y<=100)&&(x==70));
b3=((x>=45)&&(x<=70)&&(y==100));
b4=((y>=75)&&(y<=100)&&(x==45));
b5=((y>=50)&&(y<=75)&&(x==45));
b6=((x>=45)&&(x<=70)&&(y==75));
end
7:
begin 
b0=((x>=45)&&(x<=70)&&(y==50));
b1=((y>=50)&&(y<=75)&&(x==70));
b2=((y>=75)&&(y<=100)&&(x==70));
b3=0;
b4=0;
b5=0;
b6=0;
end
8:
begin 
b0=((x>=45)&&(x<=70)&&(y==50));
b1=((y>=50)&&(y<=75)&&(x==70));
b2=((y>=75)&&(y<=100)&&(x==70));
b3=((x>=45)&&(x<=70)&&(y==100));
b4=((y>=75)&&(y<=100)&&(x==45));
b5=((y>=50)&&(y<=75)&&(x==45));
b6=((x>=45)&&(x<=70)&&(y==75));
end
9:
begin 
b0=((x>=45)&&(x<=70)&&(y==50));
b1=((y>=50)&&(y<=75)&&(x==70));
b2=((y>=75)&&(y<=100)&&(x==70));
b3=((x>=45)&&(x<=70)&&(y==100));
b4=0;
b5=((y>=50)&&(y<=75)&&(x==45));
b6=((x>=45)&&(x<=70)&&(y==75));
end
endcase
end



always @ (posedge i_clk)
begin

case (ones)
0:
begin 
c0=((x>=80)&&(x<=105)&&(y==50));
c1=((y>=50)&&(y<=75)&&(x==105));
c2=((y>=75)&&(y<=100)&&(x==105));
c3=((x>=80)&&(x<=105)&&(y==100));
c4=((y>=75)&&(y<=100)&&(x==80));
c5=((y>=50)&&(y<=75)&&(x==80));
c6=0;
end
1:
begin 
c0=0;
c1=((y>=50)&&(y<=75)&&(x==105));
c2=((y>=75)&&(y<=100)&&(x==105));
c3=0;
c4=0;
c5=0;
c6=0;
end
2:
begin 
c0=((x>=80)&&(x<=105)&&(y==50));
c1=((y>=50)&&(y<=75)&&(x==105));
c2=0;
c3=((x>=80)&&(x<=105)&&(y==100));
c4=((y>=75)&&(y<=100)&&(x==80));
c5=0;
c6=((x>=80)&&(x<=105)&&(y==75));
end
3:
begin 
c0=((x>=80)&&(x<=105)&&(y==50));
c1=((y>=50)&&(y<=75)&&(x==105));
c2=((y>=75)&&(y<=100)&&(x==105));
c3=((x>=80)&&(x<=105)&&(y==100));
c4=0;
c5=0;
c6=((x>=80)&&(x<=105)&&(y==75));
end
4:
begin 
c0=0;
c1=((y>=50)&&(y<=75)&&(x==105));
c2=((y>=75)&&(y<=100)&&(x==105));
c3=0;
c4=0;
c5=((y>=50)&&(y<=75)&&(x==80));
c6=((x>=80)&&(x<=105)&&(y==75));
end
5:
begin 
c0=((x>=80)&&(x<=105)&&(y==50));
c1=0;
c2=((y>=75)&&(y<=100)&&(x==105));
c3=((x>=80)&&(x<=105)&&(y==100));
c4=0;
c5=((y>=50)&&(y<=75)&&(x==80));
c6=((x>=80)&&(x<=105)&&(y==75));
end
6:
begin 
c0=0;
c1=((y>=50)&&(y<=75)&&(x==105));
c2=((y>=75)&&(y<=100)&&(x==105));
c3=((x>=80)&&(x<=105)&&(y==100));
c4=((y>=75)&&(y<=100)&&(x==80));
c5=((y>=50)&&(y<=75)&&(x==80));
c6=((x>=80)&&(x<=105)&&(y==75));
end
7:
begin 
c0=((x>=80)&&(x<=105)&&(y==50));
c1=((y>=50)&&(y<=75)&&(x==105));
c2=((y>=75)&&(y<=100)&&(x==105));
c3=0;
c4=0;
c5=0;
c6=0;
end
8:
begin 
c0=((x>=80)&&(x<=105)&&(y==50));
c1=((y>=50)&&(y<=75)&&(x==105));
c2=((y>=75)&&(y<=100)&&(x==105));
c3=((x>=80)&&(x<=105)&&(y==100));
c4=((y>=75)&&(y<=100)&&(x==80));
c5=((y>=50)&&(y<=75)&&(x==80));
c6=((x>=80)&&(x<=105)&&(y==75));
end
9:
begin 
c0=((x>=80)&&(x<=105)&&(y==50));
c1=((y>=50)&&(y<=75)&&(x==105));
c2=((y>=75)&&(y<=100)&&(x==105));
c3=((x>=80)&&(x<=105)&&(y==100));
c4=0;
c5=((y>=50)&&(y<=75)&&(x==80));
c6=((x>=80)&&(x<=105)&&(y==75));
end
endcase
end					 

// END SCORE UPDATE

// Use counter for pseduo random scattering

// generate a 1 Hz signal
reg [3:0] A, B, C ;
reg tempclk;
reg [32:0] counter2;
wire time_signal;
initial
begin
	tempclk=1'b0;
	counter2 = 32'b0;
	A=0;
	B=0;
	C=0;
end

   always @ (posedge i_clk)
begin


    
	

begin

	if(counter2 == 32'd49999999 )
		begin
			tempclk <= 1;
			counter2 <= 0;
		
		end else begin
			counter2 <= counter2 + 1;
			tempclk <= 0;
		end
	


end
end
assign time_signal = tempclk;

// Counting upwards

always @ (posedge i_clk)

begin

        if (i_rst)  // on reset return to starting position
        begin
         A<=0;
			B<=0;
			C<=0;
				
			end
if(time_signal)
begin
if(C!=9)
begin
C <= C+1;
end
if((C==9)&&(B!=9))
begin
B <= B+1;
C <= 0;
end
if((B==9)&&(A!=9)&&(C==9))
begin
A <= A+1;
B<=0;
C<=0;
end
if((A==9)&&(B==9)&&(C==9))
begin
A<=0;
B<=0;
C<=0;
end
end
end



endmodule
