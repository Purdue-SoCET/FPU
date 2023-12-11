`ifndef UVM_FPU_PKG_VH
`define UVM_FPU_PKG_VH

package uvm_fpu_pkg;

    
    // -------------------------------------------------------
    // Half-precision
    // -------------------------------------------------------
    parameter WIDTH = 16;  
    parameter EXPONENT_WIDTH = 5;
	parameter FRACTION_WIDTH = 10;


    // -------------------------------------------------------
    // Single-precision
    // -------------------------------------------------------
    // parameter WIDTH = 32;  
    // parameter EXPONENT_WIDTH = 8;
	// parameter FRACTION_WIDTH = 23;

    // -------------------------------------------------------
    // Double-precision: 
    // -------------------------------------------------------
    // parameter WIDTH = 64;  
    // parameter EXPONENT_WIDTH = 11;
	// parameter FRACTION_WIDTH = 52;


    import "DPI-C" function int isNaN(longint binary);
    import "DPI-C" function int isInf(longint binary);
    import "DPI-C" function real binary_to_float(longint binary_float);
    import "DPI-C" function longint check_margin_err(real out, longint binary_output);
    import "DPI-C" function longint float_to_binary(real float_output);
    import "DPI-C" function longint compute_expected_output(longint binary_float1, longint binary_float2);

    parameter SIGN = WIDTH - 1;
	parameter EXPONENT_MSB = WIDTH - 2;
	parameter EXPONENT_LSB = FRACTION_WIDTH;
	parameter FRACTION_MSB = FRACTION_WIDTH - 1;
	parameter FRACTION_LSB = 0;


    // // Default values
    parameter ZERO = '0;
    parameter QNAN = {1'b1, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b1}}};
    parameter SNAN = {1'b1, {EXPONENT_WIDTH{1'b1}}, {1'b0,{FRACTION_WIDTH-1{1'b1}}}};
    parameter INF = {1'b0, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b0}}};
    parameter NINF = {1'b1, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b0}}};
    parameter MAX_NORM = {1'b0, {EXPONENT_WIDTH-1{1'b1}},1'b0,{FRACTION_WIDTH{1'b1}}};
    parameter MINI_SUB = {1'b0, {EXPONENT_WIDTH{1'b0}}, {FRACTION_WIDTH-1{1'b0}},1'b1};



endpackage
`endif // UVM_FPU_PKG_VH