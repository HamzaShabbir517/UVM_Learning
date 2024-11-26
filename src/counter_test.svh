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

   // New Constructor
   function new(string name="", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Test Build Phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h = counter_environment::type_id::create("env_h",this);
      // Set the verbose value in the Config Database
      uvm_config_db #(int)::set(this,"*","verbose",1);     
   endfunction : build_phase
   
   // Test Run Task
   task run_phase(uvm_phase phase);
   	rst_seq = counter_reset_sequence::type_id::create("rst_seq",this);
   	inc_seq = counter_inc_sequence::type_id::create("inc_seq",this);
   	load_seq = counter_load_sequence::type_id::create("load_seq",this);
   	ran_seq = counter_random_sequence::type_id::create("ran_seq",this);
   	phase.raise_objection(this);
   	rst_seq.start(env_h.agent_h.sequencer_h);
   	fork
   		inc_seq.start(env_h.agent_h.sequencer_h);
   		load_seq.start(env_h.agent_h.sequencer_h);
   		ran_seq.start(env_h.agent_h.sequencer_h);
   	join
   	phase.drop_objection(this);
   endtask
endclass


   


   
