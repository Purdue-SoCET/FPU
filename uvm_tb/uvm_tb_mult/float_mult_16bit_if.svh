`ifndef FLOAT_MULT_16BIT_IF_SVH
`define FLOAT_MULT_16BIT_IF_SVH
`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

interface float_mult_16bit_if (input logic clk);

    //input
    logic n_rst; 
    logic [15:0] float1;
    logic [15:0] float2;
    //output
    logic [15:0] product;

modport fmult16 (
    input clk, n_rst, float1, float2,
    output product
);

endinterface
`endif
