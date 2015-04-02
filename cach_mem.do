onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cach_mem_tb/clk
add wave -noupdate /cach_mem_tb/clk_mem
add wave -noupdate -radix hexadecimal /cach_mem_tb/addr
add wave -noupdate -radix hexadecimal /cach_mem_tb/addr_bufout
add wave -noupdate -radix hexadecimal /cach_mem_tb/M1/addr
add wave -noupdate -radix hexadecimal /cach_mem_tb/data_in
add wave -noupdate -radix hexadecimal /cach_mem_tb/data
add wave -noupdate -radix hexadecimal /cach_mem_tb/buf_out
add wave -noupdate -radix hexadecimal /cach_mem_tb/data_ram
add wave -noupdate -radix hexadecimal /cach_mem_tb/addr_ram
add wave -noupdate /cach_mem_tb/read
add wave -noupdate /cach_mem_tb/write
add wave -noupdate /cach_mem_tb/cmplt
add wave -noupdate /cach_mem_tb/rd_ram
add wave -noupdate /cach_mem_tb/wrt_ram
add wave -noupdate /cach_mem_tb/wrt_bck
add wave -noupdate /cach_mem_tb/fetch
add wave -noupdate /cach_mem_tb/C1/state
add wave -noupdate -radix hexadecimal {/cach_mem_tb/C1/ram[0]}
add wave -noupdate -radix hexadecimal {/cach_mem_tb/C1/ram[1]}
add wave -noupdate -radix hexadecimal /cach_mem_tb/C1/data
add wave -noupdate -radix hexadecimal /cach_mem_tb/C1/datain
add wave -noupdate -radix hexadecimal /cach_mem_tb/C1/dataout
add wave -noupdate -radix hexadecimal /cach_mem_tb/M1/data
add wave -noupdate -radix hexadecimal /cach_mem_tb/M1/datain
add wave -noupdate -radix hexadecimal /cach_mem_tb/M1/dataout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {59 ns} 0}
configure wave -namecolwidth 187
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {120 ns}
