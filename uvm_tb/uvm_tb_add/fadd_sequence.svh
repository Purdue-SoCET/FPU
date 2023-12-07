`ifndef FADD_SEQUENCE_SVH
`define FADD_SEQUENCE_SVH
import uvm_pkg::*;
`include "uvm_fpu_pkg.vh"
`include "uvm_macros.svh"
`include "transaction.svh"
import uvm_fpu_pkg::*;
class fadd_sequence extends uvm_sequence #(transaction);
    `uvm_object_utils(fadd_sequence)

    function new(string name = "");    
        super.new(name);
        //`uvm_info("fadd_sequence","sequence construct",UVM_LOW);
    endfunction: new

    task body();
        transaction req_item;
        // Create the transaction
        req_item = transaction::type_id::create("req_item");
        //`uvm_info("fadd_sequence","start sequence ",UVM_LOW);

        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);

            if(!req_item.randomize()) begin
                `uvm_error("fadd_sequence", "Failed to randomize transaction")
            end
            finish_item(req_item);
            //`uvm_info("fadd_sequence","finish item",UVM_LOW);
        end
    endtask: body

endclass: fadd_sequence

class pos_pos_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(pos_pos_seq)

    function new(string name = "zero_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1[SIGN] == 1'b0;    //pos
                req_item.float2[SIGN] == 1'b0;    //pos
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] != '1;   //exp!='1 => != inf nor NaN
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] != '1;   //exp!='1 => != inf nor NaN
            }) begin
                `uvm_error("pos_pos_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:pos_pos_seq

class neg_neg_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(neg_neg_seq)

    function new(string name = "zero_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1[SIGN] == 1'b1;    //neg
                req_item.float2[SIGN] == 1'b1;    //neg
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] != '1;   //exp!='1 => != inf nor NaN
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] != '1;   //exp!='1 => != inf nor NaN
            }) begin
                `uvm_error("neg_neg_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:neg_neg_seq

class pos_neg_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(pos_neg_seq)

    function new(string name = "zero_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1[SIGN] == 1'b0;    //pos
                req_item.float2[SIGN] == 1'b1;    //neg
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] != '1;   //exp!='1 => != inf nor NaN
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] != '1;   //exp!='1 => != inf nor NaN
            }) begin
                `uvm_error("pos_neg_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:pos_neg_seq

class NaN_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(NaN_seq)

    function new(string name = "NaN_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                // float1 exp = 5'b11111 and mantissa is not 0 => NaN
                req_item.float1[FRACTION_MSB:FRACTION_LSB] != '0;    
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] == '1;
                // float2 
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] != '1;   //exp!='1 => != inf nor NaN
            }) begin
                `uvm_error("NaN_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:NaN_seq

class norm_norm_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(norm_norm_seq)

    function new(string name = "norm_norm_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                // float1  
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] != '0;
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] != '1;
                // float2
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] != '0;
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] != '1;     
            }) begin
                `uvm_error("norm_norm_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:norm_norm_seq

class sub_sub_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(sub_sub_seq)

    function new(string name = "sub_sub_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                // float1
                req_item.float1[FRACTION_MSB:FRACTION_LSB] != '0;    
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] == '0;
                // float2
                req_item.float2[FRACTION_MSB:FRACTION_LSB] != '0;
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] == '0;   
            }) begin
                `uvm_error("sub_sub_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:sub_sub_seq

class norm_sub_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(norm_sub_seq)

    function new(string name = "norm_sub_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                // flaot1
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] != '0;
                req_item.float1[FRACTION_MSB:FRACTION_LSB] != '0; 
                // flaot2
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] == '0;   
                req_item.float2[FRACTION_MSB:FRACTION_LSB] != '0;  
            }) begin
                `uvm_error("norm_sub_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:norm_sub_seq

class Zero_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(Zero_seq)

    function new(string name = "Zero_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1 == '0;    
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] != '1;   //exp!='1 => != inf nor NaN
            }) begin
                `uvm_error("Zero_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:Zero_seq

class Inf_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(Inf_seq)

    function new(string name = "Inf_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1[FRACTION_MSB:FRACTION_LSB] == '0;     //Inf
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] == '1;
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] != '1;   //!= inf nor NaN
                req_item.float2[FRACTION_MSB:FRACTION_LSB] != '0;  
            }) begin
                `uvm_error("Inf_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:Inf_seq

class Inf_Inf_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(Inf_Inf_seq)

    function new(string name = "Inf_Inf_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(4) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1[FRACTION_MSB:FRACTION_LSB] == '0;     //Inf
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] == '1;
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] == '1;   //Inf
                req_item.float2[FRACTION_MSB:FRACTION_LSB] == '0;  
            }) begin
                `uvm_error("Inf_Inf_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:Inf_Inf_seq

class self_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(self_seq)

    function new(string name = "self_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                // float1  
                req_item.float1[EXPONENT_MSB:EXPONENT_LSB] != '1;       //exp != '1 => != NaN nor Inf
                // float2
                req_item.float2[FRACTION_MSB:FRACTION_LSB] == req_item.float1[FRACTION_MSB:FRACTION_LSB];
                req_item.float2[EXPONENT_MSB:EXPONENT_LSB] == req_item.float1[EXPONENT_MSB:EXPONENT_LSB];   
                req_item.float2[SIGN] == ~req_item.float1[SIGN];        //different sign
            }) begin
                `uvm_error("self_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:self_seq

class overflow_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(overflow_seq)

    function new(string name = "overflow_seq");
        super.new(name);
    endfunction

    task body();
        transaction req_item;
        req_item = transaction::type_id::create("req_item");
        //repeat randomized test cases
        repeat(1000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                // float1 = max/mini normal
                req_item.float1[EXPONENT_MSB:FRACTION_LSB] == {{EXPONENT_WIDTH-1{1'b1}},1'b0,{FRACTION_WIDTH{1'b1}}};    
                // float 2
                req_item.float2[SIGN] == req_item.float1[SIGN];     //same sign with float1
            }) begin
                `uvm_error("overflow_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:overflow_seq

`endif
