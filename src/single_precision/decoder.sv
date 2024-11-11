module decoder (
    input logic [6:0]in,
    output logic [1:0]out
);

always_comb begin 
    case(in)
    7'b0000000: begin //add
        out = 2'd1; end
    7'b0000001: begin //sub
        out = 2'd2; end
    7'b0000010: begin //mult
        out = 2'd3; end
    endcase
end

endmodule
