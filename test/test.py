import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
# Function to check acknowledgment from the I2C slave
async def check_acknowledgment(dut):
    await RisingEdge(dut.clk)
    sda_state = dut.ui_in[0].value
    if sda_state == 0:
        return True  # Acknowledgment received (SDA pulled low by slave)
    else:
        return False  # No acknowledgment (SDA remains high)
@cocotb.test()
async def test_project(dut):
    dut._log.info("Starting test: Write data to I2C and read from SPI")
    # Initialize clock
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    # Reset
    dut._log.info("Performing reset")
    dut.rst_n <= 1
    await RisingEdge(dut.clk)
    dut.rst_n <= 0
    await RisingEdge(dut.clk)
    dut.rst_n <= 1
    await RisingEdge(dut.clk)
    # Write data (0xAB) to the I2C bus
    data_to_write = 0xAB
    dut.ui_in[0] <= data_to_write
    dut.ui_in[1] <= 1  # Start condition (SDA = data to write, SCL = high)
    await RisingEdge(dut.clk)
    # Clock high, keeping control signal high
    dut.clk <= 1
    await RisingEdge(dut.clk)
    # Complete cycle by setting clock low and control signal low
    dut.clk <= 0
    dut.ui_in[1] <= 0  # End condition
    await RisingEdge(dut.clk)
    # Check for acknowledgment from the I2C slave
    acknowledgment = await check_acknowledgment(dut)
    if acknowledgment:
        dut._log.info("Data write successful; acknowledgment received.")
    else:
        dut._log.error("Data write failed; no acknowledgment received.")
    # Trigger read operation from SPI side
    dut.ui_in[2] <= 1  # Trigger SPI read
    await RisingEdge(dut.clk)
    dut.ui_in[2] <= 0  # Complete SPI read trigger
    await RisingEdge(dut.clk)
    # Check received data from SPI side
    received_data = dut.uo_out.value
    expected_data = 0xAB  # We expect the data to match the data written (0xAB)
    # Assert that received data matches expected data
    assert received_data == expected_data, f"Received data {hex(received_data)} does not match expected data {hex(expected_data)}"
    # Log the success of the test case
    dut._log.info(f"Test successful: Received data {hex(received_data)} matches expected data {hex(expected_data)}")
        
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



