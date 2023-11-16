`ifndef FADD16_AGENT_SVH
`define FADD16_AGENT_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fadd16_sequence.svh"
`include "fadd16_sequencer.svh"
`include "fadd16_driver.svh"
`include "fadd16_monitor.svh"

class fadd16_agent extends uvm_agent;
    `uvm_component_utils(fadd16_agent)
    fadd16_sequencer sqr;
    fadd16_driver drv;
    fadd16_monitor mon;

    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        //`uvm_info("fadd16_agent","agent construct",UVM_LOW);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        sqr = fadd16_sequencer::type_id::create("sqr", this);
        drv = fadd16_driver::type_id::create("drv", this);
        mon = fadd16_monitor::type_id::create("mon", this);
        //`uvm_info("fadd16_agent","agent build",UVM_LOW);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        //`uvm_info("fadd16_agent","agent connect",UVM_LOW);
    endfunction

endclass
`endif
