
`include "uvm_fpu_pkg.vh"
`include "float_add.sv" 

// interface file
`include "float_add_if.svh"

// UVM test file
`include "test.svh"

`timescale 1ns/1ps

`include "uvm_macros.svh"
module tb_float_add ();

    // import uvm packages
    import uvm_pkg::*;
    import uvm_fpu_pkg::*;
    logic clk;
    // generate clock
    initial begin
		clk = 0;
		forever #10 clk = !clk;
	end

    // instantiate the interface for fpu16
    float_add_if #(.WIDTH(WIDTH)) fadd_if(.clk(clk));
    
    // instantiate the DUT for fpu16
    float_add #(.FLOAT_WIDTH(WIDTH), 
                .EXPONENT_WIDTH(EXPONENT_WIDTH), 
                .FRACTION_WIDTH(FRACTION_WIDTH),
                .SIGN(SIGN),
                .EXPONENT_MSB(EXPONENT_MSB),
                .EXPONENT_LSB(EXPONENT_LSB),
                .FRACTION_MSB(FRACTION_MSB),
                .FRACTION_LSB(FRACTION_LSB),
                .FLOAT_INF(INF),
                .FLOAT_INFN(NINF),
                .FLOAT_NAN(QNAN),
                .FLOAT_ZERO(ZERO)
                ) DUT(.float1(fadd_if.float1),.float2(fadd_if.float2), .sum(fadd_if.sum), .rounding_mode(ROUND_NEAREST_EVEN));
    
    initial begin
        // configure the interface into the database, so that it can be accessed throughout the hierachy
        uvm_config_db#(virtual float_add_if#(.WIDTH(WIDTH)))::set( null, "", "float_add_vif", fadd_if); 
        run_test("test"); // initiate test component
    end
endmodule