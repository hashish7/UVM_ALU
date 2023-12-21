`include "seq_item.sv"
class driver extends uvm_driver #(packet);              
  `uvm_component_utils(driver)
  function new(string name = "driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual alu_if inf;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "alu_if", inf ))
      `uvm_fatal("DRV", "Could not get vif handel")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      packet item;
      seq_item_port.get_next_item(item);
      drive(item);
      seq_item_port.item_done();
    end
  endtask
  
  
  virtual task drive(packet item);
  	inf.a 	<= item.a;
    inf.b 	<= item.b;
    inf.alu_en    <= item.alu_en;
    inf.rst_n 	<= item.rst_n;
    inf.a_op 	<= item.a_op;
    inf.b_op 	<= item.b_op;
    inf.a_en 	<= item.a_en;
    inf.b_en 	<= item.b_en;
    @ (posedge inf.clk);
  endtask
endclass
