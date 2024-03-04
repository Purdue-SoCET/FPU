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
logic [15:0] test_result;

initial begin
	// generate waveform files
	$dumpfile("waveform_enabled.fst");
	$dumpvars;

	/////////// Zero ///////////
	// test_num += 1;
	// tb_float1 = 16'h0;
	// tb_float2 = 16'h0;
	// test_result = 16'h0;
	// $display("Test case %d", test_num);
	// $display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	// #(PERIOD) // == 0xB34D
	// if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	// @(negedge CLK);

	// test_num += 1;
	// tb_float1 = 16'h4500;
	// tb_float2 = 16'h0000;
	// test_result = 16'h4500;
	// $display("Test case %d", test_num);
	// $display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	// #(PERIOD) // == 0xB34D
	// if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	// @(negedge CLK);
	
	$finish;
end

endprogram