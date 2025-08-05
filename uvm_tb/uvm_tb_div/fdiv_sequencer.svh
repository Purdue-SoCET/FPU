`ifndef FDIV_SEQUENCER_SVH
`define  FDIV_SEQUENCER_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.svh"

class fdiv_sequencer extends uvm_sequencer#(transaction);
    `uvm_component_utils(fdiv_sequencer)

    function new(string name= "", uvm_component parent=null);
        super.new(name, parent);
        //`uvm_info("fdiv_sequencer","sequencer construct",UVM_LOW);
    endfunction : new

endclass : fdiv_sequencer
`endif
