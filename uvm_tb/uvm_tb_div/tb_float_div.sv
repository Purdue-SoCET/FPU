
`include "uvm_fpu_pkg.vh"
`include "float_div_16bit.sv" //this will need to be created in /src

// interface file
`include "float_div_if.svh"

// UVM test file
`include "test.svh"

`timescale 1ns/1ps

`include "uvm_macros.svh"
module tb_float_div ();

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
    float_div_if #(.WIDTH(WIDTH)) fdiv_if(clk);
    
    // instantiate the DUT
    float_div_16bit DUT(.float1(fdiv_if.float1),.float2(fdiv_if.float2),.rm(3'b100), .product(fdiv_if.product));
    
    initial begin
        // configure the interface into the database, so that it can be accessed throughout the hierachy
        uvm_config_db#(virtual float_div_if)::set( null, "", "float_div_vif", fdiv_if); 
        run_test("test"); // initiate test component
    end
endmodule