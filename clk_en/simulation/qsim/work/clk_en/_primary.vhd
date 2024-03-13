library verilog;
use verilog.vl_types.all;
entity clk_en is
    port(
        CLK             : in     vl_logic;
        clkenable       : out    vl_logic
    );
end clk_en;
