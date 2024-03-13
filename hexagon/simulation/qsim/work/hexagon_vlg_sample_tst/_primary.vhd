library verilog;
use verilog.vl_types.all;
entity hexagon_vlg_sample_tst is
    port(
        d               : in     vl_logic_vector(9 downto 0);
        x               : in     vl_logic_vector(9 downto 0);
        xcenter         : in     vl_logic_vector(9 downto 0);
        y               : in     vl_logic_vector(9 downto 0);
        ycenter         : in     vl_logic_vector(9 downto 0);
        sampler_tx      : out    vl_logic
    );
end hexagon_vlg_sample_tst;
