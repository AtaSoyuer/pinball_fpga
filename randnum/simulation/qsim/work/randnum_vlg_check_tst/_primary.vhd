library verilog;
use verilog.vl_types.all;
entity randnum_vlg_check_tst is
    port(
        random          : in     vl_logic_vector(8 downto 0);
        sampler_rx      : in     vl_logic
    );
end randnum_vlg_check_tst;
