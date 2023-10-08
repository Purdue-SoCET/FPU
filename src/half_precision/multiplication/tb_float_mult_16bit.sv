`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_float_mult_16bit;
    parameter PERIOD = 10;
    logic CLK = 0, nRST;
    logic [HALF_FLOAT_W-1:0] tb_float1, tb_float2, tb_product;
    always #(PERIOD/2) CLK++;

    float_mult_16bit Zfh (.float1(tb_float1), .float2(tb_float2), .product(tb_product));
    test PROG (.CLK(CLK), .float1(tb_float1), .float2(tb_float2), .product(tb_product));
endmodule

program test(
    input logic CLK,
    output logic [HALF_FLOAT_W-1:0] tb_float1,
    output logic [HALF_FLOAT_W-1:0] tb_float2,
    input logic [HALF_FLOAT_W-1:0] tb_product
);

parameter PERIOD = 10;
logic [3:0] test_num;

initial begin
    test_num = 0;
    tb_float1 = '0;
    tb_float2 = '0;
    #(PERIOD)
    @(negedge CLK);
end

endprogram