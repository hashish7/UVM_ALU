`include "env.sv"
`include "v_sequnce.sv"

class test1 extends uvm_test;
  `uvm_component_utils(test1)
  function new(string name = "test1", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  env e0;
  v_seq seq1;
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e0 = env::type_id::create("e0", this);
    seq1 = v_seq::type_id::create("seq1", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
  	super.run_phase(phase);
  	phase.raise_objection(this);
  		seq1.start(e0.a0.s0);
    phase.drop_objection(this);
    
    phase.phase_done.set_drain_time(this, 50);
  endtask
endclass
