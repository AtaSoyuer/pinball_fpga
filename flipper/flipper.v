module flipper (input wire i_clk,         // base clock
						input wire flipperbutton,
						input wire i_ani_stb,     // animation clock: pixel clock is 1 pix/frame
						input wire i_rst,         // reset: returns animation to starting position
						input wire i_animate,     // animate when input is high
						output reg [31:0] tantetavar,  // Tangent of the Angle of the flipper
						output reg [31:0] ycenter,
						output reg [31:0] xcenter,
						output reg [8:0] angle
						);

						





always @ (posedge i_clk)
    begin
        if (i_rst)  // on reset return to starting position
        begin
            angle <= 8'd0;
         end  
           

case (angle)
			 
8'd90: tantetavar <= 32'd1000000;
8'd85: tantetavar <= 32'd839099;
8'd80: tantetavar <= 32'd700207;
8'd75: tantetavar <= 32'd577350;
8'd70: tantetavar <= 32'd466307;
8'd65: tantetavar <= 32'd363970;
8'd60: tantetavar <= 32'd267949;
8'd55: tantetavar <= 32'd176326;
8'd50: tantetavar <= 32'd87488;
8'd45: tantetavar <= 32'd0;
8'd40: tantetavar <= 32'd87488;
8'd35: tantetavar <= 32'd176326;
8'd30: tantetavar <= 32'd267949;
8'd25: tantetavar <= 32'd363970;
8'd20: tantetavar <= 32'd466307;
8'd15: tantetavar <= 32'd577350;
8'd10: tantetavar <= 32'd700207;
8'd5: tantetavar <=32'd839099;
8'd0: tantetavar <= 32'd1000000;
						
						  
						  
        endcase
		  
        if (i_animate&& i_ani_stb)   
	  begin
		 
		  
		  
		  if((angle != 8'd90) && (!flipperbutton))
		  begin
		  angle <= (angle + 8'd5);
		  end
		  if((angle != 8'd0) && (flipperbutton))
		  begin
		  angle <= (angle - 8'd5);
		  end
		  
		 
end		 		 

		  
    end
	 
endmodule					
						