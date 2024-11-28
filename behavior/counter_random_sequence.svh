// Declaration of Counter Random Sequence Class which extends UVM Sequence
class counter_random_sequence extends uvm_sequence #(counter_sequence_item);

  // Registering it with UVM Factory
  `uvm_object_utils(counter_random_sequence)
  
  // Declaration of Sequence Item
  counter_sequence_item seq_item;    
  
  // Constructor
  function new(string name="");
      super.new(name);
   endfunction : new

  // Body task (it is equivalent to run task of uvm_component)
  task body();
  	repeat (20) begin
  		// Creating a new object of seq_item
  		seq_item = counter_sequence_item::type_id::create("seq_item");
  		// Initializing Random Sequence
  		// Start the Sequence
  		start_item(seq_item);
  		// Randomize Sequence
  		assert(seq_item.randomize());
  		`uvm_info("counter_random_sequence",$sformatf("Sending transaction %2h %1h ",seq_item.data,seq_item.op), UVM_MEDIUM);
  		// Finish the Sequence
  		finish_item(seq_item);
  	end
  endtask
  
endclass : counter_random_sequence