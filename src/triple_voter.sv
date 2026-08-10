module triple_voter(
    input  logic clk,
    input  logic rst_n,
    input  logic a,
    input  logic b,
    input  logic c,
    output logic y
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            y <= 1'b0;
        else
            y <= (a & b) | (a & c) | (b & c);
    end

endmodule
