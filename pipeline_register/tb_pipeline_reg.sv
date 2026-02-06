`timescale 1ns/1ps

module tb_pipeline_reg;

    logic clk;
    logic rst_n;

    logic in_valid;
    logic in_ready;
    logic [31:0] in_data;

    logic out_valid;
    logic out_ready;
    logic [31:0] out_data;

    pipeline_reg dut (
        .clk(clk),
        .rst_n(rst_n),
        .in_valid(in_valid),
        .in_ready(in_ready),
        .in_data(in_data),
        .out_valid(out_valid),
        .out_ready(out_ready),
        .out_data(out_data)
    );

    // Clock: 10ns
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        in_valid = 0;
        in_data  = 0;
        out_ready = 0;

        // Reset
        #20 rst_n = 1;

        // Send first data
        #10;
        in_valid = 1;
        in_data  = 32'hA5A5A5A5;
        out_ready = 1;

        // Backpressure
        #20;
        out_ready = 0;
        in_data   = 32'h12345678;

        // Release backpressure
        #30;
        out_ready = 1;

        // Stop input
        #20;
        in_valid = 0;

        #30 $finish;
    end

endmodule
