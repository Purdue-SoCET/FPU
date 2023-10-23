# Makefile for convenience

# target to download/update libraries for FuseSoC
update-libraries:
	#fusesoc library add fusesoc-cores https://github.com/fusesoc/fusesoc-cores
	#fusesoc library add digital-lib https://github.com/Purdue-SoCET/digital-lib
	#fusesoc library add bus-components https://github.com/Purdue-SoCET/bus-components
	#fusesoc library update

# targets for top-level design
fpu: clean
	fusesoc --cores-root . run --target sim --tool verilator socet:aft:fpu

fpu_wave: fpu
	gtkwave build/socet_aft_fpu_0.1.0/sim-verilator/waveform_fpu.fst gtkw/fpu.gtkw &

# targets for multiplier
multiply: clean
	fusesoc --cores-root . run --target sim_multiply --tool verilator socet:aft:fpu

multiply_wave: multiply
	gtkwave build/socet_aft_fpu_0.1.0/sim_multiply-verilator/waveform_multiply.fst gtkw/multiply.gtkw &

# targets for adder
add: clean
	fusesoc --cores-root . run --target sim_add --tool verilator socet:aft:fpu

add_wave: add
	gtkwave build/socet_aft_fpu_0.1.0/sim_add-verilator/waveform_add.fst gtkw/add.gtkw &

# clean targets
clean:
	rm -rf build/