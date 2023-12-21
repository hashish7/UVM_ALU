class seq extends uvm_sequence #(packet);
  `uvm_object_utils(seq)
  
  function new(string name="");
    super.new(name);
  endfunction
  
  rand int num; 	// Config total number of items to be sent
  
  constraint c1 { num == 1000000; }
  
  virtual task body();
    repeat(num) begin
    	`uvm_do_with(req, {req.a_en ==1; req.b_en==0;req.a_op inside {[0:6]};})
    end
    `uvm_info("SEQ", $sformatf("Done generation of %0d items", num), UVM_LOW)
  endtask
endclass
///-----------------------------------------------------///
class seq1 extends seq;
  `uvm_object_utils(seq1)
  
  function new(string name="seq1");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(num) begin
    	`uvm_do_with(req, {req.a_en ==0; req.b_en==1;req.b_op inside {[0:2]};})
    end
    `uvm_info("SEQ", $sformatf("Done generation of %0d items", num), UVM_LOW)
  endtask
endclass
///-----------------------------------------------------///
class seq2 extends seq;
  `uvm_object_utils(seq2)
  
  function new(string name="seq2");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(num) begin
    	`uvm_do_with(req, {req.a_en ==1; req.b_en==1;})
    end
    `uvm_info("SEQ", $sformatf("Done generation of %0d items", num), UVM_LOW)
  endtask
endclass
///-----------------------------------------------------///
class seq3 extends seq;
  `uvm_object_utils(seq3)
  
  function new(string name="seq3");
    super.new(name);
  endfunction
  
  virtual task body();
  num = 100;
    repeat(num) begin
    	`uvm_do_with(req, {req.a_en ==0; req.b_en==0;});
    end
    `uvm_info("SEQ", $sformatf("Done generation of %0d items", num), UVM_LOW)
  endtask
endclass
