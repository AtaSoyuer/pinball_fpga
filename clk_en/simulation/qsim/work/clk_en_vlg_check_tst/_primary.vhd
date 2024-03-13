library verilog;
use verilog.vl_types.all;
entity clk_en_vlg_check_tst is
    port(
        clkenable       : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end clk_en_vlg_check_tst;
