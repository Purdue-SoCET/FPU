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
// internal signals for hw
logic sign;
logic [31:0] magnitude;
logic [4:0] exponent;
logic [9:0] mantissa;
logic [10:0] extended_mantissa;

logic [31:0] msb_pos;
logic [31:0] raw_exponent;

logic [31:0] int32;
logic  [15:0] float16;
logic [2:0]  rm;

assign int32 = in;
assign out = {16'b0, float16};
assign rm = '0;



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

	// Init for hw
	sign = '0;
	magnitude = '0;
	exponent = '0;
	mantissa = '0;
	extended_mantissa = '0;
	msb_pos = '0;
	raw_exponent = '0;
	float16 = '0;

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

        // Handle zero separately
        if (int32 == '0) begin
            float16 = 0;
        end else if (rm == '0 && $signed(int32) > 65519) begin
            float16 = HALF_INF;
        end else if (rm == '0 && $signed(int32) < -65519) begin
            float16 = HALF_INFN;
        end else begin
            // Extract sign bit
            sign = int32[31];
            // Absolute value (handling 2's complement)
            magnitude = sign ? (~int32 + 1) : int32;

            // Determine the position of the most significant bit (MSB)
            msb_pos = -1; // Default for zero
            for (int i = 30; i >= 0; i--) begin
                if (magnitude[i]) begin
                    msb_pos = i;
                    break;
                end
            end
            // Calculate exponent and mantissa

            // Bias for 5-bit exponent is 15
            raw_exponent = msb_pos + 15;

            // Rounding can affect both mantissa and exponent
            extended_mantissa = magnitude[msb_pos-1 -: 11]; // 11 bits for rounding

            // Apply rounding based on mode
            // Additional rounding logic needed here based on rounding_mode
            // ...
            casez (rm)
                RM_RMM: begin // tie to max
                    if (extended_mantissa[0]) begin
                        if (extended_mantissa == '1) begin
                            raw_exponent += 1;
                        end
                        extended_mantissa += 1;
                    end
                end

                RM_RNE: begin
                    if (extended_mantissa[0]) begin  //tie to even
                        if (magnitude[msb_pos-11 -: 2] == '0) begin //tie
                            if (extended_mantissa[1]) begin // even
                                extended_mantissa += 1;
                            end
                        end else begin //not tie
                            if (extended_mantissa == '1) begin
                                raw_exponent += 1;
                            end
                            extended_mantissa += 1;
                        end
                    end
                end

                RM_RUP: begin //round up
                    if (magnitude[msb_pos-11 -: 2] != '0) begin
                        if (extended_mantissa == '1) begin
                            raw_exponent += 1;
                        end
                        extended_mantissa += 1;
                    end
                end

                RM_RDN: begin // round down
                    if (sign) begin
                        if (magnitude[msb_pos-11 -: 2] != '0) begin
                            if (extended_mantissa == '1) begin
                                raw_exponent += 1;
                            end
                            extended_mantissa += 1;
                        end
                    end
                end

                default: begin 
                    //default is round to zero
                    //no operation is needed
                end
            endcase 
                

            // Adjust exponent and mantissa after rounding
            exponent = raw_exponent[4:0]; // Assuming no overflow/underflow for simplicity
            mantissa = extended_mantissa[9:0]; // Truncated to 10 bits

            // Assemble the float16 value
            if (raw_exponent > 31) begin
                float16 = sign ? HALF_INFN: HALF_INF;
            end else begin
                float16 = {sign, exponent, mantissa};
            end   
        end

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