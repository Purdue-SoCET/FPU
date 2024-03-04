`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module rv32zhinx_wrapper(
	input CLK,
	input nRST,
	input rv32zhinx_start,
	input fpu_opcode_t operation,
	input [31:0] rv32zhinx_a,
	input [31:0] rv32zhinx_b,
	output rv32zhinx_done,
	output logic [31:0] rv32zhinx_out
);
	import rv32zhinx_pkg::*;
	
	// `ifdef RV32ZHINX_SUPPORTED
		rv32zhinx_enabled rv32zhinx(.*);
	// `else
		// rv32zhinx_disabled rv32zhinx(.*);
	// `endif

endmodule