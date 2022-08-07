onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /circular_buffer_tb/u_circular_buffer/BUFF_SIZE
add wave -noupdate /circular_buffer_tb/u_circular_buffer/DATA_WIDTH
add wave -noupdate /circular_buffer_tb/u_circular_buffer/ADDR_SIZE
add wave -noupdate /circular_buffer_tb/u_circular_buffer/MAX_POS
add wave -noupdate -divider params
add wave -noupdate /circular_buffer_tb/u_circular_buffer/clk
add wave -noupdate /circular_buffer_tb/u_circular_buffer/arst_n
add wave -noupdate -divider pt
add wave -noupdate /circular_buffer_tb/u_circular_buffer/rd_pt
add wave -noupdate /circular_buffer_tb/u_circular_buffer/wr_pt
add wave -noupdate -divider data
add wave -noupdate /circular_buffer_tb/u_circular_buffer/wr_en_i
add wave -noupdate -radix decimal /circular_buffer_tb/u_circular_buffer/data_in_i
add wave -noupdate /circular_buffer_tb/u_circular_buffer/rd_en_i
add wave -noupdate -radix decimal /circular_buffer_tb/u_circular_buffer/data_out_o
add wave -noupdate -divider state
add wave -noupdate /circular_buffer_tb/u_circular_buffer/empty_o
add wave -noupdate /circular_buffer_tb/u_circular_buffer/full_o
add wave -noupdate -radix decimal -childformat {{{/circular_buffer_tb/u_circular_buffer/internal_buffer[2]} -radix decimal} {{/circular_buffer_tb/u_circular_buffer/internal_buffer[1]} -radix decimal} {{/circular_buffer_tb/u_circular_buffer/internal_buffer[0]} -radix decimal}} -subitemconfig {{/circular_buffer_tb/u_circular_buffer/internal_buffer[2]} {-height 17 -radix decimal} {/circular_buffer_tb/u_circular_buffer/internal_buffer[1]} {-height 17 -radix decimal} {/circular_buffer_tb/u_circular_buffer/internal_buffer[0]} {-height 17 -radix decimal}} /circular_buffer_tb/u_circular_buffer/internal_buffer
add wave -noupdate /circular_buffer_tb/u_circular_buffer_depth/internal_buffer
add wave -noupdate -divider compare
add wave -noupdate -radix decimal /circular_buffer_tb/u_circular_buffer/data_out_o
add wave -noupdate -radix decimal /circular_buffer_tb/u_circular_buffer_depth/data_out_o
add wave -noupdate /circular_buffer_tb/u_circular_buffer/empty_o
add wave -noupdate /circular_buffer_tb/u_circular_buffer_depth/empty_o
add wave -noupdate /circular_buffer_tb/u_circular_buffer/full_o
add wave -noupdate /circular_buffer_tb/u_circular_buffer_depth/full_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 306
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
WaveRestoreZoom {15 ps} {36 ps}
