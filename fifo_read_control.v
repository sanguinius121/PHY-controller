module fifo_read_control
    (
        input        i_clock, //50MHz of RMII
        input        i_reset,
        input        i_data_full,

        output [8:0] o_addr_read,
        output       o_reading_done,
        output       o_TX_enab
    );

    // registers decreation
    reg        [8:0]    r_addr_read;
    reg                 r_reading_done;
    reg        [2:0]    r_ST_main;
    reg                 r_TX_enab;

    localparam [2:0]    IDLE      = 3'b000;
    localparam [2:0]    READ      = 3'b001;
    localparam [2:0]    WAIT      = 3'b010;
    // reading data
    always @(negedge i_clock or posedge i_reset)
        begin
            if (i_reset)
                begin
                    r_addr_read    <= 9'b0;
                    r_reading_done <= 1'b0;
                    r_ST_main      <= IDLE;
                    r_TX_enab      <= 1'b0;
                end
            else
                begin
                    r_reading_done <= 1'b0;
                    r_TX_enab      <= 1'b0;
                    if (r_addr_read >= 9'd287)
                        begin
                            r_reading_done <= 1'b1;
                            r_addr_read <= 9'b0;
                        end
                    case(r_ST_main)
                        IDLE:
                            begin
                                r_addr_read    <= r_addr_read;
                                r_reading_done <= 1'b0;
                                if (i_data_full)
                                    begin
                                        r_ST_main <= READ;
                                        r_TX_enab <= 1'b1;
                                    end
                            end
                        READ:
                            begin
                                r_addr_read <= r_addr_read + 1;
                                r_TX_enab <= 1'b1;
                                r_reading_done <= 1'b0;
                                if (r_addr_read >= 9'd287)
                                    begin
                                        r_reading_done <= 1'b1;
                                        r_addr_read <= r_addr_read;
                                        r_TX_enab      <= 1'b0;
                                        r_ST_main      <= WAIT;     
                                    end
                                else
                                    begin
                                        r_ST_main <= READ;
                                    end
                            end
                        WAIT:
                            begin
                                r_addr_read <= 9'b0;
                                r_TX_enab   <= 1'b1;
                                r_ST_main   <= READ;
                                r_reading_done <= 1'b0;
                            end
                    endcase
                end
        end
    assign o_addr_read = r_addr_read;
    assign o_TX_enab   = r_TX_enab;
endmodule