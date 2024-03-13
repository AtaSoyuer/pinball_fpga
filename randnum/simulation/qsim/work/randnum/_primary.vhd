library verilog;
use verilog.vl_types.all;
entity randnum is
    port(
        CLK             : in     vl_logic;
        reset           : in     vl_logic;
        random          : out    vl_logic_vector(8 downto 0)
    );
end randnum;
