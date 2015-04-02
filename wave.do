onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cache_tb/clk
add wave -noupdate -radix hexadecimal /cache_tb/addr
add wave -noupdate -radix hexadecimal /cache_tb/data_in
add wave -noupdate /cache_tb/read
add wave -noupdate /cache_tb/write
add wave -noupdate /cache_tb/cmplt
add wave -noupdate -radix hexadecimal -childformat {{{/cache_tb/data[7]} -radix hexadecimal} {{/cache_tb/data[6]} -radix hexadecimal} {{/cache_tb/data[5]} -radix hexadecimal} {{/cache_tb/data[4]} -radix hexadecimal} {{/cache_tb/data[3]} -radix hexadecimal} {{/cache_tb/data[2]} -radix hexadecimal} {{/cache_tb/data[1]} -radix hexadecimal} {{/cache_tb/data[0]} -radix hexadecimal}} -subitemconfig {{/cache_tb/data[7]} {-height 15 -radix hexadecimal} {/cache_tb/data[6]} {-height 15 -radix hexadecimal} {/cache_tb/data[5]} {-height 15 -radix hexadecimal} {/cache_tb/data[4]} {-height 15 -radix hexadecimal} {/cache_tb/data[3]} {-height 15 -radix hexadecimal} {/cache_tb/data[2]} {-height 15 -radix hexadecimal} {/cache_tb/data[1]} {-height 15 -radix hexadecimal} {/cache_tb/data[0]} {-height 15 -radix hexadecimal}} /cache_tb/data
add wave -noupdate -radix hexadecimal /cache_tb/data_in
add wave -noupdate /cache_tb/rd_ram
add wave -noupdate /cache_tb/wrt_ram
add wave -noupdate /cache_tb/wrt_bck
add wave -noupdate /cache_tb/fetch
add wave -noupdate -radix hexadecimal /cache_tb/data_ram
add wave -noupdate -radix hexadecimal /cache_tb/addr_ram
add wave -noupdate -radix symbolic /cache_tb/C1/state
add wave -noupdate -radix hexadecimal {/cache_tb/C1/ram[0]}
add wave -noupdate -radix hexadecimal {/cache_tb/C1/ram[1]}
add wave -noupdate {/cache_tb/C1/update[1]}
add wave -noupdate {/cache_tb/C1/update[0]}
add wave -noupdate -radix hexadecimal {/cache_tb/C1/tag[1]}
add wave -noupdate -radix hexadecimal -childformat {{{/cache_tb/C1/tag[0][7]} -radix hexadecimal} {{/cache_tb/C1/tag[0][6]} -radix hexadecimal} {{/cache_tb/C1/tag[0][5]} -radix hexadecimal} {{/cache_tb/C1/tag[0][4]} -radix hexadecimal} {{/cache_tb/C1/tag[0][3]} -radix hexadecimal} {{/cache_tb/C1/tag[0][2]} -radix hexadecimal} {{/cache_tb/C1/tag[0][1]} -radix hexadecimal} {{/cache_tb/C1/tag[0][0]} -radix hexadecimal}} -subitemconfig {{/cache_tb/C1/tag[0][7]} {-height 15 -radix hexadecimal} {/cache_tb/C1/tag[0][6]} {-height 15 -radix hexadecimal} {/cache_tb/C1/tag[0][5]} {-height 15 -radix hexadecimal} {/cache_tb/C1/tag[0][4]} {-height 15 -radix hexadecimal} {/cache_tb/C1/tag[0][3]} {-height 15 -radix hexadecimal} {/cache_tb/C1/tag[0][2]} {-height 15 -radix hexadecimal} {/cache_tb/C1/tag[0][1]} {-height 15 -radix hexadecimal} {/cache_tb/C1/tag[0][0]} {-height 15 -radix hexadecimal}} {/cache_tb/C1/tag[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {245 ns} 0}
configure wave -namecolwidth 150
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
WaveRestoreZoom {89 ns} {219 ns}
