class fifo_seq_item extends uvm_sequence_item;
    rand bit [31:0] data;
    rand bit write;
    rand bit read;

    `uvm_object_utils(fifo_seq_item)

    function new(string name="fifo_seq_item");
        super.new(name);
    endfunction

    constraint random_fp_values {
        // Occasionally generate special floating-point values
        (data dist {
            32'h7FC00000 := 5,   // NaN
            32'h7F800000 := 5,   // +Inf
            32'hFF800000 := 5,   // -Inf
            [32'h00000001:32'h000FFFFF] := 10, // Subnormal
            [32'h00800000:32'h7F7FFFFF] := 75  // Normal range
        });
    }

    function string convert2string();
        return $sformatf("FP DATA=%h WRITE=%0b READ=%0b", data, write, read);
    endfunction
endclass
