module triple_voter(
    input  logic a,
    input  logic b,
    input  logic c,
    output logic y
);

    always_comb begin
        y = (a & b) | (a & c) | (b & c);
    end

endmodule
