onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /processor/clk
add wave -noupdate /processor/clk_mem
add wave -noupdate -radix hexadecimal /processor/addr
add wave -noupdate -radix hexadecimal /processor/data_in
add wave -noupdate -radix hexadecimal /processor/data
add wave -noupdate /processor/read
add wave -noupdate /processor/write
add wave -noupdate -radix hexadecimal /processor/data_ram
add wave -noupdate -radix hexadecimal /processor/addr_ram
add wave -noupdate /processor/cmplt
add wave -noupdate /processor/rd_ram
add wave -noupdate /processor/wrt_ram
add wave -noupdate /processor/wrt_bck
add wave -noupdate /processor/fetch
add wave -noupdate -radix hexadecimal {/processor/C1/ram[0]}
add wave -noupdate -radix hexadecimal {/processor/C1/tag[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {225 ns} 0}
configure wave -namecolwidth 148
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
WaveRestoreZoom {78 ns} {203 ns}
