`include "fpu_types_pkg.vh"
import fpu_types_pkg::*;

module float_mult_16bit (
    input logic [HALF_FLOAT_W-1:0] float1,
    input logic [HALF_FLOAT_W-1:0] float2,
    output logic [HALF_FLOAT_W-1:0] product
);
   

logic sign1, sign2, sign_product, exp_overflow;
logic implicit_leading_bit1, implicit_leading_bit2;
exp_t exp1, exp2, exp_product;
mant_t mant1, mant2, mant_product;
logic [21: 0] mant_product_full;
logic [53:0] numerical_54;
logic [31:0] numerical, temp;
logic [5:0] left_shift;
logic [11:0] mant_product_full2;
logic zero, qnan, snan, inf, n_n, n_s, s_s; //test signals
logic carry, no_carry;
logic [5:0] normalized_exp1;
logic [6:0] exp_product_temp;
logic [4:0] shift;
logic [6:0] shift_back;
logic check, check2;
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
    mant_product_full2 = '0;
    //test signals (can be removed later)
    zero = 0;
    snan = 0;
    qnan = 0;
    inf = 0;
    n_n = 0;
    n_s = 0;
    s_s = 0;
    carry = 0;
    no_carry = 0;
    normalized_exp1 = '0;
    exp_product_temp = '0;
    shift = '0;
    shift_back = '0;
    check = 0;
    check2 = 0;
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
        // mant_product = 10'b0111111111;
        mant_product = '1; // SNaN * num = QNaN
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
        if (exp1 == '0 & exp2 == '0) begin //sub * sub
            exp_product = '0;
            s_s = 1;
        end else if (exp1 != '0 & exp2 != '0) begin //norm * norm
            exp_product = (exp1 - 5'd15) + exp2 ;
            exp_product_temp = ({2'b0, exp1} - 7'd15) + {2'b0,exp2};
            n_n = 1;
        end else begin //sub * norm or norm * sub
            n_s = 1;
            if (exp1 == '0) begin // float1 = sub
                for (int i =9; i>= 0; i=i-1) begin
                    if(mant1[i] == 1'b1) begin
                        shift=i[4:0];
                        break; 
                    end
                end
                exp_product = exp2 - (5'd10 - shift) -5'd15 + 5'd1;
                exp_product_temp = {2'b0, exp2} - (7'd10 - {2'b0,shift}) -7'd15 + 7'd1;
                mant_product_full = {1'b1, mant1 << (5'd10 - shift)} * {1'b1, mant2};
            end else if (exp2 == '0) begin // float2 = sub
                for (int i =9; i>= 0; i=i-1) begin
                    if(mant2[i] == 1'b1) begin
                        shift=i[4:0];
                        break; 
                    end
                end
                exp_product = exp1 - (5'd10 - shift) -5'd15 + 5'd1;
                exp_product_temp = {2'b0,exp1} - (7'd10 - {2'b0,shift}) -7'd15 + 7'd1;
                mant_product_full = {1'b1, mant2 << (5'd10 - shift)} * {1'b1, mant1};
            end
        end
        
        
        //-----------------------------------------------------------------
        check2 = mant_product_full[1];
        // exp_product_temp = exp_product_temp + {6'b0, mant_product_full[1]} - 7'd15;
        exp_product_temp = exp_product_temp - 7'd15;
        // if ($signed(exp_product_temp) < $signed(-7'd13) && $signed(exp_product_temp) > $signed(-7'd25)) begin
        if ($signed(exp_product_temp) < $signed(-7'd15) && $signed(exp_product_temp) > $signed(-7'd25)) begin
            shift_back = -7'd14 - exp_product_temp; 
            mant_product_full = mant_product_full >> shift_back;
            exp_product = '0;
            check = 1;
        end
        else if ($signed(exp_product_temp) < $signed(-7'd24)) begin
            exp_product = '0;
            s_s = 1;
        end
        

        //-----------------------------------------------------------------
        exp_overflow = ((exp1[HALF_EXPONENT_W-1] & exp2[HALF_EXPONENT_W-1] & ~exp_product[HALF_EXPONENT_W-1]) | (~exp1[HALF_EXPONENT_W-1] & ~exp2[HALF_EXPONENT_W-1] & exp_product[HALF_EXPONENT_W-1]));
        
        if (exp_overflow) begin //overflow in exp, product = +/-inf
            exp_product = '1;
            mant_product = '0;
        end else if (s_s == 1) begin //sub * sub guaranteed to be sub
            mant_product = '0;
        // end else begin
        //     mant_product_full2 = mant_product_full[21:10];
        //     if (mant_product_full[9]) begin
        //         mant_product_full2 += 1;
        //     end

        //     if (mant_product_full2[11])begin //mant carry 2 or 3
        //         carry = 1;
        //         if (exp_product == '1) begin //ovf
        //             exp_product = '1;
        //             mant_product = '0;
        //         end else begin
        //             if(!check) begin
        //                 exp_product += 1;
        //             end
        //             mant_product = mant_product_full2[10:1];
        //         end
        //     end else begin //mant carry 1
        //         no_carry = 1;
        //         mant_product = mant_product_full2[9:0];
        //     end 
            
        // end
        end else if (mant_product_full[21])begin //mant carry 2 or 3
            carry = 1;
            if (exp_product == '1) begin //ovf
                exp_product = '1;
                mant_product = '0;
                sign_product = '1;
            end else begin
                if(!check) begin
                    exp_product += 1;
                end
                mant_product = mant_product_full[20:11];
                //rounding
                if (mant_product_full[10]) begin
                    mant_product += 1;
                end
            end
        end else begin //mant carry 1
            no_carry = 1;
            mant_product = mant_product_full[19:10];
            //rounding
            if (mant_product_full[9]) begin
                mant_product += 1;
            end
        end 
        //-----------------------------------------------------------------
         
    end
end
endmodule