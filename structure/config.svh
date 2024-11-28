// Declaration of config object
class env_config extends uvm_object;
	
	// Register it into factory
	`uvm_object_utils(env_config)
	
	// Declaration of Variables
	bit verbose = 0;
	bit has_scoreboard = 0;
	bit has_predictor = 0;
	bit has_coverage = 0;
	virtual counter_if vi;
	uvm_active_passive_enum active = UVM_ACTIVE;
	
	// New Constructor
	function new(string name = "");
		super.new(name);
	endfunction

endclass
