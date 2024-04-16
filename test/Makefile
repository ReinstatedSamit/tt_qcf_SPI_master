# Makefile
# See https://docs.cocotb.org/en/stable/quickstart.html for more info

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src
PROJECT_SOURCES = tt_um_I2C_to_SPI.v
src_2 = simple_spi_top.v
src_3 = i2c_to_wb_top.v
src_4 = i2c_to_wb_if.v
src_5 = i2c_to_wb_fsm.v
src_6 = i2c_to_wb_config.v
src_7 = glitch_filter.v
src_8 = tt_um_I2C_SPI_Wrapper.v
src_9 = fifo4.v

ifneq ($(GATES),yes)

# RTL simulation:
SIM_BUILD				= sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(src_8))
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(src_2))
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(src_3))
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(src_4))
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(src_5))
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(src_6))
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(src_7))
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(src_9))
COMPILE_ARGS 		+= -I$(SRC_DIR)

else

# Gate level simulation:
SIM_BUILD				= sim_build/gl
COMPILE_ARGS    += -DGL_TEST
COMPILE_ARGS    += -DFUNCTIONAL
COMPILE_ARGS    += -DUSE_POWER_PINS
COMPILE_ARGS    += -DSIM
COMPILE_ARGS    += -DUNIT_DELAY=\#1
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v

# this gets copied in by the GDS action workflow
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v

endif

# Include the testbench sources:
VERILOG_SOURCES += $(PWD)/tb.v 
TOPLEVEL = tb

# MODULE is the basename of the Python test file
MODULE = test

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
