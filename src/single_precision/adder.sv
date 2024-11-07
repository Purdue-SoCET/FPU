module adder(
    input logic [31:0] data1, data2,
    output logic [31:0] result,
    output logic overflow,
    output logic underflow
);
    //making logic variables for the operations
    //extract sign, exponent, and mantissa from inputs
    logic sign1; //sign for data 1
    logic sign2; // sign for data 2
    logic [7:0] exp1; //exp data 1
    logic [7:0] exp2; //exp data 2
    logic [23:0] mant1; //mantissa data 1
    logic [23:0] mant2; //mantissa data 1

//The mantissa is 23 bits, but the normalized value has an implicit leading 1, 
//which makes it effectively a 24-bit value in calculations.

    //internal signals
    logic [7:0] exp_sub; 
    logic sign_result; //sign
    logic [24:0] mantissaResult; //mantissa result
    logic [23:0] shift1; //mant 1 alligned
    logic [23:0] shift2; //mant 2 aligned
    //logic [7:0] count;
    //logic [23:0] carroutCheck;
    logic [7:0] biggerExp; //exp result

    //normalized signals
    logic [7:0] normalized_exp;
    logic [23:0] normalized_mant;
    logic overflow_temp, underflow_temp;
    
    //assign exp of data to exp 1 and exp 2
    assign exp1 = data1[30:23];
    assign exp2 = data2[30:23];

    assign sign1 = data1[31];
    assign sign2 = data2[31];

    assign mant1 = {1'b1, data1[22:0]}; // Adding implicit leading 1
    assign mant2 = {1'b1, data2[22:0]}; // Adding implicit leading 1

    //subtract exponents
    always_comb begin
        // mant1 = '0;
        // mant2 = '0;
        //result = '0;
        // shift2 = data2[22:0]; //mantissa data for second register
        // shift1 = data1[22:0]; //mantissa data for first register
        if(exp1 > exp2) begin
            exp_sub = exp1 + (~exp2 + 1);  // do exp1 + 2's complement of exp2 (exp1 + (-exp2))
            shift1 = mant1;
            //mant2 = {1'b1, shift2[22:1]}; //Shift in 1 to the second mantissa for implied "1.####"
            shift2 = mant2 >> exp_sub; 
            //a = b >> 4 - shifting b right by 4 bits
            biggerExp = exp1;
        end
        else begin
            exp_sub = exp2 + (~exp1 + 1);
            shift2 = mant2;
            //mant1 = {1'b1, shift1[22:1]}; //Shift in 1 to the first mantissa for implied "1.####"
            shift1 = mant1 >> exp_sub;
            biggerExp = exp2;
        end 
    end

// return result as per format according to IEE-754 according to data
//refer to justin and om discussion, right shifting with 1 in msb, make sure logic is right

        // carroutCheck = mant1 + mant2; //this checks for a carryout value by using a logic variable that is 24 bits
        // if(carroutCheck[23]) begin//If the 23rd bit is equal to 1, then there is a carry out
        
        //     carroutCheck = carroutCheck >> 1; //The entire 23rd bit value is shifted by 1
        //     biggerExp = biggerExp + 1; //Then 1 is added to the exponent
        //     mantissaResult = {carroutCheck[22:0]}; //Mantissa result for addition is set to the 23 bits that were shifted in the if statement.
        // end
        // else begin
        //assign mantissaResult = shift1 + shift2; //Mantissa result for addition is set to the mantissas added if there is no carryout to worry about
        //end

    //Add or subtract mantissas based on signs
    always_comb begin
        if (sign1 == sign2) begin
            mantissaResult = shift1 + shift2;
            sign_result = sign1;
        end else begin
            if (shift1 > shift2) begin
                mantissaResult = shift1 - shift2;
                sign_result = sign1;
            end else begin
                mantissaResult = shift2 - shift1;
                sign_result = sign2;
            end
        end
    end

    always_comb begin
        if (mantissaResult[24]) begin
            // check for carry out, shift right and increment exponent
            normalized_mant = mantissaResult[24:1];
            normalized_exp = biggerExp + 1;
        end else begin
            if(~mantissaResult[23]) begin
                normalized_mant = mantissaResult[22:0] << 1;
                normalized_exp = biggerExp - 1; 
            end 
            else begin
                normalized_mant = mantissaResult[23:0];
                normalized_exp = biggerExp;
            end
        end


        // Check for overflow and underflow
        overflow_temp = (normalized_exp >= 8'hFF);  // Overflow if exponent is maxed out
        underflow_temp = (normalized_exp == 0);     // Underflow if exponent is zero
    end

    //final result according to IEE-754
    always_comb begin
        result = {sign_result, normalized_exp[7:0], normalized_mant[22:0]};
        overflow = overflow_temp;
        underflow = underflow_temp;
    end


    //     case({sign1,sign2}) 
    //         2'b00: begin result = {1'b0, biggerExp, shift1 + shift2}; end
    //         2'b11: begin result = {1'b1, biggerExp, shift1 + shift2}; end
    //         2'b01: begin 
    //             if(mant1 > mant2) begin
    //                 result = {1'b0, biggerExp, mant1 - mant2}; 
    //             end
    //             else begin
    //                 result = {1'b1, biggerExp, mant1 - mant2}; 
    //             end
    //         end
    //         2'b10: begin 
    //             if(mant2 > mant1) begin
    //                 result = {1'b0, biggerExp, mantissaResult}; 
    //             end
    //             else begin
    //                 result = {1'b1, biggerExp, mantissaResult}; 
    //             end
    //         end
    //         default: result = '0;
    //     endcase 
    // end

endmodule
