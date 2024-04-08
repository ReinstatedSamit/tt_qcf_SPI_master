`define default_netname none

module tt_um_I2C_to_SPI (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

/*  tt_um_I2C_SPI_Wrapper wrapper_inst(
    .i2c_data_in(ui_in[0]),
    .i2c_clk_in(ui_in[1]),
    .miso_i(ui_in[2]),
    .clk(i2c_wb_clk_i),
    .rst_n(i2c_wb_rst_i),
    .sck_o(uo_out[0]),
    .mosi_o(uo_out[1])
  );*/

    tt_um_I2C_SPI_Wrapper wrapper_inst(
    .i2c_data_in(ui_in[0]),
    .i2c_clk_in(ui_in[1]),
    .miso_i(ui_in[2]),
    .i2c_wb_clk_i(clk),
    .i2c_wb_rst_i(rst_n),
    .sck_o(uo_out[0]),
    .mosi_o(uo_out[1]),
    .wb_sel[0:3](uio_in[0:3])
        
  );
    
  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[2]  = 0;// Example: ou_out is the sum of ui_in and uio_in
  assign uo_out[3]  = 0;
  assign uo_out[4]  = 0;
  assign uo_out[5]  = 0;
  assign uo_out[6]  = 0;
  assign uo_out[7]  = 0;
    
  
  assign uio_out[0] = 0;
  assign uio_out[1] = 0;
  assign uio_out[2] = 0;
  assign uio_out[3] = 0;
  assign uio_out[4] = 0;
  assign uio_out[5] = 0;
  assign uio_out[6] = 0;
  assign uio_out[7] = 0;
  
  assign uio_oe[0]  = 0;
  assign uio_oe[1]  = 0;
  assign uio_oe[2]  = 0;
  assign uio_oe[3]  = 0;
  assign uio_oe[4]  = 0;
  assign uio_oe[5]  = 0;
  assign uio_oe[6]  = 0;
  assign uio_oe[7]  = 0;

endmodule
