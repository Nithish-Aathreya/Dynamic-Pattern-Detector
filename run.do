vlog tb_dynamic.v
# vlog fixed_pattern_tb.v
vsim tb
add wave -position insertpoint sim:/tb/dut/*
run -all
