`ifndef M_INTERFACE
`define M_INTERFACE

interface interfacename;
    logic a;
endinterface //interfacename

typedef struct packed {
    logic a;
} struct_name;

task automatic taskName();
    
endtask //automatic

`endif