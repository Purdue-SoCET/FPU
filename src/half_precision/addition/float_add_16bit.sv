`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_add_16bit (
	input logic CLK,
	input logic nRST,

	input logic [HALF_FLOAT_W - 1 : 0] float1,
	input logic [HALF_FLOAT_W - 1 : 0] float2,
	output logic [HALF_FLOAT_W - 1 : 0] sum,

	output logic stall
);

// internal signals
logic A_larger;

logic sign_A, sign_B;
logic [4:0] exponent_A, exponent_B;
logic [9:0] fraction_A, fraction_B;

logic [4:0] exponent_difference;
logic carry_temp;
logic [9:0] fraction_temp; // TODO calculate correct length of this
logic [4:0] exponent_loop_counter; // TODO calculate correct length of this

// next state signals
logic [HALF_FLOAT_W - 1 : 0] sum_nxt;
logic stall_nxt; // 'processing'

logic [9:0] fraction_temp_nxt; // TODO calculate correct length of this

// assign statements
assign A_larger = (float1[14:10] > float2[14:10]) | ((float1[14:10] == float2[14:10]) & (float1[9:0] >= float2[9:0])); // A_larger will be 1 if float1 >= float2
// hardwire internal 'A' to larger of two inputs
assign sign_A = A_larger ? float1[15] : float2[15];
assign exponent_A = A_larger ? float1[14:10] : float2[14:10];
assign fraction_A = A_larger ? float1[9:0] : float2[9:0];
// hardwire internal 'B' to smaller of two inputs
assign sign_B = A_larger ? float2[15] : float1[15];
assign exponent_B = A_larger ? float2[14:10] : float1[14:10];
assign fraction_B = (A_larger ? float2[9:0] : float1[9:0]) >> exponent_difference; // bit shift to 'align' float1 and float2
// loop logic
assign exponent_difference = exponent_A - exponent_B; // due to setup, this will always be >= 0

// A will always be the larger input

always_ff @ (posedge CLK, negedge nRST) begin : NXT_LOGIC

	if (~nRST) begin

		sum <= '0;
		stall <= '0;

	end else begin

		sum <= sum_nxt;
		stall <= stall_nxt;

	end
end

always_comb begin : LOOP_LOGIC
	
	// default values
	sum_nxt = sum;
	stall_nxt = stall;

	carry_temp = '0; // only used as intermediate step, shouldn't matter if reset
	fraction_temp_nxt = fraction_temp;
	exponent_loop_counter = '0; // TODO better way to handle?

	// handle stall/processing
	if (~stall & ~fraction_temp[9]) begin // TODO fix index value

		stall_nxt = 1'b1; // start processing

		// need to check if the fraction ADD/SUB causes a carry out and adjust exponent counter accordingly
		{ carry_temp, fraction_temp_nxt } = (sign_A == sign_B) ? fraction_A + fraction_B : fraction_A - fraction_B; // generate carry out correctly for ADD/SUB

		if (carry_temp) begin

			fraction_temp_nxt = fraction_temp >> 1;
			exponent_loop_counter = exponent_A + 1;

		end

	end else if (stall & ~fraction_temp[9]) begin // TODO fix index value

		// shift fraction over until MSB is a 1 to avoid losing precision
		fraction_temp_nxt = fraction_temp << 1;
		exponent_loop_counter -= 1; // adjust result exponent accordingly
	
	end else if (stall & fraction_temp[9]) begin // TODO fix index value

		stall_nxt = 1'b0; // done processing

		// create final sum
		sum_nxt = { sign_A, exponent_loop_counter, fraction_temp[9:0] };

	end else begin

		// TODO check? (this is done processing state)
		
	end
end

endmodule