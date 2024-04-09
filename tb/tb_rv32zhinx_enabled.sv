`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_rv32zhinx_enabled;
	import fpu_types_pkg::*;

	// input CLK,
	// input nRST,
	// input rv32zhinx_start,
	// input fpu_operation_t operation,
	// input [WORD_W - 1 : 0] rv32zhinx_a,
	// input [WORD_W - 1 : 0] rv32zhinx_b,
	// output rv32zhinx_done,
	// output logic [WORD_W - 1 : 0] rv32zhinx_out

	parameter PERIOD = 10;
	logic CLK = 0;
	logic nRST = 0;
	logic tb_start;
	fpu_operation_t tb_operation;
	logic [WORD_W - 1 : 0] tb_inputa, tb_inputb;
	logic tb_done;
	logic [WORD_W - 1 : 0] tb_out;

	always #(PERIOD / 2) CLK++;

	rv32zhinx_enabled toplevel (.CLK(CLK), .nRST(nRST), .rv32zhinx_start(tb_start), .operation(tb_operation), .rv32zhinx_a(tb_inputa), .rv32zhinx_b(tb_inputb), .rv32zhinx_done(tb_done), .rv32zhinx_out(tb_out));
	test PROG (.CLK(CLK), .nRST(nRST), .tb_start(tb_start), .tb_operation(tb_operation), .tb_inputa(tb_inputa), .tb_inputb(tb_inputb), .tb_done(tb_done), .tb_out(tb_out));
endmodule

program test
(
	input logic CLK,
	output logic nRST,

	output logic tb_start,

	output fpu_operation_t tb_operation,

	output logic [WORD_W - 1 : 0] tb_inputa,
	output logic [WORD_W - 1 : 0] tb_inputb,

	input logic tb_done,
	input logic [WORD_W - 1 : 0] tb_out
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [7:0] test_num;
logic [31:0] test_result;

initial begin
	// generate waveform files
	$dumpfile("waveform_enabled.fst");
	$dumpvars;

	nRST = 1'b1;
	#(PERIOD);
	nRST = 1'b0;

	$display();
	$display("****************************************");
	$display("ADD/SUB:");
	$display("****************************************");
	$display();

	/////////// ADDITION ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_ADD;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h00005400;	// 64.0
	test_result = 32'h00005450;	// 69.0
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	/////////// SUBTRACTION ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_SUB;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h00005400;	// 64.0
	test_result = 32'h0000D360;	// -59.0
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	$display();
	$display("****************************************");
	$display("MULT:");
	$display("****************************************");
	$display();

	/////////// MULTIPLICATION ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_MUL;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h00005400;	// 64.0
	test_result = 32'h00005D00;	// 320.0
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	$display();
	$display("****************************************");
	$display("MINMAX:");
	$display("****************************************");
	$display();

	/////////// MIN ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_MIN;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h00005400;	// 64.0
	test_result = 32'h00004500;	// 5.0
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	/////////// MAX ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_MAX;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h00005400;	// 64.0
	test_result = 32'h00005400;	// 64.0
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	$display();
	$display("****************************************");
	$display("COMPARE:");
	$display("****************************************");
	$display();

	/////////// FEQ ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_FEQ;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h00005400;	// 64.0
	test_result = 32'h00000000;	// 0
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	/////////// FLT ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_FLT;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h00005400;	// 64.0
	test_result = 32'h00000001;	// 1
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	/////////// FLE ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_FLE;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h00005400;	// 64.0
	test_result = 32'h00000001;	// 1
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	$display();
	$display("****************************************");
	$display("CONVERT:");
	$display("****************************************");
	$display();

	$display();
	$display("****************************************");
	$display("SIGN INJECTION:");
	$display("****************************************");
	$display();

	/////////// SGNJ ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_SGNJ;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h0000D400;	// -64.0
	test_result = 32'h0000C500;	// -5.0
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	/////////// SGNJN ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_SGNJN;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h00005400;	// 64.0
	test_result = 32'h0000C500;	// -5.0
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	/////////// SGNJX ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_SGNJX;
	tb_inputa = 32'h0000C500;	// -5.0
	tb_inputb = 32'h0000D400;	// -64.0
	test_result = 32'h00004500;	// 1
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);

	$display();
	$display("****************************************");
	$display("CLASSIFY:");
	$display("****************************************");
	$display();

	/////////// SGNJ ///////////
	test_num += 1;
	tb_start = 1'b1;
	tb_operation = FPU_HALF_CLASS;
	tb_inputa = 32'h00004500;	// 5.0
	tb_inputb = 32'h0;			// X
	test_result = 32'b1000000;	// bit 6 set
	$display("Test case %d", test_num);
	$display("Input 1: %8h | Input 2: %8h | Expected result: %8h", tb_inputa, tb_inputb, test_result);
	#(PERIOD)
	if (tb_out == test_result) $display("Correct output\n"); else $display("Incorrect output (%8h)\n", tb_out);
	@(negedge CLK);
	
	$finish;
end

endprogram