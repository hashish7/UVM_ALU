class coverage_col extends uvm_component;
  `uvm_component_utils(coverage_col)
  
  function new(string name="coverage_col", uvm_component parent=null);
    super.new(name, parent);
    cov1 = new();
  endfunction
  
  uvm_analysis_imp#(packet,coverage_col) m_in2cov;
  packet item;
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_in2cov = new("m_in2cov", this);
  endfunction
  // write 
  virtual function write(packet pkt);      
      $cast(item , pkt.clone());
      cov1.sample();
  endfunction
  
  covergroup cov1;
  	c_a: coverpoint item.a {option.weight = 0;}
  	c_b: coverpoint item.b {option.weight = 0;}
  	c_a_en: coverpoint item.a_en {option.weight = 0;}
  	c_b_en: coverpoint item.b_en {option.weight = 0;}
  	c_a_op: coverpoint item.a_op {	ignore_bins a_op_illegal = {7};
  									option.weight = 0;}
  	c_b_op: coverpoint item.b_op {	ignore_bins b_op_illegal = {3};
  									option.weight = 0;}
  									
  	cross_a : cross c_a , c_b , c_a_op;
  	cross_b : cross c_a , c_b , c_b_op , c_a_en;
  	
  endgroup
endclass
