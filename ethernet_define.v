// example of ETHERNET/IP/UDP 

// FREAMBLE 8 bytes
`define FREAMBLE                 8'h55
`define FREAMBLE_SDF             8'hD5

// MAC addresses
// MAC DESTINATION ADDRESS              6 bytes
`define TX_DST_ADDR_1            8'hFF
`define TX_DST_ADDR_2            8'hFF
`define TX_DST_ADDR_3            8'hFF
`define TX_DST_ADDR_4            8'hFF
`define TX_DST_ADDR_5            8'hFF
`define TX_DST_ADDR_6            8'hFF

// MAC SOURCE ADDRESS                   6 bytes
`define TX_SRC_ADDR_1            8'h00
`define TX_SRC_ADDR_2            8'h00
`define TX_SRC_ADDR_3            8'h00
`define TX_SRC_ADDR_4            8'h00
`define TX_SRC_ADDR_5            8'h00
`define TX_SRC_ADDR_6            8'h00

// ETHERNET type - IP type              2 bytes 
`define LENGTH_TYPE_IP_1         8'h08 
`define LENGTH_TYPE_IP_2         8'h00     

//VERSION_LENGTH + DEFFERENCE FIELD     2 bytes 
`define VER_LENGTH               8'h45
`define DIFF_FIELD               8'h00

//TOTAL LENGTH                          2 bytes 
`define TOTAL_LENGTH_1           8'h00
`define TOTAL_LENGTH_2           8'h2E

//arbitrary number (2bytes)
`define IDENTIFICATION_1         8'hB3
`define IDENTIFICATION_2         8'hFE

// FLAG + FRAGMENT (set = 00 when not use) 2 bytes
`define FLAG_FRAGMENT_1          8'h00
`define FLAG_FRAGMENT_2          8'h00

//time live (1 byte)
`define TIME_LIVE                8'h80

// define IP protocol - UDP (1 byte)
`define IP_PROTOCOL              8'h11

//IP_CHECKSUM
`define IP_CHECKSUM_1            8'h05
`define IP_CHECKSUM_2            8'h40

//IP SOURCE ADDRESS  // 192.168.0.44
`define IP_SOURCE_ADDR_1         8'hC0
`define IP_SOURCE_ADDR_2         8'hA8
`define IP_SOURCE_ADDR_3         8'h00
`define IP_SOURCE_ADDR_4         8'h2C

//IP DESTINATION ADDRESS // 192.168.0.4
`define IP_DST_ADDR_1            8'hC0
`define IP_DST_ADDR_2            8'hA8
`define IP_DST_ADDR_3            8'h00
`define IP_DST_ADDR_4            8'h04

// UDP SOURCE PORT //1024
`define UDP_SRC_PORT_1           8'h04
`define UDP_SRC_PORT_2           8'h00

// UDP DESTINATION PORT //1024
`define UDP_DST_PORT_1           8'h04
`define UDP_DST_PORT_2           8'h00

// UDP PAYLOAD LENGTH = UDP length + UDP port + UDP checksum +  UDP payload (not ethernet checksum)
`define UDP_LENGTH_1             8'h00
`define UDP_LENGTH_2             8'h1A

//UDP CHECKSUM
`define UDP_CHECKSUM_1           8'h2D
`define UDP_CHECKSUM_2           8'hE8

//UDP PAYLOAD 18 byte
`define UDP_PAYLOAD_1            8'h00
`define UDP_PAYLOAD_2            8'h01
`define UDP_PAYLOAD_3            8'h02
`define UDP_PAYLOAD_4            8'h03
`define UDP_PAYLOAD_5            8'h04
`define UDP_PAYLOAD_6            8'h05
`define UDP_PAYLOAD_7            8'h06
`define UDP_PAYLOAD_8            8'h07
`define UDP_PAYLOAD_9            8'h08
`define UDP_PAYLOAD_10           8'h09
`define UDP_PAYLOAD_11           8'h0A
`define UDP_PAYLOAD_12           8'h0B
`define UDP_PAYLOAD_13           8'h0C
`define UDP_PAYLOAD_14           8'h0D
`define UDP_PAYLOAD_15           8'h0E
`define UDP_PAYLOAD_16           8'h0F
`define UDP_PAYLOAD_17           8'h10
`define UDP_PAYLOAD_18           8'h11

// UDP check sum (4 bytes)
`define ETHER_CHECKSUM_1         8'hB3
`define ETHER_CHECKSUM_2         8'h31
`define ETHER_CHECKSUM_3         8'h88
`define ETHER_CHECKSUM_4         8'h1B

