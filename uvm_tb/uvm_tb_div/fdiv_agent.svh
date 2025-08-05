`ifndef FDIV_AGENT_SVH
`define FDIV_AGENT_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fdiv_sequence.svh"
`include "fdiv_sequencer.svh"
`include "fdiv_driver.svh"
`include "fdiv_monitor.svh"

class fdiv_agent extends uvm_agent;
    `uvm_component_utils(fdiv_agent)
    fdiv_sequencer sqr;
    fdiv_driver drv;
    fdiv_monitor mon;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        //`uvm_info("fdiv_agent","agent construct",UVM_LOW);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        sqr = fdiv_sequencer::type_id::create("sqr", this);
        drv = fdiv_driver::type_id::create("drv", this);
        mon = fdiv_monitor::type_id::create("mon", this);
        //`uvm_info("fdiv_agent","agent build",UVM_LOW);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        //`uvm_info("fdiv_agent","agent connect",UVM_LOW);
    endfunction

endclass
`endif
