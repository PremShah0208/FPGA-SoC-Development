module triple_voter_tb;

    logic clk;
    logic rst_n;
    logic a;
    logic b;
    logic c;
    logic y;

    triple_voter uut (
        .clk   (clk),
        .rst_n (rst_n),
        .a     (a),
        .b     (b),
        .c     (c),
        .y     (y)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        a = 0;
        b = 0;
        c = 0;

        #12;
        rst_n = 1;

        {a, b, c} = 3'b000; #10;
        {a, b, c} = 3'b001; #10;
        {a, b, c} = 3'b010; #10;
        {a, b, c} = 3'b011; #10;
        {a, b, c} = 3'b100; #10;
        {a, b, c} = 3'b101; #10;
        {a, b, c} = 3'b110; #10;
        {a, b, c} = 3'b111; #10;

        $finish;
    end

endmodule
