class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  // to support using two monitors
  `uvm_analysis_imp_decl(_input)
  `uvm_analysis_imp_decl(_output)
  logic signed [5:0]  scr_out;
  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  uvm_analysis_imp_input#(packet,scoreboard) m_in2sb;
  uvm_analysis_imp_output#(packet,scoreboard) m_out2sb;
    
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_in2sb = new("m_in2sb", this);
    m_out2sb = new("m_out2sb", this);
  endfunction
  // write input
  virtual function write_input(packet item);      
      predict(item);
  endfunction
  // write output
  virtual function write_output(packet item);      
      if(scr_out === item.out)begin
      	`uvm_info("PASS", $sformatf("passed at %0t", $time), UVM_LOW)
      	$display("item.out = %0d , exp out %0d ", item.out , scr_out);
  	end
  	else begin
  		`uvm_error("ERROR", $sformatf("error at %0t", $time ))
  		$display("item.out = %0d , exp out %0d " ,item.out , scr_out);
	end
  endfunction
  // predictor
  virtual function logic [4:0] predict(packet item);      
      if(item.rst_n == 1'b0 || item.alu_en == 1'b0) begin
		scr_out = 6'b000000;
	end else begin
		if(item.a_en && ~item.b_en) begin
			case(item.a_op)
			0: scr_out = item.a+item.b;
			1: scr_out = item.a-item.b;
			2: scr_out = item.a^item.b;
			3: scr_out = item.a&item.b;
			4: scr_out = item.a&item.b;
			5: scr_out = item.a|item.b;
			6: scr_out = ~(item.a^item.b);
			7: scr_out = scr_out;    /// need to be reviced
			endcase
		end else if(~item.a_en && item.b_en) begin
			case(item.b_op)
			0: scr_out = ~(item.a&item.b);
			1: scr_out = item.a+item.b;
			2: scr_out = item.a+item.b;
			3: scr_out = scr_out;   /// need to be reviced
			endcase
		end else if(item.a_en && ~item.b_en) begin
			case(item.b_op)
			0: scr_out = item.a^item.b;
			1: scr_out = ~(item.a^item.b);
			2: scr_out = item.a- 5'b00001 ;
			3: scr_out = item.b+ 5'b00010 ;
			endcase
		end else begin 
			scr_out = scr_out;
		end
		end
  endfunction
endclass
