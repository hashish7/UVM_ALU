`include "agent.sv"
`include "scoreboard.sv"
`include "coverage_col.sv"

class env extends uvm_env;
  `uvm_component_utils(env)
  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  agent 		a0; 		// Agent handle
  scoreboard	sb0; 		// Scoreboard handle
  coverage_col	cov0;		// coverage collector handle
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a0 = agent::type_id::create("a0", this);
    sb0 = scoreboard::type_id::create("sb0", this);
    cov0 = coverage_col::type_id::create("cov0", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    a0.m_in.mon_analysis_port.connect(sb0.m_in2sb);		//connect monitor input to scoreboard
    a0.m_out.mon_analysis_port.connect(sb0.m_out2sb);	//connect monitor output to scoreboard
    a0.m_in.mon_analysis_port.connect(cov0.m_in2cov);		//connect monitor input to coverage collector
  endfunction
endclass
