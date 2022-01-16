module fifo_write_control
    (
        input           i_clock,
        input           i_clock_data,
        input           i_reset,
        input   [7:0]   i_data_in,
        //input           i_DV,

        output  [1:0]   o_data_write,
        output  [8:0]   o_addr_write,
        output          o_enab_write,
        output          o_data_empt,
        output          o_data_full
    );
    // local parametters decreation
    localparam [2:0] IDLE       =    3'b000;
    localparam [2:0] BUS_1      =    3'b001;
    localparam [2:0] BUS_2      =    3'b010;
    localparam [2:0] BUS_3      =    3'b011;
    localparam [2:0] BUS_4      =    3'b100;
    localparam [2:0] BUS_1_INIT =    3'b101;
    localparam [2:0] STOP       =    3'b110;
    // registers and wires decreation 
    reg     [7:0]       r_data_in;
    reg     [2:0]       r_ST_main;
    reg     [8:0]       r_addr_write;
    reg     [1:0]       r_data_write;
    reg                 r_enab_write;
    reg                 r_data_empt;
    reg                 r_data_full;
    reg                 r_clock_data;
    reg                 r_DV;

    // storage data clock to detect rising edge
    always @(posedge i_clock or posedge i_reset)
        begin
            if (i_reset)
                begin
                    r_clock_data <= 1'b0;
                end
            else
                begin
                    r_clock_data <= i_clock_data;
                end
        end

    //generate r_DV whene rising edge of data clock 
    always @(posedge i_clock or posedge i_reset)
        begin
            if (i_reset)
                begin
                    r_DV <= 1'b0;
                end
            else if ((r_clock_data == 1'b0)  & (i_clock_data == 1'b1))
                begin
                    r_DV <= 1'b1;
                end
            else
                begin
                    r_DV <= 1'b0;
                end
        end
    // storage data in register
    always @( posedge i_clock or posedge i_reset )
        begin
            if (i_reset)
                begin
                    r_data_in <= 7'b0;
                end
            else
                begin
                    if (r_DV)
                        begin
                            r_data_in <= i_data_in;
                        end
                end
        end

    // state machine write each pair of bit  
    always @( posedge i_clock or posedge i_reset)
        begin
            if (i_reset)
                begin
                    r_ST_main       <= IDLE;
                    r_addr_write    <= 9'b0;
                    r_data_write    <= 2'b0;
                    r_enab_write    <= 1'b0;
                end
            else
                begin
                    r_data_full <= 1'b0;
                    case(r_ST_main)
                        IDLE:
                            begin
                                r_enab_write    <= 1'b0;       
                                r_data_write    <= r_data_write;
                                r_addr_write    <= r_addr_write;
                                if (r_DV &(r_addr_write == 9'b0))
                                    begin
                                        r_ST_main    <= BUS_1_INIT;
                                    end
                                else if (r_DV)
                                    begin
                                        r_ST_main <= BUS_1;
                                    end
                            end
                        BUS_1_INIT:
                            begin
                                r_addr_write <= r_addr_write;
                                r_data_write <= r_data_in[7:6];
                                r_enab_write <= 1'b1;
                                r_ST_main    <= BUS_2;
                                if (r_addr_write >= 9'd287)
                                    begin
                                        r_data_full <= 1'b1;
                                        r_addr_write <= 9'b0;
                                        r_enab_write <= 1'b0;
                                        r_ST_main    <= STOP;
                                    end
                            end
                        BUS_1:
                            begin
                                r_addr_write <= r_addr_write + 1;
                                r_data_write <= r_data_in[7:6];
                                r_enab_write <= 1'b1;
                                r_ST_main    <= BUS_2;
                                if (r_addr_write >= 9'd287)
                                    begin
                                        r_data_full <= 1'b1;
                                        r_addr_write <= 9'b0;
                                        r_enab_write <= 1'b0;
                                        r_ST_main    <= STOP;
                                    end
                            end
                        BUS_2:
                            begin
                                r_addr_write <= r_addr_write + 1;
                                r_data_write <= r_data_in[5:4];
                                r_enab_write <= 1'b1;
                                r_ST_main    <= BUS_3;
                                if (r_addr_write >= 9'd287)
                                    begin
                                        r_data_full <= 1'b1;
                                        r_addr_write <= 9'b0;
                                        r_enab_write <= 1'b0;
                                        r_ST_main    <= STOP;
                                    end
                            end
                        BUS_3:
                            begin
                                r_addr_write <= r_addr_write + 1;
                                r_data_write <= r_data_in[3:2];
                                r_enab_write <= 1'b1;
                                r_ST_main    <= BUS_4;
                                if (r_addr_write >= 9'd287)
                                    begin
                                        r_data_full <= 1'b1;
                                        r_addr_write <= 9'b0;
                                        r_enab_write <= 1'b0;
                                        r_ST_main    <= STOP;
                                    end
                            end
                        BUS_4:
                            begin
                                r_addr_write <= r_addr_write + 1;
                                r_data_write <= r_data_in[1:0];
                                r_enab_write <= 1'b1;
                                r_ST_main    <= IDLE;
                                if (r_addr_write >= 9'd287)
                                    begin
                                        r_data_full <= 1'b1;
                                        r_addr_write <= 9'b0;
                                        r_enab_write <= 1'b0;
                                        r_ST_main    <= STOP;
                                    end
                            end
                        STOP:
                            begin
                                r_addr_write    <= 9'b0;
                                r_data_write    <= 2'b0;
                                r_enab_write    <= 1'b0;
                            end
                    endcase
                end
        end

    assign o_data_write = r_data_write;
    assign o_addr_write = r_addr_write;
    assign o_enab_write = r_enab_write;
    assign o_data_full  = r_data_full;
endmodule