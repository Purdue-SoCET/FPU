`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_minmax
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

	input logic max, // 0 for smaller, 1 for larger

	output logic [FLOAT_WIDTH - 1 : 0] out
);

// internal signals
logic float1_sign, float2_sign;
logic [EXPONENT_WIDTH - 1 : 0] float1_exponent, float2_exponent;
logic [FRACTION_WIDTH - 1 : 0] float1_fraction, float2_fraction;

// assign statements
assign float1_sign = float1[SIGN];
assign float2_sign = float2[SIGN];
assign float1_exponent = float1[EXPONENT_MSB : EXPONENT_LSB];
assign float2_exponent = float2[EXPONENT_MSB : EXPONENT_LSB];
assign float1_fraction = float1[FRACTION_MSB : FRACTION_LSB];
assign float2_fraction = float2[FRACTION_MSB : FRACTION_LSB];

always_comb
begin : OUTPUT
	// comments explain logic assuming max is desired, but ternary handles min cases
	if (float1 == FLOAT_INFN)
	begin
		// float1 is -inf, return float2
		assign out = max ? float2 : float1;
	end
	else if (float2 == FLOAT_INFN)
	begin
		// float2 is -inf, return float1
		assign out = max ? float1 : float2;
	end
	else if ((float1 == HALF_NAN) && (float2 == HALF_NAN))
	begin
		// float1 and float2 are NaN, return NaN
		assign out = HALF_NAN;
	end
	else if (float1 == HALF_NAN)
	begin
		// only float1 is NaN, return float2
		assign out = float2;
	end
	else if (float2 == HALF_NAN)
	begin
		// only float2 is NaN, return float1
		assign out = float1;
	end
	else
	begin
		// end of special cases
		if (float1_sign && ~float2_sign)
		begin
			// float1 is negative and float2 is positive, return float2
			assign out = max ? float2 : float1;
		end
		else if (float2_sign && ~float1_sign)
		begin
			// float2 is negative and float1 is positive, return float1
			assign out = max ? float1 : float2;
		end
		else
		begin
			// end of sign bit cases
			if (float1_exponent > float2_exponent)
			begin
				// float1 has larger exponent, return float1
				assign out = max ? (float1_sign ? float2 : float1) : (float1_sign ? float1 : float2);
			end
			else if (float2_exponent > float1_exponent)
			begin
				// float2 has larger exponent, return float2
				assign out = max ? (float1_sign ? float1 : float2) : (float1_sign ? float2 : float1);
			end
			else
			begin
				// end of exponent cases
				if (float1_fraction > float2_fraction)
				begin
					// float1 has larger fraction, return float1
					assign out = max ? (float1_sign ? float2 : float1) : (float1_sign ? float1 : float2);
				end
				else if (float2_fraction > float1_fraction)
				begin
					// float2 has larger fraction, return float2
					assign out = max ? (float1_sign ? float1 : float2) : (float1_sign ? float2 : float1);
				end
				else
				begin
					// float1 == float2, return float1 (or float2)
					assign out = float1;
				end
			end
		end
	end
end

endmodule