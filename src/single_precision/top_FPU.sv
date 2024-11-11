module top_FPU (
    input logic [31:0] data1, data2,
    output logic [31:0] result,
    input logic [6:0]opcode
);

logic [31:0]data2_in;
logic [31:0]result_sub, result_mult, result_add;
logic overflow_mult, underflow_mult;
logic overflow_add, underflow_add;
logic [1:0]opcode_out;


adder u0 (.data1(data1), .data2(data2_in), .result(result_add), .overflow(overflow_add), .underflow(underflow_add));
multiplication u1(.data1(data1), .data2(data2), .result(result_mult), .overflow(overflow_mult), .underflow(underflow_mult));
decoder u2(.in(opcode), .out(opcode_out));

always_comb begin
    if (opcode_out == 2'd1) begin
        data2_in = data2;
        result = result_add; end
    else if (opcode_out = 2'd2) begin
        data2_in = {~data2[31],data2[30:0]};
        result = result_add; end
    else if (opcode_out = 2'd3) begin
        result = result_mult; end
end


endmodule
