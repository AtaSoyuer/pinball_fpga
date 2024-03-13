module clk_en (input CLK,
					output clkenable);

reg tempclk;

initial
begin
tempclk=1'b0;
end

always @ (posedge CLK)
begin
tempclk <= ~tempclk;
end

assign clkenable=tempclk;

endmodule
