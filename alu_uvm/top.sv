`include "uvm_macros.svh"
import uvm_pkg::*;
`include "test.sv"

interface alu_if (input bit clk);
  logic signed [4:0]  a;
  logic signed [4:0]  b;
  logic       	rst_n;
  logic       	alu_en;
  logic [2:0]  	a_op;
  logic [1:0]  	b_op;
  logic       	a_en;
  logic       	b_en;
  logic [5:0] 		out;
endinterface

module tb_top();
	bit clk;
	always #5 clk = ~ clk;
	
	alu_if inf(clk);
	alu alu1(inf.a , inf.b , clk, inf.rst_n, inf.alu_en, inf.a_op, inf.b_op, inf.a_en, inf.b_en, inf.out );
	
	initial begin
		uvm_config_db#(virtual alu_if)::set(uvm_root::get(), "*", "alu_if", inf );
		run_test("test1");
	end
endmodule
