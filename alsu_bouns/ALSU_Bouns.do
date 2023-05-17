vlib work
vlog ALSU.v convert.v ALSU_Bouns.v ALSU_Bouns_tb.v
vsim -voptargs=+acc work.ALSU_Bouns_tb
add wave *
run -all