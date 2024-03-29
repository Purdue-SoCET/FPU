
`include "uvm_fpu_pkg.vh"
`include "float_mult_16bit.sv" 

// interface file
`include "float_mult_if.svh"

// UVM test file
`include "test.svh"

`timescale 1ns/1ps

`include "uvm_macros.svh"
module tb_float_mult ();

    // import uvm packages
    import uvm_pkg::*;
    import uvm_fpu_pkg::*;
    //import fpu_types_pkg::*;
    
    logic clk;
    // generate clock
    initial begin
		clk = 0;
		forever #10 clk = !clk;
	end

    // instantiate the interface
    float_mult_if #(.WIDTH(WIDTH)) fmult_if(clk);
    
    // instantiate the DUT
    float_mult_16bit DUT(.float1(fmult_if.float1),.float2(fmult_if.float2),.rm(3'b100), .product(fmult_if.product));
    
    initial begin
        // configure the interface into the database, so that it can be accessed throughout the hierachy
        uvm_config_db#(virtual float_mult_if)::set( null, "", "float_mult_vif", fmult_if); 
        run_test("test"); // initiate test component
    end
endmodule