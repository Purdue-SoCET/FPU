`ifndef FADD_AGENT_SVH
`define FADD_AGENT_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fadd_sequence.svh"
`include "fadd_sequencer.svh"
`include "fadd_driver.svh"
`include "fadd_monitor.svh"

class fadd_agent extends uvm_agent;
    `uvm_component_utils(fadd_agent)
    fadd_sequencer sqr;
    fadd_driver drv;
    fadd_monitor mon;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        //`uvm_info("fadd_agent","agent construct",UVM_LOW);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        sqr = fadd_sequencer::type_id::create("sqr", this);
        drv = fadd_driver::type_id::create("drv", this);
        mon = fadd_monitor::type_id::create("mon", this);
        //`uvm_info("fadd_agent","agent build",UVM_LOW);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        //`uvm_info("fadd_agent","agent connect",UVM_LOW);
    endfunction

endclass
`endif
