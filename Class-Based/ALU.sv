import shared_pkg::*;

module ALU (ALU_if.DUT ALU_if);

   reg signed [4:0] ALU_out; // ALU output in 2's complement

   // Do the operation
   always @(*) begin
      case (ALU_if.opcode)
      	ADD:            ALU_out = ALU_if.A + ALU_if.B;
      	SUB:            ALU_out = ALU_if.A - ALU_if.B;
      	NOT_A:          ALU_out = ~ALU_if.A;
         REDUCTION_OR_B: ALU_out = |ALU_if.B;
         default:         ALU_out = 5'b0;
      endcase
   end // always @ *


   // Register output C
   always @(posedge ALU_if.clk or posedge ALU_if.reset) begin
      if (ALU_if.reset)
	     ALU_if.C <= 5'b0;
      else
	     ALU_if.C <= ALU_out;
   end

endmodule


