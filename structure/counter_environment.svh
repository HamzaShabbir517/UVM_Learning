// Declaration of UVM Macros
`include "uvm_macros.svh"

// Declaration of Counter Environment class which extend from uvm_env
class counter_environment extends uvm_env;

     // Register environment into factory
     `uvm_component_utils(counter_environment)
     
     // Configuration object
     env_config env_config_h;

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
     	// Getting Environment Config Object from Database
     	if(!uvm_config_db #(env_config)::get(this,"*","env_config",env_config_h)
     		`uvm_error("Environment",$sformatf("Unable to get the Environment Configuration"));
     	
     	// Creating other components from factory
     	agent_h = counter_agent::type_id::create("agent_h",this);
     	
     	// If Predictor is require then build the predictor from factory
     	if(env_config_h.has_predictor) begin
     		predictor = counter_predictor::type_id::create("predictor",this);
     	end
     	
     	// If Scoreboard is require then build the scoreboard from factory
     	if(env_config_h.has_scoreboard) begin
     		scoreboard = counter_scoreboard::type_id::create("scoreboard",this);
     	end
     	
     	// TLM Port between predictor and scoreboard
     	pred2scb = new("pred2scb",this);
     
     
     endfunction
     
     // Environment Connect Phase
     function void connect_phase(uvm_phase phase);
     	super.connect_phase(phase);
     	// If predictor and scoreboard are enable then connect them using TLM port
     	if(env_config_h.has_predictor && env_config_h.has_scoreboard) begin
     		// Connecting Predictor with TLM FIFO
     		predictor.predictor_output_port.connect(pred2scb.blocking_put_export);
     		// Connecting Scoreboard with TLM FIFO
     		scoreboard.predicted_port.connect(pred2scb.blocking_get_export);
     	end
     	
     	// If predictor is enable so connect agent analysis port with it
     	if(env_config_h.has_predictor) begin
     		// Connecting agent analysis port with predictor
     		agent_h.analysis_port.connect(predictor.predictor_input_port.analysis_export);
     	end
     	
     	// If scoreboard is enable so connect agent analysis port with it
     	if(env_config_h.has_scoreboard) begin
     	   // Connecting agent analysis port with scoreboard
     	   agent_h.analysis_port.connect(scoreboard.scoreboard_analysis_port.analysis_export);
     	end
     endfunction

endclass
