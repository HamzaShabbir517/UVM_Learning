// Declaration of Counter Increment Sequence Class which extends UVM Sequence
class counter_inc_sequence extends uvm_sequence #(counter_sequence_item);

  // Registering it with UVM Factory
  `uvm_object_utils(counter_inc_sequence)
  
  // Declaration of Sequence Item
  counter_sequence_item seq_item;    
  
  // Constructor
  function new(string name = "");
      super.new(name);
   endfunction : new

  // Body task (it is equivalent to run task of uvm_component)
  task body();
  	repeat (10) begin
  		// Creating a new object of seq_item
  		seq_item = new();
  		// Initializing Increment Sequence
  		// Start the Sequence
  		start_item(seq_item);
  		// Initiating op with reset
  		seq_item.op = inc;
  		`uvm_info("counter_inc_sequence",{"Sending transaction ",seq_item.convert2string()}, UVM_MEDIUM);
  		// Finish the Sequence
  		finish_item(seq_item);
  	end
  endtask
  
endclass : counter_inc_sequence
