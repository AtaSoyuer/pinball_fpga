onerror {exit -code 1}
vlib work
vlog -work work hexagon.vo
vlog -work work test2.vwf.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.hexagon_vlg_vec_tst -voptargs="+acc"
vcd file -direction hexagon.msim.vcd
vcd add -internal hexagon_vlg_vec_tst/*
vcd add -internal hexagon_vlg_vec_tst/i1/*
run -all
quit -f
