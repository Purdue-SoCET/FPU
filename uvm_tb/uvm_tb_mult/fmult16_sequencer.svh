`ifndef FMULT16_SEQUENCER_SVH
`define  FMULT16_SEQUENCER_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.svh"

class fmult16_sequencer extends uvm_sequencer#(transaction);
    `uvm_component_utils(fmult16_sequencer)

    function new(string name= "", uvm_component parent=null);
        super.new(name, parent);
        //`uvm_info("fmult16_sequencer","sequencer construct",UVM_LOW);
    endfunction : new

endclass : fmult16_sequencer
`endif
