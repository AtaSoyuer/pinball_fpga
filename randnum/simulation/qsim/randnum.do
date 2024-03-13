onerror {exit -code 1}
vlib work
vlog -work work randnum.vo
vlog -work work Waveform2.vwf.vt
vsim -novopt -c -t 1ps -L cyclonev_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.randnum_vlg_vec_tst -voptargs="+acc"
vcd file -direction randnum.msim.vcd
vcd add -internal randnum_vlg_vec_tst/*
vcd add -internal randnum_vlg_vec_tst/i1/*
run -all
quit -f
