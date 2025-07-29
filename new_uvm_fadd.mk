# Variables
TBTOP       = uvm_tb/uvm_tb_add/tb_float_add
SRCDIR      = src/half_precision/addition
AGENTDIR    = uvm_tb/uvm_tb_add/fadd_agent
INCDIR      = +incdir+$(SRCDIR)+include+$(AGENTDIR)
DPI_SRC     = uvm_tb/uvm_tb_add/dpi.c
DPI_LIB     = dpi_lib
VERBOSITY   = UVM_LOW
QUESTA_HOME ?= /package/eda/mg/questa2021.4/questasim

# Default test
TESTNAME    ?= base_test

# Targets
all: dpi build run_gui

dpi:
	@gcc -O3 -std=c99 -g -Wall -Wshadow -Wvla -pedantic -Werror \
		-fPIC -shared -I$(QUESTA_HOME)/include/ \
		$(DPI_SRC) -o $(DPI_LIB).so

build:
	@echo "Building testbench and DUT..."
	vlog $(INCDIR) +acc +cover \
		-L $(QUESTA_HOME)/uvm-1.2 \
		$(TBTOP).sv \
		-logfile tb_compile.log \
		-printinfilenames=file_search.log

run: build
	vsim -c -sv_lib $(DPI_LIB) $(notdir $(TBTOP)) -L $(QUESTA_HOME)/uvm-1.2 \
		-voptargs=+acc -coverage \
		+UVM_TESTNAME="$(TESTNAME)" \
		+UVM_VERBOSITY=$(VERBOSITY) \
		-do "coverage save -onexit coverage.ucdb" \
		-do "do uvm_tb/fadd.do" \
		-do "run -all" &

run_gui: build
	@echo "Running simulation in GUI mode..."
	vsim -i -sv_lib $(DPI_LIB) $(notdir $(TBTOP)) -L $(QUESTA_HOME)/uvm-1.2 \
		-voptargs=+acc -coverage \
		+UVM_TESTNAME="$(TESTNAME)" \
		+UVM_VERBOSITY=$(VERBOSITY) \
		-do "coverage save -onexit coverage.ucdb" \
		-do "do wave.do" \
		-do "run -all" &

view_cov:
	vsim -viewcov coverage.ucdb

clean:
	@echo "Cleaning up..."
	rm -rf work covhtmlreport
	rm -f *.log transcript *.ucdb *.wlf *.vstf
	rm -f $(DPI_LIB).so

.PHONY: all dpi build run run_gui view_cov clean

# Individual test aliases
run_base:        TESTNAME=base_test
run_NaN:         TESTNAME=NaN_test
run_pos_pos:     TESTNAME=pos_pos_test
run_neg_neg:     TESTNAME=neg_neg_test
run_pos_neg:     TESTNAME=pos_neg_test
run_norm_norm:   TESTNAME=norm_norm_test
run_sub_sub:     TESTNAME=sub_sub_test
run_norm_sub:    TESTNAME=norm_sub_test
run_zero:        TESTNAME=Zero_test
run_inf:         TESTNAME=Inf_test
run_inf_inf:     TESTNAME=Inf_Inf_test
run_self:        TESTNAME=self_test
run_overflow:    TESTNAME=overflow_test

run_base run_NaN run_pos_pos run_neg_neg run_pos_neg run_norm_norm run_sub_sub run_norm_sub run_zero run_inf run_inf_inf run_self run_overflow:
	$(MAKE) run TESTNAME=$(TESTNAME)
