`ifndef FMULT_SEQUENCE_SVH
`define FMULT_SEQUENCE_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.svh"

class fmult_sequence extends uvm_sequence #(transaction);
    `uvm_object_utils(fmult_sequence)

    function new(string name = "");    
        super.new(name);
        //`uvm_info("fmult_sequence","sequence construct",UVM_LOW);
    endfunction: new

    task body();
        transaction req_item;
        // Create the transaction
        req_item = transaction::type_id::create("req_item");
        //`uvm_info("fmult_sequence","start sequence ",UVM_LOW);

        //repeat randomized test cases
        repeat(100000) begin
            #20ns;
            //`uvm_info("fmult_sequence","before start item ",UVM_LOW);
            start_item(req_item);
            //`uvm_info("fmult_sequence","finish start item",UVM_LOW);

            if(!req_item.randomize()) begin
                `uvm_error("fmult_sequence", "Failed to randomize transaction")
            end
            finish_item(req_item);
            //`uvm_info("fmult_sequence","finish item",UVM_LOW);
        end
    endtask: body

endclass: fmult_sequence

class pos_pos_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(pos_pos_seq)

    function new(string name = "pos_pos_seq");
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
                req_item.float1[15] == 1'b0;    //pos
                req_item.float2[15] == 1'b0;    //pos
                req_item.float1[14:10] != '1;   //exp!='1 => != inf nor NaN
                req_item.float2[14:10] != '1;   //exp!='1 => != inf nor NaN
            }) begin
                `uvm_error("pos_pos_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:pos_pos_seq

class neg_neg_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(neg_neg_seq)

    function new(string name = "neg_neg_seq");
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
                req_item.float1[15] == 1'b1;    //neg
                req_item.float2[15] == 1'b1;    //neg
                req_item.float1[14:10] != '1;   //exp!='1 => != inf nor NaN
                req_item.float2[14:10] != '1;   //exp!='1 => != inf nor NaN
            }) begin
                `uvm_error("neg_neg_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:neg_neg_seq

class pos_neg_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(pos_neg_seq)

    function new(string name = "pos_neg_seq");
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
                req_item.float1[15] == 1'b0;    //pos
                req_item.float2[15] == 1'b1;    //neg
                req_item.float1[14:10] != '1;   //exp!='1 => != inf nor NaN
                req_item.float2[14:10] != '1;   //exp!='1 => != inf nor NaN
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
                req_item.float1[9:0] != '0;    
                req_item.float1[14:10] == 5'b11111;   //exp = '1 => NaN
                req_item.float2[14:10] != 5'b11111;   //exp!='1 => != inf nor NaN
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
                req_item.float1[9:0] != '0;    
                req_item.float1[14:10] != '0;
                req_item.float1[14:10] != '1;
                // float2
                req_item.float2[14:10] != '0;
                req_item.float2[14:10] != '1;     
                req_item.float2[9:0] != '0;  
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
                req_item.float1[9:0] != '0;    //mantissa != 0
                req_item.float1[14:10] == '0;   //exp = '0
                // float2
                req_item.float2[9:0] != '0;     //mantissa != 0
                req_item.float2[14:10] == '0;   //exp = '0
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
                req_item.float1[9:0] != '0;    
                req_item.float1[14:10] != '0;   //exp!='0 => != sub
                req_item.float1[14:10] != '1;  //exp!='1 => != inf nor NaN
                req_item.float2[14:10] == '0;   
                req_item.float2[9:0] != '0;  
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
                // float1
                req_item.float1 == '0;    
                // float2
                req_item.float2[14:10] != 5'b11111;   //exp!='1 => != inf nor NaN
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
                // float1
                req_item.float1[9:0] == '0;     //Inf
                req_item.float1[14:10] == '1;
                // float2
                req_item.float2[9:0] != '0; 
                req_item.float2[14:10] != '0;   //!= inf nor NaN
            }) begin
                `uvm_error("Inf_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:Inf_seq

class Zero_Inf_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(Zero_Inf_seq)

    function new(string name = "Zero_Inf_seq");
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
                // float1
                req_item.float1[9:0] == '0;     //0
                req_item.float1[14:10] == '0;
                // float2
                req_item.float2[9:0] == '0;  
                req_item.float2[14:10] == '1;   //Inf
            }) begin
                `uvm_error("Zero_Inf_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:Zero_Inf_seq

class overflow_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(overflow_seq)

    function new(string name = "overflow_seq");
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
                // float1 = 65504
                req_item.float1[9:0] == '1;    
                req_item.float1[14:10] == 5'b11110; 
                req_item.float2 > 16'h3C00; // > 1.0
            }) begin
                `uvm_error("overflow_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:overflow_seq
`endif
