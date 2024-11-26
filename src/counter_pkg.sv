// Declaration of counter package
package counter_pkg;

   // Importing UVM package
   import uvm_pkg::*;
   
   // Operation type
   typedef enum {inc, load, nop, reset} ctr_op;
   
   // Including UVM macros
   `include "uvm_macros.svh"
   
   // UVM Transactions
   `include "counter_sequence_item.svh"
   `include "counter_reset_sequence.svh"
   `include "counter_inc_sequence.svh"
   `include "counter_load_sequence.svh"
   `include "counter_random_sequence.svh"
   
   // UVM Agents
   `include "counter_driver.svh"
   `include "counter_monitor.svh"
   `include "counter_agent.svh"
   `include "counter_predictor.svh"
   `include "counter_scoreboard.svh"
   
   // UVM Environment
   `include "counter_environment.svh"
   
   // UVM Test
   `include "counter_test.svh"
   
endpackage // counter_pkg
   
