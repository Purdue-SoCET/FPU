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

logic zero, qnan, snan, inf; //test signals

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

    //test signals (can be removed later)
    zero = 0;
    snan = 0;
    qnan = 0;
    inf = 0;

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
        if (exp1 == '0 & exp2 == '0) begin
            exp_product = '0;
        end else if (exp1 != '0 & exp2 != '0) begin
            exp_product = exp1 + exp2 - 5'd15;
        end else begin
            exp_product = exp1 + exp2;
        end
        exp_overflow = (exp1[HALF_EXPONENT_W-1] & exp2[HALF_EXPONENT_W-1] & ~exp_product[HALF_EXPONENT_W-1]) | (~exp1[HALF_EXPONENT_W-1] & ~exp2[HALF_EXPONENT_W-1] & exp_product[HALF_EXPONENT_W-1]);
        mant_product_full = {implicit_leading_bit1, mant1} * {implicit_leading_bit2, mant2};
        if (mant_product_full[21:20] == 2'd2 | mant_product_full[21:20] == 2'd3) begin
            exp_product = exp_product + 1;
        end
        if (~exp_overflow) begin
            mant_product = mant_product_full[19:10]; 
        end else begin
            //overflow in exp, product = SNaN
            exp_product = '1;
            mant_product = 10'b0111111111;
            sign_product = '1;
        end
    end

end

endmodule