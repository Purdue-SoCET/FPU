`ifndef FADD16_SEQUENCE_SVH
`define FADD16_SEQUENCE_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.svh"

class fadd16_sequence extends uvm_sequence #(transaction);
    `uvm_object_utils(fadd16_sequence)

    function new(string name = "");    
        super.new(name);
        //`uvm_info("fadd16_sequence","sequence construct",UVM_LOW);
    endfunction: new

    task body();
        transaction req_item;
        // Create the transaction
        req_item = transaction::type_id::create("req_item");
        //`uvm_info("fadd16_sequence","start sequence ",UVM_LOW);

        //repeat randomized test cases
        repeat(10000) begin
            #20ns;
            //`uvm_info("fadd16_sequence","before start item ",UVM_LOW);
            start_item(req_item);
            //`uvm_info("fadd16_sequence","finish start item",UVM_LOW);

            if(!req_item.randomize()) begin
                `uvm_error("fadd16_sequence", "Failed to randomize transaction")
            end
            finish_item(req_item);
            //`uvm_info("fadd16_sequence","finish item",UVM_LOW);
        end
    endtask: body

endclass: fadd16_sequence

class pos_pos_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(pos_pos_seq)

    function new(string name = "zero_seq");
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

    function new(string name = "zero_seq");
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

    function new(string name = "zero_seq");
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
        repeat(1000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1[9:0] != '0;    
                req_item.float1[14:10] == 5'b11111;
                req_item.float2[14:10] != 5'b11111;   //exp!='1 => != inf nor NaN
            }) begin
                `uvm_error("NaN_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:NaN_seq

class sub_sub_seq extends uvm_sequence#(transaction);
    `uvm_object_param_utils(sub_sub_seq)

    function new(string name = "sub_sub_seq");
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
                req_item.float1[9:0] != '0;    
                req_item.float1[14:10] == '0;
                req_item.float2[14:10] == '0;   //exp<15 => fracion <1
                req_item.float2[9:0] != '0;  
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
        repeat(1000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1[9:0] != '0;    
                req_item.float1[14:10] != '0;
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
        repeat(1000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1 == '0;    
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
        repeat(1000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1[9:0] == '0;     //Inf
                req_item.float1[14:10] == '1;
                req_item.float2[14:10] != '1;   //!= inf nor NaN
                req_item.float2[9:0] != '0;  
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
                req_item.float1[9:0] == '0;     //Inf
                req_item.float1[14:10] == '1;
                req_item.float2[14:10] == '1;   //Inf
                req_item.float2[9:0] == '0;  
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
        repeat(1000) begin
            #20ns;
            start_item(req_item);
            if(!req_item.randomize() with {
                req_item.float1[9:0] != '0;    
                req_item.float1[14:10] != '0;
                req_item.float2[14:10] == req_item.float1[14:10];   
                req_item.float2[9:0] == req_item.float1[9:0];
                req_item.float2[15] == ~req_item.float1[15];
            }) begin
                `uvm_error("self_seq", "Failed to randomize transaction")
            end
            finish_item(req_item);     
        end
    endtask
endclass:self_seq

`endif
