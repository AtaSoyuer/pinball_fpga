module counter (input wire i_clk,         // base clock
						input wire i_ani_stb, finish,     // animation clock: pixel clock is 1 pix/frame
						input wire i_rst,         // reset: returns animation to starting position
						input wire i_animate,     // animate when input is high
						input [9:0] x, y,
						output reg k0,k1,k2,k3,k4,k5,k6,
						output reg l0,l1,l2,l3,l4,l5,l6,
						output reg m0,m1,m2,m3,m4,m5,m6,
						output reg [3:0] Crnd
						 );
						 
						 
// generate a 1 Hz signal
reg [3:0] A, B, C ;
reg tempclk;
reg [32:0] counter;
wire time_signal;
initial
begin
	tempclk=1'b0;
	counter = 32'b0;
	A=0;
	B=0;
	C=0;
end

   always @ (posedge i_clk)
begin


    
	

begin

	if(counter == 32'd49999999 )
		begin
			tempclk <= 1;
			counter <= 0;
		
		end else begin
			counter <= counter + 1;
			tempclk <= 0;
		end
	


end
end
assign time_signal = tempclk;

// Counting upwards

always @ (posedge i_clk)

begin

        if (i_rst  || finish)  // on reset return to starting position
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
Crnd <= C;
end




//End of counter
	

// Seven segment creation	
always @ (posedge i_clk)
begin
case (A)
0:
begin 
k0=((x>=535)&&(x<=560)&&(y==50));
k1=((y>=50)&&(y<=75)&&(x==560));
k2=((y>=75)&&(y<=100)&&(x==560));
k3=((x>=535)&&(x<=560)&&(y==100));
k4=((y>=75)&&(y<=100)&&(x==535));
k5=((y>=50)&&(y<=75)&&(x==535));
k6= 0;
end
1:
begin 
k0=0;
k1=((y>=50)&&(y<=75)&&(x==560));
k2=((y>=75)&&(y<=100)&&(x==560));
k3=0;
k4=0;
k5=0;
k6=0;
end
2:
begin 
k0=((x>=535)&&(x<=560)&&(y==50));
k1=((y>=50)&&(y<=75)&&(x==560));
k2=0;
k3=((x>=535)&&(x<=560)&&(y==100));
k4=((y>=75)&&(y<=100)&&(x==535));
k5=0;
k6=((x>=535)&&(x<=560)&&(y==75));
end
3:
begin 
k0=((x>=535)&&(x<=560)&&(y==50));
k1=((y>=50)&&(y<=75)&&(x==560));
k2=((y>=75)&&(y<=100)&&(x==560));
k3=((x>=535)&&(x<=560)&&(y==100));
k4=0;
k5=0;
k6=((x>=535)&&(x<=560)&&(y==75));
end
4:
begin 
k0=0;
k1=((y>=50)&&(y<=75)&&(x==560));
k2=((y>=75)&&(y<=100)&&(x==560));
k3=0;
k4=0;
k5=((y>=50)&&(y<=75)&&(x==535));
k6=((x>=535)&&(x<=560)&&(y==75));
end
5:
begin 
k0=((x>=535)&&(x<=560)&&(y==50));
k1=0;
k2=((y>=75)&&(y<=100)&&(x==560));
k3=((x>=535)&&(x<=560)&&(y==100));
k4=0;
k5=((y>=50)&&(y<=75)&&(x==535));
k6=((x>=535)&&(x<=560)&&(y==75));
end
6:
begin 
k0=((x>=535)&&(x<=560)&&(y==50));
k1=0;
k2=((y>=75)&&(y<=100)&&(x==560));
k3=((x>=535)&&(x<=560)&&(y==100));
k4=((y>=75)&&(y<=100)&&(x==535));
k5=((y>=50)&&(y<=75)&&(x==535));
k6=((x>=535)&&(x<=560)&&(y==75));
end
7:
begin 
k0=((x>=535)&&(x<=560)&&(y==50));
k1=((y>=50)&&(y<=75)&&(x==560));
k2=((y>=75)&&(y<=100)&&(x==560));
k3=0;
k4=0;
k5=0;
k6=0;
end
8:
begin 
k0=((x>=535)&&(x<=560)&&(y==50));
k1=((y>=50)&&(y<=75)&&(x==560));
k2=((y>=75)&&(y<=100)&&(x==560));
k3=((x>=535)&&(x<=560)&&(y==100));
k4=((y>=75)&&(y<=100)&&(x==535));
k5=((y>=50)&&(y<=75)&&(x==535));
k6=((x>=535)&&(x<=560)&&(y==75));
end
9:
begin 
k0=((x>=535)&&(x<=560)&&(y==50));
k1=((y>=50)&&(y<=75)&&(x==560));
k2=((y>=75)&&(y<=100)&&(x==560));
k3=((x>=535)&&(x<=560)&&(y==100));
k4=0;
k5=((y>=50)&&(y<=75)&&(x==535));
k6=((x>=535)&&(x<=560)&&(y==75));
end
endcase
end


						 
always @ (posedge i_clk)
begin


case (B)
0:
begin 
l0=((x>=570)&&(x<=595)&&(y==50));
l1=((y>=50)&&(y<=75)&&(x==595));
l2=((y>=75)&&(y<=100)&&(x==595));
l3=((x>=570)&&(x<=595)&&(y==100));
l4=((y>=75)&&(y<=100)&&(x==570));
l5=((y>=50)&&(y<=75)&&(x==570));
l6=0;
end
1:
begin 
l0=0;
l1=((y>=50)&&(y<=75)&&(x==595));
l2=((y>=75)&&(y<=100)&&(x==595));
l3=0;
l4=0;
l5=0;
l6=0;
end
2:
begin 
l0=((x>=570)&&(x<=595)&&(y==50));
l1=((y>=50)&&(y<=75)&&(x==595));
l2=0;
l3=((x>=570)&&(x<=595)&&(y==100));
l4=((y>=75)&&(y<=100)&&(x==570));
l5=0;
l6=((x>=570)&&(x<=595)&&(y==75));
end
3:
begin 
l0=((x>=570)&&(x<=595)&&(y==50));
l1=((y>=50)&&(y<=75)&&(x==595));
l2=((y>=75)&&(y<=100)&&(x==595));
l3=((x>=570)&&(x<=595)&&(y==100));
l4=0;
l5=0;
l6=((x>=570)&&(x<=595)&&(y==75));
end
4:
begin 
l0=0;
l1=((y>=50)&&(y<=75)&&(x==595));
l2=((y>=75)&&(y<=100)&&(x==595));
l3=0;
l4=0;
l5=((y>=50)&&(y<=75)&&(x==570));
l6=((x>=570)&&(x<=595)&&(y==75));
end
5:
begin 
l0=((x>=570)&&(x<=595)&&(y==50));
l1=0;
l2=((y>=75)&&(y<=100)&&(x==595));
l3=((x>=570)&&(x<=595)&&(y==100));
l4=0;
l5=((y>=50)&&(y<=75)&&(x==570));
l6=((x>=570)&&(x<=595)&&(y==75));
end
6:
begin 
l0=((x>=570)&&(x<=595)&&(y==50));
l1=0;
l2=((y>=75)&&(y<=100)&&(x==595));
l3=((x>=570)&&(x<=595)&&(y==100));
l4=((y>=75)&&(y<=100)&&(x==570));
l5=((y>=50)&&(y<=75)&&(x==570));
l6=((x>=570)&&(x<=595)&&(y==75));
end
7:
begin 
l0=((x>=570)&&(x<=595)&&(y==50));
l1=((y>=50)&&(y<=75)&&(x==595));
l2=((y>=75)&&(y<=100)&&(x==595));
l3=0;
l4=0;
l5=0;
l6=0;
end
8:
begin 
l0=((x>=570)&&(x<=595)&&(y==50));
l1=((y>=50)&&(y<=75)&&(x==595));
l2=((y>=75)&&(y<=100)&&(x==595));
l3=((x>=570)&&(x<=595)&&(y==100));
l4=((y>=75)&&(y<=100)&&(x==570));
l5=((y>=50)&&(y<=75)&&(x==570));
l6=((x>=570)&&(x<=595)&&(y==75));
end
9:
begin 
l0=((x>=570)&&(x<=595)&&(y==50));
l1=((y>=50)&&(y<=75)&&(x==595));
l2=((y>=75)&&(y<=100)&&(x==595));
l3=((x>=570)&&(x<=595)&&(y==100));
l4=0;
l5=((y>=50)&&(y<=75)&&(x==570));
l6=((x>=570)&&(x<=595)&&(y==75));
end
endcase
end



always @ (posedge i_clk)
begin

case (C)
0:
begin 
m0=((x>=605)&&(x<=630)&&(y==50));
m1=((y>=50)&&(y<=75)&&(x==630));
m2=((y>=75)&&(y<=100)&&(x==630));
m3=((x>=605)&&(x<=630)&&(y==100));
m4=((y>=75)&&(y<=100)&&(x==605));
m5=((y>=50)&&(y<=75)&&(x==605));
m6=0;
end
1:
begin 
m0=0;
m1=((y>=50)&&(y<=75)&&(x==630));
m2=((y>=75)&&(y<=100)&&(x==630));
m3=0;
m4=0;
m5=0;
m6=0;
end
2:
begin 
m0=((x>=605)&&(x<=630)&&(y==50));
m1=((y>=50)&&(y<=75)&&(x==630));
m2=0;
m3=((x>=605)&&(x<=630)&&(y==100));
m4=((y>=75)&&(y<=100)&&(x==605));
m5=0;
m6=((x>=605)&&(x<=630)&&(y==75));
end
3:
begin 
m0=((x>=605)&&(x<=630)&&(y==50));
m1=((y>=50)&&(y<=75)&&(x==630));
m2=((y>=75)&&(y<=100)&&(x==630));
m3=((x>=605)&&(x<=630)&&(y==100));
m4=0;
m5=0;
m6=((x>=605)&&(x<=630)&&(y==75));
end
4:
begin 
m0=0;
m1=((y>=50)&&(y<=75)&&(x==630));
m2=((y>=75)&&(y<=100)&&(x==630));
m3=0;
m4=0;
m5=((y>=50)&&(y<=75)&&(x==605));
m6=((x>=605)&&(x<=630)&&(y==75));
end
5:
begin 
m0=((x>=605)&&(x<=630)&&(y==50));
m1=0;
m2=((y>=75)&&(y<=100)&&(x==630));
m3=((x>=605)&&(x<=630)&&(y==100));
m4=0;
m5=((y>=50)&&(y<=75)&&(x==605));
m6=((x>=605)&&(x<=630)&&(y==75));
end
6:
begin 
m0=((x>=605)&&(x<=630)&&(y==50));
m1=0;
m2=((y>=75)&&(y<=100)&&(x==630));
m3=((x>=605)&&(x<=630)&&(y==100));
m4=((y>=75)&&(y<=100)&&(x==605));
m5=((y>=50)&&(y<=75)&&(x==605));
m6=((x>=605)&&(x<=630)&&(y==75));
end
7:
begin 
m0=((x>=605)&&(x<=630)&&(y==50));
m1=((y>=50)&&(y<=75)&&(x==630));
m2=((y>=75)&&(y<=100)&&(x==630));
m3=0;
m4=0;
m5=0;
m6=0;
end
8:
begin 
m0=((x>=605)&&(x<=630)&&(y==50));
m1=((y>=50)&&(y<=75)&&(x==630));
m2=((y>=75)&&(y<=100)&&(x==630));
m3=((x>=605)&&(x<=630)&&(y==100));
m4=((y>=75)&&(y<=100)&&(x==605));
m5=((y>=50)&&(y<=75)&&(x==605));
m6=((x>=605)&&(x<=630)&&(y==75));
end
9:
begin 
m0=((x>=605)&&(x<=630)&&(y==50));
m1=((y>=50)&&(y<=75)&&(x==630));
m2=((y>=75)&&(y<=100)&&(x==630));
m3=((x>=605)&&(x<=630)&&(y==100));
m4=0;
m5=((y>=50)&&(y<=75)&&(x==605));
m6=((x>=605)&&(x<=630)&&(y==75));
end
endcase
end					 
endmodule						 