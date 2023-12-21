module alu(input wire signed [4:0] a,b,
	   input wire clk,rst_n,alu_en,
	   input wire [2:0] a_op,
	   input wire [1:0] b_op,
	   input wire a_en,b_en,
	   output reg signed [5:0] out );
always@(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0 || alu_en == 1'b0) begin
		out = 6'b000000;
	end else begin
		if(a_en && ~b_en) begin
			case(a_op)
			0: out = a+b;
			1: out = a-b;
			2: out = a^b;
			3: out = a&b;
			4: out = a&b;
			5: out = a|b;
			6: out = ~(a^b);
			7: out = out;    /// need to be reviced
			endcase
		end else if(~a_en && b_en) begin
			case(b_op)
			0: out = ~(a&b);
			1: out = a+b;
			2: out = a+b;
			3: out = out;   /// need to be reviced
			endcase
		end else if(a_en && ~b_en) begin
			case(b_op)
			0: out = a^b;
			1: out = ~(a^b);
			2: out = a- 5'b00001 ;
			3: out = b+ 5'b00010 ;
			endcase
		end else begin 
			out = out;
		end
		end
end

endmodule
