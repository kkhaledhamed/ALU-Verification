package ALU_generator_pkg;
	import ALU_trans_pkg::*;

	class ALU_generator_class;
		string name;
		trans_class gen_trans_obj;
		mailbox gen_mail;
		event gen_handover;
		virtual ALU_if gen_if;
		int iteration_counter;

		function new(string name = " GENERATOR ");
			this.name = name;
			this.gen_mail = new();
		endfunction 

		task gen_run();
			gen_trans_obj = new;
			iteration_counter = 1000;
			for (int i = 0; i < iteration_counter; i++) begin
				assert(gen_trans_obj.randomize());
				$display("Number of iterations :%p", i);
				gen_mail.put(gen_trans_obj);
				@(gen_handover);
			end

		endtask : gen_run

	endclass : ALU_generator_class
	 
		
endpackage : ALU_generator_pkg