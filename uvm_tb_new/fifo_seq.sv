`include "fifo_seq_item.sv"

class fifo_seq extends uvm_sequence #(fifo_seq_item);
    `uvm_object_utils(fifo_seq)

    function new(string name="fifo_seq");
        super.new(name);
    endfunction

    task body();
        fifo_seq_item item;
        repeat (100) begin
            item = fifo_seq_item::type_id::create("item");
            assert(item.randomize() with { data inside {[32'h0:32'hFFFFFFFF]}; });
            start_item(item);
            finish_item(item);
        end
    endtask
endclass
