the top level file is PHY_controller.v
the testbench file is PHY_controller_tb.v

The write operation takes data from the static_data.v and write into the fifo. the write operation takes about 30us
until the write to fifo is done, the read operation reads the data out with 50MHz clock over and over again.