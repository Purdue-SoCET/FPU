# Makefile for convenience

# target to download/update libraries for FuseSoC
update-libraries:
	fusesoc library add fusesoc-cores https://github.com/fusesoc/fusesoc-cores
	fusesoc library add digital-lib https://github.com/Purdue-SoCET/digital-lib
	fusesoc library add bus-components https://github.com/Purdue-SoCET/bus-components
	fusesoc library update

# targets for top-level design
uart: clean
	fusesoc --cores-root . run --target sim --tool verilator socet:aft:uart

uart_wave: uart
	gtkwave build/socet_aft_uart_0.1.0/sim-verilator/waveform_uart.fst &

# targets for receiver block
rcv_block: clean
	fusesoc --cores-root . run --target sim_rcv_block --tool verilator socet:aft:uart

rcv_block_wave: rcv_block
	gtkwave build/socet_aft_uart_0.1.0/sim_rcv_block-verilator/waveform_rcv_block.fst gtkw/rcv_block.gtkw &

# clean targets
clean:
	rm -rf build/