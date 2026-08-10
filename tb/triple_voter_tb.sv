`timescale 1ns / 1ps

module triple_voter_tb;

    timeunit 1ns/100ps;
    localparam time CP = 10ns;

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

    function automatic tmr_calc(input a, input b, input c);
        begin
            return (a & b) | (b & c) | (a & c);
        end
    endfunction

    always begin
        clk = 1'b1;
        #(CP/2);
        clk = 1'b0;
        #(CP/2);
    end

    initial begin
        $timeformat(-9, 0, "ns");
        $monitor(
            "Time %0t: a = %0b, b = %0b, c = %0b, y = %0b",
            $time, a, b, c, y
        );

        clk   = 1'b0;
        rst_n = 1'b0;
        a     = 1'b0;
        b     = 1'b0;
        c     = 1'b0;

        #10;
        rst_n = 1'b1;
        #10;

        $display("----------------");
        $display("Test Start");
        $display("----------------");

        wait (rst_n == 1'b1);

        @(posedge clk);
        a = 1'b0;
        b = 1'b0;
        c = 1'b0;

        @(posedge clk);
        assert (y == tmr_calc(a, b, c))
            else $error("Triple voter mismatch");

        c = 1'b1;
        @(posedge clk);
        assert (y == tmr_calc(a, b, c))
            else $error("Triple voter mismatch");

        b = 1'b1;
        c = 1'b0;
        @(posedge clk);
        assert (y == tmr_calc(a, b, c))
            else $error("Triple voter mismatch");

        c = 1'b1;
        @(posedge clk);
        assert (y == tmr_calc(a, b, c))
            else $error("Triple voter mismatch");

        a = 1'b1;
        b = 1'b0;
        c = 1'b0;
        @(posedge clk);
        assert (y == tmr_calc(a, b, c))
            else $error("Triple voter mismatch");

        c = 1'b1;
        @(posedge clk);
        assert (y == tmr_calc(a, b, c))
            else $error("Triple voter mismatch");

        b = 1'b1;
        c = 1'b0;
        @(posedge clk);
        assert (y == tmr_calc(a, b, c))
            else $error("Triple voter mismatch");

        c = 1'b1;
        @(posedge clk);
        assert (y == tmr_calc(a, b, c))
            else $error("Triple voter mismatch");

        $display("----------------");
        $display("Test end");
        $display("----------------");

        $finish;
    end

endmodule
