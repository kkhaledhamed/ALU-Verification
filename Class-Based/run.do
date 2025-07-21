vlib work
vlog -f ALU.list +cover -covercells
vsim -voptargs=+acc work.ALU_tb -cover
add wave /ALU_tb/ALU_if/*
coverage save ALU_tb.ucdb -onexit
#coverage exclude -src alu.sv -line 14 -code s
run -all
vcover report ALU_tb.ucdb -details -annotate -all -output ALU_cover_report.txt