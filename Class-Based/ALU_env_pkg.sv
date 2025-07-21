package ALU_env_pkg;
import ALU_trans_pkg::*;
import ALU_generator_pkg::*;
import ALU_driver_pkg::*;
import ALU_monitor_pkg::*;

	class ALU_env_class;

		string name;
		trans_class trans;
		ALU_generator_class gen;
		ALU_driver_class driv;
		ALU_monitor_class mon;
		virtual ALU_if env_if;

		function new(string name = " ENV ");
			this.name = name;
		endfunction 

		task run_env();
			trans = new;
			gen = new;
			driv = new;
			mon = new;

			gen.gen_mail = driv.driv_mail;
			gen.gen_handover = driv.driver_handover;
			driv.driv_if = env_if;
			mon.mon_if = env_if;

			fork
				mon.mon_run();
				driv.run_driver();
				gen.gen_run();
			join_any
			@(negedge env_if.clk);

			$stop;

		endtask : run_env

	endclass : ALU_env_class
	
endpackage : ALU_env_pkg