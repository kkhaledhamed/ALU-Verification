package ALU_monitor_pkg;
	import ALU_trans_pkg::*;

	class ALU_monitor_class;
		string name;
		trans_class mon_trans_obj;
		//mailbox mon_mail_s;
		//mailbox mon_mail_su;
		virtual ALU_if mon_if;

		function new(string name = " MONITOR ");
			this.name = name;
			//this.mon_mail_s = new();
			//this.mon_mail_su = new();
		endfunction 

		task mon_run();
			@(posedge mon_if.clk);
			forever begin
				mon_trans_obj = new();
				@(posedge mon_if.clk);
				#1;
				mon_trans_obj.reset = mon_if.reset;
				mon_trans_obj.opcode = mon_if.opcode;
				mon_trans_obj.A = mon_if.A;
				mon_trans_obj.B = mon_if.B;
				//mon_mail_s.put(mon_trans_obj);
				//mon_mail_su.put(mon_trans_obj);
			end
		endtask :mon_run
	endclass : ALU_monitor_class
endpackage : ALU_monitor_pkg