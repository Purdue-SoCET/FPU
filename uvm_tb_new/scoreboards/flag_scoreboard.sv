class flag_scoreboard extends uvm_scoreboard;
    uvm_analysis_imp #(fifo_seq_item, flag_scoreboard) imp;

    `uvm_component_utils(flag_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        imp = new("imp", this);
    endfunction

    function void write(fifo_seq_item t);
        `uvm_info("FLAG_SB", $sformatf("Checking flag: %s", t.convert2string()), UVM_LOW)
    endfunction
endclass
