// Importing uvm packages
import uvm_pkg::*;
// Importing counter package
import counter_pkg::*;

module top;

   // Declaration of signals
   bit clk = 0;
   
   // Declaration of counter interface
   counter_if ctr_if(clk);
   
   // Declaration of Design Under Test (Counter Example)
   counter DUT(
			.clk(clk),
			.rst(ctr_if.rst),
			.ld(ctr_if.ld),
			.inc(ctr_if.inc),
			.data_in(ctr_if.data_in),
			.q(ctr_if.q)
	      );
	     
   // Clock Generation
   always begin
   	#10;
   	clk = ~clk;
   end

   // Initial Block to set the interface as global and run the test
   initial begin
      string test_name;

      counter_pkg::global_if = ctr_if;

      run_test();
      
   end   
      
endmodule // top

   
