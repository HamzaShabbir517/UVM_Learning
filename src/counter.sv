// Declaration of Counter Module
module counter (
		input logic clk, rst, ld, inc, 
		input logic [7:0] data_in, 
		output logic [7:0] q
		);
		
   // Always block which triggers on posedge of the clock		
   always @(posedge clk) begin
     if (!rst) // If reset is low, reset the counter
       begin
       	q <= 0;
       end
     else begin
       if (ld) // if load is enable, load the value in counter
         begin
          q <= data_in;
         end
       else if (inc) // if inc is enable, increment the counter
         begin
          q<= q+1;
         end
       else begin // else save the previous value of counter
          q <= q;
       end
     end
   end
endmodule // counter
