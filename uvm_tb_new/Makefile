# Makefile for FPU UVM Testbench
SIM ?= vsim
COMP ?= vlog

# All SV files
SRCS = fpu_uvm_pkg.sv tb_top.sv fifo_buffer.sv

# Compile
compile:
	$(COMP) +acc $(SRCS)

# Run simulation
run: compile
	$(SIM) -c tb_top -do "run -all; quit"

# Clean
clean:
	rm -rf work transcript vsim.wlf
