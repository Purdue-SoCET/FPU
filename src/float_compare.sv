`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_compare
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

	input fpu_cmp_rm_t operation, // for FEQ, FLT, FLE

	output logic out
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

// todo handle signaling NaN

always_comb
begin : OUTPUT
	if ((float1 == FLOAT_NAN) || (float2 == FLOAT_NAN))
	begin
		assign out = 1'b0;
	end
	else if (float1 == float2)
	begin
		casez (operation)
			RM_FEQ, RM_FLE:
			begin
				assign out = 1'b1;
			end

			default:
			begin
				assign out = 1'b0;
			end
		endcase
	end
	else if (float1 == FLOAT_INFN)
	begin
		casez (operation)
			RM_FLT, RM_FLE:
			begin
				assign out = 1'b1;
			end

			default:
			begin
				assign out = 1'b0;
			end
		endcase
	end
	else if (float1_sign & ~float2_sign)
	begin
		// float1 is negative, float2 is positive
		casez (operation)
			RM_FLT, RM_FLE:
			begin
				assign out = 1'b1;
			end

			default:
			begin
				assign out = 1'b0;
			end
		endcase
	end
	else if (~float1_sign & float2_sign)
	begin
		// float1 is positive, float2 is negative
		assign out = 1'b0;
	end
	else if (float1_exponent < float2_exponent)
	begin
		// float1 is smaller than float2
		casez (operation)
			RM_FLT, RM_FLE:
			begin
				assign out = float1_sign ? 1'b0 : 1'b1;
			end

			default:
			begin
				assign out = 1'b0;
			end
		endcase
	end
	else if (float1_exponent == float2_exponent)
	begin
		if (float1_fraction < float2_fraction)
		begin
			// float1 is smaller than float2
			casez (operation)
				RM_FLT, RM_FLE:
				begin
					assign out = float1_sign ? 1'b0 : 1'b1;
				end

				default:
				begin
					assign out = 1'b0;
				end
			endcase
		end
		else if (float1_fraction > float2_fraction)
		begin
			// float1 is larger than float2
			casez (operation)
				RM_FLT, RM_FLE:
				begin
					assign out = float1_sign ? 1'b1 : 1'b0;
				end

				default:
				begin
					assign out = 1'b0;
				end
			endcase
		end
	end
	else if (float1_exponent > float2_exponent)
	begin
		// float1 is larger than float2
		casez (operation)
			RM_FLT, RM_FLE:
			begin
				assign out = float1_sign ? 1'b1 : 1'b0;
			end

			default:
			begin
				assign out = 1'b0;
			end
		endcase
	end
end

endmodule