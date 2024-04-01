//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////


`timescale 1ns/100ps


module tb_dut_combine(
                input tb_clk,
                input tb_rst
              );


  // --------------------------------------------------------------------
  // test bench variables
  reg test_it;
  

  // --------------------------------------------------------------------
  // wires
  wire i2c_data;
  wire i2c_clk;
    
  
  // --------------------------------------------------------------------
  //  async_mem_master
	pullup p1(i2c_data); // pullup scl line
	pullup p2(i2c_clk); // pullup sda line
 //hookup i2master model 
  i2c_master_model
    i2c(  
      .i2c_data(i2c_data),
      .i2c_clk(i2c_clk)
    );
    
    
// hookup spi slave model
	spi_slave_model spi_slave (
		.csn(1'b0),
		.sck(sck),
		.di(mosi),
		.do(miso)
	);



    // hookup_wrapper
     tt_um_I2C_SPI_Wrapper wrapper(
               .sck_o(sck_o),
               .mosi_o(mosi_o),
               .miso_i(miso_i),
               .i2c_data_in(i2c_data_in),
               .i2c_clk_in(i2c_clk_in),
               .i2c_data_out(i2c_data_out),
               .i2c_clk_out(i2c_clk_out),
               .i2c_data_oe(i2c_data_oe),
               .i2c_clk_oe(i2c_clk_oe),
               .i2c_wb_clk_i(i2c_wb_clk_i),
               .i2c_wb_rst_i(i2c_wb_rst_i)
);
     
  
  // tristate buffers
  assign i2c_data = i2c_data_oe ? i2c_data_out  : 1'bz;
  assign i2c_clk  = i2c_clk_oe  ? i2c_clk_out   : 1'bz;
    
    
  // --------------------------------------------------------------------
  //  glitch_generator 
  glitch_generator i_g1( i2c_data );
  glitch_generator i_g2( i2c_clk );
  
  
  // --------------------------------------------------------------------
  //  outputs
  
  
  
endmodule

