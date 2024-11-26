// Declaration of counter agent which extends uvm_agent
class counter_agent extends uvm_agent;
	
	// Register the counter agent class into factory
	`uvm_component_utils(counter_agent)
	
	// Declaration of Driver
	counter_driver driver_h;
	// Declaration of Sequencer
	uvm_sequencer #(counter_sequence_item,counter_sequence_item) sequencer_h;
	// Declaration of Monitor
	counter_monitor monitor_h;
	
	// Declaration of UVM Analysis Port
	uvm_analysis_port #(counter_sequence_item) analysis_port;
	
	// New Constructor
	function new(string name="", uvm_component parent);
	   super.new(name, parent);
	endfunction : new
	
	// Agent Build Phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		// Creating other components from factory
	     	driver_h = counter_driver::type_id::create("driver_h",this);
	     	monitor_h = counter_monitor::type_id::create("monitor_h",this);
	     	sequencer_h = new("sequencer_h",this);
	     	analysis_port = new("analysis_port",this);
	endfunction
	
	// Agent Connect Phase
	function void connect_phase(uvm_phase phase);
		driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
		monitor_h.analysis_port.connect(analysis_port);
	endfunction
	
	
endclass
