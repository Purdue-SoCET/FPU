`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_add
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

	input fpu_rounding_mode_t rounding_mode,

	output logic [FLOAT_WIDTH - 1 : 0] sum
);

// internal signals
logic A_larger;

logic sign_A, sign_B;
// logic sign_flip;
logic [EXPONENT_WIDTH - 1 : 0] exponent_A, exponent_B, exponent_out;
logic normal_A, normal_B;
logic [TOP_FRAC_CALC_BIT : 0] fraction_A, fraction_B, fraction_calc, fraction_out;

logic [EXPONENT_WIDTH - 1 : 0] exponent_difference;
logic carry_out;

logic guard_bit, rounding_bit, sticky_bit;

// assign statements
assign A_larger = (float1[EXPONENT_MSB : EXPONENT_LSB] > float2[EXPONENT_MSB : EXPONENT_LSB]) | ((float1[EXPONENT_MSB : EXPONENT_LSB] == float2[EXPONENT_MSB : EXPONENT_LSB]) & (float1[FRACTION_MSB : FRACTION_LSB] >= float2[FRACTION_MSB : FRACTION_LSB])); // A_larger will be 1 if float1 >= float2
// assign sign_flip = ~A_larger & sign_B; // flip output sign if |float2| > |float1| and float2 is negative

// hardwire internal 'A' to larger of two inputs
assign sign_A = A_larger ? float1[SIGN] : float2[SIGN];
assign exponent_A = A_larger ? float1[EXPONENT_MSB : EXPONENT_LSB] : float2[EXPONENT_MSB : EXPONENT_LSB];
assign normal_A = exponent_A != '0;
assign fraction_A = A_larger ? { normal_A, float1[FRACTION_MSB : FRACTION_LSB], {BOTTOM_FRAC_OUT_BIT{1'b0}} } : { normal_A, float2[FRACTION_MSB : FRACTION_LSB], {BOTTOM_FRAC_OUT_BIT{1'b0}} };

// hardwire internal 'B' to smaller of two inputs
assign sign_B = A_larger ? float2[SIGN] : float1[SIGN];
assign exponent_B = A_larger ? float2[EXPONENT_MSB : EXPONENT_LSB] : float1[EXPONENT_MSB : EXPONENT_LSB];
assign normal_B = exponent_B != '0;
assign fraction_B = (A_larger ? { normal_B, float2[FRACTION_MSB : FRACTION_LSB], {BOTTOM_FRAC_OUT_BIT{1'b0}} } : { normal_B, float1[FRACTION_MSB : FRACTION_LSB], {BOTTOM_FRAC_OUT_BIT{1'b0}} }) >> exponent_difference; // bit shift to 'align' float1 and float2

// miscellaneous variables
assign exponent_difference =
	~normal_A ? exponent_A - exponent_B				// A is subnormal, and since A >= B, B is also subnormal
	: ~normal_B ? exponent_A - (exponent_B + 1'b1)	// A is not subnormal, but B is subnormal, so adjust exponent difference to account for weird subnormal exponent
	: exponent_A - exponent_B;						// A and B are normal, so calculate difference as normal

// rounding variables
// assign rounding_bit = fraction_out[FRACTION_WIDTH - 1];		// next bit after fraction
// assign sticky_bit = |fraction_out[FRACTION_WIDTH - 2 : 0];	// logical OR of all remaining bits

always_comb begin : SUM_CALC

	// default values
	carry_out = '0;
	exponent_out = '0;
	fraction_out = '0;

	rounding_bit = '0;
	sticky_bit = '0;
	sum = '0;

	if (sign_A == sign_B)
	begin
		// adding :)
		{ carry_out, fraction_calc } = fraction_A + fraction_B;
		if (carry_out)
		begin
			// normal overflow
			exponent_out = exponent_A + 1'b1;
			fraction_out = fraction_calc >> 1;
		end
		else if (~fraction_A[TOP_FRAC_CALC_BIT] & fraction_calc[TOP_FRAC_CALC_BIT])
		begin
			// subnormal overflow to normal
			exponent_out = exponent_A + 1'b1;
			fraction_out = fraction_calc;
		end
		else
		begin
			// no overflow
			exponent_out = exponent_A;
			fraction_out = fraction_calc;
		end
	end
	else
	begin
		// subtracting, need to shift result :skull:
		fraction_calc = fraction_A - fraction_B;
		exponent_out = exponent_A;

		// need to shift result over (for underflow to subnormal case)
		// don't shift if fraction is '0 (infinite loop)
		// don't shift if both numbers are already subnormal (will affect result)
		// don't shift if exponent is already 0 (will underflow back to 31)
		while (~fraction_calc[TOP_FRAC_CALC_BIT] & (fraction_calc != '0) & ~(~normal_A & ~normal_B) & (exponent_out > '0))
		begin
			fraction_calc <<= 1;
			exponent_out -= 1;
		end

		if ((exponent_out == '0) & ~(~normal_A & ~normal_B)) // same check as while loop
		begin
			// normal underflow to subnormal
			fraction_out = fraction_calc >> 1;
		end
		else
		begin
			// no underflow
			fraction_out = fraction_calc;
		end
	end

	// sum time :)
	if ((exponent_A == '1 & fraction_A[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] != 0) | (exponent_B == '1 & fraction_B[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] != 0))
	begin
		// carry NaN through
		sum = FLOAT_NAN;
	end
	else if ((float1 == FLOAT_INF) | (float1 == FLOAT_INFN) | (float2 == FLOAT_INF) | (float2 == FLOAT_INFN))
	begin
		// A and/or B is infinite
		if ((exponent_A == '1) & (exponent_B == '1))
		begin
			if (sign_A == sign_B)
			begin
				// add infinities together (same sign)
				sum = sign_A ? FLOAT_INFN : FLOAT_INF;
			end
			else
			begin
				// inf + -inf or -inf + inf (result = NaN)
				sum = FLOAT_NAN;
			end
		end
		else if (exponent_A == '1)
		begin
			// A is infinite
			sum = sign_A ? FLOAT_INFN : FLOAT_INF;
		end
		else
		begin
			// B is infinite
			sum = sign_B ? FLOAT_INFN : FLOAT_INF;
		end
	end
	else if ((exponent_difference == 0) & (fraction_out == 0) & (normal_A == normal_B))
	begin
		// x + -x or -x + x
		sum = FLOAT_ZERO;
	end
	else
	begin
		if (exponent_out == '1)
		begin
			if (sign_A)
			begin
				// negative infinity
				sum = FLOAT_INFN;
			end
			else
			begin
				// positive infinity
				sum = FLOAT_INF;
			end
		end
		else
		begin
			// no special cases, assemble final sum

			// rounding bits
			guard_bit = fraction_out[BOTTOM_FRAC_OUT_BIT - 1];		// MSB rounding bit after fraction
			rounding_bit = fraction_out[BOTTOM_FRAC_OUT_BIT - 2];	// LSB rounding bit after fraction
			sticky_bit = |fraction_out[BOTTOM_FRAC_OUT_BIT - 3 : 0];	// logical OR of all remaining bits

			// handle rounding
			casez (rounding_mode)

				ROUND_NEAREST_EVEN:
				begin
					// normal rounding mode
					if (~guard_bit)
					begin
						// truncate result
						sum = { sign_A, exponent_out, fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] };
					end
					else if (rounding_bit | sticky_bit)
					begin
						// increment result
						if (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] == '1)
						begin
							if (exponent_out == '1)
							begin
								if (sign_A)
								begin
									sum = FLOAT_INFN;
								end
								else
								begin
									sum = FLOAT_INF;
								end
							end
							else
							begin
								sum = { sign_A, exponent_out + 1'b1, (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] + 1'b1) };
							end
						end
						else
						begin
							sum = { sign_A, exponent_out, (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] + 1'b1) };
						end
					end
					else
					begin
						// TODO below should be correct, but online calculators don't like it
						// "halfway" case
						if (fraction_out[BOTTOM_FRAC_OUT_BIT])
						begin
							// odd (round up)
							// increment result
							if (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] == '1)
							begin
								if (exponent_out == '1)
								begin
									if (sign_A)
									begin
										sum = FLOAT_INFN;
									end
									else
									begin
										sum = FLOAT_INF;
									end
								end
								else
								begin
									sum = { sign_A, exponent_out + 1'b1, (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] + 1'b1) };
								end
							end
							else
							begin
								sum = { sign_A, exponent_out, (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] + 1'b1) };
							end
						end
						else
						begin
							// even (round down)
							sum = { sign_A, exponent_out, fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] };
						end
					end
				end

				ROUND_INF:
				begin
					if (sign_A)
					begin
						// negative number, will always truncate
						sum = { sign_A, exponent_out, fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] };
					end
					else
					begin
						// positive number, will round up if any bits after LSB
						if (guard_bit | rounding_bit | sticky_bit)
						begin
							// increment result
							if (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] == '1)
							begin
								if (exponent_out == '1)
								begin
									if (sign_A)
									begin
										sum = FLOAT_INFN;
									end
									else
									begin
										sum = FLOAT_INF;
									end
								end
								else
								begin
									sum = { sign_A, exponent_out + 1'b1, (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] + 1'b1) };
								end
							end
							else
							begin
								sum = { sign_A, exponent_out, (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] + 1'b1) };
							end
						end
						else
						begin
							// result is exact
							sum = { sign_A, exponent_out, fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] };
						end
					end
				end

				ROUND_INFN:
				begin
					if (sign_A)
					begin
						// negative number, will round to larger magnitude if any bits after LSB
						if (guard_bit | rounding_bit | sticky_bit)
						begin
							// increment result
							if (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] == '1)
							begin
								if (exponent_out == '1)
								begin
									if (sign_A)
									begin
										sum = FLOAT_INFN;
									end
									else
									begin
										sum = FLOAT_INF;
									end
								end
								else
								begin
									sum = { sign_A, exponent_out + 1'b1, (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] + 1'b1) };
								end
							end
							else
							begin
								sum = { sign_A, exponent_out, (fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] + 1'b1) };
							end
						end
						else
						begin
							// result is exact
							sum = { sign_A, exponent_out, fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] };
						end
					end
					else
					begin
						// positive number, will always truncate
						sum = { sign_A, exponent_out, fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] };
					end
				end

				ROUND_ZERO:
				begin
					// truncate result
					sum = { sign_A, exponent_out, fraction_out[TOP_FRAC_OUT_BIT : BOTTOM_FRAC_OUT_BIT] };
				end
				
			endcase
		end
	end
end

endmodule