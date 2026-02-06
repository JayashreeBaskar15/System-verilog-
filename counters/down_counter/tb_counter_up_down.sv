`timescale 1ns/1ps

module tb_counter_up_down;

    logic clk;
    logic rst_n;
    logic en;
    logic dir;
    logic [3:0] count;

    counter_up_down dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .dir(dir),
        .count(count)
    );

    // 10ns clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst_n = 0;
        en = 0;
        dir = 1;   // start with UP

        // Reset
        #20 rst_n = 1;

        // Enable UP count
        #10 en = 1;
        #60;

        // Change direction to DOWN
        dir = 0;
        #60;

        // Disable counter
        en = 0;
        #20;

        $finish;
    end

endmodule
