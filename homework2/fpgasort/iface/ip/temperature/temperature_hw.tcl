# TCL File Generated by Component Editor 11.0
# Tue Jul 19 13:15:52 PDT 2011


# +-----------------------------------
# | 
# | temperature "ACL Timer" v1.0
# | Altera OpenCL 2011.07.19.13:15:52
# | Simple temperature
# | 
# | 
# |    ./temperature.v syn, sim
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 11.0
# | 
package require -exact sopc 10.0
# | 
# +-----------------------------------

# +-----------------------------------
# | module temperature
# | 
set_module_property DESCRIPTION "Temperature sensor - Stratix V"
set_module_property NAME temperature
set_module_property VERSION 10.0
set_module_property GROUP "ACL Internal Components"
set_module_property AUTHOR "Altera OpenCL"
set_module_property DISPLAY_NAME "ACL temperature sensor"
set_module_property TOP_LEVEL_HDL_FILE temperature.v
set_module_property TOP_LEVEL_HDL_MODULE temperature
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
set_module_property ANALYZE_HDL false
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file temperature.v {SYNTHESIS SIMULATION}
add_file temp_sense.v {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point clk
# | 
add_interface clk clock end
set_interface_property clk ENABLED true
add_interface_port clk clk clk Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point clk_reset
# | 
add_interface clk_reset reset end
set_interface_property clk_reset associatedClock clk
set_interface_property clk_reset synchronousEdges DEASSERT
set_interface_property clk_reset ENABLED true
add_interface_port clk_reset resetn reset_n Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point s
# | 
add_interface s avalon end
set_interface_property s addressAlignment DYNAMIC
set_interface_property s addressUnits WORDS
set_interface_property s associatedClock clk
set_interface_property s associatedReset clk_reset
set_interface_property s burstOnBurstBoundariesOnly false
set_interface_property s explicitAddressSpan 0
set_interface_property s holdTime 0
set_interface_property s isMemoryDevice false
set_interface_property s isNonVolatileStorage false
set_interface_property s linewrapBursts false
set_interface_property s maximumPendingReadTransactions 1
set_interface_property s printableDevice false
set_interface_property s readLatency 0
set_interface_property s readWaitTime 0
set_interface_property s setupTime 0
set_interface_property s timingUnits Cycles
set_interface_property s writeWaitTime 0
set_interface_property s ENABLED true

add_interface_port s slave_address address Input 1
add_interface_port s slave_writedata writedata Input 32
add_interface_port s slave_read read Input 1
add_interface_port s slave_write write Input 1
add_interface_port s slave_byteenable byteenable Input 4
add_interface_port s slave_waitrequest waitrequest Output 1
add_interface_port s slave_readdata readdata Output 32
add_interface_port s slave_readdatavalid readdatavalid Output 1
# | 
# +-----------------------------------

