`include "fpu_types_pkg.vh"

module float_mult_16bit (
    input logic [HALF_FLOAT_W-1:0] float1,
    input logic [HALF_FLOAT_W-1:0] float2,
    output logic [HALF_FLOAT_W-1:0] product
);
import fpu_types_pkg::*;    

logic sign1, sign2, sign_product, exp_overflow;
logic implicit_leading_bit1, implicit_leading_bit2;
exp_t exp1, exp2, exp_product;
mant_t mant1, mant2, mant_product;
logic [21: 0] mant_product_full;
logic [53:0] numerical_54;
logic [31:0] numerical, temp;
logic [5:0] left_shift;
logic zero, qnan, snan, inf, n_n, n_s, s_s; //test signals
logic pt1, pt3;
logic pt2, pt4;
/////////// Initialization ///////////
assign exp1 = float1[HALF_FRACTION_W+HALF_EXPONENT_W-1 : HALF_FRACTION_W]; // all exp(s) are signed to represent float between 1 and 2
assign exp2 = float2[HALF_FRACTION_W+HALF_EXPONENT_W-1 : HALF_FRACTION_W];
assign mant1 = float1[HALF_FRACTION_W-1 : 0];
assign mant2 = float2[HALF_FRACTION_W-1 : 0];
assign sign1 = float1[HALF_FLOAT_W-1];
assign sign2 = float2[HALF_FLOAT_W-1];
assign implicit_leading_bit1 = ~(exp1 == '0);
assign implicit_leading_bit2 = ~(exp2 == '0);

assign product = {sign_product, exp_product, mant_product};

always_comb begin : mult
    /////////// Default ///////////
    exp_product = '0;
    mant_product = '0;
    sign_product = '0;
    mant_product_full = '0;
    exp_overflow = '0;
    numerical_54 = '0;
    numerical = '0;
    left_shift = '0;
    //test signals (can be removed later)
    zero = 0;
    snan = 0;
    qnan = 0;
    inf = 0;
    n_n = 0;
    n_s = 0;
    s_s = 0;
    pt1 = 0;
    pt2 = 0;
    pt3 = 0;
    pt4 = 0;

    /////////// Zero ///////////
    if ((float1 == HALF_ZERO & ~(exp2 == '1 & mant2 == '0)) | (float2 == HALF_ZERO & ~(exp1 == '1 & mant1 == '0))) begin
        exp_product = '0;
        mant_product = '0;
        sign_product = '0;

        zero = 1;
    end

    /////////// NaN ///////////
    else if ({exp1, mant1[HALF_FRACTION_W-1]} == '1 | {exp2, mant2[HALF_FRACTION_W-1]} == '1 | float1 == HALF_ZERO & (exp2 == '1 & mant2 == '0) | float2 == HALF_ZERO & (exp1 == '1 & mant1 == '0)) begin
        //QNaN
        exp_product = '1;
        mant_product = '1;
        sign_product = '1;

        qnan = 1;
    end else if (exp1 == '1 & ~mant1[HALF_FRACTION_W-1] & mant1 != '0 | exp2 == '1 & ~mant2[HALF_FRACTION_W-1] & mant2 != '0) begin
        //SNaN
        exp_product = '1;
        mant_product = 10'b0111111111;
        sign_product = '1;

        snan = 1;
    end

    /////////// Inf ///////////
    else if (exp1 == '1 & mant1 == '0 | exp2 == '1 & mant2 == '0) begin
        exp_product = '1;
        mant_product = '0;
        sign_product = sign1 ^ sign2;

        inf = 1;
    end

    /////////// mult ///////////
    else begin
        sign_product = sign1 ^ sign2;
        mant_product_full = {implicit_leading_bit1, mant1} * {implicit_leading_bit2, mant2};
        if (exp1 == '0 & exp2 == '0) begin
            exp_product = '0;
            s_s = 1;
        end else if (exp1 != '0 & exp2 != '0) begin
            exp_product = exp1 + exp2 - 5'd15;
            n_n = 1;
        end else begin
            exp_product = exp1 + exp2;
            n_s = 1;
        end

        exp_overflow = (exp1[HALF_EXPONENT_W-1] & exp2[HALF_EXPONENT_W-1] & ~exp_product[HALF_EXPONENT_W-1]) | (~exp1[HALF_EXPONENT_W-1] & ~exp2[HALF_EXPONENT_W-1] & exp_product[HALF_EXPONENT_W-1]);

        if (exp_overflow) begin
            //overflow in exp, product = SNaN
            exp_product = '1;
            mant_product = 10'b0111111111;
            sign_product = '1;
        end else if (exp1 == '0 & exp2 == '0) begin
            mant_product = '0;
        end else begin
            if (mant_product_full[21:20] == 2'b01 & exp_product != '0 | mant_product_full[21:20] == 2'b00 & exp_product == '0) begin
                mant_product = mant_product_full[19:10];
                pt1 = 1;
            end else begin
                pt2 = 1;
                if (exp_product >= 5'd15) begin
                    pt3 = 1;
                    temp = 32'b1 << (exp_product - 5'd15);
                    numerical_54 = temp * mant_product_full;
                    numerical = numerical_54[51:20];
                end else begin
                    pt4 = 1;
                    left_shift = 5'd15 - exp_product;
                    numerical_54 = {32'b0, mant_product_full};
                    numerical_54 = numerical_54 >> left_shift;
                    numerical = numerical_54[51:20];
                end

                exp_product = '0;
                if (numerical != '0) begin
                    for (int i =31 ; i>=0 ; i=i-1) begin
                        if(numerical[i] == 1'b1) begin
                            exp_product=i[4:0];
                            break; 
                        end
                    end

                    if (exp_product >= 5'd10) begin
                    mant_product = numerical[exp_product-1 -: 10];
                    end else begin
                        case (exp_product)
                            0:mant_product = numerical_54[19:10];
                            1:mant_product = {numerical[0], numerical_54[19:11]};
                            2:mant_product = {numerical[1:0], numerical_54[19:12]};
                            3:mant_product = {numerical[2:0], numerical_54[19:13]};
                            4:mant_product = {numerical[3:0], numerical_54[19:14]};
                            5:mant_product = {numerical[4:0], numerical_54[19:15]};
                            6:mant_product = {numerical[5:0], numerical_54[19:16]};
                            7:mant_product = {numerical[6:0], numerical_54[19:17]};
                            8:mant_product = {numerical[7:0], numerical_54[19:18]};
                            9:mant_product = {numerical[8:0], numerical_54[19]};
                        endcase
                    end
                    exp_product = exp_product + 4'd15;

                end else begin

                    mant_product_full = numerical_54[21:0];
                    for (int i =0; i<= 19; i=i+1) begin
                        if(mant_product_full[i] == 1'b1) begin
                            exp_product=i[4:0];
                            break; 
                        end
                    end
                    // mant_product = {mant_product_full[exp_product+1:0], 0s}; 
                    if (exp_product <= 5'd9) begin
                        mant_product = mant_product_full[19-exp_product-1 -: 10];
                    end else begin
                        case (exp_product)
                            10: mant_product = {mant_product_full[8:0], 1'b0};
                            11: mant_product = {mant_product_full[7:0], 2'b0};
                            12: mant_product = {mant_product_full[6:0], 3'b0};
                            13: mant_product = {mant_product_full[5:0], 4'b0};
                            14: mant_product = {mant_product_full[4:0], 5'b0};
                            15: mant_product = {mant_product_full[3:0], 6'b0};
                            16: mant_product = {mant_product_full[2:0], 7'b0};
                            17: mant_product = {mant_product_full[1:0], 8'b0};
                            18: mant_product = {mant_product_full[0], 9'b0};
                            19: mant_product = '0;
                        endcase
                    end
                    exp_product = 5'd16 - (exp_product + 1'b1);

                end

                
            end  
        end
    end
end
endmodule