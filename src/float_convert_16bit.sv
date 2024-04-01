`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_convert_16bit
(
	input logic [31:0] in,

	input fpu_cvt_type_t cvt_type,

	output logic [31:0] out
);

float_convert
# (
	.FLOAT_WIDTH(HALF_FLOAT_W),
	.EXPONENT_WIDTH(HALF_EXPONENT_W),
	.FRACTION_WIDTH(HALF_FRACTION_W),

	.FLOAT_INF(HALF_INF),
	.FLOAT_INFN(HALF_INFN),
	.FLOAT_NAN(HALF_NAN),
	.FLOAT_ZERO(HALF_ZERO)
) convert_16bit (
	.*
);

endmodule