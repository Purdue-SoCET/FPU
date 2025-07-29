class clk_seq_item extends uvm_sequence_item;
    rand int cycles;
    `uvm_object_utils(clk_seq_item)

    function new(string name="clk_seq_item");
        super.new(name);
    endfunction
endclass
