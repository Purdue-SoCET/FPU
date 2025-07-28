class fdiv_test extends uvm_test;
  `uvm_component_utils(fdiv_test)

  virtual float_div_if vif;
  fdiv_env        env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(virtual float_div_if)::set(this, "env.agent.driver", "vif", vif);
    env = fdiv_env::type_id::create("env", this);
  endfunction

  virtual task main_phase(uvm_phase phase);
    float_div_seq seq = float_div_seq::type_id::create("seq");
    seq.start(env.agent.sequencer);
  endtask
endclass
