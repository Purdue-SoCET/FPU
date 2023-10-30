`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_add_16bit
#
(
	parameter FLOAT_WIDTH = HALF_FLOAT_W,
	parameter EXPONENT_WIDTH = HALF_EXPONENT_W,
	parameter FRACTION_WIDTH = HALF_FRACTION_W,

	parameter SIGN = HALF_FLOAT_W - 1,
	parameter EXPONENT_MSB = HALF_FLOAT_W - SIGN_W - 1,
	parameter EXPONENT_LSB = HALF_FRACTION_W,
	parameter FRACTION_MSB = HALF_FRACTION_W - 1,
	parameter FRACTION_LSB = 0
)
(
	input logic [FLOAT_WIDTH - 1 : 0] float1,
	input logic [FLOAT_WIDTH - 1 : 0] float2,

	output logic [FLOAT_WIDTH - 1 : 0] sum
);

// internal signals
logic A_larger;

logic sign_A, sign_B;
logic [EXPONENT_WIDTH - 1 : 0] exponent_A, exponent_B, exponent_out;
logic normal_A, normal_B;
logic [FRACTION_WIDTH : 0] fraction_A, fraction_B, fraction_calc, fraction_out;

logic [EXPONENT_WIDTH - 1 : 0] exponent_difference;
logic carry_out;

logic [FLOAT_WIDTH - 1 : 0] sum_out;

// assign statements
assign A_larger = (float1[EXPONENT_MSB : EXPONENT_LSB] > float2[EXPONENT_MSB : EXPONENT_LSB]) | ((float1[EXPONENT_MSB : EXPONENT_LSB] == float2[EXPONENT_MSB : EXPONENT_LSB]) & (float1[FRACTION_MSB : FRACTION_LSB] >= float2[FRACTION_MSB : FRACTION_LSB])); // A_larger will be 1 if float1 >= float2

// hardwire internal 'A' to larger of two inputs
assign sign_A = A_larger ? float1[SIGN] : float2[SIGN];
assign exponent_A = A_larger ? float1[EXPONENT_MSB : EXPONENT_LSB] : float2[EXPONENT_MSB : EXPONENT_LSB];
assign normal_A = exponent_A != '0;
assign fraction_A = A_larger ? { normal_A, float1[FRACTION_MSB : FRACTION_LSB] } : { normal_A, float2[FRACTION_MSB : FRACTION_LSB] };

// hardwire internal 'B' to smaller of two inputs
assign sign_B = A_larger ? float2[SIGN] : float1[SIGN];
assign exponent_B = A_larger ? float2[EXPONENT_MSB : EXPONENT_LSB] : float1[EXPONENT_MSB : EXPONENT_LSB];
assign normal_B = exponent_B != '0;
assign fraction_B = (A_larger ? { normal_B, float2[FRACTION_MSB : FRACTION_LSB] } : { normal_B, float1[FRACTION_MSB : FRACTION_LSB] }) >> exponent_difference; // bit shift to 'align' float1 and float2

// miscellaneous variables
assign exponent_difference =
	~normal_A ? exponent_A - exponent_B				// A is subnormal, and since A >= B, B is also subnormal
	: ~normal_B ? exponent_A - (exponent_B + 1'b1)	// A is not subnormal, but B is subnormal, so adjust exponent difference to account for weird subnormal exponent
	: exponent_A - exponent_B;						// A and B are normal, so calculate difference as normal

// sum calculation
assign { carry_out, fraction_calc } = (sign_A == sign_B) ? fraction_A + fraction_B : fraction_A - fraction_B;
assign exponent_out = carry_out ? exponent_A + 1'b1 : exponent_A;
assign fraction_out = carry_out ? fraction_calc >> 1 : fraction_calc;

// special cases when generating sum output
assign sum_out =
	(exponent_A == '1 & fraction_A != 0) | (exponent_B == '1 & fraction_B != 0) ? HALF_NAN	// carry NaN through equation
	: exponent_out == '1 ? sign_A ? HALF_INFN : HALF_INF									// determine whether overflow occurred and correct sign
	: { sign_A, exponent_out, fraction_out[HALF_FRACTION_W - 1 : 0] };						// no errors, assemble sum

endmodule