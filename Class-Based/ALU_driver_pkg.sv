package ALU_driver_pkg;
	import ALU_trans_pkg::*;
	
	class ALU_driver_class;
		string name;
		trans_class driv_trans_obj;
		mailbox driv_mail;
		event driver_handover;
		virtual ALU_if driv_if;

		function new(string name = " DRIVER ");
			this.name = name;
			this.driv_mail = new();
		endfunction 

		task run_driver();
			forever begin
				driv_trans_obj = new();
				driv_mail.get(driv_trans_obj);
				driv_trans_obj.display("DRIVER");

				$display("Driver has set data to the dut", $realtime());

				driv_if.reset = driv_trans_obj.reset;
				driv_if.A = driv_trans_obj.A;
				driv_if.B = driv_trans_obj.B;
				driv_if.opcode = driv_trans_obj.opcode;
				@(negedge driv_if.clk);
				-> driver_handover;
			end
		endtask : run_driver
		
	endclass : ALU_driver_class
endpackage : ALU_driver_pkg