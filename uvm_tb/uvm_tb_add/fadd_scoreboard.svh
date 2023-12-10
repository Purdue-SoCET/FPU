`ifndef FADD_SCOREBOARD_SVH
`define FADD_SCOREBOARD_SVH

import uvm_pkg::*;
`include "uvm_fpu_pkg.vh"
`include "uvm_macros.svh"
import uvm_fpu_pkg::*;

class fadd_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(fadd_scoreboard)

    // Declare actual result transactions
    uvm_analysis_export#(transaction) actual_result; //from monitor
    uvm_tlm_analysis_fifo #(transaction) actual_fifo;

    logic [WIDTH-1:0] expected_output;
    logic [WIDTH-1:0] actual_output;
    int PASSED, MISMATCH, txn_num;
    real num1, num2;
    function new(string name, uvm_component parent = null);
        super.new(name, parent);
        PASSED = 0;
        MISMATCH = 0;
        txn_num = 0;
        num1 = 0.0;
        num2 = 0.0;
        //`uvm_info("fadd_scoreboard","scoreboard construct",UVM_LOW);
    endfunction

    function void build_phase(uvm_phase phase);
        actual_result = new("actual_result", this);
        actual_fifo = new("actual_fifo", this);
        //`uvm_info("fadd_scoreboard","scoreboard build",UVM_LOW);
    endfunction

    function void connect_phase (uvm_phase phase);
        actual_result.connect(actual_fifo.analysis_export);
        //`uvm_info("fadd_scoreboard","scoreboard connect",UVM_LOW);
    endfunction

    task run_phase(uvm_phase phase);
        
        transaction actual_txn;
        //`uvm_info("fadd_scoreboard","scoreboard run",UVM_LOW);
        forever begin
            actual_fifo.get(actual_txn);
            txn_num++;
            // print the input float for visulization
            num1 = binary_to_float(actual_txn.float1);
            num2 = binary_to_float(actual_txn.float2);
            
            // calculate the expected output
            expected_output = compute_expected_output(actual_txn.float1,actual_txn.float2);
            // get actual output
            actual_output = actual_txn.sum;

            // compare
            if (actual_output != expected_output) begin
                MISMATCH++;
                uvm_report_info("Input float", $sformatf("%b + %b => %e + %e", actual_txn.float1[WIDTH-1:0], actual_txn.float2[WIDTH-1:0] ,num1,num2), UVM_LOW);
                uvm_report_info("Sum", $sformatf("%e",num1+num2), UVM_LOW);
                `uvm_error("fadd_Scoreboard", $sformatf("\nOUTPUT MISMATCH \nExpected output: %b(%e)\n  Actual output: %b(%e)", expected_output[WIDTH-1:0] , 
                                                                            binary_to_float(expected_output), actual_output[WIDTH-1:0] ,binary_to_float(actual_output)))
            end
            else begin
                PASSED ++;
            end
        end
    endtask

    function void report_phase(uvm_phase phase);
        `uvm_info("fadd_SB", $sformatf("\nTotal number of transactions: %0d\nTotal number of MISMATCH: %0d\n", txn_num, MISMATCH), UVM_LOW)
       
    endfunction

    //ALL FUNCTION ALSO in dpi.c 
    function logic [WIDTH-1:0] compute_expected_output(logic [WIDTH-1:0] binary_float1, logic [WIDTH-1:0] binary_float2);
        logic sign_output;
        // logic [WIDTH-1:0]QNAN,sNaN,Inf,nInf,max_norm,mini_sub;
        real float_output;
        logic [WIDTH-1:0] binary_output;
        int exp_overflow;
        real norm_bound;
        real subnorm_bound;

        norm_bound = binary_to_float(MAX_NORM);  //maximum normalize number, ex: in 16'b{0,11110,1111111111}
        subnorm_bound = binary_to_float(MINI_SUB); //smallest subnormal number, ex: in 16'b{0,00000,0000000001}

        // Handling NaN case
        // Any calculation involved NaN {exp = 5'b11111, mant != 0} => QNAN
        if (isNaN(binary_float1) || isNaN(binary_float2)) begin
            return QNAN; 
        end
        
        // Handling Inf case
        if ((binary_float1[WIDTH-1] ^ binary_float2[WIDTH-1]) && (isInf(binary_float1) && isInf(binary_float2))) begin
            return QNAN;  // Inf + (-Inf) -> QNAN
        end

        float_output = binary_to_float(binary_float1) + binary_to_float(binary_float2);
        //uvm_report_info("Sum", $sformatf("%.8f",float_output), UVM_LOW);

        //calculate signed bit
        if(float_output < 0) begin
            sign_output = 1'b1;
        end
        else begin
            sign_output = 1'b0;
        end

        // Handling Inf case
        if (isInf(binary_float1) || isInf(binary_float2)) begin
            return {sign_output, {EXPONENT_WIDTH{1'b1}}, {FRACTION_WIDTH{1'b0}}};  // Inf
        end

        // Handling Underflow case
        if((float_output < (subnorm_bound) && float_output > (-subnorm_bound))) begin
            return {sign_output,{EXPONENT_WIDTH+FRACTION_WIDTH{1'b0}}};    //underflow-> flush to 0
        end
        
        // Handling Overflow case
        if ((float_output > norm_bound) || (float_output < (-norm_bound))) begin
            if(sign_output) begin 
                return NINF; //Overflow-> -Inf
            end
            else begin 
                return INF;  //Overflow-> Inf
            end
        end
        
        //convert float to binary
        binary_output = float_to_binary(float_output);

        return binary_output;
    
    endfunction


    function real binary_to_float(logic [WIDTH-1:0] binary_float);
        int signed S = binary_float[WIDTH-1];
        int E = binary_float[EXPONENT_MSB:EXPONENT_LSB];
        int F = binary_float[FRACTION_MSB:FRACTION_LSB];
        int bias = $pow(2,EXPONENT_WIDTH-1)-1;
        real float_result;
        // uvm_report_info("CONVERT",$sformatf("\nS: %d\nE: %d\nF: %d\n",S,E,F),UVM_LOW);
        // Special cases
        if (binary_float[EXPONENT_MSB:EXPONENT_LSB] == '1 && F != '0) return $realtobits(0.0/0.0);
        if (binary_float[EXPONENT_MSB:EXPONENT_LSB] == '1 && F == '0 && S) return (-1.0/0.0);
        if (binary_float[EXPONENT_MSB:EXPONENT_LSB] == '1 && F == '0 && ~S) return (1.0/0.0);
        // Denormalized
        if (E == 0) begin
            float_result = $pow(-1,S)*$pow(2.0,-(bias-1))*(F/($pow(2.0,FRACTION_WIDTH)));
        end
        // Normalized
        else begin
            float_result = $pow(-1,S)*$pow(2.0,E-bias)*(1+(F/($pow(2.0,FRACTION_WIDTH))));
        end
        return float_result;
    endfunction //binary_to_float

    function logic [WIDTH-1:0] float_to_binary(real float_output);
        logic S;
        logic [EXPONENT_WIDTH-1:0] E;
        logic [FRACTION_WIDTH-1:0] F;
        logic [WIDTH-1:0] binary_output;
        logic [WIDTH-1:0] final_binary_output;
        real normalized_num;
        int int_part;
        real frac_part;
        int biased_exponent;
        int d;
        real temp;
        int subnorm_flag;
        int bias = $pow(2,EXPONENT_WIDTH-1)-1;
        // uvm_report_info("CONVERT",$sformatf("\nS: %d\nE: %d\nF: %d\n",S,E,F),UVM_LOW);

        //define the sign bit S
        if (float_output < 0) begin
            S = 1;
        end
        else begin 
            S = 0;
        end
        //Normalize the output
        normalized_num = float_output;
        biased_exponent = 0;

        // get abs(normalized_num) to help calculating since we already get the Signed bit
        normalized_num = abs(normalized_num);

        // CASE 1: if output >= 2.0, divided until it become (1.mantissa) and get the exponent
        while (normalized_num >= 2.0) begin
            normalized_num = normalized_num / 2.0;
            biased_exponent = biased_exponent + 1;
        end
        // CASE 2: if output < 1.0, muliplied until it become (1.mantissa) and get the exponent
        //Subnormal num: if the biased_exponent is exceed the maximum number it can represent, just stop and stay (0.mantissa)
        while (normalized_num < 1.0 && biased_exponent > -(bias-1)) begin
            normalized_num = normalized_num * 2.0;
            biased_exponent = biased_exponent - 1;
        end

        //Handle subnorms (if the number is too small to be represented with the biased exponent)
        //Set the subnorm_flag
        if(normalized_num < 1.0) begin
            subnorm_flag = 1;
        end

        // print messages for debug
        // uvm_report_info("normalized_num", $sformatf("%e", normalized_num), UVM_LOW);
        // uvm_report_info("biased_exponent", $sformatf("%0d", biased_exponent), UVM_LOW);

        // convert mantissa into 10 bits binary
        F = {FRACTION_WIDTH{1'b0}};
        int_part = $floor(normalized_num);
        frac_part = normalized_num-int_part;
        temp = frac_part;
        for (int i = (FRACTION_WIDTH-1); i >=0; i--) begin
            temp = temp * 2.0;
            F[i] = $floor(temp);
            temp = temp - $floor(temp);
        end
        // uvm_report_info("F", $sformatf("%b", F[FRACTION_WIDTH-1:0]), UVM_LOW);

        // Normalized number in the form: 1.mantissa x 2^biased_exponent
        // Bias is WIDTH-1 for half-precision
        biased_exponent = biased_exponent + bias;

        // Handle subnorms (if the number is too small to be represented with the biased exponent)
        if (subnorm_flag) begin
            F = F >> (-biased_exponent + 1);
            biased_exponent = 0; 
            binary_output = {S, biased_exponent[EXPONENT_WIDTH-1:0], F};
            final_binary_output = check_margin_err(float_output,binary_output);
            return final_binary_output;
        end

        binary_output = {S, biased_exponent[EXPONENT_WIDTH-1:0], F};
        final_binary_output = check_margin_err(float_output,binary_output);

        return final_binary_output;
    endfunction // float_to_binary

    function logic [WIDTH-1:0] check_margin_err(real out, logic [WIDTH-1:0] binary_output);
        logic [WIDTH-1:0] binary_output_add1;
        logic [WIDTH-1:0] final_output;
        real temp1;
        real temp2;
        binary_output_add1 = binary_output +1'd1;
        temp1 = binary_to_float(binary_output);
        temp2 = binary_to_float(binary_output_add1);
        if ((abs(out-temp1)) < (abs(out-temp2))) begin
            return binary_output;
        end
        else begin
            return binary_output_add1;
        end
    endfunction

    //some helper functions
    function int isNaN(logic [WIDTH-1:0] binary_float);
        logic [EXPONENT_WIDTH-1:0] E = binary_float[EXPONENT_MSB:EXPONENT_LSB];
        logic [FRACTION_WIDTH-1:0] F = binary_float[FRACTION_MSB:FRACTION_LSB];
        if ((binary_float[EXPONENT_MSB:EXPONENT_LSB] == '1) && (F != '0)) return 1;
        else return 0;
    endfunction

    function int isInf(logic [WIDTH-1:0] binary_float);
        logic [EXPONENT_WIDTH-1:0] E = binary_float[EXPONENT_MSB:EXPONENT_LSB];
        logic [FRACTION_WIDTH-1:0] F = binary_float[FRACTION_MSB:FRACTION_LSB];
        if ((E == '1) && (F == '0)) return 1;
        else return 0;
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
