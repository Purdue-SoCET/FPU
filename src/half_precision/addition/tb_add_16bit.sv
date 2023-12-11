`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_add_16bit;
	import fpu_types_pkg::*;

	parameter PERIOD = 10;
	logic CLK = 0;
	logic [HALF_FLOAT_W - 1 : 0] tb_float1, tb_float2, tb_sum;
	fpu_rounding_mode_t tb_rounding_mode;
	logic tb_subtract;
	always #(PERIOD/2) CLK++;

	float_add Zfh (.float1(tb_float1), .float2(tb_float2), .rounding_mode(tb_rounding_mode), .sum(tb_sum));
	test PROG (.CLK(CLK), .tb_float1(tb_float1), .tb_float2(tb_float2), .tb_rounding_mode(tb_rounding_mode), .tb_sum(tb_sum));
endmodule

program test
(
	input logic CLK,

	output logic [HALF_FLOAT_W - 1:0] tb_float1,
	output logic [HALF_FLOAT_W - 1:0] tb_float2,

	output fpu_rounding_mode_t tb_rounding_mode,

	input logic [HALF_FLOAT_W - 1:0] tb_sum
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [7:0] test_num;
logic [15:0] test_result;

initial begin
	// generate waveform files
	$dumpfile("waveform_add.fst");
	$dumpvars;

	/////////// Zero ///////////
	test_num += 1;
	tb_float1 = 16'h0;
	tb_float2 = 16'h0;
	test_result = 16'h0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h4500;
	tb_float2 = 16'h0000;
	test_result = 16'h4500;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h4500;
	tb_float2 = 16'h4500;
	test_result = 16'h4900;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h4500;
	tb_float2 = 16'h5804;
	test_result = 16'h582C;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	// NaN
	test_num += 1;
	tb_float1 = 16'hFFFF;
	tb_float2 = 16'h0000;
	test_result = 16'hFFFF;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	/////////// Inf ///////////
	// max int + max int
	test_num += 1;
	tb_float1 = 16'h7BFF;
	tb_float2 = 16'h7BFF;
	test_result = 16'h7C00;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	/////////// Inf ///////////
	// min int + min int
	test_num += 1;
	tb_float1 = 16'hFBFF;
	tb_float2 = 16'hFBFF;
	test_result = 16'hFC00;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	/////////// Subnormal ///////////
	// smallest subnormal + smallest subnormal
	test_num += 1;
	tb_float1 = 16'h0001;
	tb_float2 = 16'h0001;
	test_result = 16'h0002;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	// smallest subnormal + smallest normal
	test_num += 1;
	tb_float1 = 16'h0001;
	tb_float2 = 16'h0400;
	test_result = 16'h0401;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	// largest subnormal + largest subnormal
	test_num += 1;
	tb_float1 = 16'h03FF;
	tb_float2 = 16'h03FF;
	test_result = 16'h07FE;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	// neg + neg
	test_num += 1;
	tb_float1 = 16'hC500;
	tb_float2 = 16'hC900;
	test_result = 16'hCB80;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	// 10 + -5
	test_num += 1;
	tb_float1 = 16'h4900;
	tb_float2 = 16'hC500;
	test_result = 16'h4500;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	// 100 + -5
	test_num += 1;
	tb_float1 = 16'h5640;
	tb_float2 = 16'hC500;
	test_result = 16'h55F0;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	// 5 + -10
	test_num += 1;
	tb_float1 = 16'h4500;
	tb_float2 = 16'hC900;
	test_result = 16'hC500;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	// subnormal + -subnormal
	test_num += 1;
	tb_float1 = 16'h01C3;
	tb_float2 = 16'h8321;
	test_result = 16'h815E;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	/////// FAILED CASES ////////
	test_num = 1;
	tb_float1 = 16'hE84B;
	tb_float2 = 16'h7484;
	test_result = 16'h73F5;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h2873;
	tb_float2 = 16'hB435;
	test_result = 16'hB34D;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h028E;
	tb_float2 = 16'h01C6;
	test_result = 16'h0454;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h83C0;
	tb_float2 = 16'h8332;
	test_result = 16'h86F2;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h08D4;
	tb_float2 = 16'h81E9;
	test_result = 16'h07BF;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h05C3;
	tb_float2 = 16'h8321;
	test_result = 16'h02A2;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h8201;
	tb_float2 = 16'h0201;
	test_result = 16'h0000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'hFC00;
	tb_float2 = 16'h1DE7;
	test_result = 16'hFC00;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h7C00;
	tb_float2 = 16'h09D8;
	test_result = 16'h7C00;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	$display("ROUND 2");
	// FAILED ROUND 2
	test_num = 1;
	tb_float1 = 16'hF12B;
	tb_float2 = 16'hE31F;
	test_result = 16'hF19D;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h2A05;
	tb_float2 = 16'h1E86;
	test_result = 16'h2AD6;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h0C2B;
	tb_float2 = 16'hDBEC;
	test_result = 16'hDBEC;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'hABBE;
	tb_float2 = 16'h812C;
	test_result = 16'hABBF;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h34BA;
	tb_float2 = 16'h82EA;
	test_result = 16'h34BA;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'hAA81;
	tb_float2 = 16'h816D;
	test_result = 16'hAA82;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'h2B00;
	tb_float2 = 16'h01CF;
	test_result = 16'h2B01;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	$display("ROUND 3");
	// FAILED ROUND 3
	test_num = 1;
	tb_float1 = 16'b1000010001100011;
	tb_float2 = 16'b0000010101000001;
	test_result = 16'b0000000011011110;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'b1100100111101010;
	tb_float2 = 16'b1110101111111010;
	test_result = 16'b1110110000000000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'b1001000001100110;
	tb_float2 = 16'b0001000001001100;
	test_result = 16'b1000000011010000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'b1000010111100111;
	tb_float2 = 16'b0000011010101000;
	test_result = 16'b0000000011000001;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'b1000111101111100;
	tb_float2 = 16'b0000111101100101;
	test_result = 16'b1000000001011100;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	$display("ROUND 4");
	// FAILED ROUND 4
	test_num = 1;
	tb_float1 = 16'hC9EA;
	tb_float2 = 16'hEBFA;
	test_result = 16'hEC00;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'b0101010001000011;
	tb_float2 = 16'b1100010000110010;
	test_result = 16'b0101010000000000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'b0010001101100101;
	tb_float2 = 16'b1111000000000000;
	test_result = 16'b1111000000000000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'b0100010000000000;
	tb_float2 = 16'b1000101011110010;
	test_result = 16'b0100010000000000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
	@(negedge CLK);

	test_num += 1;
	tb_float1 = 16'b1110110000000000;
	tb_float2 = 16'b0010100100011110;
	test_result = 16'b1110110000000000;
	$display("Test case %d", test_num);
	$display("Input 1: %4h | Input 2: %4h | Expected result: %4h", tb_float1, tb_float2, test_result);
	#(PERIOD) // == 0xB34D
	if (tb_sum == test_result) $display("Correct output\n"); else $display("Incorrect output (%4h)\n", tb_sum);
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