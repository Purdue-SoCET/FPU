`ifndef ENVIRONMENT_SVH
`define ENVIRONMENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "float_mult_if.svh"
`include "fmult_agent.svh"
`include "fmult_scoreboard.svh" // uvm_scoreboard
`include "transaction.svh" // uvm_sequence_item
`include "coverage.svh"

class environment extends uvm_env;
  `uvm_component_utils(environment)
  
    fmult_agent agt; // contains monitor and driver and sequencer
    fmult_scoreboard scrb; // scoreboard
    // coverage cov;

    function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
        //`uvm_info("environment","environment construct",UVM_LOW);
	endfunction

    function void build_phase(uvm_phase phase);
        agt = fmult_agent::type_id::create("agt", this);
        scrb = fmult_scoreboard::type_id::create("scrb", this);
        // cov = coverage::type_id::create("cov",this);
        //`uvm_info("environment","environment build",UVM_LOW);
    endfunction

    function void connect_phase(uvm_phase phase);
        agt.mon.result_ap.connect(scrb.actual_result);

        // agt.mon.result_ap.connect(cov.analysis_imp_outp);
        //`uvm_info("environment","environment connect",UVM_LOW);
    endfunction

endclass
`endif
