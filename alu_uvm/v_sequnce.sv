`include "sequence.sv"
class v_seq extends uvm_sequence;
  `uvm_object_utils(v_seq)
  
  function new(string name="v_seq");
    super.new(name);
  endfunction
  seq s0;
  seq1 s1;
  seq2 s2;
  seq3 s3;
  
  virtual task pre_body();
	  s0 = seq::type_id::create("s0");
	  s1 = seq1::type_id::create("s1");
	  s2 = seq2::type_id::create("s2");
	  s3 = seq3::type_id::create("s3");
  endtask
  virtual task body();
	  `uvm_do(s0)
	  `uvm_do(s1)
	  `uvm_do(s2)
	  `uvm_do(s3)
  endtask
endclass
