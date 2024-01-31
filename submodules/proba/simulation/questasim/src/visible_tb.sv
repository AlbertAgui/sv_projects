module visible_tb;

    logic [2:0] a,b,c;

    visible_top visible_top_u(
        .a(a),
        .b(b),
        .c(c)
    );

    initial begin
        a= 3'b000;
        b= 3'b000;
        $display("a: %d",a);
        $display("b: %d",b);
        #1;
        $display("c: %d",c);
        a=3'b001;
        b=3'b001;
        $display("a: %d",a);
        $display("b: %d",b);
        #4;
        $display("c: %d",c);

        #2;
        $finish;
    end
endmodule