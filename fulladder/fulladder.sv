module fulladder 
#()
(clk, reset, bit_a, bit_b, bit_c, carry);

input clk;
input reset;
input bit_a;
input bit_b;
output reg bit_c;
output reg carry;

always_ff @(posedge clk)
begin
	if (reset)
	begin
	carry <= 0;
	bit_c <= 0;
	end 
	else begin
	
	end
end

assign {carry,bit_c} <= bit_a + bit_b;

endmodule;

/*module fulladder 
#()
(clk, reset, bit_a, bit_b);

input clk;
input reset;
input bit_a;
input bit_b;
output bit_c;
output carry;

genvar i;

generate
for ()
fulladder f0
endgenerate

begin
reset = 1;

end

endmodule;*/