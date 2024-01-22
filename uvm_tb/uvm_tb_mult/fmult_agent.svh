`ifndef FMULT_AGENT_SVH
`define FMULT_AGENT_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fmult_sequence.svh"
`include "fmult_sequencer.svh"
`include "fmult_driver.svh"
`include "fmult_monitor.svh"

class fmult_agent extends uvm_agent;
    `uvm_component_utils(fmult_agent)
    fmult_sequencer sqr;
    fmult_driver drv;
    fmult_monitor mon;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        //`uvm_info("fmult_agent","agent construct",UVM_LOW);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        sqr = fmult_sequencer::type_id::create("sqr", this);
        drv = fmult_driver::type_id::create("drv", this);
        mon = fmult_monitor::type_id::create("mon", this);
        //`uvm_info("fmult_agent","agent build",UVM_LOW);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        //`uvm_info("fmult_agent","agent connect",UVM_LOW);
    endfunction

endclass
`endif
