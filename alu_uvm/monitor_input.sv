class monitor_input extends uvm_monitor;
  `uvm_component_utils(monitor_input)
  function new(string name="monitor_input", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  uvm_analysis_port  #(packet) mon_analysis_port;
  virtual alu_if inf;
  packet item;
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual alu_if)::get(this, "", "alu_if", inf))
      `uvm_fatal("MON", "Could not get vif handel")
    mon_analysis_port = new ("mon_analysis_port", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    sample_port();
    
  endtask
  
  virtual task sample_port();
    forever begin
      @(posedge inf.clk);
      item = packet::type_id::create("item", this);
      item.a 	= inf.a;
      item.b 	= inf.b;
      item.alu_en   = inf.alu_en;
      item.rst_n 	= inf.rst_n;
      item.a_op 	= inf.a_op;
      item.b_op 	= inf.b_op;
      item.a_en 	= inf.a_en;
      item.b_en 	= inf.b_en;
      mon_analysis_port.write(item);
    end
  endtask
endclass
