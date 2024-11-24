// Declaration of Counter Sequence Item Class which extends UVM Sequence Item
class counter_sequence_item extends uvm_sequence_item;

  // Registering it with UVM Factory
  `uvm_object_utils(counter_sequence_item)    
  
  // Declaration of Variables
  rand logic [7:0] data;
  rand ctr_op op;
  
  // Constructor
  function new(string name = "");
      super.new(name);
   endfunction : new

  // Convert to String Function
  function string convert2string();
    return $sformatf("data: %2h op: %2h", data,op);
  endfunction : convert2string

  // Copy Function
  function void do_copy(uvm_object rhs);
    counter_sequence_item  RHS;
    super.do_copy(rhs);
    $cast(RHS, rhs);
    data = RHS.data;
    op = RHS.op;
  endfunction : do_copy

  // Comparison Function
  function bit comp(uvm_object rhs);
    counter_sequence_item RHS;
    $cast(RHS,rhs);
    return data == RHS.data;
  endfunction : comp
  
  // Load Data Function
  function void load_data(logic[7:0] d, ctr_op o);
    data = d;
    op = o
  endfunction
endclass : counter_sequence_item
