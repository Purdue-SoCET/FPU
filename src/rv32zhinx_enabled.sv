`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module rv32zhinx_enabled (
	input CLK,
	input nRST,
	input rv32zhinx_start,
	input fpu_operation_t operation,
	input [WORD_W - 1 : 0] rv32zhinx_a,
	input [WORD_W - 1 : 0] rv32zhinx_b,
	output rv32zhinx_done,
	output logic [WORD_W - 1 : 0] rv32zhinx_out
);

/* FPU */

// generic FPU signals
fpu_operation_t operation_save;
logic [WORD_W - 1 : 0] a_save, b_save;

fpu_rm_t rounding_mode;
assign rounding_mode = RM_RNE; // TODO update based on rounding mode instruction

// save input values in case of multi-clock processing
always_ff @(posedge CLK, negedge nRST)
begin : SAVE_INPUTS
	if (~nRST)
	begin
		a_save	<= '0;
		b_save	<= '0;
		operation_save <= FPU_HALF_ADD;
	end
	else if (rv32zhinx_start && rv32zhinx_done)
	begin
		a_save	<= rv32zhinx_a;
		b_save	<= rv32zhinx_b;
		operation_save <= operation;
	end
end

/* 16-BIT ADDITION/SUBTRACTION */

// subtraction signals
logic [HALF_FLOAT_W - 1 : 0] half_input_b;
assign half_input_b = (operation == FPU_HALF_SUB) ?
					rv32zhinx_b[HALF_FLOAT_W - 1 : 0] ^ 16'h8000 : 	// negative for subtraction
					rv32zhinx_b[HALF_FLOAT_W - 1 : 0];				// unchanged for addition
logic [HALF_FLOAT_W - 1 : 0] half_sum;

float_add_16bit add
(
	.float1(rv32zhinx_a[HALF_FLOAT_W - 1 : 0]),
	.float2(half_input_b),
	.rounding_mode(rounding_mode),
	.sum(half_sum)
);

/* 16-BIT MULTIPLICATION */

// multiplication signals
logic [HALF_FLOAT_W - 1 : 0] half_product;

float_mult_16bit multiply
(
	.float1(rv32zhinx_a[HALF_FLOAT_W - 1 : 0]),
	.float2(rv32zhinx_b[HALF_FLOAT_W - 1 : 0]),
	.rm(rounding_mode),
	.product(half_product)
);

/* RESULT */
always_comb
begin : RESULT
	if (rv32zhinx_start)
	begin
		casez(operation)
			FPU_HALF_ADD, FPU_HALF_SUB:
			begin
				rv32zhinx_done = 1'b1; // TODO ?
				rv32zhinx_out = { 16'b0, half_sum };
			end

			FPU_HALF_MUL:
			begin
				rv32zhinx_done = 1'b1; // TODO ?
				rv32zhinx_out = { 16'b0, half_product };
			end

			// TODO:
			// FPU_HALF_DIV:
			// FPU_HALF_MIN:
			// FPU_HALF_MAX:
			// FPU_HALF_SQRT:
			// FPU_HALF_SGNJ:
			// FPU_HALF_COMP:
			// FPU_HALF_CLASS:
			// FPU_HALF_MADD:
			// FPU_HALF_MSUB:
			// FPU_HALF_NMADD:
			// FPU_HALF_NMSUB:
			default:
			begin
				rv32zhinx_done = 1'b1;
				rv32zhinx_out = '0; // TODO error signal?
			end
		endcase
	end
	else
	begin
		rv32zhinx_done = 1'b1;
		rv32zhinx_out = '0;
	end
end

endmodule