`timescale 1ns/1ps

module tb_mod_n_counter;

    logic clk;
    logic rst_n;
    logic en;
    logic [3:0] count;

    // MOD-10 counter
    mod_n_counter #(
        .WIDTH(4),
        .N(10)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .count(count)
    );

    // 10ns clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        en = 0;

        // Reset
        #20 rst_n = 1;

        // Enable counting
        #10 en = 1;

        // Run long enough to see wrap-around
        #150;

        en = 0;
        #20;

        $finish;
    end

endmodule
