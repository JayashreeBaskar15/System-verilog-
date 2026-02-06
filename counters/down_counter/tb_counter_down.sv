`timescale 1ns/1ps

module tb_counter_down;

    logic clk;
    logic rst_n;
    logic en;
    logic [3:0] count;

    counter_down dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .count(count)
    );

    // Clock: 10ns period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        en = 0;

        // Reset active
        #20;
        rst_n = 1;

        // Enable counter
        #10;
        en = 1;

        // Run counter
        #100;

        // Disable counter
        en = 0;

        #20;
        $finish;
    end

endmodule

