`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_compare_16bit;
	import fpu_types_pkg::*;

	parameter PERIOD = 10;
	logic CLK = 0;
	logic [HALF_FLOAT_W - 1 : 0] tb_float1, tb_float2;
	fpu_cmp_rm_t tb_operation;
	logic tb_out;
	always #(PERIOD/2) CLK++;

	float_compare_16bit Zfh (.float1(tb_float1), .float2(tb_float2), .operation(tb_operation), .out(tb_out));
	test PROG (.CLK(CLK), .tb_float1(tb_float1), .tb_float2(tb_float2), .tb_operation(tb_operation), .tb_out(tb_out));
endmodule

program test
(
	input logic CLK,

	output logic [HALF_FLOAT_W - 1:0] tb_float1,
	output logic [HALF_FLOAT_W - 1:0] tb_float2,

	output fpu_cmp_rm_t tb_operation,

	input logic tb_out
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [7:0] test_num;
logic test_result;

initial begin
	// generate waveform files
	$dumpfile("waveform_compare.fst");
	$dumpvars;

	/////////// Zero : Zero (FEQ) ///////////
	test_num += 1;
	tb_float1 = 16'h0;
	tb_float2 = 16'h0;
	tb_operation = RM_FEQ;
	test_result = 1'b1;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// Zero : Zero (FLT) ///////////
	test_num += 1;
	tb_float1 = 16'h0;
	tb_float2 = 16'h0;
	tb_operation = RM_FLT;
	test_result = 1'b0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// Zero : Zero (FLE) ///////////
	test_num += 1;
	tb_float1 = 16'h0;
	tb_float2 = 16'h0;
	tb_operation = RM_FLE;
	test_result = 1'b1;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// Pos : Zero (FEQ) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;
	tb_float2 = 16'h0;
	tb_operation = RM_FEQ;
	test_result = 1'b0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// Pos : Zero (FLT) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;
	tb_float2 = 16'h0;
	tb_operation = RM_FLT;
	test_result = 1'b0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// Pos : Zero (FLE) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;
	tb_float2 = 16'h0;
	tb_operation = RM_FLE;
	test_result = 1'b0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// Neg : Zero (FEQ) ///////////
	test_num += 1;
	tb_float1 = 16'hC500;
	tb_float2 = 16'h0;
	tb_operation = RM_FEQ;
	test_result = 1'b0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// Neg : Zero (FLT) ///////////
	test_num += 1;
	tb_float1 = 16'hC500;
	tb_float2 = 16'h0;
	tb_operation = RM_FLT;
	test_result = 1'b1;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// Neg : Zero (FLE) ///////////
	test_num += 1;
	tb_float1 = 16'hC500;
	tb_float2 = 16'h0;
	tb_operation = RM_FLE;
	test_result = 1'b1;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// -inf : Zero (FEQ) ///////////
	test_num += 1;
	tb_float1 = HALF_INFN;
	tb_float2 = 16'h0;
	tb_operation = RM_FEQ;
	test_result = 1'b0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// -inf : Zero (FLT) ///////////
	test_num += 1;
	tb_float1 = HALF_INFN;
	tb_float2 = 16'h0;
	tb_operation = RM_FLT;
	test_result = 1'b1;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);
	
	/////////// -inf : Zero (FLE) ///////////
	test_num += 1;
	tb_float1 = HALF_INFN;
	tb_float2 = 16'h0;
	tb_operation = RM_FLE;
	test_result = 1'b1;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// NaN : Zero (FLT) ///////////
	test_num += 1;
	tb_float1 = HALF_NAN;
	tb_float2 = 16'h0;
	tb_operation = RM_FLT;
	test_result = 1'b0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// Zero : NaN (FLE) ///////////
	test_num += 1;
	tb_float1 = 16'h0;
	tb_float2 = HALF_NAN;
	tb_operation = RM_FLE;
	test_result = 1'b0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// NaN : NaN (FLE) ///////////
	test_num += 1;
	tb_float1 = HALF_NAN;
	tb_float2 = HALF_NAN;
	tb_operation = RM_FLE;
	test_result = 1'b0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %1b", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
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