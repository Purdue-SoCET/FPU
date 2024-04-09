`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_classify
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
	parameter FLOAT_QNAN = HALF_QNAN,
	parameter FLOAT_SNAN = HALF_SNAN,
	parameter FLOAT_ZERO = HALF_ZERO,
	parameter FLOAT_ZERON = HALF_ZERON,

	// internal variables
	parameter TOP_FRAC_CALC_BIT = FRACTION_WIDTH + (2 ** EXPONENT_WIDTH - 1),
	parameter TOP_FRAC_OUT_BIT = TOP_FRAC_CALC_BIT - 1,
	parameter BOTTOM_FRAC_OUT_BIT = TOP_FRAC_CALC_BIT - FRACTION_WIDTH
)
(
	input logic [FLOAT_WIDTH - 1 : 0] float1,

	output logic [9:0] out
);

// internal signals
logic float1_sign;
logic [EXPONENT_WIDTH - 1 : 0] float1_exponent;

// assign statements
assign float1_sign = float1[SIGN];
assign float1_exponent = float1[EXPONENT_MSB : EXPONENT_LSB];

always_comb
begin : OUTPUT
	if (float1 == FLOAT_INFN)
	begin
		// -inf
		assign out = 10'b0000000001;
	end
	else if (float1 == FLOAT_ZERON)
	begin
		// -0
		assign out = 10'b0000001000;
	end
	else if (float1 == FLOAT_ZERO)
	begin
		// +0
		assign out = 10'b0000010000;
	end
	else if (float1 == FLOAT_INF)
	begin
		// inf
		assign out = 10'b0010000000;
	end
	else if (float1 == FLOAT_SNAN)
	begin
		// signaling NaN
		assign out = 10'b0100000000;
	end
	else if (float1 == FLOAT_QNAN)
	begin
		// quiet NaN
		assign out = 10'b1000000000;
	end	
	else if (float1_sign)
	begin
		// negative number
		if (float1_exponent == '0)
		begin
			// subnormal
			assign out = 10'b0000000100;
		end
		else
		begin
			// normal
			assign out = 10'b0000000010;
		end
	end
	else if (~float1_sign)
	begin
		// positive number
		if (float1_exponent == '0)
		begin
			// subnormal
			assign out = 10'b0000100000;
		end
		else
		begin
			// normal
			assign out = 10'b0001000000;
		end
	end
	else
	begin
		assign out = '0;
	end
end

endmodule