interface fifo_interface(input logic clk, input logic rst);
    logic [31:0] data_in;
    logic [31:0] data_out;
    logic write_en;
    logic read_en;
    logic full;
    logic empty;
endinterface
