`ifndef ENVIRONMENT_SVH
`define ENVIRONMENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "float_add_16bit_if.svh"
`include "fadd16_agent.svh"
`include "fadd16_scoreboard.svh" // uvm_scoreboard
`include "transaction.svh" // uvm_sequence_item
`include "coverage.svh"

class environment extends uvm_env;
  `uvm_component_utils(environment)
  
    fadd16_agent agt; // contains monitor and driver and sequencer
    fadd16_scoreboard scrb; // scoreboard
    // coverage cov;

    function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
        //`uvm_info("environment","environment construct",UVM_LOW);
	endfunction

    function void build_phase(uvm_phase phase);
        agt = fadd16_agent::type_id::create("agt", this);
        scrb = fadd16_scoreboard::type_id::create("scrb", this);
        // cov = coverage::type_id::create("cov",this);
        //`uvm_info("environment","environment build",UVM_LOW);
    endfunction

    function void connect_phase(uvm_phase phase);
        //connect to scoreboard for compared
        agt.mon.result_ap.connect(scrb.actual_result);
        //connect to generate coverage
        // agt.mon.result_ap.connect(cov.analysis_imp_outp);
        //`uvm_info("environment","environment connect",UVM_LOW);
    endfunction

endclass
`endif
