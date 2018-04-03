// system_mm_interconnect_0.v

// This file was auto-generated from altera_mm_interconnect_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 14.0 200 at 2018.04.03.09:12:35

`timescale 1 ps / 1 ps
module system_mm_interconnect_0 (
		input  wire         acl_iface_kernel_clk_clk,                                      //                                    acl_iface_kernel_clk.clk
		input  wire         fpgasort_system_clock_reset_reset_reset_bridge_in_reset_reset, // fpgasort_system_clock_reset_reset_reset_bridge_in_reset.reset
		input  wire [29:0]  fpgasort_system_avm_memgmem0_port_0_0_rw_address,              //                fpgasort_system_avm_memgmem0_port_0_0_rw.address
		output wire         fpgasort_system_avm_memgmem0_port_0_0_rw_waitrequest,          //                                                        .waitrequest
		input  wire [4:0]   fpgasort_system_avm_memgmem0_port_0_0_rw_burstcount,           //                                                        .burstcount
		input  wire [31:0]  fpgasort_system_avm_memgmem0_port_0_0_rw_byteenable,           //                                                        .byteenable
		input  wire         fpgasort_system_avm_memgmem0_port_0_0_rw_read,                 //                                                        .read
		output wire [255:0] fpgasort_system_avm_memgmem0_port_0_0_rw_readdata,             //                                                        .readdata
		output wire         fpgasort_system_avm_memgmem0_port_0_0_rw_readdatavalid,        //                                                        .readdatavalid
		input  wire         fpgasort_system_avm_memgmem0_port_0_0_rw_write,                //                                                        .write
		input  wire [255:0] fpgasort_system_avm_memgmem0_port_0_0_rw_writedata,            //                                                        .writedata
		output wire [29:0]  acl_iface_kernel_mem0_address,                                 //                                   acl_iface_kernel_mem0.address
		output wire         acl_iface_kernel_mem0_write,                                   //                                                        .write
		output wire         acl_iface_kernel_mem0_read,                                    //                                                        .read
		input  wire [255:0] acl_iface_kernel_mem0_readdata,                                //                                                        .readdata
		output wire [255:0] acl_iface_kernel_mem0_writedata,                               //                                                        .writedata
		output wire [4:0]   acl_iface_kernel_mem0_burstcount,                              //                                                        .burstcount
		output wire [31:0]  acl_iface_kernel_mem0_byteenable,                              //                                                        .byteenable
		input  wire         acl_iface_kernel_mem0_readdatavalid,                           //                                                        .readdatavalid
		input  wire         acl_iface_kernel_mem0_waitrequest,                             //                                                        .waitrequest
		output wire         acl_iface_kernel_mem0_debugaccess                              //                                                        .debugaccess
	);

	wire          fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_waitrequest;   // acl_iface_kernel_mem0_translator:uav_waitrequest -> fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_waitrequest
	wire    [9:0] fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_burstcount;    // fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_burstcount -> acl_iface_kernel_mem0_translator:uav_burstcount
	wire  [255:0] fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_writedata;     // fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_writedata -> acl_iface_kernel_mem0_translator:uav_writedata
	wire   [29:0] fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_address;       // fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_address -> acl_iface_kernel_mem0_translator:uav_address
	wire          fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_lock;          // fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_lock -> acl_iface_kernel_mem0_translator:uav_lock
	wire          fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_write;         // fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_write -> acl_iface_kernel_mem0_translator:uav_write
	wire          fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_read;          // fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_read -> acl_iface_kernel_mem0_translator:uav_read
	wire  [255:0] fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_readdata;      // acl_iface_kernel_mem0_translator:uav_readdata -> fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_readdata
	wire          fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_debugaccess;   // fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_debugaccess -> acl_iface_kernel_mem0_translator:uav_debugaccess
	wire   [31:0] fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_byteenable;    // fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_byteenable -> acl_iface_kernel_mem0_translator:uav_byteenable
	wire          fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_readdatavalid; // acl_iface_kernel_mem0_translator:uav_readdatavalid -> fpgasort_system_avm_memgmem0_port_0_0_rw_translator:uav_readdatavalid

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (30),
		.AV_DATA_W                   (256),
		.AV_BURSTCOUNT_W             (5),
		.AV_BYTEENABLE_W             (32),
		.UAV_ADDRESS_W               (30),
		.UAV_BURSTCOUNT_W            (10),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.USE_READRESPONSE            (0),
		.USE_WRITERESPONSE           (0),
		.AV_SYMBOLS_PER_WORD         (32),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (1),
		.UAV_CONSTANT_BURST_BEHAVIOR (1),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) fpgasort_system_avm_memgmem0_port_0_0_rw_translator (
		.clk                      (acl_iface_kernel_clk_clk),                                                                    //                       clk.clk
		.reset                    (fpgasort_system_clock_reset_reset_reset_bridge_in_reset_reset),                               //                     reset.reset
		.uav_address              (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount           (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read                 (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write                (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest          (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid        (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable           (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata             (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata            (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock                 (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess          (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address               (fpgasort_system_avm_memgmem0_port_0_0_rw_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest           (fpgasort_system_avm_memgmem0_port_0_0_rw_waitrequest),                                        //                          .waitrequest
		.av_burstcount            (fpgasort_system_avm_memgmem0_port_0_0_rw_burstcount),                                         //                          .burstcount
		.av_byteenable            (fpgasort_system_avm_memgmem0_port_0_0_rw_byteenable),                                         //                          .byteenable
		.av_read                  (fpgasort_system_avm_memgmem0_port_0_0_rw_read),                                               //                          .read
		.av_readdata              (fpgasort_system_avm_memgmem0_port_0_0_rw_readdata),                                           //                          .readdata
		.av_readdatavalid         (fpgasort_system_avm_memgmem0_port_0_0_rw_readdatavalid),                                      //                          .readdatavalid
		.av_write                 (fpgasort_system_avm_memgmem0_port_0_0_rw_write),                                              //                          .write
		.av_writedata             (fpgasort_system_avm_memgmem0_port_0_0_rw_writedata),                                          //                          .writedata
		.av_beginbursttransfer    (1'b0),                                                                                        //               (terminated)
		.av_begintransfer         (1'b0),                                                                                        //               (terminated)
		.av_chipselect            (1'b0),                                                                                        //               (terminated)
		.av_lock                  (1'b0),                                                                                        //               (terminated)
		.av_debugaccess           (1'b0),                                                                                        //               (terminated)
		.uav_clken                (),                                                                                            //               (terminated)
		.av_clken                 (1'b1),                                                                                        //               (terminated)
		.uav_response             (2'b00),                                                                                       //               (terminated)
		.av_response              (),                                                                                            //               (terminated)
		.uav_writeresponserequest (),                                                                                            //               (terminated)
		.uav_writeresponsevalid   (1'b0),                                                                                        //               (terminated)
		.av_writeresponserequest  (1'b0),                                                                                        //               (terminated)
		.av_writeresponsevalid    ()                                                                                             //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (30),
		.AV_DATA_W                      (256),
		.UAV_DATA_W                     (256),
		.AV_BURSTCOUNT_W                (5),
		.AV_BYTEENABLE_W                (32),
		.UAV_BYTEENABLE_W               (32),
		.UAV_ADDRESS_W                  (30),
		.UAV_BURSTCOUNT_W               (10),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.USE_READRESPONSE               (0),
		.USE_WRITERESPONSE              (0),
		.AV_SYMBOLS_PER_WORD            (32),
		.AV_ADDRESS_SYMBOLS             (1),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) acl_iface_kernel_mem0_translator (
		.clk                      (acl_iface_kernel_clk_clk),                                                                    //                      clk.clk
		.reset                    (fpgasort_system_clock_reset_reset_reset_bridge_in_reset_reset),                               //                    reset.reset
		.uav_address              (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_address),       // avalon_universal_slave_0.address
		.uav_burstcount           (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_burstcount),    //                         .burstcount
		.uav_read                 (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_read),          //                         .read
		.uav_write                (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_write),         //                         .write
		.uav_waitrequest          (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid        (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_readdatavalid), //                         .readdatavalid
		.uav_byteenable           (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_byteenable),    //                         .byteenable
		.uav_readdata             (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_readdata),      //                         .readdata
		.uav_writedata            (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_writedata),     //                         .writedata
		.uav_lock                 (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_lock),          //                         .lock
		.uav_debugaccess          (fpgasort_system_avm_memgmem0_port_0_0_rw_translator_avalon_universal_master_0_debugaccess),   //                         .debugaccess
		.av_address               (acl_iface_kernel_mem0_address),                                                               //      avalon_anti_slave_0.address
		.av_write                 (acl_iface_kernel_mem0_write),                                                                 //                         .write
		.av_read                  (acl_iface_kernel_mem0_read),                                                                  //                         .read
		.av_readdata              (acl_iface_kernel_mem0_readdata),                                                              //                         .readdata
		.av_writedata             (acl_iface_kernel_mem0_writedata),                                                             //                         .writedata
		.av_burstcount            (acl_iface_kernel_mem0_burstcount),                                                            //                         .burstcount
		.av_byteenable            (acl_iface_kernel_mem0_byteenable),                                                            //                         .byteenable
		.av_readdatavalid         (acl_iface_kernel_mem0_readdatavalid),                                                         //                         .readdatavalid
		.av_waitrequest           (acl_iface_kernel_mem0_waitrequest),                                                           //                         .waitrequest
		.av_debugaccess           (acl_iface_kernel_mem0_debugaccess),                                                           //                         .debugaccess
		.av_begintransfer         (),                                                                                            //              (terminated)
		.av_beginbursttransfer    (),                                                                                            //              (terminated)
		.av_writebyteenable       (),                                                                                            //              (terminated)
		.av_lock                  (),                                                                                            //              (terminated)
		.av_chipselect            (),                                                                                            //              (terminated)
		.av_clken                 (),                                                                                            //              (terminated)
		.uav_clken                (1'b0),                                                                                        //              (terminated)
		.av_outputenable          (),                                                                                            //              (terminated)
		.uav_response             (),                                                                                            //              (terminated)
		.av_response              (2'b00),                                                                                       //              (terminated)
		.uav_writeresponserequest (1'b0),                                                                                        //              (terminated)
		.uav_writeresponsevalid   (),                                                                                            //              (terminated)
		.av_writeresponserequest  (),                                                                                            //              (terminated)
		.av_writeresponsevalid    (1'b0)                                                                                         //              (terminated)
	);

endmodule
