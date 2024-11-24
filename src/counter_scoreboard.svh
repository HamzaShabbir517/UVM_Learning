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
         `uvm_info("Scoreboard Run",$sformatf("Comparator Actual: %s",
                actual_item.convert2string()), 
                UVM_DEBUG)
                
         predicted_port.get(predicted_item);
         `uvm_info("Scoreboard Run",$sformatf("Comparator Predicted: %s",
                predicted_item.convert2string()), 
                UVM_DEBUG)
                
         // Called the comparison method
         if (actual_item.comp(predicted_item))
           `uvm_info("Scoreboard Run", $sformatf("passed: %s",actual_item.convert2string()),UVM_MEDIUM)
         else
           `uvm_error("Scoreboard Run", $sformatf("FAILED: Expected: %s   Actual: %s",
                            predicted_item.convert2string(),predicted_item.convert2string()))
        
      end
   endtask

endclass



   


   
