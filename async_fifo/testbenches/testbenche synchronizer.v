module tb_sync_2ff;
    reg clk = 0;
    reg d_in;
    wire q_out;

    sync_2ff dut (.clk(clk), .d_in(d_in), .q_out(q_out));

    always #5 clk = ~clk;

    initial begin
        d_in = 0;
        #12 d_in = 1;
        #18 d_in = 0;
        #20 $stop;
    end
endmodule
