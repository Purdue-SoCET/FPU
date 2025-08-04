import uvm_pkg::*;
`include "uvm_macros.svh"
`include "environment.svh"

class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    environment env;
    virtual float_div_if vif;
    
    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
        //`uvm_info("tesbase_testt","test construct",UVM_LOW);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = environment::type_id::create("env",this);
        // send the interface down
        if (!uvm_config_db#(virtual float_div_if)::get(this, "", "float_div_vif", vif)) begin 
        // check if interface is correctly set in testbench top level
            `uvm_fatal("base_test", "No virtual interface specified for this test instance")
        end 

        uvm_config_db#(virtual float_div_if)::set(this, "env.agt*", "float_div_vif", vif);
        //`uvm_info("base_test","base_test build phase",UVM_LOW);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        fdiv_sequence seq = fdiv_sequence::type_id::create("seq",this);

        phase.raise_objection( this, "Starting sequence in run phase" );
        //`uvm_info("base_test"," base_test run_phase.raise",UVM_LOW);

        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;

        phase.drop_objection( this , "Finished in run phase" );
        //`uvm_info("base_test","base_test run_phase.drop",UVM_LOW);
    endtask

endclass: base_test

class pos_pos_test extends base_test;
    `uvm_component_utils(pos_pos_test)

    function new(string name = "pos_pos_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        pos_pos_seq seq = pos_pos_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: pos_pos_test

class neg_neg_test extends base_test;
    `uvm_component_utils(neg_neg_test)

    function new(string name = "neg_neg_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        neg_neg_seq seq = neg_neg_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: neg_neg_test

class NaN_test extends base_test;
    `uvm_component_utils(NaN_test)

    function new(string name = "NaN_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        NaN_seq seq = NaN_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: NaN_test

class norm_norm_test extends base_test;
    `uvm_component_utils(norm_norm_test)

    function new(string name = "norm_norm_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        norm_norm_seq seq = norm_norm_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: norm_norm_test

class sub_sub_test extends base_test;
    `uvm_component_utils(sub_sub_test)

    function new(string name = "sub_sub_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        sub_sub_seq seq = sub_sub_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: sub_sub_test

class norm_sub_test extends base_test;
    `uvm_component_utils(norm_sub_test)

    function new(string name = "norm_sub_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        norm_sub_seq seq = norm_sub_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: norm_sub_test

class Zero_test extends base_test;
    `uvm_component_utils(Zero_test)

    function new(string name = "Zero_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        Zero_seq seq = Zero_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: Zero_test
class Inf_test extends base_test;
    `uvm_component_utils(Inf_test)

    function new(string name = "Inf_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        Inf_seq seq = Inf_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: Inf_test

class Zero_Inf_test extends base_test;
    `uvm_component_utils(Zero_Inf_test)

    function new(string name = "Zero_Inf_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        Zero_Inf_seq seq = Zero_Inf_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: Zero_Inf_test

class overflow_test extends base_test;
    `uvm_component_utils(overflow_test)

    function new(string name = "overflow_test", uvm_component parent = null);
            super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        overflow_seq seq = overflow_seq::type_id::create("seq",this);
        
        phase.raise_objection( this, "Starting sequence in run phase" );
        $display("%t Starting sequence run_phase",$time);
        seq.start(env.agt.sqr);
        #30ns;    
        phase.drop_objection( this , "Finished in run phase" );
    
    endtask

endclass: overflow_test