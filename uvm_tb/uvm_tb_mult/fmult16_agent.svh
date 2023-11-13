`ifndef FMULT16_AGENT_SVH
`define FMULT16_AGENT_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fmult16_sequence.svh"
`include "fmult16_sequencer.svh"
`include "fmult16_driver.svh"
`include "fmult16_monitor.svh"

class fmult16_agent extends uvm_agent;
    `uvm_component_utils(fmult16_agent)
    fmult16_sequencer sqr;
    fmult16_driver drv;
    fmult16_monitor mon;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        //`uvm_info("fmult16_agent","agent construct",UVM_LOW);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        sqr = fmult16_sequencer::type_id::create("sqr", this);
        drv = fmult16_driver::type_id::create("drv", this);
        mon = fmult16_monitor::type_id::create("mon", this);
        //`uvm_info("fmult16_agent","agent build",UVM_LOW);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        //`uvm_info("fmult16_agent","agent connect",UVM_LOW);
    endfunction

endclass
`endif
