module fifo
    (   
        input             i_clock,
        input   [1:0]     i_data_in,     // 2 bit length followed by RMII protocol
        input   [8:0]     i_addr_write, // 9 bits address - 2^9 = 512 depth
        input             i_enab_write,

        input   [8:0]     i_addr_read,  // reading address
        output  [1:0]     o_data_out
    );

    reg [1:0]   data_reg_FIFO [287 :0];
    // write data activity
    always @(posedge i_clock)
        begin
            if (i_enab_write)
                begin
                    data_reg_FIFO[i_addr_write] <= i_data_in;
                end
        end
    
    assign o_data_out = data_reg_FIFO[i_addr_read];
endmodule