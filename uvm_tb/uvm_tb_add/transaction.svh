`ifndef TRANSACTION_SVH
`define TRANSACTION_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;
class transaction extends uvm_sequence_item;
    rand logic [15:0]float1;
    rand logic [15:0]float2;
    logic [15:0]sum;
    fpu_rounding_mode_t rounding_mode;

     `uvm_object_utils_begin(transaction)
        `uvm_field_int(float1, UVM_ALL_ON)
        `uvm_field_int(float2, UVM_ALL_ON)
        `uvm_field_int(sum, UVM_ALL_ON)
        `uvm_field_enum(fpu_rounding_mode_t, rounding_mode, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "transaction");
        super.new(name);
        //`uvm_info("transaction","transaction construct",UVM_LOW);
    endfunction 

endclass 
`endif
