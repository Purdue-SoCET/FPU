`include "float_div_if.svh"
import uvm_pkg::*;

module tb_float_div;
  timeunit 1ns; timeprecision 1ps;
  logic clk, reset_n;
  float_div_if div_if(clk, reset_n);

  // instantiate your DUT division module here

  initial begin
    clk = 0; forever #5 clk = ~clk;
  end
  initial begin
    reset_n = 0; #20; reset_n = 1;
  end

  initial begin
    run_test("fdiv_test");
  end
endmodule
