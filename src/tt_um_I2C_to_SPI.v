`default_nettype none

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

reg MOD_bi;
reg temp_data_in;
reg temp_clk_in; 
reg temp_data_out;
reg temp_clk_out;
reg temp_data_oe;
reg temp_clk_oe;
reg temp_data_out2;
reg temp_clk_out2;
reg temp_data_oe2;
reg temp_clk_oe2;

assign MOD_bi = ui_in[3];
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
        .i2c_data_in(temp_data_in),
        .i2c_clk_in(temp_clk_in),
    .miso_i(ui_in[2]),
    .i2c_wb_clk_i(clk),
    .i2c_wb_rst_i(rst_n),
    .sck_o(uo_out[0]),
        .mosi_o(uo_out[1]),
        .i2c_wb_err_i(ui_in[5]),
        .i2c_wb_rty_i(ui_in[6]),
        .i2c_data_out(temp_data_out),
        .i2c_clk_out(temp_clk_out),
        .i2c_data_oe(temp_data_oe),
        .i2c_clk_oe(temp_clk_oe)
      
        
  );

 /*   .i2c_data_out(uio_out[0]),
        .i2c_clk_out(uio_out[1]),
        .i2c_data_in(uio_in[0]),
        .i2c_clk_in(uio_in[1]),
        .i2c_data_oe(uio_oe[0]),
        .i2c_clk_oe(uio_oe[1]) */
  // All output pins must be assigned. If not used, assign to 0.

        assign uio_out[0] = temp_data_out2;
        assign uio_out[1] = temp_clk_out2;
        assign uio_oe[0] = temp_data_oe2;
        assign uio_oe[1] = temp_clk_oe2;
		
		assign uo_out[2] = temp_data_out;
        assign uo_out[3] = temp_clk_out;
        assign uo_out[4] = temp_data_oe;
        assign uo_out[5] = temp_clk_oe;
			

always @* begin
    if (MOD_bi) begin
       temp_data_in = uio_in[0];
       temp_clk_in = uio_in[1];
      //  uio_in[0] <= ui_in[0];
     //   uio_in[1] <= ui_in[1];
        temp_data_out2 <= temp_data_out;
        temp_clk_out2 <= temp_clk_out;
        temp_data_oe2 <= temp_data_oe;
        temp_clk_oe2 <= temp_clk_oe;

    end
    else begin
         // Assign default values if MOD_bi is 0
        temp_data_in = ui_in[0];
        temp_clk_in = ui_in[1];
        temp_data_out2 <= 0;
        temp_clk_out2 <= 0;
        temp_data_oe2 <= 0;
        temp_clk_oe2 <= 0;
    end
end

    
  assign uo_out[6]  = 0;
  assign uo_out[7]  = 0;


assign uio_out[2] =0;
assign uio_out[3] =0;
assign uio_out[4] =0;
assign uio_out[5]=0;
   
  assign uio_out[6] = 0;
  assign uio_out[7] = 0;


  assign uio_oe[2]  = 0;
  assign uio_oe[3]  = 0;
  assign uio_oe[4]  = 0;
  assign uio_oe[5]  = 0;
  assign uio_oe[6]  = 0;
  assign uio_oe[7]  = 0;

endmodule
