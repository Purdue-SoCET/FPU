`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_convert
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
	input logic [31:0] in,

	input fpu_cvt_type_t cvt_type, // for FCVT

	output logic [31:0] out
);

// internal signals (assuming input is a float)
logic float1_sign;
logic [EXPONENT_WIDTH - 1 : 0] float1_exponent;
logic [FRACTION_WIDTH - 1 : 0] float1_fraction;

// assign statements
assign float1_sign = in[SIGN];
assign float1_exponent = in[EXPONENT_MSB : EXPONENT_LSB];
assign float1_fraction = in[FRACTION_MSB : FRACTION_LSB];

// output
logic [31:0] output_int;

// TODO handle signaling NaN
// TODO handle rounding modes

always_comb
begin : OUTPUT
	// initial values
	output_int = '0;

	if (cvt_type == FUNCT_W_H)
	begin
		// convert from half-precision float to word
		if ((in[FLOAT_WIDTH - 1 : 0] == FLOAT_INF) || (in[FLOAT_WIDTH - 1 : 0] == FLOAT_NAN))
		begin
			// number is INF or NaN, return MAX
			output_int = { 1'b0, {31{1'b1}} };
		end
		else if (in[FLOAT_WIDTH - 1 : 0] == FLOAT_INFN)
		begin
			// number is -INF, return MIN
			output_int = { 1'b1, 31'b0 };
		end
		else if (float1_sign)
		begin
			if (float1_exponent <= (EXPONENT_WIDTH >> 1))
			begin
				// number is a decimal, return 0
				output_int = 32'b0;
			end
			else
			begin
				// number is greater than 1
				// place the sign-extended float fraction (with leading 1. in the integer)
				// the XOR logic is to 2s complement the original fraction
				output_int = { {21{1'b1}}, ({ 1'b1, {FRACTION_WIDTH{1'b1}} } ^ { 1'b1, float1_fraction }) };
				// shift result to right (fraction width - (float exponent - float exponent offset)) times
				for (logic[EXPONENT_WIDTH - 1 : 0] i = 0; i < (FRACTION_WIDTH - (float1_exponent - ({EXPONENT_WIDTH{1'b1}} >> 1))); i++)
				begin
					// sign extend while shifting
					output_int = { 1'b1, output_int[31:1] };
				end
				// +1 for 2s complement on the int part
				output_int = output_int + 1'b1;
			end
		end
		else
		begin
			if (float1_exponent <= (EXPONENT_WIDTH >> 1))
			begin
				// number is a decimal, return 0
				output_int = 32'b0;
			end
			else
			begin
				// number is greater than 1
				// place the sign-extended float fraction (with leading 1. in the integer)
				output_int = { 21'b0, 1'b1, float1_fraction };
				// shift result to right (fraction width - (float exponent - float exponent offset)) times
				output_int = output_int >> (FRACTION_WIDTH - (float1_exponent - ({EXPONENT_WIDTH{1'b1}} >> 1)));
			end
		end
	end
	else if (cvt_type == FUNCT_H_W)
	begin
		// convert from word to half-precision float
	end
	else if (cvt_type == FUNCT_WU_H)
	begin
		// convert from half-precision float to unsigned word
		// convert from half-precision float to word
		if ((in[FLOAT_WIDTH - 1 : 0] == FLOAT_INF) || (in[FLOAT_WIDTH - 1 : 0] == FLOAT_NAN))
		begin
			// number is INF or NaN, return MAX
			output_int = {32{1'b1}};
		end
		else if (float1_sign)
		begin
			// number is negative, need to clamp to 0
			output_int = 32'b0;
		end
		else
		begin
			if ((in[FLOAT_WIDTH - 1 : 0] == FLOAT_INFN) || (in[FLOAT_WIDTH - 1 : 0] == FLOAT_NAN))
			begin
				// number is INF or NaN, return MAX
				output_int = {32{1'b1}};
			end
			else if (float1_exponent <= (EXPONENT_WIDTH >> 1))
			begin
				// number is a decimal, return 0
				output_int = 32'b0;
			end
			else
			begin
				// number is greater than 1
				// place the sign-extended float fraction (with leading 1. in the integer)
				output_int = { 21'b0, 1'b1, float1_fraction };
				// shift result to right (fraction width - (float exponent - float exponent offset)) times
				output_int = output_int >> (FRACTION_WIDTH - (float1_exponent - ({EXPONENT_WIDTH{1'b1}} >> 1)));
			end
		end
	end
	else if (cvt_type == FUNCT_H_WU)
	begin
		// convert from unsigned word to half-precision float
	end

	// assign output int to real output
	out = output_int;
end

endmodule