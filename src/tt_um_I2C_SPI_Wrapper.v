`timescale 1ns/100ps
module tt_um_I2C_SPI_Wrapper (
    // SPI interface
     output wire        sck_o,         // serial clock output
     output wire       mosi_o,        // MasterOut SlaveIN
     input  wire       miso_i,         // MasterIn SlaveOut

    // I2C interface
    input   wire           i2c_data_in,
    input   wire           i2c_clk_in,
  
    input wire        i2c_wb_clk_i,
    input wire        i2c_wb_rst_i,

    output wire       i2c_data_out,
    output wire       i2c_clk_out,
    output wire       i2c_data_oe,
    output wire       i2c_clk_oe,

      // Wishbone error and retry inputs
    input wire i2c_wb_err_i,
    input wire i2c_wb_rty_i
);

//SPI Interface

  wire       spi_clk_i;         // clock
  wire       spi_rst_i;         // reset (asynchronous active low)
  wire       spi_cyc_i;         // cycle
  wire       spi_stb_i;         // strobe
    wire [7:0] spi_adr_i;         // ad;dress
  wire       spi_we_i;          // write enable
  wire [7:0] spi_dat_i;         // data input
  wire  [7:0] spi_dat_o;         // data output
  wire        spi_ack_o;         // normal bus termination
  wire        spi_inta_o;        // interrupt output

//I2C interface


    wire [7:0]  i2c_wb_data_i;
    wire  [7:0]  i2c_wb_data_o;
    wire  [7:0]  i2c_wb_addr_o;
    wire  [3:0]  i2c_wb_sel_o;
    wire         i2c_wb_we_o;
    wire         i2c_wb_cyc_o;
    wire         i2c_wb_stb_o;
    wire        i2c_wb_ack_i;
  
    




    // SPI module instantiation
    simple_spi_top spi_inst (
        .clk_i(spi_clk_i),
        .rst_i(spi_rst_i),
        .cyc_i(spi_cyc_i),
        .stb_i(spi_stb_i),
        .adr_i(spi_adr_i),
        .we_i(spi_we_i),
        .dat_i(spi_dat_i),
        .dat_o(spi_dat_o),
        .ack_o(spi_ack_o),
        .inta_o(spi_inta_o),
        .sck_o(sck_o),
        .mosi_o(mosi_o),
        .miso_i(miso_i)
    );

    // I2C to Wishbone module instantiation
    i2c_to_wb_top i2c_inst (
        .i2c_data_in(i2c_data_in),
        .i2c_clk_in(i2c_clk_in),
        .i2c_data_out(i2c_data_out),
        .i2c_clk_out(i2c_clk_out),
        .i2c_data_oe(i2c_data_oe),
        .i2c_clk_oe(i2c_clk_oe),
        .wb_data_i(i2c_wb_data_i),
        .wb_data_o(i2c_wb_data_o),
        .wb_addr_o(i2c_wb_addr_o),
        .wb_sel_o(i2c_wb_sel_o),
        .wb_we_o(i2c_wb_we_o),
        .wb_cyc_o(i2c_wb_cyc_o),
        .wb_stb_o(i2c_wb_stb_o),
        .wb_ack_i(i2c_wb_ack_i),
        .wb_err_i(i2c_wb_err_i),
        .wb_rty_i(i2c_wb_rty_i),
        .wb_clk_i(i2c_wb_clk_i),
        .wb_rst_i(i2c_wb_rst_i)
    );

// Connect SPI Wishbone interface to I2C to Wishbone interface
assign i2c_wb_data_i = spi_dat_o;
assign spi_dat_i = i2c_wb_data_o;
assign spi_adr_i= i2c_wb_addr_o;
// Assuming single byte transfers for simplicity
assign spi_clk_i = i2c_wb_clk_i;
assign spi_rst_i = i2c_wb_rst_i;
assign spi_we_i = i2c_wb_we_o;
assign spi_cyc_i = i2c_wb_cyc_o;
assign spi_stb_i = i2c_wb_stb_o;
assign i2c_wb_ack_i = spi_ack_o;

//spi_inta_o


endmodule
