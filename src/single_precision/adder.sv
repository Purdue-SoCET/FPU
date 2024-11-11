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
    logic [25:0] mantissaResult; //mantissa result
    logic [24:0] shift1; //mant 1 alligned
    logic [24:0] shift2, shift_int; //mant 2 aligned
    //logic [7:0] count;
    //logic [23:0] carroutCheck;
    logic [7:0] biggerExp; //exp result

    //normalized signals
    logic [7:0] normalized_exp;
    logic [23:0] normalized_mant;
    logic overflow_temp, underflow_temp;
    
    //overflow checking variables
    logic carry;
    logic[24:0] temp;
    logic[24:0] mr;

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
            shift1 = {1'b0,mant1};
            //mant2 = {1'b1, shift2[22:1]}; //Shift in 1 to the second mantissa for implied "1.####"
            shift2[23:0] = mant2 >> exp_sub;
            shift2[24] = 0; 
            //a = b >> 4 - shifting b right by 4 bits
            biggerExp = exp1;
        end
        else begin
            exp_sub = exp2 + (~exp1 + 1);
            shift2 = {1'b0,mant2};
            //mant1 = {1'b1, shift1[22:1]}; //Shift in 1 to the first mantissa for implied "1.####"
            shift1[23:0] = mant1 >> exp_sub;
            shift1[24] = 0;
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
        shift_int = 0; carry = 0;
        if (sign1 == sign2) begin
            mantissaResult = shift1 + shift2;
            temp = shift1[23:0] + shift2[23:0];
            carry = temp[24];
            sign_result = sign1;
        end else begin
            if (shift1 > shift2) begin
                shift_int = ~shift2 + 1;
                //shift_int[23] = 0;
                mantissaResult = shift1 + shift_int; //shift1 - shift2
                temp = shift1[23:0] + shift_int[23:0];
                carry = temp[24];
                sign_result = sign1;
            end else begin
                shift_int = ~shift1 + 1;
                //shift_int[23] = 0;
                mantissaResult = shift2 + shift_int; //shift2 - shift1
                temp = shift2[23:0] + shift_int[23:0];
                carry = temp[24];
                sign_result = sign2;
            end
        end
    end

//normalising the result
    always_comb begin
        mr = 0;
        if (carry & ~mantissaResult[25]) begin
            // check for carry out, shift right and increment exponent
            normalized_mant = mantissaResult[24:1];
            normalized_exp = biggerExp + 1;
        end 
        //else if (carry & mantissaResult[24]) begin
        //     mr[24:0] = ~mantissaResult[24:0] + 1;
        //     casez (mr[24:1])
        //         24'b1??????????????????????: normalized_mant = mr[24:1];         
        //         24'b01?????????????????????: begin
        //             normalized_mant = {mr[23:1],1'b0};
        //             normalized_exp -= 1; end
        //         24'b001????????????????????: begin 
        //             normalized_mant = {mr[22:1],2'd0}; 
        //             normalized_exp -= 2; end
        //         24'b0001???????????????????: begin 
        //             normalized_mant = {mr[21:1], 3'd0}; 
        //             normalized_exp -= 3; end
        //         24'b00001??????????????????: begin 
        //             normalized_mant = {mr[20:1] , 4'd0}; 
        //             normalized_exp -= 4; end
        //         24'b000001?????????????????: begin 
        //             normalized_mant = {mr[19:1] , 5'd0}; 
        //             normalized_exp -= 5; end
        //         24'b0000001????????????????: begin 
        //             normalized_mant = {mr[18:1] , 6'd0}; 
        //             normalized_exp -= 6; end
        //         24'b00000001???????????????: begin 
        //             normalized_mant = {mr[17:1] , 7'd0}; 
        //             normalized_exp -= 7; end
        //         24'b000000001??????????????: begin 
        //             normalized_mant = {mr[16:1] , 8'd0}; 
        //             normalized_exp -= 8; end
        //         24'b0000000001?????????????: begin 
        //             normalized_mant = {mr[15:1] , 9'd0}; 
        //             normalized_exp -= 9; end
        //         24'b00000000001????????????: begin 
        //             normalized_mant = {mr[14:1] , 10'd0}; 
        //             normalized_exp -= 10; end
        //         24'b000000000001???????????: begin 
        //             normalized_mant = {mr[13:1] , 11'd0}; 
        //             normalized_exp -= 11; end
        //         24'b0000000000001??????????: begin 
        //             normalized_mant = {mr[12:1] , 12'd0}; 
        //             normalized_exp -= 12; end
        //         24'b00000000000001?????????: begin 
        //             normalized_mant = {mr[11:1] , 13'd0}; 
        //             normalized_exp -= 13; end
        //         24'b000000000000001????????: begin 
        //             normalized_mant = {mr[10:1] , 14'd0}; 
        //             normalized_exp -= 14; end
        //         24'b0000000000000001???????: begin 
        //             normalized_mant = {mr[9:1] , 15'd0}; 
        //             normalized_exp -= 15; end
        //         24'b00000000000000001??????: begin 
        //             normalized_mant = {mr[8:1] , 16'd0}; 
        //             normalized_exp -= 16; end
        //         24'b000000000000000001?????: begin 
        //             normalized_mant = {mr[7:1] , 17'd0}; 
        //             normalized_exp -= 17; end
        //         24'b0000000000000000001????: begin 
        //             normalized_mant = {mr[6:1] , 18'd0}; 
        //             normalized_exp -= 18; end
        //         24'b00000000000000000001???: begin 
        //             normalized_mant = {mr[5:1] , 19'd0}; 
        //             normalized_exp -= 19; end
        //         24'b000000000000000000001??: begin 
        //             normalized_mant = {mr[4:1] , 20'd0}; 
        //             normalized_exp -= 20; end
        //         24'b0000000000000000000001?: begin 
        //             normalized_mant = {mr[3:1] , 21'd0}; 
        //             normalized_exp -= 21; end
        //         24'b00000000000000000000001: begin 
        //             normalized_mant = {mr[2:1] , 22'd0}; 
        //             normalized_exp -= 22; end
        //         // default: begin
        //         //     normalized_mant = mantissaResult[23:0]; //result = 0/normalized
        //         //     normalized_exp = 8'h00; //exp = 0
        //         // end
        //     endcase
        // end 
        else begin
            // if(~mantissaResult[23]) begin //underflow case, shift mantissa, and minus exponent
            //     normalized_mant = {mantissaResult[22:0],1'b1}
            //     normalized_exp = biggerExp - 1; 
            // end
            // else begin
                // normalized_mant = mantissaResult[23:0];
                // normalized_exp = biggerExp;
            //end
            normalized_mant = mantissaResult[23:0];
            normalized_exp = biggerExp;
            //leading zero checking using case statement for normalization
            casez (mantissaResult[24:0])
                25'b01???????????????????????: normalized_mant = mantissaResult[23:0];         
                25'b001??????????????????????: begin
                    normalized_mant = {mantissaResult[22:0],1'b0};
                    normalized_exp -= 1; end
                25'b0001?????????????????????: begin 
                    normalized_mant = {mantissaResult[21:0],2'd0}; 
                    normalized_exp -= 2; end
                25'b00001????????????????????: begin 
                    normalized_mant = {mantissaResult[20:0], 3'd0}; 
                    normalized_exp -= 3; end
                25'b000001???????????????????: begin 
                    normalized_mant = {mantissaResult[19:0] , 4'd0}; 
                    normalized_exp -= 4; end
                25'b0000001??????????????????: begin 
                    normalized_mant = {mantissaResult[18:0] , 5'd0}; 
                    normalized_exp -= 5; end
                25'b00000001?????????????????: begin 
                    normalized_mant = {mantissaResult[17:0] , 6'd0}; 
                    normalized_exp -= 6; end
                25'b000000001????????????????: begin 
                    normalized_mant = {mantissaResult[16:0] , 7'd0}; 
                    normalized_exp -= 7; end
                25'b0000000001???????????????: begin 
                    normalized_mant = {mantissaResult[15:0] , 8'd0}; 
                    normalized_exp -= 8; end
                25'b00000000001??????????????: begin 
                    normalized_mant = {mantissaResult[14:0] , 9'd0}; 
                    normalized_exp -= 9; end
                25'b000000000001?????????????: begin 
                    normalized_mant = {mantissaResult[13:0] , 10'd0}; 
                    normalized_exp -= 10; end
                25'b0000000000001????????????: begin 
                    normalized_mant = {mantissaResult[12:0] , 11'd0}; 
                    normalized_exp -= 11; end
                25'b00000000000001???????????: begin 
                    normalized_mant = {mantissaResult[11:0] , 12'd0}; 
                    normalized_exp -= 12; end
                25'b000000000000001??????????: begin 
                    normalized_mant = {mantissaResult[10:0] , 13'd0}; 
                    normalized_exp -= 13; end
                25'b0000000000000001?????????: begin 
                    normalized_mant = {mantissaResult[9:0] , 14'd0}; 
                    normalized_exp -= 14; end
                25'b00000000000000001????????: begin 
                    normalized_mant = {mantissaResult[8:0] , 15'd0}; 
                    normalized_exp -= 15; end
                25'b000000000000000001???????: begin 
                    normalized_mant = {mantissaResult[7:0] , 16'd0}; 
                    normalized_exp -= 16; end
                25'b0000000000000000001??????: begin 
                    normalized_mant = {mantissaResult[6:0] , 17'd0}; 
                    normalized_exp -= 17; end
                25'b00000000000000000001?????: begin 
                    normalized_mant = {mantissaResult[5:0] , 18'd0}; 
                    normalized_exp -= 18; end
                25'b000000000000000000001????: begin 
                    normalized_mant = {mantissaResult[4:0] , 19'd0}; 
                    normalized_exp -= 19; end
                25'b0000000000000000000001???: begin 
                    normalized_mant = {mantissaResult[3:0] , 20'd0}; 
                    normalized_exp -= 20; end
                25'b00000000000000000000001??: begin 
                    normalized_mant = {mantissaResult[2:0] , 21'd0}; 
                    normalized_exp -= 21; end
                25'b000000000000000000000001?: begin 
                    normalized_mant = {mantissaResult[1:0] , 22'd0}; 
                    normalized_exp -= 22; end
                // default: begin
                //     normalized_mant = mantissaResult[23:0]; //result = 0/normalized
                //     normalized_exp = 8'h00; //exp = 0
                // end
            endcase
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
