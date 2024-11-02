module subtraction (    
    input logic [31:0] data1, data2,
    output logic [31:0] result
    output logic overflow, underflow, invalid
);
    localparam BIAS = 127

    logic sign1; // sign bit of data 1
    logic sign2; // sign bit of data 2
    logic [7:0] exp1 // exponent bit of data 1
    logic [7:0] exp2 // exponent bit of data 2
    logic [22:0] mant1 // mantisan bit of data 1 
    logic [22:0] mant2 // mantisan bit of data 2 
    logic [23:0] mantA // mantisan bit for normalize mantisan of data 1
    logic [23:0] mantB // mantisan bit for normalize mantisan of data 2

    assign sign1 = data1[31];
    assign sign2 = data2[31];
    assign exp1 = data1[30:23];
    assign exp2 = data2[30:23];
    assign mant1 = data1[22:0];
    assign mant2 = data2[22:0];

    always_comb begin 
        if (exp1 != 0) begin 
            mantA = {1'b0, mant1}; // normalized numbers with 1 leading of data 1
        end
        else if (exp1 == 0) begin // denormalized numbers with 0 leading of data 2
            mantA = {0'b0, mant1};
        end
        else if (exp2 != 0) begin // normalized numbers with 1 leading of data 1
            mantB = {1'b0, mant2};
        end
        else if (exp == 0) begin // denormalized numbers with 0 leading of data 2
            mantB = {0'b0, mant2};
        end
    end

endmodule 