package ALU_trans_pkg;
import shared_pkg::*;

	class trans_class;
		
		rand logic signed [3:0] A, B;
		rand logic reset;
		rand opcode_e opcode;
		logic signed [4:0] out;

		constraint reset_con {
			reset dist {1:=5, 0:=95};
		}

		constraint operations_con {
			A dist {MAXPOS:/20, ZERO:/20, MAXNEG:/20, [4'b0000:4'b1111]:/70};
			B dist {MAXPOS:/20, ZERO:/20, MAXNEG:/20, [4'b0000:4'b1111]:/70};
		}

		constraint opcode_con {
			opcode dist {ADD :/25, SUB:/25, NOT_A:/25, REDUCTION_OR_B:/25};
		}


		function void display(input string name = " ");
	        $display("------------------------------------------------------");
	        $info("[%s] - Transaction Data: A = %d, B = %d, opcode = %b, reset = %b",
	              name, A, B, opcode, reset);
	    endfunction: display

	  
	endclass : trans_class
	

endpackage : ALU_trans_pkg