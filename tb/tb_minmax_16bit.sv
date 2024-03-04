`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_minmax_16bit;
	import fpu_types_pkg::*;

	parameter PERIOD = 10;
	logic CLK = 0;
	logic [HALF_FLOAT_W - 1 : 0] tb_float1, tb_float2, tb_out;
	logic tb_max;
	always #(PERIOD/2) CLK++;

	float_minmax_16bit Zfh (.float1(tb_float1), .float2(tb_float2), .max(tb_max), .out(tb_out));
	test PROG (.CLK(CLK), .tb_float1(tb_float1), .tb_float2(tb_float2), .tb_max(tb_max), .tb_out(tb_out));
endmodule

program test
(
	input logic CLK,

	output logic [HALF_FLOAT_W - 1:0] tb_float1,
	output logic [HALF_FLOAT_W - 1:0] tb_float2,

	output logic tb_max,

	input logic [HALF_FLOAT_W - 1:0] tb_out
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [7:0] test_num;
logic [15:0] test_result;

initial begin
	// generate waveform files
	$dumpfile("waveform_minmax.fst");
	$dumpvars;

	/////////// Zero : Zero (MIN) ///////////
	test_num += 1;
	tb_float1 = 16'h0;
	tb_float2 = 16'h0;
	tb_max = 1'b0;
	test_result = 16'h0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Positive : Zero (MIN) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	tb_float2 = 16'h0;		// 0.0
	tb_max = 1'b0;			// MIN
	test_result = 16'h0;	// 0.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Positive : Zero (MAX) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	tb_float2 = 16'h0;		// 0.0
	tb_max = 1'b1;			// MIN
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Zero : Positive (MIN) ///////////
	test_num += 1;
	tb_float1 = 16'h0;		// 0.0
	tb_float2 = 16'h4500;	// 5.0
	tb_max = 1'b0;			// MIN
	test_result = 16'h0;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Zero : Positive (MAX) ///////////
	test_num += 1;
	tb_float1 = 16'h0;		// 0.0
	tb_float2 = 16'h4500;	// 5.0
	tb_max = 1'b1;			// MIN
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Negative : Zero (MIN) ///////////
	test_num += 1;
	tb_float1 = 16'hC500;	// -5.0
	tb_float2 = 16'h0;		// 0.0
	tb_max = 1'b0;			// MIN
	test_result = 16'hC500;	// -5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Negative : Zero (MAX) ///////////
	test_num += 1;
	tb_float1 = 16'hC500;	// -5.0
	tb_float2 = 16'h0;		// 0.0
	tb_max = 1'b1;			// MIN
	test_result = 16'h0;	// 0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Zero : Negative (MIN) ///////////
	test_num += 1;
	tb_float1 = 16'h0;		// 0.0
	tb_float2 = 16'hC500;	// -5.0
	tb_max = 1'b0;			// MIN
	test_result = 16'hC500;	// -5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Zero : Negative (MAX) ///////////
	test_num += 1;
	tb_float1 = 16'h0;		// 0.0
	tb_float2 = 16'hC500;	// -5.0
	tb_max = 1'b1;			// MIN
	test_result = 16'h0;	// 0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Negative : Positive (MIN) ///////////
	test_num += 1;
	tb_float1 = 16'hC500;	// -5.0
	tb_float2 = 16'h4500;	// 5.0
	tb_max = 1'b0;			// MIN
	test_result = 16'hC500;	// -5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Negative : Positive (MAX) ///////////
	test_num += 1;
	tb_float1 = 16'hC500;	// -5.0
	tb_float2 = 16'h4500;	// 5.0
	tb_max = 1'b1;			// MIN
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Positive : Negative (MIN) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	tb_float2 = 16'hC500;	// -5.0
	tb_max = 1'b0;			// MIN
	test_result = 16'hC500;	// -5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Positive : Negative (MAX) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	tb_float2 = 16'hC500;	// -5.0
	tb_max = 1'b1;			// MIN
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// NaN : Negative (MIN) ///////////
	test_num += 1;
	tb_float1 = HALF_NAN;	// NaN
	tb_float2 = 16'hC500;	// -5.0
	tb_max = 1'b0;			// MIN
	test_result = 16'hC500;	// -5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Positive : NaN (MIN) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	tb_float2 = HALF_NAN;	// NaN
	tb_max = 1'b0;			// MIN
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// NaN : NaN (MIN) ///////////
	test_num += 1;
	tb_float1 = HALF_NAN;	// NaN
	tb_float2 = HALF_NAN;	// NaN
	tb_max = 1'b0;			// MIN
	test_result = HALF_NAN;	// NaN
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Zero : -Zero (MIN) ///////////
	test_num += 1;
	tb_float1 = HALF_ZERO;		// 0.0
	tb_float2 = HALF_ZERON;		// -0.0
	tb_max = 1'b0;				// MIN
	test_result = HALF_ZERON;	// -0.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Zero : -Zero (MAX) ///////////
	test_num += 1;
	tb_float1 = HALF_ZERO;		// 0.0
	tb_float2 = HALF_ZERON;		// -0.0
	tb_max = 1'b1;				// MAX
	test_result = HALF_ZERO;	// 0.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Inf : Positive (MIN) ///////////
	test_num += 1;
	tb_float1 = HALF_INF;	// inf
	tb_float2 = 16'h4500;	// 5.0
	tb_max = 1'b0;			// MIN
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// Inf : Positive (MAX) ///////////
	test_num += 1;
	tb_float1 = HALF_INF;	// inf
	tb_float2 = 16'h4500;	// 5.0
	tb_max = 1'b1;			// MIN
	test_result = HALF_INF;	// inf
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// -Inf : Positive (MIN) ///////////
	test_num += 1;
	tb_float1 = HALF_INFN;		// -inf
	tb_float2 = 16'h4500;		// 5.0
	tb_max = 1'b0;				// MIN
	test_result = HALF_INFN;	// -inf
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// -Inf : Positive (MAX) ///////////
	test_num += 1;
	tb_float1 = HALF_INFN;	// -inf
	tb_float2 = 16'h4500;	// 5.0
	tb_max = 1'b1;			// MIN
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);
	
	$finish;
end

task print(input [15:0] half_product, input [3:0] testNum);
	logic half_sign;
	logic [4:0] half_exp;
	logic [10:0] double_exp;
	logic [9:0] half_mant;
	logic [63:0] double_product;

	half_sign = half_product[15];
	if (half_product[14:10] != '0) begin
		half_exp = half_product[14:10] - 5'd15; //unbiased
		double_exp = {6'b0, half_exp} + 10'd1023; //biased
	end else begin
		double_exp = '0;
	end
	
	half_mant = half_product[9:0];
	
	double_product = {half_sign, double_exp, half_mant, 42'b0};

	$display("test num = %d: product = %f", testNum, $bitstoreal(double_product));
endtask 

endprogram