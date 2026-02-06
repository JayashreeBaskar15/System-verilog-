module mod_n_counter #(
    parameter WIDTH = 4,
    parameter N     = 10        // Modulus value
)(
    input  logic clk,
    input  logic rst_n,
    input  logic en,
    output logic [WIDTH-1:0] count
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= '0;
        else if (en) begin
            if (count == N-1)
                count <= '0;      // wrap-around
            else
                count <= count + 1'b1;
        end
    end

endmodule
