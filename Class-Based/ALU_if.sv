import shared_pkg::*;

interface ALU_if (clk);

	input clk;
	logic signed [3:0] A, B;
	opcode_e opcode;
	logic reset;
	logic signed [4:0] C;

	modport DUT (input reset, A, B, opcode, clk, output C);

	
endinterface : ALU_if
