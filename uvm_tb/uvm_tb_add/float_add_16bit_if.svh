`ifndef FLOAT_ADD_16BIT_IF_SVH
`define FLOAT_ADD_16BIT_IF_SVH
`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

interface float_add_16bit_if (input logic clk);

    //input
    logic n_rst; 
    logic [15:0] float1;
    logic [15:0] float2;
    //output
    logic [15:0] sum;
    fpu_rounding_mode_t rounding_mode;

modport fadd16 (
    input clk, n_rst, float1, float2, rounding_mode,
    output sum
);

endinterface
`endif
