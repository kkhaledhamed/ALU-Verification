import ALU_trans_pkg::*;
import ALU_generator_pkg::*;
import ALU_driver_pkg::*;
import ALU_monitor_pkg::*;
import ALU_env_pkg::*;

module ALU_tb ();
	bit clk;

	ALU_env_class env;

	initial begin
		clk = 0;
		forever
			#2 clk = ~ clk;
	end

	ALU_if ALU_if(clk);
	ALU DUT (ALU_if);

	initial begin
		env = new;
		env.env_if = ALU_if;
		env.run_env();

		
	end

endmodule : ALU_tb
	
