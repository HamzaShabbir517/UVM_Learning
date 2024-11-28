// Declaration of Counter Scoreboard class which extend from uvm_component
class counter_scoreboard  extends uvm_component;

   // Register Scorboard with factory
   `uvm_component_utils(counter_scoreboard)
   
   // Declaraing UVM TLM Analysis FIFO for input port
   uvm_tlm_analysis_fifo #(counter_sequence_item) scoreboard_analysis_port;
   
   // Declaraing UVM Get Port for input port
   uvm_get_port  #(counter_sequence_item) predicted_port; 

   // Declaring Counter sequence item for actual and predicted
   counter_sequence_item actual_item, predicted_item;
   
   // New Constructor
   function new(string name="", uvm_component parent);
      super.new(name, parent);
   endfunction : new
   
  // Scoreboard Build Phase 
  function void build_phase(uvm_phase phase);
  	super.build_phase(phase);
  	scoreboard_analysis_port   = new("scoreboard_analysis_port", this); 
  	predicted_port    = new("predicted_port", this);
   endfunction
   
   // Scoreboard Run Task
   task run_phase(uvm_phase phase);
      forever begin
         scoreboard_analysis_port.get(actual_item);
         `uvm_info("Scoreboard Run",$sformatf("Comparator Actual: %2h",
                actual_item.q), 
                UVM_MEDIUM)
                
         predicted_port.get(predicted_item);
         `uvm_info("Scoreboard Run",$sformatf("Comparator Predictor: %2h",
                predicted_item.q), 
                UVM_MEDIUM)
                
         // Compare the values 
         if (actual_item.q == predicted_item.q) begin
         	`uvm_info("Scoreboard Run", $sformatf("MATCH: Actual value = %2h matches Predicted value = %2h",actual_item.q, predicted_item.q), UVM_MEDIUM)
	end else begin
    		`uvm_error("Scoreboard Run", $sformatf("MISMATCH: Actual value = %2h does not match Predicted value = %2h",actual_item.q, predicted_item.q))
	end  
      end
   endtask

endclass



   


   
