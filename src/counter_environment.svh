// Declaration of UVM Macros
`include "uvm_macros.svh"

// Declaration of Counter Environment class which extend from uvm_env
class counter_environment extends uvm_env;

     // Register environment into factory
     `uvm_component_utils(counter_environment);
     
     // Declaration of Test Sequences
     counter_reset_sequence  rst_seq;
     counter_inc_sequence    inc_seq;
     counter_load_sequence   load_seq;
     counter_random_sequence ran_seq;

     // Declaration of Driver
     counter_driver driver;
     // Declaration of Sequencer
     uvm_sequencer #(counter_sequence_item,counter_sequence_item) sequencer_h;
     // Declaration of Monitor
     counter_monitor monitor;
     // Declaration of Predictor
     counter_predictor predictor;
     // Declaration of Scoreboard
     counter_scoreboard scoreboard;
     
     // Declaration of TLM FIFO between Predictor and Scoreboard
     uvm_tlm_fifo #(counter_sequence_item) pred2scb;
     
     // New Constructor
     function new(string name="", uvm_component parent);
     	super.new(name, parent);
     endfunction : new
     
     // Environment Build Phase
     function void build_phase(uvm_phase phase);
     	super.build_phase(phase);
     	
     	// Creating Test Sequences from factory
     	rst_seq = counter_reset_sequence::type_id::create("rst_seq",this);
     	inc_seq = counter_inc_sequence::type_id::create("inc_seq",this);
     	load_seq = counter_load_sequence::type_id::create("load_seq",this);
     	ran_seq = counter_random_sequence::type_id::create("ran_seq",this);
     	
     	// Creating other components from factory
     	driver = counter_driver::type_id::create("driver",this);
     	monitor = counter_monitor::type_id::create("monitor",this);
     	sequencer_h = new("sequencer_h",this);
     	predictor = counter_predictor::type_id::create("predictor",this);
     	scoreboard = counter_scoreboard::type_id::create("scoreboard",this);
     	pred2scb = new("pred2scb",this);
     
     endfunction
     
     // Environment Connect Phase
     function void connect_phase(uvm_phase phase);
     	super.connect_phase(phase);
     	// Connecting Sequencer with Driver
     	driver.seq_item_port.connect(sequencer_h.seq_item_export);
     	// Connecting Predictor with TLM FIFO
     	predictor.predictor_output_port.connect(pred2scb.blocking_put_export);
     	// Connecting Scoreboard with TLM FIFO
     	scoreboard.predicted_port.connect(pred2scb.blocking_get_export);
     	// Connecting monitor analysis port with predictor
     	monitor.request_port.connect(predictor.predictor_input_port.analysis_export);
     	// Connecting monitor analysis port with scoreboard
     	monitor.response_port.connect(scoreboard.scoreboard_analysis_port.analysis_export);
     endfunction
     
     // Environment Run Task
     task run_phase(uvm_phase phase);
     	phase.raise_objection(this);
     	// Start the test Sequence
     	rst_seq.start(sequencer_h);
     	fork
     		inc_seq.start(sequencer_h);
     		load_seq.start(sequencer_h);
     		ran_seq.start(sequencer_h);
     	join
     	phase.drop_objection(this);
     endtask

endclass
