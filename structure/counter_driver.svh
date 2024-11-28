// Declaration of Counter Driver which extends uvm_driver class
class counter_driver extends uvm_driver #(counter_sequence_item);

   // Register the driver with factory
   `uvm_component_utils(counter_driver)

   // Declaration of Virtual Interface
   virtual interface counter_if i;
   
   // Declaration of Sequence Item
   counter_sequence_item seq_item;

   // New Constructor
   function new(string name="", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Driver Build Phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
   endfunction : build_phase
   
   
   // Driver Run Task
   task run_phase(uvm_phase phase);
   	seq_item = counter_sequence_item::type_id::create("seq_item",this);
   	forever begin
   		@(negedge i.clk);
   		seq_item_port.get_next_item(seq_item);
   		`uvm_info("Driver Run",$sformatf("Driver got %2h %1h",seq_item.data,seq_item.op),UVM_MEDIUM)
   		transfer(seq_item);
   		seq_item_port.item_done();
   	end
   		
   endtask
   
   // Trasnfer task
   task transfer(counter_sequence_item item);
   	case(item.op)
   		// If the operation is of reset
   		reset: begin
   			i.rst = 0;
   			i.inc = 0;
   			i.ld = 0;
   			i.data_in = 0;
   		end
   		// If the operation is of load
   		load: begin
   			i.rst = 1;
   			i.inc = 0;
   			i.ld = 1;
   			i.data_in = item.data;
   		end
   		// If the operation is of increment
   		inc: begin
   			i.rst = 1;
   			i.inc = 1;
   			i.ld = 0;
   			i.data_in = item.data;
   		end
   		// If the operation is of nop
   		nop: begin
   		end
   	endcase
   	@(posedge i.clk);
   endtask
   
   
endclass


   


   
