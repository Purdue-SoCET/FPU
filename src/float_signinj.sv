`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_signinj
#
(
	parameter FLOAT_WIDTH = HALF_FLOAT_W,
	parameter EXPONENT_WIDTH = HALF_EXPONENT_W,
	parameter FRACTION_WIDTH = HALF_FRACTION_W,

	parameter SIGN = HALF_FLOAT_W - 1,
	parameter EXPONENT_MSB = HALF_FLOAT_W - SIGN_W - 1,
	parameter EXPONENT_LSB = HALF_FRACTION_W,
	parameter FRACTION_MSB = HALF_FRACTION_W - 1,
	parameter FRACTION_LSB = 0,

	parameter FLOAT_INF = HALF_INF,
	parameter FLOAT_INFN = HALF_INFN,
	parameter FLOAT_NAN = HALF_NAN,
	parameter FLOAT_ZERO = HALF_ZERO,

	// internal variables
	parameter TOP_FRAC_CALC_BIT = FRACTION_WIDTH + (2 ** EXPONENT_WIDTH - 1),
	parameter TOP_FRAC_OUT_BIT = TOP_FRAC_CALC_BIT - 1,
	parameter BOTTOM_FRAC_OUT_BIT = TOP_FRAC_CALC_BIT - FRACTION_WIDTH
)
(
	input logic [FLOAT_WIDTH - 1 : 0] float1,
	input logic [FLOAT_WIDTH - 1 : 0] float2,

	input fpu_sgnj_type_t sgnj_type,

	output logic [FLOAT_WIDTH - 1 : 0] out
);

// internal signals
logic float1_sign, float2_sign;

// assign statements
assign float1_sign = float1[SIGN];
assign float2_sign = float2[SIGN];

always_comb
begin : OUTPUT
	casez (sgnj_type)
		RM_J:
		begin
			// result's sign bit = float2 sign bit
			assign out = { float2_sign, float1[FLOAT_WIDTH - 2 : 0] };
		end

		RM_JN:
		begin
			// result's sign bit = opposite of float2 sign bit
			assign out = { ~float2_sign, float1[FLOAT_WIDTH - 2 : 0] };
		end

		RM_JX:
		begin
			// result's sign bit = XOR of float1 and float2 sign bits
			assign out = { (float1_sign ^ float2_sign), float1[FLOAT_WIDTH - 2 : 0] };
		end
	endcase
end

endmodule