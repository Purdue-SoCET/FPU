`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module rv32zhinx_disabled(
    input CLK,
    input nRST,
    input rv32zhinx_start,
    input fpu_opcode_t operation,
    input [31:0] rv32zhinx_a,
    input [31:0] rv32zhinx_b,
    output rv32zhinx_done,
    output logic [31:0] rv32zhinx_out
);

    assign rv32zhinx_done = 1'b1;
    assign rv32zhinx_out = 32'b0;

endmodule