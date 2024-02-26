`ifndef FLOAT_ADD_IF_SVH
`define FLOAT_ADD_IF_SVH
`include "uvm_fpu_pkg.vh"
import uvm_fpu_pkg::*;

interface float_add_if #(parameter WIDTH = 16) (input logic clk);

    //input
    logic n_rst; 
    logic [WIDTH-1:0] float1;
    logic [WIDTH-1:0] float2;
    //output
    logic [WIDTH-1:0] sum;
    fpu_rounding_mode_t rounding_mode;

    modport fadd (
        input clk, n_rst, float1, float2, rounding_mode,
        output sum
    );

endinterface
`endif
