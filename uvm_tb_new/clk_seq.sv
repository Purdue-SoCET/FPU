`include "clk_seq_item.sv"

class clk_seq extends uvm_sequence #(clk_seq_item);
    `uvm_object_utils(clk_seq)

    function new(string name="clk_seq");
        super.new(name);
    endfunction

    task body();
        clk_seq_item item;
        repeat (10) begin
            item = clk_seq_item::type_id::create("clk_item");
            assert(item.randomize() with { cycles inside {[1:20]}; });
            start_item(item);
            finish_item(item);
        end
    endtask
endclass
