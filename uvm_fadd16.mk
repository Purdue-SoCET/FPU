ifeq (0,1)
Command to run UVM:
Step1 : make -f uvm_fadd16.mk build
Step2 : make -f uvm_fadd16.mk <test_case> (replace test_case in following test_case list, no need <> when running)

test_case list(every case repeat 100000 now):
1. run: 100000 random testcases
2. run_NaN_test: NaN +/- finite num
3. run_pos_pos_test: Postive finite +/- Postive finite 
4. run_neg_neg_test: Negative finite +/- Negative finite 
5. run_pos_neg_test: Postive finite +/- Negative finite
6. run_norm_norm_test: Normal  +/- Normal 
7. run_sub_sub_test: Subnormal +/- Subnormal
8. run_norm_sub_test: Normal  +/- Subnormal
9. run_Zero_test: Zero +/- finite
10. run_Inf_test: Inf +/- finite
11. run_Inf_Inf_test: Inf +/- Inf
12. run_self_test: Self +/- Self
13. run_overflow_test: Maximum Normal +/- finite

After running, see transcript for the result will be more clear
(If there are some Make error, try: make -f uvm_fadd16.mk clean)
endif

# Makefile
TB = uvm_tb/uvm_tb_add
TOP = $(TB)/tb_float_add_16bit.sv
AGENT = $(TB)/fadd16_agent
RTL = src/half_precision/addition/float_add.sv

build:
	vlog +incdir+src/half_precision/addition \
	+incdir+include \
	+incdir+$(AGENT) \
	+acc \
	+cover \
	-L $$QUESTA_HOME/uvm-1.2 $(FADD16) $(TOP) \
	-logfile tb_compile.log \
	-printinfilenames=file_search.log

# run for 100000 random testcases now
run: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="base_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "run -all" &
#-do "coverage save -onexit coverage.ucdb"
#-do "do uvm_tb/fadd.do"

run_NaN_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="NaN_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &

run_pos_pos_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="pos_pos_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &

run_neg_neg_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="neg_neg_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &	
	
run_pos_neg_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="pos_neg_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &

run_norm_norm_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="norm_norm_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &

run_sub_sub_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="sub_sub_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &

run_norm_sub_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="norm_sub_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &

run_Zero_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="Zero_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &		

run_Inf_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="Inf_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &	

run_Inf_Inf_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="Inf_Inf_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &	

run_self_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="self_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &	

run_overflow_test: build
	vsim -c tb_float_add_16bit -L \
	$$QUESTA_HOME/uvm-1.2 \
	-voptargs=+acc \
	-coverage \
	+UVM_TESTNAME="overflow_test" \
	+UVM_VERBOSITY=UVM_LOW \
	-do "coverage save -onexit coverage.ucdb" -do "do uvm_tb/fadd.do" -do "run -all" &	

run_gui:
	vsim -i tb_float_add_16bit -L \
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
