module subtraction(
    input logic [31:0] data1, data2,
    output logic [31:0] result
);
    logic [31:0] data1_sub; // complement of data1
    logic [31:0] data2_sub; // complement of data2
    logic sign1; // sign bit of data1's complement 
    logic sign2; // sign bit of data2's complement
    logic [7:0] exp1; // exponent bit of data1's complement
    logic [7:0] exp2; // exponent bit of data2's complement
    logic [22:0] shift1; // fraction bit of data1's complement before shifting 
    logic [22:0] shift2; // fraction bit of data2's complement before shifting
    logic [22:0] mant1; // fraction bit of data1's complement
    logic [22:0] mant2; // fraction bit of data2's complement

    logic [7:0] count;
    logic [7:0] biggerEXP;
    logic [7:0] exp_sub;
 
    always_comb begin 
        data1_sub = ~data1 + 1;
        data2_sub = ~data2 + 1;
    end

    assign sign1 = data1_sub[31]; 
    assign sign2 = data2_sub[31]; 

    assign exp1 = data1_sub[30:23];
    assign exp2 = data2_sub[30:23];

    always_comb begin 
        mant1 = '0;
        mant2 = '0;
        result = '0;
        shift2 = data2[22:0]; //mantissa data for second register
        shift1 = data1[22:0]; //mantissa data for first register
        if(exp1 > exp2) begin 
            exp_sub = exp1 - exp2; 
            
            mant2 = {1'b1, shift2[22:1]}; //Shift in 1 to the second mantissa for implied "1.####"
            mant2 = mant2 >> exp_sub;
            biggerEXP = exp1;
        end
        else begin 
            exp_sub = exp2 + (~exp1 + 1);
            
            mant1 = {1'b1, shift1[22:1]}; //Shift in 1 to the second mantissa for implied "1.####"
            mant1 = shift1 >> exp_sub;
            biggerEXP = exp2;
        end

        case({sign1, sign2})
            2'b00: begin
                result = {1'b0, biggerEXP, mant1 + mant2}; 
            end
            2'b11: begin 
                result = {1'b1, biggerEXP, mant1 + mant2};
            end
            2'b01: begin 
                if(mant1 > mant2) begin
                    result = {1'b0, biggerEXP, mant1 - mant2};
                end
                else begin 
                    result = {1'b1, biggerEXP, mant1 - mant2};
                end
            end
            2'b10: begin
                if(mant2 > mant1) begin 
                    result = {1'b0, biggerEXP, mant1 - mant2};
                end
                else begin 
                    result = {1'b1, biggerEXP, mant1 + mant2};
                end
            end
            default: result = '0;
        endcase
    end
endmodule
