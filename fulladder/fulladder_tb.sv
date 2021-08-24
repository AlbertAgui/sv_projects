module fulladder_tb
();


reg clk;
reg reset;
reg bit_a;
reg bit_b;
reg bit_c;
reg carry;

fulladder #() fa(clk,rest,bit_a,bit_b,bit_c,carry);

always #1 clk = ~clk;

initial
begin
clk<=0;
reset <= 1;
#4
end

endmodule;
