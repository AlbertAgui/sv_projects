`ifndef SEQ_ITEM_SV
`define SEQ_ITEM_SV

class seq_item extends uvm_sequence_item;
  `uvm_object_utils(seq_item)
  //Analysis Information
  logic [7:0] rdata;
  
  //Constructor
  function new(string name = "seq_item");
    super.new(name);
  endfunction
  
endclass

`endif