module counter_up_down #(
    parameter WIDTH = 4
)(
    input  logic clk,
    input  logic rst_n,
    input  logic en,
    input  logic dir,                // 1 = UP, 0 = DOWN
    output logic [WIDTH-1:0] count
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= '0;
        else if (en) begin
            if (dir)
                count <= count + 1'b1;  // up count
            else
                count <= count - 1'b1;  // down count
        end
    end

endmodule
