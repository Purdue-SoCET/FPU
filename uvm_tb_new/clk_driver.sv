class clk_driver extends uvm_driver #(clk_seq_item);
    virtual fifo_interface vif;
    `uvm_component_utils(clk_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        clk_seq_item item;
        forever begin
            seq_item_port.get_next_item(item);
            repeat (item.cycles) @(posedge vif.clk);
            seq_item_port.item_done();
        end
    endtask
endclass
