// Declaration of UVM Macros
`include "uvm_macros.svh"

// Declaration of Counter Environment class which extend from uvm_env
class counter_environment extends uvm_env;

     // Register environment into factory
     `uvm_component_utils(counter_environment)

     // Declaration of Agent
     counter_agent agent_h;
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
     	
     	// Creating other components from factory
     	agent_h = counter_agent::type_id::create("agent_h",this);
     	predictor = counter_predictor::type_id::create("predictor",this);
     	scoreboard = counter_scoreboard::type_id::create("scoreboard",this);
     	pred2scb = new("pred2scb",this);
     
     endfunction
     
     // Environment Connect Phase
     function void connect_phase(uvm_phase phase);
     	super.connect_phase(phase);
     	// Connecting Predictor with TLM FIFO
     	predictor.predictor_output_port.connect(pred2scb.blocking_put_export);
     	// Connecting Scoreboard with TLM FIFO
     	scoreboard.predicted_port.connect(pred2scb.blocking_get_export);
     	// Connecting agent analysis port with predictor
     	agent_h.analysis_port.connect(predictor.predictor_input_port.analysis_export);
     	// Connecting agent analysis port with scoreboard
     	agent_h.analysis_port.connect(scoreboard.scoreboard_analysis_port.analysis_export);
     endfunction

endclass
