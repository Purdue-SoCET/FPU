onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Coral -itemcolor Orange /tb_float_mult_16bit/fmult16_if/clk
add wave -noupdate /tb_float_mult_16bit/fmult16_if/n_rst
add wave -noupdate /tb_float_mult_16bit/DUT/float1
add wave -noupdate -radix hexadecimal /tb_float_mult_16bit/fmult16_if/float2
add wave -noupdate /tb_float_mult_16bit/DUT/sign1
add wave -noupdate /tb_float_mult_16bit/DUT/sign2
add wave -noupdate /tb_float_mult_16bit/DUT/sign_product
add wave -noupdate /tb_float_mult_16bit/DUT/exp_overflow
add wave -noupdate /tb_float_mult_16bit/DUT/implicit_leading_bit1
add wave -noupdate /tb_float_mult_16bit/DUT/implicit_leading_bit2
add wave -noupdate -radix binary /tb_float_mult_16bit/DUT/exp1
add wave -noupdate -radix binary /tb_float_mult_16bit/DUT/exp2
add wave -noupdate /tb_float_mult_16bit/DUT/exp_product
add wave -noupdate /tb_float_mult_16bit/DUT/mant1
add wave -noupdate /tb_float_mult_16bit/DUT/mant2
add wave -noupdate /tb_float_mult_16bit/DUT/mant_product
add wave -noupdate /tb_float_mult_16bit/DUT/mant_product_full
add wave -noupdate /tb_float_mult_16bit/DUT/zero
add wave -noupdate /tb_float_mult_16bit/DUT/qnan
add wave -noupdate /tb_float_mult_16bit/DUT/snan
add wave -noupdate /tb_float_mult_16bit/DUT/inf
add wave -noupdate /tb_float_mult_16bit/DUT/product
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {87754 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 195
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {51518 ps} {160227 ps}
