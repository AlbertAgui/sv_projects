//`include "visible.sv"

module visible_top (
    input logic [2:0] a,
    input logic [2:0] b,
    output logic [2:0] c
);
    visible visible_u(
    .a(a),
    .b(b),
    .c(c));
endmodule