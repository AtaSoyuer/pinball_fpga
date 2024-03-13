onerror {exit -code 1}
vlib work
vlog -work work clk_en.vo
vlog -work work test1.vwf.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.clk_en_vlg_vec_tst -voptargs="+acc"
vcd file -direction clk_en.msim.vcd
vcd add -internal clk_en_vlg_vec_tst/*
vcd add -internal clk_en_vlg_vec_tst/i1/*
run -all
quit -f
