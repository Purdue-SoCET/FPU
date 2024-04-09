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

/* 16-BIT MIN/MAX */

// min/max signals
logic max;
assign max = (operation == FPU_HALF_MAX);
logic [HALF_FLOAT_W - 1 : 0] half_minmax;

float_minmax_16bit minmax
(
	.float1(rv32zhinx_a[HALF_FLOAT_W - 1 : 0]),
	.float2(rv32zhinx_b[HALF_FLOAT_W - 1 : 0]),
	.max(max),
	.out(half_minmax)
);

/* 16-BIT COMPARE */

// compare signals
fpu_cmp_rm_t cmp;
assign cmp = operation == FPU_HALF_FLT ? RM_FLT : operation == FPU_HALF_FLE ? RM_FLE : RM_FEQ;
logic half_compare;

float_compare_16bit compare
(
	.float1(rv32zhinx_a[HALF_FLOAT_W - 1 : 0]),
	.float2(rv32zhinx_b[HALF_FLOAT_W - 1 : 0]),
	.operation(cmp),
	.out(half_compare)
);

/* 16-BIT SIGN INJECTION */

// sign injection signals
fpu_sgnj_type_t sgnj;
assign sgnj = operation == FPU_HALF_SGNJ ? RM_J : operation == FPU_HALF_SGNJN ? RM_JN : RM_JX;
logic [HALF_FLOAT_W - 1 : 0] half_sgnj;

float_signinj_16bit signinj
(
	.float1(rv32zhinx_a[HALF_FLOAT_W - 1 : 0]),
	.float2(rv32zhinx_b[HALF_FLOAT_W - 1 : 0]),
	.sgnj_type(sgnj),
	.out(half_sgnj)
);

/* 16-BIT CLASSIFY */

// classify signals
logic [9:0] half_classify;

float_classify_16bit classify
(
	.float1(rv32zhinx_a[HALF_FLOAT_W - 1 : 0]),
	.out(half_classify)
);

/* RESULT */
always_comb
begin : RESULT
	if (rv32zhinx_start)
	begin
		casez (operation)
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

			FPU_HALF_MIN, FPU_HALF_MAX:
			begin
				rv32zhinx_done = 1'b1; // TODO ?
				rv32zhinx_out = { 16'b0, half_minmax };
			end

			FPU_HALF_FEQ, FPU_HALF_FLT, FPU_HALF_FLE:
			begin
				rv32zhinx_done = 1'b1; // TODO ?
				rv32zhinx_out = { 31'b0, half_compare };
			end

			// TODO convert

			FPU_HALF_SGNJ, FPU_HALF_SGNJN, FPU_HALF_SGNJX:
			begin
				rv32zhinx_done = 1'b1; // TODO ?
				rv32zhinx_out = { 16'b0, half_sgnj };
			end

			FPU_HALF_CLASS:
			begin
				rv32zhinx_done = 1'b1; // TODO ?
				rv32zhinx_out = { 22'b0, half_classify };
			end

			// TODO:
			/* FPI_HALF_DIV, FPU_HALF_SQRT, */
			/* FPU_HALF_MADD, FPU_HALF_MSUB, FPU_HALF_NMADD, FPU_HALF_NMSUB, */
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