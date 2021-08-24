module cpu_tb
import cpu_package::*;
();

logic clk, reset;

cpu #()
cpu0(
.clk,
.reset
);

always #1 clk = ~clk;

initial
begin
clk <= 0;
reset <= 0;

#1
reset<=1;
#2
reset<=0;

end
endmodule;
