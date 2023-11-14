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
	parameter FRACTION_LSB = 0
)
(
	input logic [FLOAT_WIDTH - 1 : 0] float1,
	input logic [FLOAT_WIDTH - 1 : 0] float2,
	input logic subtract,

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

// assign statements
assign A_larger = (float1[EXPONENT_MSB : EXPONENT_LSB] > float2[EXPONENT_MSB : EXPONENT_LSB]) | ((float1[EXPONENT_MSB : EXPONENT_LSB] == float2[EXPONENT_MSB : EXPONENT_LSB]) & (float1[FRACTION_MSB : FRACTION_LSB] >= float2[FRACTION_MSB : FRACTION_LSB])); // A_larger will be 1 if float1 >= float2

// hardwire internal 'A' to larger of two inputs
assign sign_A = A_larger ? float1[SIGN] : subtract ? ~float2[SIGN] : float2[SIGN];
assign exponent_A = A_larger ? float1[EXPONENT_MSB : EXPONENT_LSB] : float2[EXPONENT_MSB : EXPONENT_LSB];
assign normal_A = exponent_A != '0;
assign fraction_A = A_larger ? { normal_A, float1[FRACTION_MSB : FRACTION_LSB] } : { normal_A, float2[FRACTION_MSB : FRACTION_LSB] };

// hardwire internal 'B' to smaller of two inputs
assign sign_B = A_larger ? subtract ? ~float2[SIGN] : float2[SIGN] : float1[SIGN];
assign exponent_B = A_larger ? float2[EXPONENT_MSB : EXPONENT_LSB] : float1[EXPONENT_MSB : EXPONENT_LSB];
assign normal_B = exponent_B != '0;
assign fraction_B = (A_larger ? { normal_B, float2[FRACTION_MSB : FRACTION_LSB] } : { normal_B, float1[FRACTION_MSB : FRACTION_LSB] }) >> exponent_difference; // bit shift to 'align' float1 and float2

// miscellaneous variables
assign exponent_difference =
	~normal_A ? exponent_A - exponent_B				// A is subnormal, and since A >= B, B is also subnormal
	: ~normal_B ? exponent_A - (exponent_B + 1'b1)	// A is not subnormal, but B is subnormal, so adjust exponent difference to account for weird subnormal exponent
	: exponent_A - exponent_B;						// A and B are normal, so calculate difference as normal

// // sum calculation
// assign exponent_out = carry_out ? exponent_A + 1'b1 : (sign_A == sign_B) ? exponent_A : exponent_A - 1;
// assign fraction_out = carry_out ? fraction_calc >> 1 : fraction_calc;

// // special cases when generating sum output
// assign sum =
// 	(exponent_A == '1 & fraction_A != 0) | (exponent_B == '1 & fraction_B != 0) ? HALF_NAN	// carry NaN through equation
// 	: exponent_out == '1 ? sign_A ? HALF_INFN : HALF_INF									// determine whether overflow occurred and correct sign
// 	: { sign_A, exponent_out, fraction_out[HALF_FRACTION_W - 1 : 0] };						// no errors, assemble sum

// generate;
// genvar i;
// 	for (i = 1; i < FRACTION_WIDTH; i++)
// 	begin
// 		if (fraction_calc[FRACTION_WIDTH:i] == '0)
// 		begin
// 			assign exponent_out = exponent_A - FRACTION_WIDTH - i;
// 			assign fraction_out = fraction_calc << FRACTION_WIDTH - i;
// 		end
// 	end
// endgenerate;

always_comb begin : SUM_CALC

	// default values
	exponent_out = '0;
	fraction_out = '0;

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
		else if (~fraction_A[FRACTION_WIDTH] & fraction_calc[FRACTION_WIDTH])
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
		{ carry_out, fraction_calc } = fraction_A - fraction_B;

		// for (integer i = FRACTION_WIDTH; i >= 0; i++)
		// begin
		// 	if (fraction_calc[i] == '0)
		// 	begin
		// 		exponent_out -= 1;
		// 		fraction_out <<= 1;
		// 	end
		// end
		if (fraction_calc[FRACTION_WIDTH:0] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH + 1);
			fraction_out = fraction_calc << (FRACTION_WIDTH + 1);
		end
		else if (fraction_calc[FRACTION_WIDTH:1] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 0);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 0);
		end
		else if (fraction_calc[FRACTION_WIDTH:2] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 1);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 1);
		end
		else if (fraction_calc[FRACTION_WIDTH:3] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 2);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 2);
		end
		else if (fraction_calc[FRACTION_WIDTH:4] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 3);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 3);
		end
		else if (fraction_calc[FRACTION_WIDTH:5] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 4);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 4);
		end
		else if (fraction_calc[FRACTION_WIDTH:6] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 5);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 5);
		end
		else if (fraction_calc[FRACTION_WIDTH:7] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 6);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 6);
		end
		else if (fraction_calc[FRACTION_WIDTH:8] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 7);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 7);
		end
		else if (fraction_calc[FRACTION_WIDTH:9] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 8);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 8);
		end
		else if (fraction_calc[FRACTION_WIDTH:10] == '0)
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 9);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 9);
		end
		else
		begin
			exponent_out = exponent_A - (FRACTION_WIDTH - 10);
			fraction_out = fraction_calc << (FRACTION_WIDTH - 10);
		end
	end

	// sum time :)
	if ((exponent_A == '1 & fraction_A != 0) | (exponent_B == '1 & fraction_B != 0))
	begin
		// carry NaN through
		sum = HALF_NAN; // TODO change for other width floats (parameter pass in)
	end
	else
	begin
		if (exponent_out == '1)
		begin
			if (sign_A)
			begin
				// negative infinity
				sum = HALF_INFN;
			end
			else
			begin
				// positive infinity
				sum = HALF_INF;
			end
		end
		else
		begin
			// correct sign
			sum = { sign_A, exponent_out, fraction_out[HALF_FRACTION_W - 1 : 0] };
		end
	end
end

endmodule