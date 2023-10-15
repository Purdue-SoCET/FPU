`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_multiply;
    import fpu_types_pkg::*;
    parameter PERIOD = 10;
    logic CLK = 0, nRST;
    logic [HALF_FLOAT_W-1:0] tb_float1, tb_float2, tb_product;
    always #(PERIOD/2) CLK++;

    float_mult_16bit Zfh (.float1(tb_float1), .float2(tb_float2), .product(tb_product));
    test PROG (.CLK(CLK), .tb_float1(tb_float1), .tb_float2(tb_float2), .tb_product(tb_product));
endmodule

program test(
    input logic CLK,
    output logic [HALF_FLOAT_W-1:0] tb_float1,
    output logic [HALF_FLOAT_W-1:0] tb_float2,
    input logic [HALF_FLOAT_W-1:0] tb_product
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [3:0] test_num;

initial begin
    // generate waveform files
    $dumpfile("waveform_multiply.fst");
    $dumpvars;
    /////////// Zero ///////////
    test_num = 0; // case0: 0 * 0
    tb_float1 = '0;
    tb_float2 = '0;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case1: 5 * 0
    tb_float1 = 16'h4510;
    tb_float2 = '0;
    #(PERIOD)
    @(negedge CLK);

    /////////// Inf ///////////
    test_num += 1; // case2: +Inf * 5
    tb_float1 = 16'h7c00; 
    tb_float2 = 16'h4510;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case3: 5 * -Inf
    tb_float1 = 16'h4510;
    tb_float2 = 16'hfc00;
    #(PERIOD)
    @(negedge CLK);

    /////////// NaN ///////////
    test_num += 1; // case4: +Inf * 0 (QNaN)
    tb_float1 = 16'h7c00; 
    tb_float2 = '0;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case5: 0 * -Inf (QNaN)
    tb_float1 = '0;
    tb_float2 = 16'hfc00;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case6: QNaN * 5
    tb_float1 = 16'hfe00;
    tb_float2 = 16'h4510;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case7: 5 * SNaN
    tb_float1 = 16'h4510;
    tb_float2 = 16'hfd00;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case8: normal * normal = normal (5*3)
    tb_float1 = 16'h4510;
    tb_float2 = 16'h4200;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case9: subnormal * normal  = normal (5*0.5)
    tb_float1 = 16'h4510;
    tb_float2 = 16'h0200;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case10: normal * subnormal = subnormal (0.125*2)
    tb_float1 = 16'h0400;
    tb_float2 = 16'h4000;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case11: subnormal * subnormal = subnormal (0.5*0.25)
    tb_float1 = 16'h0200;
    tb_float2 = 16'h0100;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case12: overflow
    tb_float1 = 16'h7800;
    tb_float2 = 16'h0400;
    #(PERIOD)
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