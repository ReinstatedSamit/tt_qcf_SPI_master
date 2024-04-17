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
    dut.ena <= 1
    dut.ui_in <= 0
    dut.uio_in <= 0
    dut.rst_n <= 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    dut.rst_n <= 1

    # Test case 1: Input 2 on ui_in, Input 1 on uio_in
    dut._log.info("Test case 1")
    dut.ui_in <= 2
    dut.uio_in <= 1
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    assert dut.uo_out.value == 0  # Verify the output based on the expected behavior

    # Test case 2: Add more test cases as needed
