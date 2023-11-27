`include "fpu_types_pkg.vh"
`include "float_add.sv" 

// interface file
`include "float_add_16bit_if.svh"

// UVM test file
`include "test.svh"

`timescale 1ns/1ps

`include "uvm_macros.svh"
module tb_float_add_16bit ();

    // import uvm packages
    import uvm_pkg::*;
    import fpu_types_pkg::*;
    logic clk;
    // generate clock
    initial begin
		clk = 0;
		forever #10 clk = !clk;
	end

    // instantiate the interface
    float_add_16bit_if fadd16_if(clk);
    
    // instantiate the DUT
    float_add DUT(.float1(fadd16_if.float1),.float2(fadd16_if.float2), .sum(fadd16_if.sum), .rounding_mode(ROUND_NEAREST_EVEN));
    
    initial begin
        // configure the interface into the database, so that it can be accessed throughout the hierachy
        uvm_config_db#(virtual float_add_16bit_if)::set( null, "", "float_add_16bit_vif", fadd16_if); 
        run_test("test"); // initiate test component
    end
endmodule