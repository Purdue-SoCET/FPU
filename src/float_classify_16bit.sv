`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_classify_16bit
(
	input logic [HALF_FLOAT_W - 1 : 0] float1,

	output logic [9:0] out
);

float_classify
# (
	.FLOAT_WIDTH(HALF_FLOAT_W),
	.EXPONENT_WIDTH(HALF_EXPONENT_W),
	.FRACTION_WIDTH(HALF_FRACTION_W),

	.FLOAT_INF(HALF_INF),
	.FLOAT_INFN(HALF_INFN),
	.FLOAT_QNAN(HALF_QNAN),
	.FLOAT_SNAN(HALF_SNAN),
	.FLOAT_ZERO(HALF_ZERO),
	.FLOAT_ZERON(HALF_ZERON)
) classify_16bit (
	.*
);

endmodule