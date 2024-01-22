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
logic [4:0] test_num;

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
    tb_float1 = 16'b0100001000000000;
    tb_float2 = 16'b0100010100000000;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case9: normal * normal = normal (1.75 * 2.25 = 3.937500)
    tb_float1 = 16'b0011111100000000;
    tb_float2 = 16'b0100000010000000;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case10: normal * normal = normal (0.625 * 0.4375 = 0.2734375)
    tb_float1 = 16'b0011100100000000;
    tb_float2 = 16'b0011011100000000;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);



    test_num += 1; // case11: normal * normal = normal (2.843750 * 2.843750 = 4.175781)
    tb_float1 = 16'b0011110111100000;
    tb_float2 = 16'b0100000110110000;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case12: subnormal * subnormal
    tb_float1 = 16'b0000000111111111;
    tb_float2 = 16'b0000000111111111;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b0,test_num);

    test_num += 1; // case13: subnormal * normal (with carry)
    tb_float1 = 16'b0_00000_0111111111;
    tb_float2 = 16'b0_11110_1000000000;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case14: subnormal * normal (without carry)
    tb_float1 = 16'b0_00000_0001000000;
    tb_float2 = 16'b0_11110_0000000000;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);
    
    test_num += 1; // case15: normal * subnormal(with carry)
    tb_float2 = 16'b0_00000_0111111111;
    tb_float1 = 16'b0_11110_1000000000;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case16: normal * subnormal(without carry)
    tb_float2 = 16'b0_00000_0001000000;
    tb_float1 = 16'b0_11110_0000000000;
    #(PERIOD)
    @(negedge CLK);
    print(tb_product, test_num);

    test_num += 1; // case17: subnormal * normal (result is subnormal)
    tb_float1 = 16'b0_00000_0001000000;
    tb_float2 = 16'b0_01110_0000000000;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'h0020,test_num);  

    test_num += 1; // case18: normal * normal (result is subnormal)
    tb_float1 = 16'b0_00100_0001000000;
    tb_float2 = 16'b0_00010_0000000000;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'h0001,test_num);  

    test_num += 1; // case19: normal * normal ((result is subnormal))
    tb_float1 = 16'b0_00111_0000001010;
    tb_float2 = 16'b0_00001_0000100100;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b0_00000_0000000100,test_num);  


    test_num += 1; // case20: UVM
    tb_float1 = 16'b0_00000_0101111011;
    tb_float2 = 16'b0_01010_0011111100;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b0_00000_0000001111,test_num);  

    test_num += 1; // case21: UVM
    tb_float1 = 16'b0_01010_1000010111;
    tb_float2 = 16'b1_00000_1100011101;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b1_00000_0000100110,test_num);  

    test_num += 1; // case22: UVM
    tb_float1 = 16'b0_01001_0110000011;
    tb_float2 = 16'b1_00010_1100001001;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b1000000001001110,test_num); 
    
    test_num += 1; // case23: UVM ovf
    tb_float1 = 16'b0110111101101101;
    tb_float2 = 16'b0110010001010111;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b0111110000000000,test_num); 

    test_num += 1; // case24: UVM ovf
    tb_float1 = 16'b0110111101101101;
    tb_float2 = 16'b1110010001010111;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b1111110000000000,test_num); 

    test_num += 1; // case25: UVM ovf
    tb_float1 = 16'b1110111101101101;
    tb_float2 = 16'b1110010001010111;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b0111110000000000,test_num); 
    
    test_num += 1; // case26: UVM n*n
    tb_float1 = 16'b0_00001_1011111110;
    tb_float2 = 16'b0_01110_1110111000;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b0_00001_1010111111,test_num); 
    
    test_num += 1; // case27: UVM n*n
    tb_float1 = 16'b0_01001_0001001111;
    tb_float2 = 16'b1_00111_1101101111;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b1_00010_0000000001,test_num); 
    
    test_num += 1; // case28: UVM n*n
    tb_float1 = 16'b1_00101_1010011011;
    tb_float2 = 16'b0_01010_1000110110;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b1_00001_0100100001,test_num); 

    test_num += 1; // case29: UVM inf
    tb_float1 = 16'b0_11100_0011100001;
    tb_float2 = 16'b1_10001_1010101011;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b1111110000000000,test_num); 

    // 0_01110_0001101011 * 1_00001_1010101011
    test_num += 1; // case30: 
    tb_float1 = 16'b0_01110_0001101011;
    tb_float2 = 16'b1_00001_1010101011;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b1_00000_1110101111,test_num); 

    // 0001100101011010 * 1010010001110000
    test_num += 1; // case31: 
    tb_float1 = 16'b0001100101011010;
    tb_float2 = 16'b1010010001110000;
    #(PERIOD)
    @(negedge CLK);
    check_ans(tb_product, 16'b1000001011111000,test_num); 
    $finish;
end

task print(input [15:0] half_product, input [4:0] testNum);
    logic half_sign;
    logic [4:0] half_exp;
    logic [10:0] double_exp;
    logic [9:0] half_mant;
    logic [63:0] double_product;
    logic [10:0] shift;

        

    half_sign = half_product[15];
    half_exp = half_product[14:10];
    if (half_exp == '0) begin
        for (int i =9; i>= 0; i=i-1) begin
            if(half_mant[i] == 1'b1) begin
                shift=i[10:0];
                break; 
            end
        end
        double_exp = '0 - (11'd10 - shift) -11'd15 + 1 + 11'd1023;
        half_mant = half_product[9:0] << (11'd10 - shift);
    end else begin
        half_exp = half_exp - 5'd15; //unbiased
        double_exp = {{6{half_exp[4]}}, half_exp} + 10'd1023; //biased
        half_mant = half_product[9:0];
    end
    
    double_product = {half_sign, double_exp, half_mant, 42'b0};
    $display("test num = %d: product = %f", testNum, $bitstoreal(double_product));
endtask 

task check_ans (input [15:0] result, input [15:0] exp, input [4:0] testNum);
    if (result == exp) begin
        $display("test num = %d: correct, result is %b.", testNum, result);
    end else begin
        $display("test num = %d: wrong, should be %b, get %b.", testNum, exp, result);
    end
endtask

endprogram