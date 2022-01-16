`include "ethernet_define.v"
module static_data
    (
        input i_clock_data,
        input i_reset,
        
        output [7:0] o_data_out
    );

    //resigters decreation
    reg [7:0] r_status_data;
    reg [7:0] r_data_out;
    // increase status register each rising edge of i_clock_data
    always @(posedge i_reset or posedge i_clock_data)
        begin
            if (i_reset)
                begin
                    r_status_data <= 8'b0;
                    r_data_out    <= 8'b0;
                end
            else
                begin
                    r_status_data <= r_status_data + 1;
                        if (r_status_data >= 8'd71)
                            begin
                                r_status_data <= 8'b0;
                            end
                        case(r_status_data)
                        // preamble
                        8'b00000000 : r_data_out <= `FREAMBLE;
                        8'b00000001 : r_data_out <= `FREAMBLE;
                        8'b00000010 : r_data_out <= `FREAMBLE;
                        8'b00000011 : r_data_out <= `FREAMBLE;
                        8'b00000100 : r_data_out <= `FREAMBLE;
                        8'b00000101 : r_data_out <= `FREAMBLE;
                        8'b00000110 : r_data_out <= `FREAMBLE;
                        8'b00000111 : r_data_out <= `FREAMBLE_SDF;
                        // MAC ADDRESSES
                        // MAC DESTINATION ADDRESS
                        8'b00001000 : r_data_out <= `TX_DST_ADDR_1;
                        8'b00001001 : r_data_out <= `TX_DST_ADDR_2;
                        8'b00001010 : r_data_out <= `TX_DST_ADDR_3;
                        8'b00001011 : r_data_out <= `TX_DST_ADDR_4;
                        8'b00001100 : r_data_out <= `TX_DST_ADDR_5;
                        8'b00001101 : r_data_out <= `TX_DST_ADDR_6;
                        //MAC SOURCE ADDRESS
                        8'b00001110 : r_data_out <= `TX_SRC_ADDR_1;
                        8'b00001111 : r_data_out <= `TX_SRC_ADDR_2;
                        8'b00010000 : r_data_out <= `TX_SRC_ADDR_3;
                        8'b00010001 : r_data_out <= `TX_SRC_ADDR_4;
                        8'b00010010 : r_data_out <= `TX_SRC_ADDR_5;
                        8'b00010011 : r_data_out <= `TX_SRC_ADDR_6;
                        //ETHERNET TYPE
                        8'b00010100 : r_data_out <= `LENGTH_TYPE_IP_1;
                        8'b00010101 : r_data_out <= `LENGTH_TYPE_IP_2;
                        // VERSION LENGTH + DIFFERENCE FIELD
                        8'b00010110 : r_data_out <= `VER_LENGTH;
                        8'b00010111 : r_data_out <= `DIFF_FIELD;
                        // TOTAL LENGTH
                        8'b00011000 : r_data_out <= `TOTAL_LENGTH_1;
                        8'b00011001 : r_data_out <= `TOTAL_LENGTH_2;
                        // ARBITARY NUMBER
                        8'b00011010 : r_data_out <= `IDENTIFICATION_1;
                        8'b00011011 : r_data_out <= `IDENTIFICATION_2;
                        // FLAG + FRAGMENT
                        8'b00011100 : r_data_out <= `FLAG_FRAGMENT_1;
                        8'b00011101 : r_data_out <= `FLAG_FRAGMENT_2;
                        // TIME LIVE
                        8'b00011110 : r_data_out <= `TIME_LIVE;
                        // define IP protocol
                        8'b00011111 : r_data_out <= `IP_PROTOCOL;
                        // IP checksum
                        8'b00100000 : r_data_out <= `IP_CHECKSUM_1;
                        8'b00100001 : r_data_out <= `IP_CHECKSUM_2;
                        // IP SOURCE ADDRESS // 192.168.0.44
                        8'b00100010 : r_data_out <= `IP_SOURCE_ADDR_1;
                        8'b00100011 : r_data_out <= `IP_SOURCE_ADDR_2;
                        8'b00100100 : r_data_out <= `IP_SOURCE_ADDR_3;
                        8'b00100101 : r_data_out <= `IP_SOURCE_ADDR_4;
                        // IP SEDTINATION ADDRESS // 192.168.0.4
                        8'b00100110 : r_data_out <= `IP_DST_ADDR_1;
                        8'b00100111 : r_data_out <= `IP_DST_ADDR_2;
                        8'b00101000 : r_data_out <= `IP_DST_ADDR_3;
                        8'b00101001 : r_data_out <= `IP_DST_ADDR_4;
                        // UDP SOURCE PORT // 1024
                        8'b00101010 : r_data_out <= `UDP_SRC_PORT_1;
                        8'b00101011 : r_data_out <= `UDP_SRC_PORT_2;
                        // UDP DESTINATION PORT 
                        8'b00101100 : r_data_out <= `UDP_DST_PORT_1;
                        8'b00101101 : r_data_out <= `UDP_DST_PORT_2;
                        // UDP PAYLOAD LENGTH = UDP length + UDP port + UDP checksum +  UDP payload (not ethernet checksum)
                        8'b00101110 : r_data_out <= `UDP_LENGTH_1;
                        8'b00101111 : r_data_out <= `UDP_LENGTH_2;
                        // UDP CHECKSUM
                        8'b00110000 : r_data_out <= `UDP_CHECKSUM_1;
                        8'b00110001 : r_data_out <= `UDP_CHECKSUM_2;
                        // UDP PAYLOAD
                        8'b00110010 : r_data_out <= `UDP_PAYLOAD_1;
                        8'b00110011 : r_data_out <= `UDP_PAYLOAD_2;
                        8'b00110100 : r_data_out <= `UDP_PAYLOAD_3;
                        8'b00110101 : r_data_out <= `UDP_PAYLOAD_4;
                        8'b00110110 : r_data_out <= `UDP_PAYLOAD_5;
                        8'b00110111 : r_data_out <= `UDP_PAYLOAD_6;
                        8'b00111000 : r_data_out <= `UDP_PAYLOAD_7;
                        8'b00111001 : r_data_out <= `UDP_PAYLOAD_8;
                        8'b00111010 : r_data_out <= `UDP_PAYLOAD_9;
                        8'b00111011 : r_data_out <= `UDP_PAYLOAD_10;
                        8'b00111100 : r_data_out <= `UDP_PAYLOAD_11;
                        8'b00111101 : r_data_out <= `UDP_PAYLOAD_12;
                        8'b00111110 : r_data_out <= `UDP_PAYLOAD_13;
                        8'b00111111 : r_data_out <= `UDP_PAYLOAD_14;
                        8'b01000000 : r_data_out <= `UDP_PAYLOAD_15;
                        8'b01000001 : r_data_out <= `UDP_PAYLOAD_16;
                        8'b01000010 : r_data_out <= `UDP_PAYLOAD_17;
                        8'b01000011 : r_data_out <= `UDP_PAYLOAD_18;
                        // CRC 32
                        8'b01000100 : r_data_out <= `ETHER_CHECKSUM_1;
                        8'b01000101 : r_data_out <= `ETHER_CHECKSUM_2;
                        8'b01000110 : r_data_out <= `ETHER_CHECKSUM_3;
                        8'b01000111 : r_data_out <= `ETHER_CHECKSUM_4;
                    endcase
                end
        end
    
    assign o_data_out = r_data_out;
endmodule
