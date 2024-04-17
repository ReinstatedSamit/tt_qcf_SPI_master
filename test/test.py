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
    
    dut._log.info("Test case 1: Write data to I2C")
    # Set the data to write to the I2C bus (data byte 0xAB)
    data_to_write = 0xAB
    dut.ui_in[0] <= data_to_write
    # Generate a start condition
    dut.ui_in[1] <= 1  # Set control signal high to indicate start condition
    await RisingEdge(dut.clk)
    # Perform one cycle with the clock high, keeping control signal high
    # This might simulate an SCL high phase while data is held on the SDA line
    dut.clk <= 1
    await RisingEdge(dut.clk)
    # Complete the cycle by setting the clock low and control signal low
    dut.clk <= 0
    dut.ui_in[1] <= 0  # Set control signal low to indicate the end of a cycle
    await RisingEdge(dut.clk)
    # Check for the acknowledgment from the I2C device
    # You may need to add a function to check if the data transfer was successful
    # Check I2C acknowledge signal (e.g., on a specific status flag or line)
    acknowledgment = check_acknowledgment(dut)
    if acknowledgment:
         dut._log.info("Data write successful.")
    else:
        dut._log.error("Data write failed or no acknowledgment received.")
    # You may want to add more I2C operations or assertions here
    '''
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

    '''
    # Read operation
    # Assuming some triggering mechanism for reading data from SPI
    # Example: Trigger a read operation
    dut.ui_in[2] <= 1
    await RisingEdge(dut.clk)
    dut.ui_in[2] <= 0
    await RisingEdge(dut.clk)
    # Example: Check received data
    received_data = dut.uo_out.value



