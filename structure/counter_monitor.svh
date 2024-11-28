// Declaration of Counter Monitor which extends uvm_monitor class
class counter_monitor extends uvm_monitor;

   // Register the monitor with factory
   `uvm_component_utils(counter_monitor)

   // Declaration of Virtual Interface
   virtual interface counter_if i;
   
   // Declaration of Sequence Item
   counter_sequence_item seq_item;
   
   // Declaration of UVM Analysis Port
   uvm_analysis_port #(counter_sequence_item) analysis_port;

   // New Constructor
   function new(string name="", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Monitor Build Phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // Construct Monitor analysis port
      analysis_port = new("analysis_port",this);  
   endfunction : build_phase
   
   
   // Monitor Run Task
   task run_phase(uvm_phase phase);
   	seq_item = counter_sequence_item::type_id::create("seq_item",this);
   	@(negedge i.rst);
   	forever begin
   		@(posedge i.clk);
   		// Capture the input signals
   		seq_item.data = i.data_in;
   		seq_item.op = (i.inc) ? inc :
   			      (i.ld)  ? load  :
                             (~i.rst) ? reset : nop;
                // Capture the output signals
                seq_item.q = i.q;
                // Write the transaction on analysis port
   		analysis_port.write(seq_item);
   		
   		`uvm_info("Monitor Run",$sformatf("Monitor got %2h %1h %2h",seq_item.data,seq_item.op,seq_item.q),UVM_MEDIUM);
   		
   	end
   endtask
   
endclass


   


   
