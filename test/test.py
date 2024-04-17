import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Our example module doesn't use clock and reset, but we show how to use them here anyway.
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.rst_n <= 1
    await RisingEdge(dut.clk)
    dut.rst_n <= 0
    await RisingEdge(dut.clk)

    # Test case 1: Write data to I2C
    dut._log.info("Test case 1: Write data to I2C")
    dut.ui_in[0] <= 0xAB  # Example data to write
    dut.clk <= 1
    dut.ui_in[1] <= 1
    await RisingEdge(dut.clk)
    dut.clk <= 0
    dut.ui_in[1] <= 0
    await RisingEdge(dut.clk)
    # Add assertion or checking mechanism here if needed


    # Read operation
    # Assuming some triggering mechanism for reading data from SPI
    # Example: Trigger a read operation
    dut.ui_in[2] <= 2
    await RisingEdge(dut.clk)
    dut.ui_in[2] <= 0
    await RisingEdge(dut.clk)
    # Example: Check received data
    received_data = dut.uo_out.value
    # Add assertion or checking mechanism here if needed


