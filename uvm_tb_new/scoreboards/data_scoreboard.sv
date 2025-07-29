class data_scoreboard extends uvm_scoreboard;
    uvm_analysis_imp #(fifo_seq_item, data_scoreboard) imp;

    `uvm_component_utils(data_scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        imp = new("imp", this);
    endfunction

    function void write(fifo_seq_item t);
        `uvm_info("DATA_SB", $sformatf("Checking data: %s", t.convert2string()), UVM_MEDIUM)
    endfunction
endclass
