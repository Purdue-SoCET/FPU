`timescale 1ns/1ps
module tb_top;
    import uvm_pkg::*;
    import fpu_uvm_pkg::*;

    logic clk;
    logic rst;
    fifo_interface intf(clk, rst);

    // DUT instantiation
    fifo_buffer dut (
        .clk(clk),
        .rst(rst),
        .data_in(intf.data_in),
        .data_out(intf.data_out),
        .write_en(intf.write_en),
        .read_en(intf.read_en),
        .full(intf.full),
        .empty(intf.empty)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset logic
    initial begin
        rst = 1;
        #20 rst = 0;
    end

    // Pass virtual interface to UVM
    initial begin
        uvm_config_db#(virtual fifo_interface)::set(null, "*", "vif", intf);
        run_test("tb_test");
    end
endmodule
