class monitor_output extends uvm_monitor;
  `uvm_component_utils(monitor_output)
  function new(string name="monitor_output", uvm_component parent=null);
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
      @(negedge inf.clk);
      item = packet::type_id::create("item", this);
      item.out 	= inf.out;
      mon_analysis_port.write(item);
    end
  endtask
endclass
