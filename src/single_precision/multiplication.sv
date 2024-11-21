module multiplication (    
    input logic [31:0] data1, data2,
    output logic [31:0] result,
    output logic overflow, underflow
);

    logic sign1; // sign bit of data 1
    logic sign2; // sign bit of data 2
    logic sign_result; // sign bit of result
    logic [7:0] exp1; // exponent bit of data 1
    logic [7:0] exp2; // exponent bit of data 2
    logic [7:0] exp_result; // exponent bit of result 
    logic [22:0] mant1; // mantissa bit of data 1 
    logic [22:0] mant2; // mantissa bit of data 2 
    logic [22:0] mant_result; // mantissa bit of result
    logic [23:0] mantA; // mantissa bit for normalize mantissa of data 1
    logic [23:0] mantB; // mantissa bit for normalize mantissa of data 2
    logic [23:0] mant_AB; // mantissa bit for normalize mantissa of result

    logic [8:0] exp_temp; // exponential bit when having overflow 
    logic [47:0] mant_temp; // product of 2 mantissas

  
    assign sign1 = data1[31];
    assign sign2 = data2[31];
    assign exp1 = data1[30:23];
    assign exp2 = data2[30:23];
    assign mant1 = data1[22:0];
    assign mant2 = data2[22:0];
    
    // Handle mantissa normalization
    always_comb begin
        mantA = (exp1 != 0) ? {1'b1, mant1} : {1'b0, mant1}; // Normalized or denormalized
        mantB = (exp2 != 0) ? {1'b1, mant2} : {1'b0, mant2}; // Normalized or denormalized
    end

    // Check for special cases
    logic zero1, zero2; // flags for checking zero 
    logic infi1, infi2; // flags for checking infinite value 
    logic na1, na2; // flags for cheking N/A
    // zero flag
    assign zero1 = (exp1 == 0) && (mant1 == 0); // zero when all are zeros
    assign zero2 = (exp2 == 0) && (mant2 == 0); // zero when all are zeros
    // infinite flag
    assign infi1 = (exp1 == 255) && (mant1 == 0); // infinity when all ones and mant is 0
    assign infi2 = (exp2 == 255) && (mant2 == 0); // infinity when all ones and mant is 0
    // Not a number 
    assign na1 = (exp1 == 255) && (mant1 != 0); // NaN when all ones and mant is not 0 
    assign na2 = (exp2 == 255) && (mant2 != 0); // NaN when all ones and mant is not 0 

    // Caculate for sign, temp exponent and mantissa
    always_comb begin 
        // Initialize defaults for avoiding latches
        exp_temp = 0;
        mant_temp = 0;
        // sign bit
        sign_result = sign1 ^ sign2; // same sign (positive), different sign (negative)
        // exponent bit 
        if ((exp1 + exp2) < 8'd127) begin 
            exp_temp = 9'd0; // if less than 127, assign to 0 to prevent underflow
        end
        else begin 
            exp_temp = exp1 + exp2 - 8'd127;
        end
        // mantissa bit 
        mant_temp = mantA * mantB;
    end

    assign mant_result = mant_temp[45:23];

    // Special case with normal multiplication process
    always_comb begin
        // Initialize defaults to avoid latches
        overflow = 0;
        underflow = 0;
        exp_temp = 0;
        mant_temp = 0;
        result = 0;
        // case zero  
        if (zero1 || zero2) begin 
            // zero times any number is zero
            result = {sign_result, 31'h0};
        end
        // case infinity
        else if (infi1 || infi2) begin 
            // if one operand is infinite value, result is infinity
            result = {sign_result, 8'hFF, 23'h0};
        end
        // Undefined case 
        else if (infi1 && zero2) begin 
            //  infinity times with zero is undefined value
            result = 32'h7FC00000; // Quiet NaN
        end
        // Undefined case
        else if (na1 || na2) begin 
            // if one operand is NaN, result is NaN
            result = 32'h7FC00000; // Quiet NaN
        end

        else begin 
            // checking for mantissa of result falls in range from 1 to over 2
            if (mant_temp[47]) begin // MSB is 1, result's mantissa > 2.0 
                mant_AB = mant_temp[47:24]; /*FIXME shift right (or left?)*/
                // mant_temp = mant_temp << 1; /* FIXME shift left (or right?) 1 bit to normalize */  
                exp_result = exp_temp[7:0] + 1; // take 8 bit and increment the exp by 1
            end
            else begin // no carry, result's mantissa is already within 1 to 2 (no needed shift)
                mant_AB = mant_temp[46:23];
                exp_result = exp_temp[7:0]; // take the lower 8 bits 
            end
            // handling and detecting overflow
            if (exp_result >= 8'd255) begin // when MSB is 1, exponent is set to max value from IEEE 754
                overflow = 1;
                // exp_result = 8'hff;
                result = {sign_result, 8'hFF, 23'h0}; // infinity
            end
            else if (exp_result == 0) begin 
                underflow = 1;
                if (exp_result < -23) begin // the result is too small for denormalized representation 
                    mant_AB = 24'h0; // set underflow to zero
                    mant_result = mant_AB[22:0]; 
                end
                else begin // the result can be represented as denormalized number
                    mant_AB = mant_temp >> (1 - exp_result); 
                    mant_result = mant_AB[22:0];
                end
                result = {sign_result, 8'h00, mant_AB[22:0]};
                // else begin 
                //     result = {sign_result, exp_result, mant_result};
                // end
            end
        end
    end

    // final result 
    always_comb begin 
        result = {sign_result, exp_result, mant_AB[22:0]};
    end

endmodule 
