`ifndef FMULT16_SCOREBOARD_SVH
`define FMULT16_SCOREBOARD_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

class fmult16_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(fmult16_scoreboard)

    // Declare actual result transactions
    uvm_analysis_export#(transaction) actual_result; //from monitor
    uvm_tlm_analysis_fifo #(transaction) actual_fifo;
    
    logic [15:0] expected_product;
    logic [15:0] actual_product;
    int PASSED, MISMATCH, txn_num;
    real num1, num2;
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        PASSED = 0;
        MISMATCH = 0;
        txn_num = 0;
        num1 = 0.0;
        num2 = 0.0;
        //`uvm_info("fmult16_scoreboard","scoreboard construct",UVM_LOW);
    endfunction

    function void build_phase(uvm_phase phase);
        actual_result = new("actual_result", this);
        actual_fifo = new("actual_fifo", this);
        //`uvm_info("fmult16_scoreboard","scoreboard build",UVM_LOW);
    endfunction

    function void connect_phase (uvm_phase phase);
        actual_result.connect(actual_fifo.analysis_export);
        //`uvm_info("fmult16_scoreboard","scoreboard connect",UVM_LOW);
    endfunction

    task run_phase(uvm_phase phase);
        
        transaction actual_txn;
        //`uvm_info("fmult16_scoreboard","scoreboard run",UVM_LOW);
        forever begin
            actual_fifo.get(actual_txn);
            txn_num++;
            // print the input float for visulization
            num1 = binary_to_float(actual_txn.float1);
            num2 = binary_to_float(actual_txn.float2);
            uvm_report_info("Input float", $sformatf("%16b * %16b => %.8f * %.8f", actual_txn.float1, actual_txn.float2,num1,num2), UVM_LOW);

            // calculate the expected product
            expected_product = compute_expected_product(actual_txn.float1,actual_txn.float2);
            // get actual product
            actual_product = actual_txn.product;

            // compare
            if (actual_product != expected_product) begin
                MISMATCH++;
                // `uvm_error("fmult16_Scoreboard", $sformatf("\nPRODUCT MISMATCH: %16b * %16b => %.8f * %.8f \nExpected product: %16b(%.8f)\n  Actual product: %16b(%.8f)", 
                // actual_txn.float1, actual_txn.float2,num1,num2, expected_product,binary_to_float(expected_product), actual_product,binary_to_float(actual_product)))
                `uvm_error("fmult16_Scoreboard", $sformatf("\nPRODUCT MISMATCH: \nExpected product: %16b(%.8f)\n  Actual product: %16b(%.8f)", 
                 expected_product,binary_to_float(expected_product), actual_product,binary_to_float(actual_product)))
            end
            else begin
                PASSED ++;
            end
        end
    endtask

    function void report_phase(uvm_phase phase);
        `uvm_info("fmult16_SB", $sformatf("\nTotal number of transactions: %0d\nTotal number of MISMATCH: %0d\n", txn_num, MISMATCH), UVM_LOW)
       
    endfunction

    function logic [15:0] compute_expected_product(logic [15:0] binary_float1, logic [15:0] binary_float2);
        logic sign_product;
        logic [15:0]qNaN,sNaN,Inf,nInf;
        real float_product;
        logic [15:0] binary_product;
        int exp_overflow;
        real norm_bound;
        real subnorm_bound;
        // Default values
        qNaN = {1'b1, 5'b11111, 10'b1111111111};
        sNaN = {1'b1, 5'b11111, 10'b0111111111};
        Inf = {1'b0, 5'b11111, 10'b0};
        nInf = {1'b1, 5'b11111, 10'b0};
        norm_bound = binary_to_float(16'b0111101111111111);  //maximum normalize number
        subnorm_bound = binary_to_float(16'b0000000000000001); //smallest subnormal number

        //calculate signed bit
        sign_product = binary_float1[15] ^ binary_float2[15];

        // Handling NaN case
        // Any calculation involved NaN {exp = 5'b11111, mant != 0} => qNaN
        if (isNaN(binary_float1) || isNaN(binary_float2)) begin
            return qNaN; 
        end
        
        // Handling Zero case
        if(binary_float1[14:0] == 14'b0 || binary_float2[14:0] == 14'b0) begin
            if(isInf(binary_float1) || isInf(binary_float2)) begin
                return qNaN; // Zero * Inf => qNaN
            end
            else begin
                return {sign_product,15'b0};    // +/- 0
            end
        end
            
        // Handling Inf case
        if (isInf(binary_float1) || isInf(binary_float2)) begin
            return {sign_product, 5'b11111, 10'b0};  // Inf
        end

        float_product = binary_to_float(binary_float1)*binary_to_float(binary_float2);
        uvm_report_info("Product", $sformatf("%.8f",float_product), UVM_LOW);

        // Handling Underflow case
        if((float_product < (subnorm_bound) && float_product > (-subnorm_bound))) begin
            return {sign_product,15'b0};    //underflow-> flush to 0
        end
        
        // Handling Overflow case
        if ((float_product > norm_bound) || (float_product < (-norm_bound))) begin
            if(sign_product) begin 
                return nInf; //Overflow-> -Inf
            end
            else begin 
                return Inf;  //Overflow-> Inf
            end
        end
        
        //convert float to binary
        binary_product = float_to_binary(float_product);

        return binary_product;
    
    endfunction


    function real binary_to_float(logic [15:0] binary_float);
        int signed S = binary_float[15];
        int E = binary_float[14:10];
        int F = binary_float[9:0];
        real float_result;
        // uvm_report_info("CONVERT",$sformatf("\nS: %d\nE: %d\nF: %d\n",S,E,F),UVM_LOW);
        // Special cases
        if (E == 5'b11111 && F != 0) return $realtobits(0.0/0.0);
        if (E == 5'b11111 && F == 0 && S) return (-1.0/0.0);
        if (E == 5'b11111 && F == 0 && ~S) return (1.0/0.0);;
        // Denormalized
        if (E == 0) begin
            float_result = $pow(-1,S)*$pow(2.0,-14)*(F/($pow(2.0,10)));
        end
        // Normalized
        else begin
            float_result = $pow(-1,S)*$pow(2.0,E-15)*(1+(F/($pow(2.0,10))));
        end
        return float_result;
    endfunction //binary_to_float

    function logic [15:0] float_to_binary(real float_product);
        logic S;
        logic [4:0] E;
        logic [9:0] F;
        logic [15:0] binary_output;
        logic [15:0] final_binary_output;
        real normalized_num;
        integer int_part;
        real frac_part;
        integer biased_exponent;
        integer d;
        real temp;
        int subnorm_flag;
        // uvm_report_info("CONVERT",$sformatf("\nS: %d\nE: %d\nF: %d\n",S,E,F),UVM_LOW);

        //define the sign bit S
        if (float_product < 0) begin
            S = 1;
        end
        else begin 
            S = 0;
        end
        //Normalize the product
        normalized_num = float_product;
        biased_exponent = 0;

        // get abs(normalized_num) to help calculating since we already get the S bit
        normalized_num = abs(normalized_num);

        // CASE 1: if product >= 2.0, divided until it become (1.mantissa) and get the exponent
        while (normalized_num >= 2.0) begin
            normalized_num = normalized_num / 2.0;
            biased_exponent = biased_exponent + 1;
        end
        // CASE 2: if product < 1.0, multiplied until it become (1.mantissa) and get the exponent
        //Subnormal num: if the biased_exponent is exceed the maximum number it can represent, just stop and stay (0.mantissa)
        while (normalized_num < 1.0 && biased_exponent > -14) begin
            normalized_num = normalized_num * 2.0;
            biased_exponent = biased_exponent - 1;
        end

        //Handle subnorms (if the number is too small to be represented with the biased exponent)
        //Set the subnorm_flag
        if(normalized_num < 1.0) begin
            subnorm_flag = 1;
        end

        // print messages for debug
        // uvm_report_info("normalized_num", $sformatf("%.8f", normalized_num), UVM_LOW);
        // uvm_report_info("biased_exponent", $sformatf("%0d", biased_exponent), UVM_LOW);

        // convert mantissa into 10 bits binary
        F = 10'b0;
        int_part = $floor(normalized_num);
        frac_part = normalized_num-int_part;
        temp = frac_part;
        for (int i = 9; i >=0; i--) begin
            temp = temp * 2;
            F[i] = $floor(temp);
            temp = temp - $floor(temp);
        end
        
        // Normalized number in the form: 1.mantissa x 2^biased_exponent
        // Bias is 15 for half-precision
        biased_exponent = biased_exponent + 5'd15;

        // Handle subnorms (if the number is too small to be represented with the biased exponent)
        if (subnorm_flag) begin
            F = F >> (-biased_exponent + 1); // +1'd1?
            biased_exponent = 0;
            binary_output = {S, biased_exponent[4:0], F};
            final_binary_output = check_margin_err(float_product,binary_output);
            return final_binary_output;
        end

        binary_output = {S, biased_exponent[4:0], F};
        final_binary_output = check_margin_err(float_product,binary_output);

        return final_binary_output;
    endfunction // float_to_binary

    //some helper functions
    function int isNaN(logic [15:0] binary_float);
        int signed S = binary_float[15];
        int E = binary_float[14:10];
        int F = binary_float[9:0];
        if ((E == 5'b11111) && (F != '0)) return 1;
        else return 0;
    endfunction

    function int isInf(logic [15:0] binary_float);
        int E = binary_float[14:10];
        int F = binary_float[9:0];
        if ((E == 5'b11111) && (F == '0)) return 1;
        else return 0;
    endfunction

    function logic [15:0] check_margin_err(real product, logic [15:0] binary_output);
        logic [15:0] binary_output_add1;
        logic [15:0] final_output;
        real temp1;
        real temp2;
        binary_output_add1 = binary_output +1'd1;
        temp1 = binary_to_float(binary_output);
        temp2 = binary_to_float(binary_output_add1);
        if ((abs(product-temp1)) < (abs(product-temp2))) begin
            return binary_output;
        end
        else begin
            return binary_output_add1;
        end
    endfunction

    function real abs(real value);
        if(value < 0) begin
            return -value;
        end
        else begin
            return value;
        end    
    endfunction
endclass
`endif
