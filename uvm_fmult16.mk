# step1: make -f uvm_fmult16.mk build
# step2: make -f uvm_fmult16.mk <test_case>

TB = uvm_tb/uvm_tb_mult
TOP = $(TB)/tb_float_mult_16bit.sv
AGENT = $(TB)/fmult16_agent
RTL = src/half_precision/multiplication/float_mult_16bit.sv

build:
	vlog +incdir+src/half_precision/multiplication \
	+incdir+include \
	+incdir+$(AGENT) \
	+acc \
	+cover \
	-L $$QUESTA_HOME/uvm-1.2 $(FMULT16) $(TOP) \
	-logfile tb_compile.log \
	-printinfilenames=file_search.log

run: build
	vsim -c tb_float_mult_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="base_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "do uvm_tb/fmult.do" -do "run -all" &

run_NaN_test: build
	vsim -c tb_float_mult_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="NaN_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fmult.do" -do "run -all" &

run_pos_pos_test: build
	vsim -c tb_float_mult_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="pos_pos_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fmult.do" -do "run -all" &

run_neg_neg_test: build
	vsim -c tb_float_mult_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="neg_neg_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fmult.do" -do "run -all" &	

run_norm_norm_test: build
	vsim -c tb_float_mult_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="norm_norm_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fmult.do" -do "run -all" &

run_sub_sub_test: build
	vsim -c tb_float_mult_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="sub_sub_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fmult.do" -do "run -all" &

run_norm_sub_test: build
	vsim -c tb_float_mult_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="norm_sub_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fmult.do" -do "run -all" &	

run_Zero_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="Zero_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &		

run_Inf_test: build
	vsim -c tb_float_mult_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="Inf_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fmult.do" -do "run -all" &	

run_Inf_Inf_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="Inf_Inf_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &	

run_gui:
	vsim -i tb_float_mult_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="base_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do wave.do" -do "run -all" &

view_cov:
	vsim -viewcov coverage.ucdb

clean:
	rm -rf work
	rm -rf mitll90_Dec2019_all
	rm -rf covhtmlreport
	rm *.log
	rm transcript
	rm *.ucdb
	rm *.wlf
	rm *.vstf

.phony: build, run, run_gui, clean
