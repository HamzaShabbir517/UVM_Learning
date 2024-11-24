// Counter Interface Declaration
interface counter_if (input bit clk);

  // Port List
   logic [7:0] data_in;
   logic [7:0] q;
   logic       inc;
   logic       ld;
   logic       rst;
   
   // Wait Clk task
   task automatic wait_clks(input int num);
    		repeat (num) @(posedge clk);
   endtask
   
    
endinterface : counter_if
