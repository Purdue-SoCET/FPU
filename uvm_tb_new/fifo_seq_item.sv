`ifndef FIFO_SEQ_ITEM_SV
`define FIFO_SEQ_ITEM_SV

class fifo_seq_item extends uvm_sequence_item;
    rand bit [31:0] data;
    rand bit write;
    rand bit read;

    `uvm_object_utils(fifo_seq_item)

    function new(string name="fifo_seq_item");
        super.new(name);
    endfunction

    function string convert2string();
        return $sformatf("data=%h write=%0b read=%0b", data, write, read);
    endfunction
endclass

`endif
