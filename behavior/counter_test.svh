// Include UVM Macros
`include "uvm_macros.svh"

// Declaration of Test which extends uvm_test class
class counter_test extends uvm_test;

   // Register the test with factory
   `uvm_component_utils(counter_test)
   
   // Declaration of Test Sequences
   counter_reset_sequence  rst_seq;
   counter_inc_sequence    inc_seq;
   counter_load_sequence   load_seq;
   counter_random_sequence ran_seq;

   // Declaration of Environment Component
   counter_environment env_h;
   env_config env_config_h;

   // New Constructor
   function new(string name="", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Test Build Phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      // Create env configuration object 
      env_config_h =  env_config::type_id::create("env_config_h");
      configure_env(env_config_h);
      // Setting the environment configure in data
      uvm_config_db #(env_config)::set(this,"*","env_config",env_config_h);
      
      // Buildig envrionment
      env_h = counter_environment::type_id::create("env_h",this); 
   endfunction : build_phase
   
   // Test Run Task
   task run_phase(uvm_phase phase);
   	// Creating test sequences from factory
   	rst_seq = counter_reset_sequence::type_id::create("rst_seq",this);
   	inc_seq = counter_inc_sequence::type_id::create("inc_seq",this);
   	load_seq = counter_load_sequence::type_id::create("load_seq",this);
   	ran_seq = counter_random_sequence::type_id::create("ran_seq",this);
   	phase.raise_objection(this);
   	// Reset Sequence
   	rst_seq.start(env_h.agent_h.sequencer_h);
   	// Parallel Sequence
   	fork
   		inc_seq.start(env_h.agent_h.sequencer_h);
   		load_seq.start(env_h.agent_h.sequencer_h);
   		ran_seq.start(env_h.agent_h.sequencer_h);
   	join
   	phase.drop_objection(this);
   endtask
   
   // Configure the Environment Config Object
   function void configure_env(env_config cfg);
   	cfg.has_scoreboard = 1;
   	cfg.has_predictor = 1;
   	cfg.has_coverage = 0;
   	cfg.verbose = 1;
   	cfg.active = UVM_ACTIVE;
   	if(!uvm_config_db #(virtual counter_if)::get(this,"*","vif",cfg.vi))
   		`uvm_fatal("TEST",$sformatf("Virtual Interface Not Found"));
   endfunction
endclass


   


   
