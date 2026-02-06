module pipeline_reg #(
    parameter WIDTH = 32
)(
    input  logic              clk,
    input  logic              rst_n,

    // Input interface
    input  logic              in_valid,
    output logic              in_ready,
    input  logic [WIDTH-1:0]  in_data,

    // Output interface
    output logic              out_valid,
    input  logic              out_ready,
    output logic [WIDTH-1:0]  out_data
);

    // Internal storage
    logic [WIDTH-1:0] data_q;
    logic             valid_q;

    // Ready when buffer is empty OR consumer is ready
    assign in_ready = ~valid_q || out_ready;

    // Output signals
    assign out_valid = valid_q;
    assign out_data  = data_q;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_q <= 1'b0;
            data_q  <= '0;
        end
        else if (in_ready) begin
            valid_q <= in_valid;
            if (in_valid)
                data_q <= in_data;
        end
    end

endmodule
