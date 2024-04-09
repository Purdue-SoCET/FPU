`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_classify_16bit;
	import fpu_types_pkg::*;

	parameter PERIOD = 10;
	logic CLK = 0;
	logic [HALF_FLOAT_W - 1 : 0] tb_float1;
	logic [9:0] tb_out;
	always #(PERIOD/2) CLK++;

	float_classify_16bit Zfh (.float1(tb_float1), .out(tb_out));
	test PROG (.CLK(CLK), .tb_float1(tb_float1), .tb_out(tb_out));
endmodule

program test
(
	input logic CLK,

	output logic [HALF_FLOAT_W - 1:0] tb_float1,

	input logic [9:0] tb_out
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [7:0] test_num;
logic [9:0] test_result;

initial begin
	// generate waveform files
	$dumpfile("waveform_classify.fst");
	$dumpvars;

	/////////// -INF ///////////
	test_num += 1;
	tb_float1 = HALF_INFN;	// -inf
	test_result = 10'b0000000001;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);

	/////////// NEGATIVE NORMAL ///////////
	test_num += 1;
	tb_float1 = 16'hC500;	// -5.0
	test_result = 10'b0000000010;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);

	/////////// NEGATIVE SUBNORMAL ///////////
	test_num += 1;
	tb_float1 = 16'h8100;	// -1.526E-5
	test_result = 10'b0000000100;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);

	/////////// -0 ///////////
	test_num += 1;
	tb_float1 = HALF_ZERON;	// -0
	test_result = 10'b0000001000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);

	/////////// +0 ///////////
	test_num += 1;
	tb_float1 = HALF_ZERO;	// +0
	test_result = 10'b0000010000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);

	/////////// POSITIVE SUBNORMAL ///////////
	test_num += 1;
	tb_float1 = 16'h0100;	// 1.526E-5
	test_result = 10'b0000100000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);

	/////////// POSITIVE NORMAL ///////////
	test_num += 1;
	tb_float1 = 16'h4500;	// 5.0
	test_result = 10'b0001000000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);

	/////////// INF ///////////
	test_num += 1;
	tb_float1 = HALF_INF;	// inf
	test_result = 10'b0010000000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);

	/////////// SIGNALING NAN ///////////
	test_num += 1;
	tb_float1 = HALF_SNAN;	// SNAN
	test_result = 10'b0100000000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);

	/////////// QUIET NAN ///////////
	test_num += 1;
	tb_float1 = HALF_QNAN;	// QNAN
	test_result = 10'b1000000000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Expected result: %10b", tb_float1, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%10b)\n", tb_out);
	@(negedge CLK);
	
	$finish;
end

endprogram