`include "driver.sv"
`include "monitor_input.sv"
`include "monitor_output.sv"

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  function new(string name="agent", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  driver 		d0; 		// Driver handle
  monitor_input 		m_in; 		// Monitor input handle
  monitor_output 		m_out; 		// Monitor output handle
  uvm_sequencer #(packet)	s0; 		// Sequencer Handle

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_in = monitor_input::type_id::create("m_in", this);
	m_out = monitor_output::type_id::create("m_out", this);
    if(get_is_active() == UVM_ACTIVE)begin // active agent or passive 
		d0 = driver::type_id::create("d0", this);
		s0 = uvm_sequencer#(packet)::type_id::create("s0", this);
    end
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(get_is_active() == UVM_ACTIVE)begin
    	d0.seq_item_port.connect(s0.seq_item_export);
    end
  endfunction
endclass
