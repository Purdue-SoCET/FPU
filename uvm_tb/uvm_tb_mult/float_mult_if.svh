`ifndef FLOAT_MULT_IF_SVH
`define FLOAT_MULT_IF_SVH
`include "uvm_fpu_pkg.vh"
import uvm_fpu_pkg::*;

interface float_mult_if#(parameter WIDTH = 16)  (input logic clk);

    //input
    logic n_rst; 
    logic [WIDTH-1:0] float1;
    logic [WIDTH-1:0] float2;
    //output
    logic [WIDTH-1:0] product;

modport fmult (
    input clk, n_rst, float1, float2,
    output product
);

endinterface
`endif
