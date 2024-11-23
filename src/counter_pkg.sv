// Declaration of counter package
package counter_pkg;

   // Importing UVM package
   import uvm_pkg::*;
   
   // Operation type
   typedef enum {inc, load, nop, reset} ctr_op;
   
   // Gloabal counter interface
   virtual interface counter_if global_if;

   // Verbosity bit
   bit verbose = 0;
   
   // Including UVM macros
   `include "uvm_macros.svh"  


endpackage // counter_pkg
   
