`ifndef FADD16_SEQUENCER_SVH
`define  FADD16_SEQUENCER_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.svh"

class fadd16_sequencer extends uvm_sequencer#(transaction);
    `uvm_component_utils(fadd16_sequencer)

    function new(string name= "", uvm_component parent=null);
        super.new(name, parent);
        //`uvm_info("fadd16_sequencer","sequencer construct",UVM_LOW);
    endfunction : new

endclass : fadd16_sequencer
`endif
