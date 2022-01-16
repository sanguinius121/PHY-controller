`timescale 1ns/1ps
module PHY_controller_tb();

    reg         r_clock = 1'b0;
    reg         r_clock_data = 1'b0;
    reg         r_reset;
    wire [1:0]  o_data_out;
    wire        o_clock_out;

    PHY_controller UUT
        (
            .i_clock(r_clock),
            .i_clock_data(r_clock_data),
            .i_reset(r_reset),
            .o_data_out(o_data_out),
            .o_clock_out(o_clock_out)
        );
    
    always #10  r_clock <= !r_clock;
    always #200 r_clock_data <= !r_clock_data;
    initial 
        begin
            r_reset <= 1'b1;
            #200
            r_reset <= 1'b0;
        end
endmodule