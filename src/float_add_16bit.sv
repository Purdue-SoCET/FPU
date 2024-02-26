`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_add_16bit
(
	input logic [HALF_FLOAT_W - 1 : 0] float1,
	input logic [HALF_FLOAT_W - 1 : 0] float2,

	input fpu_rounding_mode_t rounding_mode,

	output logic [HALF_FLOAT_W - 1 : 0] sum
);

float_add
# (
	.FLOAT_WIDTH(HALF_FLOAT_W),
	.EXPONENT_WIDTH(HALF_EXPONENT_W),
	.FRACTION_WIDTH(HALF_FRACTION_W),

	.FLOAT_INF(HALF_INF),
	.FLOAT_INFN(HALF_INFN),
	.FLOAT_NAN(HALF_NAN),
	.FLOAT_ZERO(HALF_ZERO)
) adder_16bit (
	.*
);

endmodule