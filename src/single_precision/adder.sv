
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

    //assign exp of data to exp 1 and exp 2
    assign exp1 = data1[30:23];
    assign exp2 = data2[30:23];

    assign shift1 = data1[22:0];
    assign shift2 = data2[22:0]; //

    assign sign1 = data1[31];
    assign sign2 = data2[31];


    //subtract exponents
    always_comb begin
        mant1 = '0;
        mant2 = '0;
        result = '0;
        count = '0;
        if(exp1 > exp2) begin
            exp_sub = exp1 - exp2;  // do exp1 + 2's complement of exp2 (exp1 + (-exp2))
            if(count == 0) begin
               mant2 = shift2 << 1; //is this right // - think it should be right shift, what we have is left shift
               count = count + 1; // = expsub

               // we already shifted somehting

               //line 81 - do 2's complement
               //dont use count, and if loop
               //mant2 = shift 2 >> exp_sub
            end
            while(count < exp_sub - 1) begin // check if working first, if not wherever there is -, use 2's complement 
               mant2 = shift2 << 0; // whatever we did in line 83 got erased //is this correct // while loop doesnt work in verilog & shifting by 0 doesnt work
               //not synthesizable in verilog, use for loop in verilog
               //only use while loop in tb
               //change the while loop
              // count is not necessary
               count = count + 1;
            end
            //a = b >> 4 - shifting b right by 4 bits
            biggerExp = exp1;
        end
        else begin
            exp_sub = exp2 - exp1;
            if(count == 0) begin
                mant1 = shift1 << 1;
                count = count + 1;
            end
            while(count < exp_sub - 1) begin
                mant1 = shift1 << 0;
                count = count + 1;
            end
            biggerExp = exp2;
        end 

// return result as per format according to IEE-754 according to data
//refer to justin and om discussion, right shifting with 1 in msb, make sure logic is right

        case({sign1,sign2}) 
            2'b00: begin result = {1'b0, biggerExp, mant1 + mant2}; end
            2'b11: begin result = {1'b1, biggerExp, mant1 + mant2}; end
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
                    result = {1'b0, biggerExp, mant1 + mant2}; 
                end
                else begin
                    result = {1'b1, biggerExp, mant1 + mant2}; 
                end
            end
            default: result = '0;
        endcase 
    end

endmodule
