`include "ethernet_define.v"
module PHY_controller
    (
        input        i_clock, // 50MHz
        input        i_clock_data, // 2.5MHz
        input        i_reset,
        output [1:0] o_data_out,
        output       o_clock_out,
        output       o_TX_enab
    );
    // wire decreation
    wire w_clock;
    wire w_clock_data;
    wire w_reset;
    wire [7:0] w_data_8bits;
    wire [1:0] w_data_2bits;
    wire [8:0] w_addr_wire;
    wire       w_enab_write;
    wire [8:0] w_addr_read;
    wire       w_data_full;
    wire       w_clock_20MHz;

    assign w_clock = i_clock;
    assign w_clock_data = i_clock_data;
    assign w_reset      = i_reset;
    assign o_clock_out = i_clock;
    
    fifo fifo_inst
        (
            .i_clock(w_clock),
            .i_data_in(w_data_2bits),
            .i_addr_write(w_addr_wire),
            .i_enab_write(w_enab_write),
            .i_addr_read(w_addr_read),
            .o_data_out(o_data_out)
        );
    
    static_data data_source
        (
            .i_clock_data(w_clock_data),
            .i_reset(w_reset),
            .o_data_out(w_data_8bits)
        );

    fifo_read_control read_control_inst
        (
            .i_clock(w_clock),
            .i_reset(w_reset),
            .i_data_full(w_data_full),
            .o_addr_read(w_addr_read),
            .o_TX_enab(o_TX_enab),
            .o_reading_done()
        );

    fifo_write_control write_control_inst
        (
            .i_clock(w_clock),
            .i_clock_data(w_clock_data),
            .i_reset(w_reset),
            .i_data_in(w_data_8bits),
            .o_data_write(w_data_2bits),
            .o_addr_write(w_addr_wire),
            .o_enab_write(w_enab_write),
            .o_data_empt(),
            .o_data_full(w_data_full)
        ); 
endmodule   
    