// Declaration of Counter Monitor which extends uvm_monitor class
class counter_monitor extends uvm_monitor;

   // Register the monitor with factory
   `uvm_component_utils(counter_monitor);

   // Declaration of Virtual Interface
   virtual interface counter_if i;
   
   // Declaration of Sequence Item
   counter_sequence_item req_item;
   counter_sequence_item rsp_item;
   
   // Declaration of UVM Analysis Port
   uvm_analysis_port #(counter_sequence_item) request_port;
   uvm_analysis_port #(counter_sequence_item) response_port;

   // New Constructor
   function new(string name="", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Monitor Build Phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      i = counter_pkg::global_if;
      request_port = new("request_port",this);
      response_port = new("response_port",this);   
   endfunction : build_phase
   
   // Monitor Run Task
   task run_phase(uvm_phase phase);
   	req_item = counter_sequence_item::type_id::create("req_item",this);
   	rsp_item = counter_sequence_item::type_id::create("rsp_item",this);
   	@(negedge i.rst);
   	forever begin
   		@(posedge i.clk);
   		
   		// Capture the input signals (request)
   		req_item.data = i.data_in;
   		req_item.op = (i.inc) ? inc :
   			      (i.ld)  ? laod  :
                             (~i.rst) ? reset : nop;
   		request_port.write(req_item);
   		
   		// Capture the response signals from the DUT
   		rsp_item.data = i.q;
   		response_port.write(rsp_item);
   		
   		`uvm_info("Monitor Run",$sformatf("Monitor got req %s",req_item.convert2string()),UVM_DEBUG);
   		`uvm_info("Monitor Run",$sformatf("Monitor got rsp %s",rsp_item.convert2string()),UVM_DEBUG);
   		
   	end
   endtask
   
endclass


   


   
