class packet extends uvm_sequence_item;
/// inputs
  rand bit signed [4:0]  a;
  rand bit signed [4:0]  b;
  rand bit       	clk;
  rand bit       	rst_n;
  rand bit       	alu_en;
  rand bit [2:0]  	a_op;
  rand bit [1:0]  	b_op;
  rand bit       	a_en;
  rand bit       	b_en;
/// outputs
  logic signed [5:0] 		out;


/// define template functions
  `uvm_object_utils_begin(packet)
  	`uvm_field_int (a, UVM_DEFAULT)
  	`uvm_field_int (b, UVM_DEFAULT)
  	`uvm_field_int (clk, UVM_DEFAULT)
  	`uvm_field_int (rst_n, UVM_DEFAULT)
  	`uvm_field_int (alu_en, UVM_DEFAULT)
  	`uvm_field_int (a_op, UVM_DEFAULT)
	`uvm_field_int (b_op, UVM_DEFAULT)
	`uvm_field_int (a_en, UVM_DEFAULT)
	`uvm_field_int (b_en, UVM_DEFAULT)
	`uvm_field_int (out, UVM_DEFAULT)
  `uvm_object_utils_end
/// constractor 
  function new(string name = "packet");
    super.new(name);
  endfunction
/// constraints
  constraint valid {alu_en == 1 ; rst_n == 1;};
endclass
