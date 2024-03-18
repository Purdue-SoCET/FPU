`ifndef FPU_TYPES_PKG_VH
`define FPU_TYPES_PKG_VH
package fpu_types_pkg;

	// word width and size
	parameter WORD_W	= 32;

	// instruction format widths
	parameter OP_W		= 7;
	parameter REG_W		= 5;
	parameter WIDTH_W 	= 3;
	parameter IMM_W		= 12;
	parameter FMT_W		= 2;
	parameter RM_W		= 3;
	parameter FUNCT5_W	= 5;

	// special format widths
	parameter CLASSIFY_W	= 10;

	// floating-point widths
	parameter SIGN_W			= 1;
	parameter HALF_EXPONENT_W	= 5;
	parameter HALF_FRACTION_W	= 10;
	parameter HALF_FLOAT_W		= 16;

	// half-precision special number representations
	parameter HALF_ZERO		= 16'h0000; // exponent 0, mantissa zero
	parameter HALF_ZERON	= 16'h8000; // exponent 0, mantissa zero, negative
	parameter HALF_INF		= 16'h7C00; // exponent 255, mantissa zero
	parameter HALF_INFN		= 16'hFC00; // exponent 255, mantissa zero, negative
	parameter HALF_NAN		= 16'hFFFF; // exponent 255, mantissa non-zero

	// top-level operations
	typedef enum {
		FPU_HALF_ADD,
		FPU_HALF_SUB,
		FPU_HALF_MUL,
		FPU_HALF_DIV,
		FPU_HALF_MIN,
		FPU_HALF_MAX,
		FPU_HALF_SQRT,
		FPU_HALF_SGNJ,
		FPU_HALF_FEQ,
		FPU_HALF_FLT,
		FPU_HALF_FLE,
		FPU_HALF_CLASS,
		FPU_HALF_MADD,
		FPU_HALF_MSUB,
		FPU_HALF_NMADD,
		FPU_HALF_NMSUB
	} fpu_operation_t;

	// opcode field types
	typedef enum logic [OP_W - 1 : 0] {

		// OPCODE_LOADFP	= 7'b0000111,	// unused for Zhinx
		// OPCODE_STOREFP	= 7'b0100111,	// unused for Zhinx
		OPCODE_OPFP		= 7'b1010011,
		OPCODE_FMADD	= 7'b1000011,
		OPCODE_FMSUB	= 7'b1000111,
		OPCODE_FNMADD	= 7'b1001111,
		OPCODE_FNMSUB	= 7'b1001011

	} fpu_opcode_t;

	// funct field types
	typedef enum logic [FUNCT5_W - 1 : 0] {

		FUNCT_FADD		= 5'b00000,
		FUNCT_FSUB		= 5'b00001,
		FUNCT_FMUL		= 5'b00010,
		FUNCT_FDIV		= 5'b00011,
		FUNCT_FMINMAX	= 5'b00101, // include FMIN/FMAX
		FUNCT_FSQRT		= 5'b01011,
		FUNCT_FSGNJ		= 5'b00100, // includes FSGNJ, FSGNJN, FSGNJX
		FUNCT_FCOMP		= 5'b10100, // include FEQ, FLT, FLE
		FUNCT_FCLASS	= 5'b11100
		// convert and move instructions not used for Zhinx

	} fpu_funct_t;

	// TODO: unused for Zhinx
	// width field types
	// typedef enum logic [WIDTH_W - 1 : 0] {

	// 	WIDTH_SINGLE	= 3'b010,
	// 	WIDTH_DOUBLE	= 3'b011,
	// 	WIDTH_HALF		= 3'b000, // TODO: unknown
	// 	WIDTH_QUAD		= 3'b100

	// } fpu_width_t;

	// fmt field types
	typedef enum logic [FMT_W - 1 : 0] {

		FMT_SINGLE	= 2'b00,
		FMT_DOUBLE	= 2'b01,
		FMT_HALF	= 2'b10,
		FMT_QUAD	= 2'b11

	} fpu_fmt_t;

	// rm field types
	typedef enum logic [RM_W - 1 : 0] {

		RM_RNE	= 3'b000,	// round to nearest, ties to even
		RM_RTZ	= 3'b001,	// round towards zero
		RM_RDN	= 3'b010,	// round down (towards -inf)
		RM_RUP	= 3'b011,	// round up (rowards inf)
		RM_RMM	= 3'b100,	// round to nearest, ties to max magnitude
		RM_DYN	= 3'b111	// selects dynamic rounding mode; in rounding mode register, invalid

	} fpu_rm_t;

	typedef enum logic [RM_W - 1 : 0] {

		// for FMINMAX instructions
		RM_FMIN	= 3'b000,
		RM_FMAX	= 3'b001

	} fpu_mm_rm_t;

	typedef enum logic [RM_W - 1 : 0] {

		// for FCOMP instructions
		RM_FEQ		= 3'b010,
		RM_FLT		= 3'b001,
		RM_FLE		= 3'b000

	} fpu_cmp_rm_t;

	// classify result bits
	typedef enum logic [CLASSIFY_W - 1 : 0] {

		CLASS_INFN		= 10'b0000000001,	// rs1 is -inf
		CLASS_NORMN		= 10'b0000000010,	// rs1 is a negative normal number
		CLASS_SUBNORMN	= 10'b0000000100,	// rs1 is a negative subnormal number
		CLASS_ZERON		= 10'b0000001000,	// rs1 is -0
		CLASS_ZERO		= 10'b0000010000,	// rs1 is +0
		CLASS_SUBNORM	= 10'b0000100000,	// rs1 is a positive subnormal number
		CLASS_NORM		= 10'b0001000000,	// rs1 is a positive normal number
		CLASS_INF		= 10'b0010000000,	// rs1 is +inf
		CLASS_SIGNAN	= 10'b0100000000,	// rs1 is a signaling NaN
		CLASS_QNAN		= 10'b1000000000	// rs1 is a quiet NaN

	} fpu_classify_w;

typedef logic [WORD_W-1:0] word_t;
typedef logic [HALF_EXPONENT_W-1:0] exp_t; // 5 bits
typedef logic [HALF_FRACTION_W-1:0] mant_t; // 10 bits

typedef struct packed {
	logic [4:0] funct5;
	logic [1:0] fmt;
	logic [4:0] rs2;
	logic [4:0] rs1;
	logic [2:0] rm;
	logic [4:0] rd;
	logic [6:0] opcode;
} rv32zhinx_insn_t; // 1 word

endpackage
`endif // FPU_TYPES_PKG_VH