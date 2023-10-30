`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_add_16bit;
    import fpu_types_pkg::*;

    parameter PERIOD = 10;
    logic CLK = 0;
    logic [HALF_FLOAT_W - 1 : 0] tb_float1, tb_float2, tb_sum;
    always #(PERIOD/2) CLK++;

    float_add Zfh (.float1(tb_float1), .float2(tb_float2), .sum(tb_sum));
    test PROG (.CLK(CLK), .tb_float1(tb_float1), .tb_float2(tb_float2), .tb_sum(tb_sum));
endmodule

program test
(
    input logic CLK,

    output logic [HALF_FLOAT_W - 1:0] tb_float1,
    output logic [HALF_FLOAT_W - 1:0] tb_float2,

    input logic [HALF_FLOAT_W - 1:0] tb_sum
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [3:0] test_num;

initial begin
    // generate waveform files
    $dumpfile("waveform_add.fst");
    $dumpvars;

    /////////// Zero ///////////
    test_num = 0; // case0: 0 + 0
    tb_float1 = '0;
    tb_float2 = '0;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case1: 5 + 0
    tb_float1 = 16'h4500;
    tb_float2 = '0;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case1: 5 + 5
    tb_float1 = 16'h4500;
    tb_float2 = 16'h4500;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case1: 5 + 128.5
    tb_float1 = 16'h4500;
    tb_float2 = 16'h5804;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case1: 5 + 128.5
    tb_float1 = 16'hFFFF;
    tb_float2 = 16'h0000;
    #(PERIOD)
    @(negedge CLK);

    /////////// Inf ///////////
    test_num += 1; // case2: MAX + MAX
    tb_float1 = 16'h7bff; 
    tb_float2 = 16'h7bff;
    #(PERIOD)
    @(negedge CLK);

    /////////// Inf ///////////
    test_num += 1; // case2: MIN + MIN
    tb_float1 = 16'hFBFF;
    tb_float2 = 16'hFBFF;
    #(PERIOD)
    @(negedge CLK);

    /////////// Subnormal ///////////
    test_num += 1; // case2: smallest subnormal + smallest subnormal
    tb_float1 = 16'h1;
    tb_float2 = 16'h1;
    #(PERIOD) // == 0x0002
    @(negedge CLK);

    test_num += 1; // case2: smallest subnormal + small normal
    tb_float1 = 16'h0001;
    tb_float2 = 16'h0401;
    #(PERIOD) // == 0x0402
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