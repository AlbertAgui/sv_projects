import visible_pkg::class_a;

module visible 
(
    input logic [2:0] a,
    input logic [2:0] b,
    output logic [2:0] c
);

    class_a c_a;

    initial begin
        c_a=new();
        c_a.a = 3'b001;
        #2;
        c = (a + b) + c_a.a; //+ X;
    end
    
endmodule