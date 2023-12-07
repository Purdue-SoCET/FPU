`ifndef FADD_SEQUENCER_SVH
`define  FADD_SEQUENCER_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.svh"

class fadd_sequencer extends uvm_sequencer#(transaction);
    `uvm_component_utils(fadd_sequencer)

    function new(string name= "", uvm_component parent=null);
        super.new(name, parent);
        //`uvm_info("fadd_sequencer","sequencer construct",UVM_LOW);
    endfunction : new

endclass : fadd_sequencer
`endif
