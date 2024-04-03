`include "fpu_types_pkg.vh"

`timescale 1 ns/ 1 ns

module tb_cvtHW;
    import fpu_types_pkg::*;
    parameter PERIOD = 10;
    logic CLK = 0, nRST;
    logic [31:0] tb_int;
    logic [2:0] tb_rm;
    logic [15:0] tb_hf;

    always #(PERIOD/2) CLK++;

    float_cvtHW cvt (.int32(tb_int), .rm(tb_rm), .float16(tb_hf));
    test PROG (.CLK(CLK), .tb_int(tb_int), .tb_rm(tb_rm), .tb_hf(tb_hf));
endmodule

program test(
    input logic CLK,
    output logic [31:0] tb_int,
    output logic [2:0] tb_rm,
    input logic [15:0] tb_hf
);
import fpu_types_pkg::*;

parameter PERIOD = 10;
logic [5:0] test_num;

initial begin
    // generate waveform files
    $dumpfile("waveform_cvtHW.fst");
    $dumpvars;

    
    test_num = 0; // case0: 0
    tb_rm = '0;
    tb_int = '0;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case1: +INF
    tb_rm = '0;
    tb_int = 65520;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case2: -INF
    tb_rm = '0;
    tb_int = -65520;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case3
    tb_rm = '0;
    tb_int = 65519;
    #(PERIOD)
    @(negedge CLK);

    test_num += 1; // case4
    tb_rm = '0;
    tb_int = -65519;
    #(PERIOD)
    @(negedge CLK);

    $finish;
end


endprogram