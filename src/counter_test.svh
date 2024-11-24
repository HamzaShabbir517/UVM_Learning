// Include UVM Macros
`include "uvm_macros.svh"

// Declaration of Test which extends uvm_test class
class counter_test extends uvm_test;

   // Register the test with factory
   `uvm_component_utils(counter_test);

   // Declaration of Environment Component
   counter_env env;

   // New Constructor
   function new(string name="", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Test Build Phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      counter_pkg::verbose = 1;
      env = counter_env::type_id::create("env",this);     
   endfunction : build_phase
   
endclass


   


   
