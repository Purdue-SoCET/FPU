`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_signinj_16bit;
	import fpu_types_pkg::*;

	parameter PERIOD = 10;
	logic CLK = 0;
	logic [HALF_FLOAT_W - 1 : 0] tb_float1, tb_float2, tb_out;
	fpu_sgnj_type_t tb_type;
	always #(PERIOD/2) CLK++;

	float_signinj_16bit Zfh (.float1(tb_float1), .float2(tb_float2), .sgnj_type(tb_type), .out(tb_out));
	test PROG (.CLK(CLK), .tb_float1(tb_float1), .tb_float2(tb_float2), .tb_type(tb_type), .tb_out(tb_out));
endmodule

program test
(
	input logic CLK,

	output logic [HALF_FLOAT_W - 1:0] tb_float1,
	output logic [HALF_FLOAT_W - 1:0] tb_float2,

	output fpu_sgnj_type_t tb_type,

	input logic [HALF_FLOAT_W - 1:0] tb_out
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [7:0] test_num;
logic [15:0] test_result;

initial begin
	// generate waveform files
	$dumpfile("waveform_signinj.fst");
	$dumpvars;

	/////////// 5, -1 : (J) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	tb_float2 = 16'hBC00;	// -1.0
	tb_type = RM_J;
	test_result = 16'hC500;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// 5, -1 : (JN) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	tb_float2 = 16'hBC00;	// -1.0
	tb_type = RM_JN;
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// 5, -1 : (J) ///////////
	test_num += 1;
	tb_float1 = 16'hC500;	// -5.0
	tb_float2 = 16'h3C00;	// 1.0
	tb_type = RM_J;
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// 5, -1 : (JX) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	tb_float2 = 16'hBC00;	// -1.0
	tb_type = RM_JX;
	test_result = 16'hC500;	// -5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// 5, 1 : (JX) ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	tb_float2 = 16'h3C00;	// 1.0
	tb_type = RM_JX;
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);

	/////////// -5, -1 : (JX) ///////////
	test_num += 1;
	tb_float1 = 16'hC500;	// -5.0
	tb_float2 = 16'hBC00;	// -1.0
	tb_type = RM_JX;
	test_result = 16'h4500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_out);
	@(negedge CLK);
	
	$finish;
end

endprogram