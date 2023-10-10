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
    tb_float1 = 16'h0900;
    tb_float2 = '0;
    #(PERIOD)
    @(negedge CLK);

    /////////// Inf ///////////
    test_num += 1; // case2: +Inf * 5
    tb_float1 = 16'h7c00; 
    tb_float2 = 16'h0900;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case3: 5 * -Inf
    tb_float1 = 16'h0900;
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
    tb_float2 = 16'h0900;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case7: 5 * SNaN
    tb_float1 = 16'h0900;
    tb_float2 = 16'hfd00;
    #(PERIOD)
    @(negedge CLK);

    $finish;
end

endprogram