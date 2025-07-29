class fifo_driver extends uvm_driver #(fifo_seq_item);
    virtual fifo_interface vif;
    `uvm_component_utils(fifo_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        fifo_seq_item item;
        forever begin
            seq_item_port.get_next_item(item);
            vif.write_en = item.write;
            vif.read_en  = item.read;
            vif.data_in  = item.data;
            @(posedge vif.clk);
            seq_item_port.item_done();
        end
    endtask
endclass
