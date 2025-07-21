import cocotb
from cocotb.clock import Clock
from cocotb.triggers import *
from cocotb.handle import Force , Release , Freeze 

# First Method: Concurrent execution using start()
async def try_start(dut) : 
    dut.reset.value= 1
    dut.A.value = 7
    dut.B.value = 3
    dut.Opcode.value = 2
    await RisingEdge(dut.clk)
    cocotb.log.info(" After Rising Start ")
    await FallingEdge(dut.clk)
    cocotb.log.info(" After Falling Start")

"""@cocotb.test()
async def tb_top(dut):
    cocotb.log.info(" STARTING SIMULATION ")
    CLK = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(CLK.start())
    await cocotb.start(try_start(dut))
    await Timer(20, units='ns')
    cocotb.log.info(" After start coroutine")"""

# Second Method: Concurrent execution using start_soon()
async def try_start_soon(dut) : 
    cocotb.log.info("Inside Try Start_Soon")
    dut.reset.value = 1
    dut.A.value = 6
    dut.B.value = 2
    dut.Opcode.value = 1
    await RisingEdge(dut.clk)
    cocotb.log.info(" After Rising start  soon ")
    await FallingEdge(dut.clk)
    cocotb.log.info(" After Falling start  soon ")

"""@cocotb.test()
async def tb_top(dut):
    cocotb.log.info(" STARTING SIMULATION ")
    CLK = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(CLK.start())
    await cocotb.start_soon(try_start_soon(dut))
    cocotb.log.info(" After start coroutine ")"""

        
# Third Method: Normal Driving Stimilus
async def driving_stimilus(dut):
    await FallingEdge(dut.clk)
    dut.reset.value = 0
    dut.A.value = 3
    dut.B.value = 4
    dut.Opcode.value = 0
    await RisingEdge(dut.clk)
    await ReadOnly()
    cocotb.log.info(" Output : "+str(dut.C.value))
    
@cocotb.test()
async def tb_top(dut):
    cocotb.log.info(" STARTING SIMULATION ")
    CLK = Clock(dut.clk, 10, units="ns")
    dut.reset.value = 1
    await cocotb.start(CLK.start())
    await cocotb.start_soon(driving_stimilus(dut))
    cocotb.log.info(" After Driving Stimilus ")