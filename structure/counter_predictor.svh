// Declaration of Counter Predictor class which extend from uvm_component
class counter_predictor  extends uvm_component;

   // Register the predictor with factory
   `uvm_component_utils(counter_predictor)
   
   // Declaraing UVM TLM Analysis FIFO for input port 
   uvm_tlm_analysis_fifo #(counter_sequence_item) predictor_input_port;
   
   // Declaraing UVM Put Port for output port
   uvm_put_port  #(counter_sequence_item) predictor_output_port; 
   
   // Declaring internal variable for behavioural q
   logic [7:0] beh_q;
   ctr_op op = nop;
   
   // Declaring Counter sequence item for request and response
   counter_sequence_item req_item;
   counter_sequence_item rsp_item, rsp_item_cln;
   
   // New Constructor
   function new(string name="", uvm_component parent);
      super.new(name, parent);
   endfunction : new
   
  // Predictor Build Phase
  function void build_phase(uvm_phase phase);
  	super.build_phase(phase);
  	predictor_input_port = new("predictor_input_port", this); 
 	predictor_output_port = new("predictor_output_port", this);
  endfunction : build_phase

  // Predictor Run Task
   task run_phase(uvm_phase phase);
      req_item = counter_sequence_item::type_id::create("req_item",this);
      rsp_item = counter_sequence_item::type_id::create("rsp_item",this);
      forever begin
         predictor_input_port.get(req_item);
         case (req_item.op) 
           reset : beh_q = 0;
           inc   : beh_q = beh_q + 1;
           load  : beh_q = req_item.data;
         endcase
         
         rsp_item.load_data(beh_q);
         $cast(rsp_item_cln,rsp_item.clone());
         predictor_output_port.put(rsp_item_cln);
         `uvm_info(" Pedictor Run",$sformatf("Predictor predicted  %2h",rsp_item.q),UVM_MEDIUM)
      end
   endtask

endclass



   


   
