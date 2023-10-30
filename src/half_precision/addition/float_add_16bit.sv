`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_add_16bit (
	input logic [HALF_FLOAT_W - 1 : 0] float1,
	input logic [HALF_FLOAT_W - 1 : 0] float2,

	output logic [HALF_FLOAT_W - 1 : 0] sum
);

// internal signals
logic A_larger;

logic sign_A, sign_B;
logic [4:0] exponent_A, exponent_B, exponent_out;
logic normal_A, normal_B;
logic [10:0] fraction_A, fraction_B, fraction_calc, fraction_out;

logic [4:0] exponent_difference;
logic carry_out;

logic [HALF_FLOAT_W - 1 : 0] sum_out;

// assign statements
assign A_larger = (float1[14:10] > float2[14:10]) | ((float1[14:10] == float2[14:10]) & (float1[9:0] >= float2[9:0])); // A_larger will be 1 if float1 >= float2
// hardwire internal 'A' to larger of two inputs
assign sign_A = A_larger ? float1[15] : float2[15];
assign exponent_A = A_larger ? float1[14:10] : float2[14:10];
assign normal_A = exponent_A != 5'b0;
assign fraction_A = A_larger ? { normal_A, float1[9:0] } : { normal_A, float2[9:0] };
// hardwire internal 'B' to smaller of two inputs
assign sign_B = A_larger ? float2[15] : float1[15];
assign exponent_B = A_larger ? float2[14:10] : float1[14:10];
assign normal_B = exponent_B != 5'b0;
assign fraction_B = (A_larger ? { normal_B, float2[9:0] } : { normal_B, float1[9:0] }) >> exponent_difference; // bit shift to 'align' float1 and float2
// miscellaneous variables
assign exponent_difference = exponent_A - exponent_B; // due to setup, this will always be >= 0
// sum calculation
assign { carry_out, fraction_calc } = (sign_A == sign_B) ? fraction_A + fraction_B : fraction_A - fraction_B;
assign exponent_out = carry_out ? exponent_A + 1'b1 : exponent_A;
assign fraction_out = carry_out ? fraction_calc >> 1 : fraction_calc;
// special cases when generating sum output
assign sum_out =
	(exponent_A == 5'b11111 & fraction_A != 0) | (exponent_B == 5'b11111 & fraction_B != 0) ? HALF_NAN	// carry NaN through equation
	: exponent_out == 5'b11111 ? sign_A ? HALF_INFN : HALF_INF											// determine whether overflow occurred and correct sign
	: { sign_A, exponent_out, fraction_out[HALF_FRACTION_W - 1 : 0] };									// no errors, assemble sum

endmodule