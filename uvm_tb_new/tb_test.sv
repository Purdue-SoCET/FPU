`timescale 1ns/1ps
import uvm_pkg::*;
import fpu_uvm_pkg::*;

module tb_top;
    logic clk;
    logic rst;
    fifo_interface intf(clk, rst);

    // Instantiate DUT
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

    // Run UVM test
    initial begin
        run_test("tb_test");
    end
endmodule
