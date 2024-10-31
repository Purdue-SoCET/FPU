
// module fracAdder (
//     input logic [22:0] data1, data2,
//     output logic sum[22:0],
//     output logic carryOut
// );
//     logic [23:0] sumTemp;
    
//     always_comb begin
//     sumTemp = data1 + data2;
//     carryOut = sumTemp[23];
//     sum = sumTemp[22:0];
//     end

// endmodule

// module expAdder(
//     input logic [31:23] data1, data2,
//     output logic exp[8:0]

// );

// always_comb begin
//     exp = data1 + data2;
// end

// endmodule

// module concat(
//     input logic [31:0] data1, data2,
//     output logic [31:0] output
// );

// logic [8:0] exponent;
// logic carryOut;
// logic [22:0] sum;


// always_comb begin
//     fracAdder u0 (.data1(data1[22:0]), .data2(data2[22:0]), .sum(sum), .carryOut(carryOut));
//     expAdder u1 (.data1(data1[31:23]), .data2(data2[31:23]), .exp(exponent));
//     output = {exponent, sum};
// end

// endmodule

module adder(
    input logic [31:0] data1, data2,
    output logic [31:0] result
);
    //making logic variables for the operations
    logic [7:0] exp_sub;
    logic sign1;
    logic sign2;
    logic [7:0] exp1;
    logic [7:0] exp2;
    logic [22:0] mant1;
    logic [22:0] mant2;
    logic [7:0] biggerExp;
    logic [22:0] shift1;
    logic [22:0] shift2;
    logic [7:0] count;
    logic [23:0] carroutCheck;
    logic [22:0] mantissaResult;

    //assign exp of data to exp 1 and exp 2
    assign exp1 = data1[30:23];
    assign exp2 = data2[30:23];

    assign sign1 = data1[31];
    assign sign2 = data2[31];


    //subtract exponents
    always_comb begin
        mant1 = '0;
        mant2 = '0;
        result = '0;
        shift2 = data2[22:0]; //mantissa data for second register
        shift1 = data1[22:0]; //mantissa data for first register
        if(exp1 > exp2) begin
            exp_sub = exp1 + (~exp2 + 1);  // do exp1 + 2's complement of exp2 (exp1 + (-exp2))
            
            mant2 = {1'b1, shift2[22:1]}; //Shift in 1 to the second mantissa for implied "1.####"
            mant2 = mant2 >> exp_sub; 

            //a = b >> 4 - shifting b right by 4 bits
            biggerExp = exp1;
        end
        else begin
            exp_sub = exp2 + (~exp1 + 1);
            
            mant1 = {1'b1, shift1[22:1]}; //Shift in 1 to the first mantissa for implied "1.####"
            mant1 = shift1 >> exp_sub;
            
            biggerExp = exp2;
        end 

// return result as per format according to IEE-754 according to data
//refer to justin and om discussion, right shifting with 1 in msb, make sure logic is right

        carroutCheck = mant1 + mant2; //this checks for a carryout value by using a logic variable that is 24 bits
        if(carroutCheck[23]) begin//If the 23rd bit is equal to 1, then there is a carry out
        
            carroutCheck = carroutCheck >> 1; //The entire 23rd bit value is shifted by 1
            biggerExp = biggerExp + 1; //Then 1 is added to the exponent
            mantissaResult = {carroutCheck[22:0]}; //Mantissa result for addition is set to the 23 bits that were shifted in the if statement.
        end
        else begin
            mantissaResult = mant1 + mant2; //Mantissa result for addition is set to the mantissas added if there is no carryout to worry about
        end

        case({sign1,sign2}) 
            2'b00: begin result = {1'b0, biggerExp, mantissaResult}; end
            2'b11: begin result = {1'b1, biggerExp, mantissaResult}; end
            2'b01: begin 
                if(mant1 > mant2) begin
                    result = {1'b0, biggerExp, mant1 - mant2}; 
                end
                else begin
                    result = {1'b1, biggerExp, mant1 - mant2}; 
                end
            end
            2'b10: begin 
                if(mant2 > mant1) begin
                    result = {1'b0, biggerExp, mantissaResult}; 
                end
                else begin
                    result = {1'b1, biggerExp, mantissaResult}; 
                end
            end
            default: result = '0;
        endcase 
    end

endmodule
