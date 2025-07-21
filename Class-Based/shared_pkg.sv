package shared_pkg;
	
	typedef enum logic [1:0] {ADD=2'b00, SUB=2'b01, NOT_A=2'b10, REDUCTION_OR_B=2'b11} opcode_e;
	localparam MAXPOS = 7;
	localparam MAXNEG = -8;
	localparam ZERO = 0;

endpackage : shared_pkg