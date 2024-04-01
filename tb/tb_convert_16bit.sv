`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_convert_16bit;
	import fpu_types_pkg::*;

	parameter PERIOD = 10;
	logic CLK = 0;
	logic [31:0] tb_in;
	fpu_cvt_type_t tb_cvt_type;
	logic [31:0] tb_out;
	always #(PERIOD/2) CLK++;

	float_convert_16bit Zfh (.in(tb_in), .cvt_type(tb_cvt_type), .out(tb_out));
	test PROG (.CLK(CLK), .tb_in(tb_in), .tb_cvt_type(tb_cvt_type), .tb_out(tb_out));
endmodule

program test
(
	input logic CLK,

	output logic [31:0] tb_in,

	output fpu_cvt_type_t tb_cvt_type,

	input logic [31:0] tb_out
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [7:0] test_num;
logic [31:0] test_result;

initial begin
	// generate waveform files
	$dumpfile("waveform_convert.fst");
	$dumpvars;

	/////////// -64.5 : -64 (HALF -> INT) ///////////
	test_num += 1;
	tb_in = 32'hD408;		// -64.5
	tb_cvt_type = FUNCT_W_H;
	test_result = -32'd64;	// -64
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// -12.125 : -12 (HALF -> INT) ///////////
	test_num += 1;
	tb_in = 32'hCA10;		// -12.125
	tb_cvt_type = FUNCT_W_H;
	test_result = -32'd12;	// -12
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// 64.5 : 64 (HALF -> INT) ///////////
	test_num += 1;
	tb_in = 32'h5408;		// 64.5
	tb_cvt_type = FUNCT_W_H;
	test_result = 32'd64;	// 64
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// 12.125 : 12 (HALF -> INT) ///////////
	test_num += 1;
	tb_in = 32'h4A10;		// 12.125
	tb_cvt_type = FUNCT_W_H;
	test_result = 32'd12;	// 12
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// -64.5 : 0 (HALF -> UINT) ///////////
	test_num += 1;
	tb_in = 32'hD408;		// -64.5
	tb_cvt_type = FUNCT_WU_H;
	test_result = 32'd0;	// 0
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// 64.5 : 64 (HALF -> UINT) ///////////
	test_num += 1;
	tb_in = 32'h5408;		// 64.5
	tb_cvt_type = FUNCT_WU_H;
	test_result = 32'd64;	// 64
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// 0.9995 : 0 (HALF -> INT) ///////////
	test_num += 1;
	tb_in = 32'h3BFF;		// 0.9995
	tb_cvt_type = FUNCT_W_H;
	test_result = 32'd0;	// 0
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// SUBNORMAL : 0 (HALF -> INT) ///////////
	test_num += 1;
	tb_in = 32'h03FF;		// 6.1E-5
	tb_cvt_type = FUNCT_W_H;
	test_result = 32'd0;	// 0
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// INF : MAX (HALF -> INT) ///////////
	test_num += 1;
	tb_in = {16'b0, HALF_INF};	// INF
	tb_cvt_type = FUNCT_W_H;
	test_result = 32'h7FFFFFFF;	// MAX
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// INF : MAX (HALF -> UINT) ///////////
	test_num += 1;
	tb_in = {16'b0, HALF_INF};	// INF
	tb_cvt_type = FUNCT_WU_H;
	test_result = 32'hFFFFFFFF;	// MAX
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// NaN : MAX (HALF -> INT) ///////////
	test_num += 1;
	tb_in = {16'b0, HALF_NAN};	// INF
	tb_cvt_type = FUNCT_W_H;
	test_result = 32'h7FFFFFFF;	// MAX
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// NAN : MAX (HALF -> UINT) ///////////
	test_num += 1;
	tb_in = {16'b0, HALF_NAN};	// INF
	tb_cvt_type = FUNCT_WU_H;
	test_result = 32'hFFFFFFFF;	// MAX
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// -INF : MIN (HALF -> INT) ///////////
	test_num += 1;
	tb_in = {16'b0, HALF_INFN};	// -INF
	tb_cvt_type = FUNCT_W_H;
	test_result = 32'h80000000;	// MIN
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);

	/////////// -INF : 0 (HALF -> UINT) ///////////
	test_num += 1;
	tb_in = {16'b0, HALF_INFN};	// INF
	tb_cvt_type = FUNCT_WU_H;
	test_result = 32'h00000000;	// 0
	$display("Test case %d", test_num);
	$display("Input: %8h | Output: %8h | Expected result: %8h", tb_in, tb_out, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%1b)\n", tb_out);
	@(negedge CLK);
	
	$finish;
end

endprogram