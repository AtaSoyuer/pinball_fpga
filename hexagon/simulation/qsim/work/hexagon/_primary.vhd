library verilog;
use verilog.vl_types.all;
entity hexagon is
    port(
        x               : in     vl_logic_vector(9 downto 0);
        xcenter         : in     vl_logic_vector(9 downto 0);
        y               : in     vl_logic_vector(9 downto 0);
        ycenter         : in     vl_logic_vector(9 downto 0);
        d               : in     vl_logic_vector(9 downto 0);
        hexagon         : out    vl_logic
    );
end hexagon;
