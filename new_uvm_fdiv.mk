# Variables
TBTOP       = uvm_tb/uvm_tb_div/tb_float_div
SRCDIR      = src/half_precision/addition
AGENTDIR    = uvm_tb/uvm_tb_div/fdiv_agent
INCDIR      = +incdir+$(SRCDIR)+include+$(AGENTDIR)
DPI_SRC     = uvm_tb/uvm_tb_div/dpi.c
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
run_base:            TESTNAME=base_test
run_NaN:             TESTNAME=NaN_test
run_pos_pos:         TESTNAME=pos_pos_test
run_neg_neg:         TESTNAME=neg_neg_test
run_pos_neg:         TESTNAME=pos_neg_test
run_neg_pos_div:     TESTNAME=neg_pos_div_test
run_zero_num_div:    TESTNAME=zero_num_div_test
run_div_by_zero:     TESTNAME=div_by_zero_test
run_zero_zero_div:   TESTNAME=zero_zero_div_test
run_NaN_div:         TESTNAME=NaN_div_test
run_inf_div:         TESTNAME=Inf_div_test
run_norm_div_inf:    TESTNAME=norm_div_Inf_test
run_inf_inf_div:     TESTNAME=Inf_Inf_div_test
run_overflow_div:    TESTNAME=overflow_div_test
run_underflow_div:   TESTNAME=underflow_div_test
run_norm_norm:       TESTNAME=norm_norm_test
run_sub_sub:         TESTNAME=sub_sub_test
run_norm_sub:        TESTNAME=norm_sub_test
run_zero:            TESTNAME=Zero_test
run_inf:             TESTNAME=Inf_test
run_zero_inf:        TESTNAME=Zero_Inf_test
run_overflow:        TESTNAME=overflow_test

# Aggregate “phony” target to launch any of the above
run_base run_NaN run_pos_pos run_neg_neg run_pos_neg \
run_neg_pos_div run_zero_num_div run_div_by_zero run_zero_zero_div \
run_NaN_div run_inf_div run_norm_div_inf run_inf_inf_div \
run_overflow_div run_underflow_div run_norm_norm run_sub_sub \
run_norm_sub run_zero run_inf run_zero_inf run_overflow:
	$(MAKE) run TESTNAME=$(TESTNAME)
