// (C) 1992-2014 Altera Corporation. All rights reserved.                         
// Your use of Altera Corporation's design tools, logic functions and other       
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Altera MegaCore Function License Agreement, or other applicable     
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Altera and sold by   
// Altera or its authorized distributors.  Please refer to the applicable         
// agreement for further details.                                                 
    

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_0
	(
		input 		clock,
		input 		resetn,
		input 		start,
		input [31:0] 		input_subarr_size,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_bb0_add,
		output [31:0] 		lvb_input_global_id_0,
		output [31:0] 		lvb_input_acl_hw_wg_id,
		input [31:0] 		workgroup_size
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_global_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_global_id_0_staging_reg_NO_SHIFT_REG <= input_global_id_0;
				input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements a registered operation.
// 
wire local_bb0_add_inputs_ready;
 reg local_bb0_add_wii_reg_NO_SHIFT_REG;
 reg local_bb0_add_valid_out_NO_SHIFT_REG;
wire local_bb0_add_stall_in;
wire local_bb0_add_output_regs_ready;
 reg [31:0] local_bb0_add_NO_SHIFT_REG;
wire local_bb0_add_causedstall;

assign local_bb0_add_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb0_add_output_regs_ready = (~(local_bb0_add_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_add_valid_out_NO_SHIFT_REG) | ~(local_bb0_add_stall_in))));
assign merge_node_stall_in_0 = (~(local_bb0_add_wii_reg_NO_SHIFT_REG) & (~(local_bb0_add_output_regs_ready) | ~(local_bb0_add_inputs_ready)));
assign local_bb0_add_causedstall = (local_bb0_add_inputs_ready && (~(local_bb0_add_output_regs_ready) && !(~(local_bb0_add_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_add_NO_SHIFT_REG <= 'x;
		local_bb0_add_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_add_NO_SHIFT_REG <= 'x;
			local_bb0_add_valid_out_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_add_output_regs_ready)
			begin
				local_bb0_add_NO_SHIFT_REG <= (input_subarr_size + 32'hFFFFFFFF);
				local_bb0_add_valid_out_NO_SHIFT_REG <= local_bb0_add_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_add_stall_in))
				begin
					local_bb0_add_valid_out_NO_SHIFT_REG <= local_bb0_add_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_add_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_add_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_add_inputs_ready)
			begin
				local_bb0_add_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_bb0_add_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb0_add_valid_out_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb0_add_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign merge_node_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb0_add = lvb_bb0_add_reg_NO_SHIFT_REG;
assign lvb_input_global_id_0 = lvb_input_global_id_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_bb0_add_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb0_add_reg_NO_SHIFT_REG <= local_bb0_add_NO_SHIFT_REG;
			lvb_input_global_id_0_reg_NO_SHIFT_REG <= local_lvm_input_global_id_0_NO_SHIFT_REG;
			lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_1
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_subarr_size,
		input [31:0] 		input_num_of_elements,
		input [31:0] 		input_wii_add,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_bb1_c0_exe1,
		output 		lvb_bb1_c0_exe2,
		output [31:0] 		lvb_bb1_c0_exe3,
		output [31:0] 		lvb_bb1_c0_exe4,
		output [31:0] 		lvb_bb1_c0_exe5,
		output [63:0] 		lvb_bb1_c0_exe6,
		output 		lvb_bb1_c0_exe7,
		output [31:0] 		lvb_input_acl_hw_wg_id,
		input [31:0] 		workgroup_size,
		input 		start
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_global_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_global_id_0_staging_reg_NO_SHIFT_REG <= input_global_id_0;
				input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_input_global_id_0_NO_SHIFT_REG <= input_global_id_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_eni1_valid_out;
wire local_bb1_c0_eni1_stall_in;
wire local_bb1_c0_eni1_inputs_ready;
wire local_bb1_c0_eni1_stall_local;
wire [63:0] local_bb1_c0_eni1;

assign local_bb1_c0_eni1_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb1_c0_eni1[31:0] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
assign local_bb1_c0_eni1[63:32] = local_lvm_input_global_id_0_NO_SHIFT_REG;
assign local_bb1_c0_eni1_valid_out = local_bb1_c0_eni1_inputs_ready;
assign local_bb1_c0_eni1_stall_local = local_bb1_c0_eni1_stall_in;
assign merge_node_stall_in_0 = (|local_bb1_c0_eni1_stall_local);

// Register node:
//  * latency = 41
//  * capacity = 41
 logic rnode_1to42_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to42_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to42_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to42_input_acl_hw_wg_id_0_reg_42_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to42_input_acl_hw_wg_id_0_reg_42_NO_SHIFT_REG;
 logic rnode_1to42_input_acl_hw_wg_id_0_valid_out_reg_42_NO_SHIFT_REG;
 logic rnode_1to42_input_acl_hw_wg_id_0_stall_in_reg_42_NO_SHIFT_REG;
 logic rnode_1to42_input_acl_hw_wg_id_0_stall_out_reg_42_NO_SHIFT_REG;

acl_data_fifo rnode_1to42_input_acl_hw_wg_id_0_reg_42_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to42_input_acl_hw_wg_id_0_reg_42_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to42_input_acl_hw_wg_id_0_stall_in_reg_42_NO_SHIFT_REG),
	.valid_out(rnode_1to42_input_acl_hw_wg_id_0_valid_out_reg_42_NO_SHIFT_REG),
	.stall_out(rnode_1to42_input_acl_hw_wg_id_0_stall_out_reg_42_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to42_input_acl_hw_wg_id_0_reg_42_NO_SHIFT_REG)
);

defparam rnode_1to42_input_acl_hw_wg_id_0_reg_42_fifo.DEPTH = 42;
defparam rnode_1to42_input_acl_hw_wg_id_0_reg_42_fifo.DATA_WIDTH = 32;
defparam rnode_1to42_input_acl_hw_wg_id_0_reg_42_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to42_input_acl_hw_wg_id_0_reg_42_fifo.IMPL = "ram";

assign rnode_1to42_input_acl_hw_wg_id_0_reg_42_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign merge_node_stall_in_1 = rnode_1to42_input_acl_hw_wg_id_0_stall_out_reg_42_NO_SHIFT_REG;
assign rnode_1to42_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to42_input_acl_hw_wg_id_0_reg_42_NO_SHIFT_REG;
assign rnode_1to42_input_acl_hw_wg_id_0_stall_in_reg_42_NO_SHIFT_REG = rnode_1to42_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to42_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to42_input_acl_hw_wg_id_0_valid_out_reg_42_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_c0_enter_c0_eni1_inputs_ready;
 reg local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni1_stall_in;
wire local_bb1_c0_enter_c0_eni1_output_regs_ready;
 reg [63:0] local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG;
wire local_bb1_c0_enter_c0_eni1_input_accepted;
wire local_bb1_c0_exit_c0_exi7_entry_stall;
wire local_bb1_c0_exit_c0_exi7_output_regs_ready;
wire [37:0] local_bb1_c0_exit_c0_exi7_valid_bits;
wire local_bb1_c0_exit_c0_exi7_phases;
wire local_bb1_c0_enter_c0_eni1_inc_pipelined_thread;
wire local_bb1_c0_enter_c0_eni1_dec_pipelined_thread;
wire local_bb1_c0_enter_c0_eni1_causedstall;

assign local_bb1_c0_enter_c0_eni1_inputs_ready = local_bb1_c0_eni1_valid_out;
assign local_bb1_c0_enter_c0_eni1_output_regs_ready = 1'b1;
assign local_bb1_c0_enter_c0_eni1_input_accepted = (local_bb1_c0_enter_c0_eni1_inputs_ready && !(local_bb1_c0_exit_c0_exi7_entry_stall));
assign local_bb1_c0_enter_c0_eni1_inc_pipelined_thread = 1'b1;
assign local_bb1_c0_enter_c0_eni1_dec_pipelined_thread = ~(1'b0);
assign local_bb1_c0_eni1_stall_in = ((~(local_bb1_c0_enter_c0_eni1_inputs_ready) | local_bb1_c0_exit_c0_exi7_entry_stall) | ~(1'b1));
assign local_bb1_c0_enter_c0_eni1_causedstall = (1'b1 && ((~(local_bb1_c0_enter_c0_eni1_inputs_ready) | local_bb1_c0_exit_c0_exi7_entry_stall) && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG <= 'x;
		local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_enter_c0_eni1_output_regs_ready)
		begin
			local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG <= local_bb1_c0_eni1;
			local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_c0_enter_c0_eni1_stall_in))
			begin
				local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_42to43_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_42to43_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_42to43_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_42to43_input_acl_hw_wg_id_0_reg_43_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_42to43_input_acl_hw_wg_id_0_reg_43_NO_SHIFT_REG;
 logic rnode_42to43_input_acl_hw_wg_id_0_valid_out_reg_43_NO_SHIFT_REG;
 logic rnode_42to43_input_acl_hw_wg_id_0_stall_in_reg_43_NO_SHIFT_REG;
 logic rnode_42to43_input_acl_hw_wg_id_0_stall_out_reg_43_NO_SHIFT_REG;

acl_data_fifo rnode_42to43_input_acl_hw_wg_id_0_reg_43_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_42to43_input_acl_hw_wg_id_0_reg_43_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_42to43_input_acl_hw_wg_id_0_stall_in_reg_43_NO_SHIFT_REG),
	.valid_out(rnode_42to43_input_acl_hw_wg_id_0_valid_out_reg_43_NO_SHIFT_REG),
	.stall_out(rnode_42to43_input_acl_hw_wg_id_0_stall_out_reg_43_NO_SHIFT_REG),
	.data_in(rnode_1to42_input_acl_hw_wg_id_0_NO_SHIFT_REG),
	.data_out(rnode_42to43_input_acl_hw_wg_id_0_reg_43_NO_SHIFT_REG)
);

defparam rnode_42to43_input_acl_hw_wg_id_0_reg_43_fifo.DEPTH = 2;
defparam rnode_42to43_input_acl_hw_wg_id_0_reg_43_fifo.DATA_WIDTH = 32;
defparam rnode_42to43_input_acl_hw_wg_id_0_reg_43_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_42to43_input_acl_hw_wg_id_0_reg_43_fifo.IMPL = "ll_reg";

assign rnode_42to43_input_acl_hw_wg_id_0_reg_43_inputs_ready_NO_SHIFT_REG = rnode_1to42_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
assign rnode_1to42_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = rnode_42to43_input_acl_hw_wg_id_0_stall_out_reg_43_NO_SHIFT_REG;
assign rnode_42to43_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_42to43_input_acl_hw_wg_id_0_reg_43_NO_SHIFT_REG;
assign rnode_42to43_input_acl_hw_wg_id_0_stall_in_reg_43_NO_SHIFT_REG = rnode_42to43_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_42to43_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_42to43_input_acl_hw_wg_id_0_valid_out_reg_43_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_c0_ene1_valid_out;
wire local_bb1_c0_ene1_stall_in;
wire local_bb1_c0_ene1_inputs_ready;
wire local_bb1_c0_ene1_stall_local;
wire [31:0] local_bb1_c0_ene1;

assign local_bb1_c0_ene1_inputs_ready = local_bb1_c0_enter_c0_eni1_valid_out_NO_SHIFT_REG;
assign local_bb1_c0_ene1 = local_bb1_c0_enter_c0_eni1_NO_SHIFT_REG[63:32];
assign local_bb1_c0_ene1_valid_out = 1'b1;
assign local_bb1_c0_enter_c0_eni1_stall_in = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_mul_inputs_ready;
 reg local_bb1_mul_valid_out_0_NO_SHIFT_REG;
wire local_bb1_mul_stall_in_0;
 reg local_bb1_mul_valid_out_1_NO_SHIFT_REG;
wire local_bb1_mul_stall_in_1;
wire local_bb1_mul_output_regs_ready;
wire [31:0] local_bb1_mul;
 reg local_bb1_mul_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul_causedstall;

acl_int_mult32s_s5 int_module_local_bb1_mul (
	.clock(clock),
	.dataa(local_bb1_c0_ene1),
	.datab(input_subarr_size),
	.enable(local_bb1_mul_output_regs_ready),
	.result(local_bb1_mul)
);

defparam int_module_local_bb1_mul.INPUT1_WIDTH = 32;
defparam int_module_local_bb1_mul.INPUT2_WIDTH = 32;

assign local_bb1_mul_inputs_ready = 1'b1;
assign local_bb1_mul_output_regs_ready = 1'b1;
assign local_bb1_c0_ene1_stall_in = 1'b0;
assign local_bb1_mul_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_output_regs_ready)
		begin
			local_bb1_mul_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_mul_valid_pipe_1_NO_SHIFT_REG <= local_bb1_mul_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_mul_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_mul_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_mul_output_regs_ready)
		begin
			local_bb1_mul_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_mul_valid_out_1_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_mul_stall_in_0))
			begin
				local_bb1_mul_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_mul_stall_in_1))
			begin
				local_bb1_mul_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_sub_valid_out;
wire local_bb1_sub_stall_in;
wire local_bb1_sub_inputs_ready;
wire local_bb1_sub_stall_local;
wire [31:0] local_bb1_sub;

assign local_bb1_sub_inputs_ready = local_bb1_mul_valid_out_0_NO_SHIFT_REG;
assign local_bb1_sub = (input_wii_add + local_bb1_mul);
assign local_bb1_sub_valid_out = 1'b1;
assign local_bb1_mul_stall_in_0 = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb1_mul_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb1_mul_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb1_mul_1_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb1_mul_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_valid_out_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_stall_in_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb1_mul_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb1_mul_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb1_mul_0_stall_in_0_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb1_mul_0_valid_out_0_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb1_mul_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(local_bb1_mul),
	.data_out(rnode_5to6_bb1_mul_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb1_mul_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb1_mul_0_reg_6_fifo.DATA_WIDTH = 32;
defparam rnode_5to6_bb1_mul_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb1_mul_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb1_mul_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_mul_stall_in_1 = 1'b0;
assign rnode_5to6_bb1_mul_0_stall_in_0_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb1_mul_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_5to6_bb1_mul_0_NO_SHIFT_REG = rnode_5to6_bb1_mul_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_mul_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_5to6_bb1_mul_1_NO_SHIFT_REG = rnode_5to6_bb1_mul_0_reg_6_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb1_sub_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb1_sub_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb1_sub_1_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_5to6_bb1_sub_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_valid_out_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_stall_in_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb1_sub_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb1_sub_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb1_sub_0_stall_in_0_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb1_sub_0_valid_out_0_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb1_sub_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(local_bb1_sub),
	.data_out(rnode_5to6_bb1_sub_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb1_sub_0_reg_6_fifo.DEPTH = 1;
defparam rnode_5to6_bb1_sub_0_reg_6_fifo.DATA_WIDTH = 32;
defparam rnode_5to6_bb1_sub_0_reg_6_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_5to6_bb1_sub_0_reg_6_fifo.IMPL = "shift_reg";

assign rnode_5to6_bb1_sub_0_reg_6_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_sub_stall_in = 1'b0;
assign rnode_5to6_bb1_sub_0_stall_in_0_reg_6_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb1_sub_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_5to6_bb1_sub_0_NO_SHIFT_REG = rnode_5to6_bb1_sub_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_sub_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_5to6_bb1_sub_1_NO_SHIFT_REG = rnode_5to6_bb1_sub_0_reg_6_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_6to7_bb1_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_6to7_bb1_mul_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_6to7_bb1_mul_0_NO_SHIFT_REG;
 logic rnode_6to7_bb1_mul_0_reg_7_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_6to7_bb1_mul_0_reg_7_NO_SHIFT_REG;
 logic rnode_6to7_bb1_mul_0_valid_out_reg_7_NO_SHIFT_REG;
 logic rnode_6to7_bb1_mul_0_stall_in_reg_7_NO_SHIFT_REG;
 logic rnode_6to7_bb1_mul_0_stall_out_reg_7_NO_SHIFT_REG;

acl_data_fifo rnode_6to7_bb1_mul_0_reg_7_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_6to7_bb1_mul_0_reg_7_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_6to7_bb1_mul_0_stall_in_reg_7_NO_SHIFT_REG),
	.valid_out(rnode_6to7_bb1_mul_0_valid_out_reg_7_NO_SHIFT_REG),
	.stall_out(rnode_6to7_bb1_mul_0_stall_out_reg_7_NO_SHIFT_REG),
	.data_in(rnode_5to6_bb1_mul_1_NO_SHIFT_REG),
	.data_out(rnode_6to7_bb1_mul_0_reg_7_NO_SHIFT_REG)
);

defparam rnode_6to7_bb1_mul_0_reg_7_fifo.DEPTH = 1;
defparam rnode_6to7_bb1_mul_0_reg_7_fifo.DATA_WIDTH = 32;
defparam rnode_6to7_bb1_mul_0_reg_7_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_6to7_bb1_mul_0_reg_7_fifo.IMPL = "shift_reg";

assign rnode_6to7_bb1_mul_0_reg_7_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_5to6_bb1_mul_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_6to7_bb1_mul_0_NO_SHIFT_REG = rnode_6to7_bb1_mul_0_reg_7_NO_SHIFT_REG;
assign rnode_6to7_bb1_mul_0_stall_in_reg_7_NO_SHIFT_REG = 1'b0;
assign rnode_6to7_bb1_mul_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_add2_valid_out;
wire local_bb1_add2_stall_in;
wire local_bb1_add2_inputs_ready;
wire local_bb1_add2_stall_local;
wire [31:0] local_bb1_add2;

assign local_bb1_add2_inputs_ready = (rnode_5to6_bb1_mul_0_valid_out_0_NO_SHIFT_REG & rnode_5to6_bb1_sub_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_add2 = (rnode_5to6_bb1_sub_0_NO_SHIFT_REG + rnode_5to6_bb1_mul_0_NO_SHIFT_REG);
assign local_bb1_add2_valid_out = 1'b1;
assign rnode_5to6_bb1_mul_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_5to6_bb1_sub_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_6to7_bb1_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_6to7_bb1_sub_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_6to7_bb1_sub_0_NO_SHIFT_REG;
 logic rnode_6to7_bb1_sub_0_reg_7_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_6to7_bb1_sub_0_reg_7_NO_SHIFT_REG;
 logic rnode_6to7_bb1_sub_0_valid_out_reg_7_NO_SHIFT_REG;
 logic rnode_6to7_bb1_sub_0_stall_in_reg_7_NO_SHIFT_REG;
 logic rnode_6to7_bb1_sub_0_stall_out_reg_7_NO_SHIFT_REG;

acl_data_fifo rnode_6to7_bb1_sub_0_reg_7_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_6to7_bb1_sub_0_reg_7_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_6to7_bb1_sub_0_stall_in_reg_7_NO_SHIFT_REG),
	.valid_out(rnode_6to7_bb1_sub_0_valid_out_reg_7_NO_SHIFT_REG),
	.stall_out(rnode_6to7_bb1_sub_0_stall_out_reg_7_NO_SHIFT_REG),
	.data_in(rnode_5to6_bb1_sub_1_NO_SHIFT_REG),
	.data_out(rnode_6to7_bb1_sub_0_reg_7_NO_SHIFT_REG)
);

defparam rnode_6to7_bb1_sub_0_reg_7_fifo.DEPTH = 1;
defparam rnode_6to7_bb1_sub_0_reg_7_fifo.DATA_WIDTH = 32;
defparam rnode_6to7_bb1_sub_0_reg_7_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_6to7_bb1_sub_0_reg_7_fifo.IMPL = "shift_reg";

assign rnode_6to7_bb1_sub_0_reg_7_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_5to6_bb1_sub_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_6to7_bb1_sub_0_NO_SHIFT_REG = rnode_6to7_bb1_sub_0_reg_7_NO_SHIFT_REG;
assign rnode_6to7_bb1_sub_0_stall_in_reg_7_NO_SHIFT_REG = 1'b0;
assign rnode_6to7_bb1_sub_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 29
//  * capacity = 29
 logic rnode_7to36_bb1_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_7to36_bb1_mul_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_7to36_bb1_mul_0_NO_SHIFT_REG;
 logic rnode_7to36_bb1_mul_0_reg_36_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_7to36_bb1_mul_0_reg_36_NO_SHIFT_REG;
 logic rnode_7to36_bb1_mul_0_valid_out_reg_36_NO_SHIFT_REG;
 logic rnode_7to36_bb1_mul_0_stall_in_reg_36_NO_SHIFT_REG;
 logic rnode_7to36_bb1_mul_0_stall_out_reg_36_NO_SHIFT_REG;

acl_data_fifo rnode_7to36_bb1_mul_0_reg_36_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_7to36_bb1_mul_0_reg_36_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_7to36_bb1_mul_0_stall_in_reg_36_NO_SHIFT_REG),
	.valid_out(rnode_7to36_bb1_mul_0_valid_out_reg_36_NO_SHIFT_REG),
	.stall_out(rnode_7to36_bb1_mul_0_stall_out_reg_36_NO_SHIFT_REG),
	.data_in(rnode_6to7_bb1_mul_0_NO_SHIFT_REG),
	.data_out(rnode_7to36_bb1_mul_0_reg_36_NO_SHIFT_REG)
);

defparam rnode_7to36_bb1_mul_0_reg_36_fifo.DEPTH = 29;
defparam rnode_7to36_bb1_mul_0_reg_36_fifo.DATA_WIDTH = 32;
defparam rnode_7to36_bb1_mul_0_reg_36_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_7to36_bb1_mul_0_reg_36_fifo.IMPL = "shift_reg";

assign rnode_7to36_bb1_mul_0_reg_36_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_6to7_bb1_mul_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_7to36_bb1_mul_0_NO_SHIFT_REG = rnode_7to36_bb1_mul_0_reg_36_NO_SHIFT_REG;
assign rnode_7to36_bb1_mul_0_stall_in_reg_36_NO_SHIFT_REG = 1'b0;
assign rnode_7to36_bb1_mul_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements a registered operation.
// 
wire local_bb1_div_inputs_ready;
 reg local_bb1_div_valid_out_0_NO_SHIFT_REG;
wire local_bb1_div_stall_in_0;
 reg local_bb1_div_valid_out_1_NO_SHIFT_REG;
wire local_bb1_div_stall_in_1;
wire local_bb1_div_output_regs_ready;
wire [31:0] local_bb1_div;
 reg local_bb1_div_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_1_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_2_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_3_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_4_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_5_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_6_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_7_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_8_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_9_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_10_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_11_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_12_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_13_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_14_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_15_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_16_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_17_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_18_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_19_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_20_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_21_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_22_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_23_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_24_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_25_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_26_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_27_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_28_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_29_NO_SHIFT_REG;
 reg local_bb1_div_valid_pipe_30_NO_SHIFT_REG;
wire local_bb1_div_causedstall;

acl_int_div32s int_module_local_bb1_div (
	.clock(clock),
	.numer(local_bb1_add2),
	.denom(32'h2),
	.enable(local_bb1_div_output_regs_ready),
	.quotient(local_bb1_div),
	.remain()
);


assign local_bb1_div_inputs_ready = 1'b1;
assign local_bb1_div_output_regs_ready = 1'b1;
assign local_bb1_add2_stall_in = 1'b0;
assign local_bb1_div_causedstall = (1'b1 && (1'b0 && !(1'b0)));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_div_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_4_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_5_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_6_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_7_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_8_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_9_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_10_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_11_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_12_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_13_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_14_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_15_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_16_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_17_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_18_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_19_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_20_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_21_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_22_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_23_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_24_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_25_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_26_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_27_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_28_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_29_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_pipe_30_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_div_output_regs_ready)
		begin
			local_bb1_div_valid_pipe_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_div_valid_pipe_1_NO_SHIFT_REG <= local_bb1_div_valid_pipe_0_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_2_NO_SHIFT_REG <= local_bb1_div_valid_pipe_1_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_3_NO_SHIFT_REG <= local_bb1_div_valid_pipe_2_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_4_NO_SHIFT_REG <= local_bb1_div_valid_pipe_3_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_5_NO_SHIFT_REG <= local_bb1_div_valid_pipe_4_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_6_NO_SHIFT_REG <= local_bb1_div_valid_pipe_5_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_7_NO_SHIFT_REG <= local_bb1_div_valid_pipe_6_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_8_NO_SHIFT_REG <= local_bb1_div_valid_pipe_7_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_9_NO_SHIFT_REG <= local_bb1_div_valid_pipe_8_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_10_NO_SHIFT_REG <= local_bb1_div_valid_pipe_9_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_11_NO_SHIFT_REG <= local_bb1_div_valid_pipe_10_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_12_NO_SHIFT_REG <= local_bb1_div_valid_pipe_11_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_13_NO_SHIFT_REG <= local_bb1_div_valid_pipe_12_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_14_NO_SHIFT_REG <= local_bb1_div_valid_pipe_13_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_15_NO_SHIFT_REG <= local_bb1_div_valid_pipe_14_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_16_NO_SHIFT_REG <= local_bb1_div_valid_pipe_15_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_17_NO_SHIFT_REG <= local_bb1_div_valid_pipe_16_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_18_NO_SHIFT_REG <= local_bb1_div_valid_pipe_17_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_19_NO_SHIFT_REG <= local_bb1_div_valid_pipe_18_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_20_NO_SHIFT_REG <= local_bb1_div_valid_pipe_19_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_21_NO_SHIFT_REG <= local_bb1_div_valid_pipe_20_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_22_NO_SHIFT_REG <= local_bb1_div_valid_pipe_21_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_23_NO_SHIFT_REG <= local_bb1_div_valid_pipe_22_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_24_NO_SHIFT_REG <= local_bb1_div_valid_pipe_23_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_25_NO_SHIFT_REG <= local_bb1_div_valid_pipe_24_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_26_NO_SHIFT_REG <= local_bb1_div_valid_pipe_25_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_27_NO_SHIFT_REG <= local_bb1_div_valid_pipe_26_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_28_NO_SHIFT_REG <= local_bb1_div_valid_pipe_27_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_29_NO_SHIFT_REG <= local_bb1_div_valid_pipe_28_NO_SHIFT_REG;
			local_bb1_div_valid_pipe_30_NO_SHIFT_REG <= local_bb1_div_valid_pipe_29_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_div_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_div_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_div_output_regs_ready)
		begin
			local_bb1_div_valid_out_0_NO_SHIFT_REG <= 1'b1;
			local_bb1_div_valid_out_1_NO_SHIFT_REG <= 1'b1;
		end
		else
		begin
			if (~(local_bb1_div_stall_in_0))
			begin
				local_bb1_div_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_div_stall_in_1))
			begin
				local_bb1_div_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 30
//  * capacity = 30
 logic rnode_7to37_bb1_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_7to37_bb1_sub_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_7to37_bb1_sub_0_NO_SHIFT_REG;
 logic rnode_7to37_bb1_sub_0_reg_37_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_7to37_bb1_sub_0_reg_37_NO_SHIFT_REG;
 logic rnode_7to37_bb1_sub_0_valid_out_reg_37_NO_SHIFT_REG;
 logic rnode_7to37_bb1_sub_0_stall_in_reg_37_NO_SHIFT_REG;
 logic rnode_7to37_bb1_sub_0_stall_out_reg_37_NO_SHIFT_REG;

acl_data_fifo rnode_7to37_bb1_sub_0_reg_37_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_7to37_bb1_sub_0_reg_37_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_7to37_bb1_sub_0_stall_in_reg_37_NO_SHIFT_REG),
	.valid_out(rnode_7to37_bb1_sub_0_valid_out_reg_37_NO_SHIFT_REG),
	.stall_out(rnode_7to37_bb1_sub_0_stall_out_reg_37_NO_SHIFT_REG),
	.data_in(rnode_6to7_bb1_sub_0_NO_SHIFT_REG),
	.data_out(rnode_7to37_bb1_sub_0_reg_37_NO_SHIFT_REG)
);

defparam rnode_7to37_bb1_sub_0_reg_37_fifo.DEPTH = 30;
defparam rnode_7to37_bb1_sub_0_reg_37_fifo.DATA_WIDTH = 32;
defparam rnode_7to37_bb1_sub_0_reg_37_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_7to37_bb1_sub_0_reg_37_fifo.IMPL = "shift_reg";

assign rnode_7to37_bb1_sub_0_reg_37_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_6to7_bb1_sub_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_7to37_bb1_sub_0_NO_SHIFT_REG = rnode_7to37_bb1_sub_0_reg_37_NO_SHIFT_REG;
assign rnode_7to37_bb1_sub_0_stall_in_reg_37_NO_SHIFT_REG = 1'b0;
assign rnode_7to37_bb1_sub_0_valid_out_NO_SHIFT_REG = 1'b1;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_36to37_bb1_mul_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_36to37_bb1_mul_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_36to37_bb1_mul_0_NO_SHIFT_REG;
 logic rnode_36to37_bb1_mul_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_36to37_bb1_mul_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_36to37_bb1_mul_1_NO_SHIFT_REG;
 logic rnode_36to37_bb1_mul_0_reg_37_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_36to37_bb1_mul_0_reg_37_NO_SHIFT_REG;
 logic rnode_36to37_bb1_mul_0_valid_out_0_reg_37_NO_SHIFT_REG;
 logic rnode_36to37_bb1_mul_0_stall_in_0_reg_37_NO_SHIFT_REG;
 logic rnode_36to37_bb1_mul_0_stall_out_reg_37_NO_SHIFT_REG;

acl_data_fifo rnode_36to37_bb1_mul_0_reg_37_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_36to37_bb1_mul_0_reg_37_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_36to37_bb1_mul_0_stall_in_0_reg_37_NO_SHIFT_REG),
	.valid_out(rnode_36to37_bb1_mul_0_valid_out_0_reg_37_NO_SHIFT_REG),
	.stall_out(rnode_36to37_bb1_mul_0_stall_out_reg_37_NO_SHIFT_REG),
	.data_in(rnode_7to36_bb1_mul_0_NO_SHIFT_REG),
	.data_out(rnode_36to37_bb1_mul_0_reg_37_NO_SHIFT_REG)
);

defparam rnode_36to37_bb1_mul_0_reg_37_fifo.DEPTH = 1;
defparam rnode_36to37_bb1_mul_0_reg_37_fifo.DATA_WIDTH = 32;
defparam rnode_36to37_bb1_mul_0_reg_37_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_36to37_bb1_mul_0_reg_37_fifo.IMPL = "shift_reg";

assign rnode_36to37_bb1_mul_0_reg_37_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_7to36_bb1_mul_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_36to37_bb1_mul_0_stall_in_0_reg_37_NO_SHIFT_REG = 1'b0;
assign rnode_36to37_bb1_mul_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_36to37_bb1_mul_0_NO_SHIFT_REG = rnode_36to37_bb1_mul_0_reg_37_NO_SHIFT_REG;
assign rnode_36to37_bb1_mul_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_36to37_bb1_mul_1_NO_SHIFT_REG = rnode_36to37_bb1_mul_0_reg_37_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_add3_stall_local;
wire [31:0] local_bb1_add3;

assign local_bb1_add3 = (local_bb1_div + 32'h1);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_37to38_bb1_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_37to38_bb1_sub_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_37to38_bb1_sub_0_NO_SHIFT_REG;
 logic rnode_37to38_bb1_sub_0_reg_38_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_37to38_bb1_sub_0_reg_38_NO_SHIFT_REG;
 logic rnode_37to38_bb1_sub_0_valid_out_reg_38_NO_SHIFT_REG;
 logic rnode_37to38_bb1_sub_0_stall_in_reg_38_NO_SHIFT_REG;
 logic rnode_37to38_bb1_sub_0_stall_out_reg_38_NO_SHIFT_REG;

acl_data_fifo rnode_37to38_bb1_sub_0_reg_38_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_37to38_bb1_sub_0_reg_38_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_37to38_bb1_sub_0_stall_in_reg_38_NO_SHIFT_REG),
	.valid_out(rnode_37to38_bb1_sub_0_valid_out_reg_38_NO_SHIFT_REG),
	.stall_out(rnode_37to38_bb1_sub_0_stall_out_reg_38_NO_SHIFT_REG),
	.data_in(rnode_7to37_bb1_sub_0_NO_SHIFT_REG),
	.data_out(rnode_37to38_bb1_sub_0_reg_38_NO_SHIFT_REG)
);

defparam rnode_37to38_bb1_sub_0_reg_38_fifo.DEPTH = 1;
defparam rnode_37to38_bb1_sub_0_reg_38_fifo.DATA_WIDTH = 32;
defparam rnode_37to38_bb1_sub_0_reg_38_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_37to38_bb1_sub_0_reg_38_fifo.IMPL = "shift_reg";

assign rnode_37to38_bb1_sub_0_reg_38_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_7to37_bb1_sub_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_37to38_bb1_sub_0_NO_SHIFT_REG = rnode_37to38_bb1_sub_0_reg_38_NO_SHIFT_REG;
assign rnode_37to38_bb1_sub_0_stall_in_reg_38_NO_SHIFT_REG = 1'b0;
assign rnode_37to38_bb1_sub_0_valid_out_NO_SHIFT_REG = 1'b1;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_valid_out;
wire local_bb1_cmp_stall_in;
wire local_bb1_cmp_inputs_ready;
wire local_bb1_cmp_stall_local;
wire local_bb1_cmp;

assign local_bb1_cmp_inputs_ready = rnode_36to37_bb1_mul_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_cmp = ($signed(rnode_36to37_bb1_mul_0_NO_SHIFT_REG) < $signed(input_num_of_elements));
assign local_bb1_cmp_valid_out = 1'b1;
assign rnode_36to37_bb1_mul_0_stall_in_0_NO_SHIFT_REG = 1'b0;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_37to38_bb1_mul_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_37to38_bb1_mul_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_37to38_bb1_mul_0_NO_SHIFT_REG;
 logic rnode_37to38_bb1_mul_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_37to38_bb1_mul_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_37to38_bb1_mul_1_NO_SHIFT_REG;
 logic rnode_37to38_bb1_mul_0_reg_38_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_37to38_bb1_mul_0_reg_38_NO_SHIFT_REG;
 logic rnode_37to38_bb1_mul_0_valid_out_0_reg_38_NO_SHIFT_REG;
 logic rnode_37to38_bb1_mul_0_stall_in_0_reg_38_NO_SHIFT_REG;
 logic rnode_37to38_bb1_mul_0_stall_out_reg_38_NO_SHIFT_REG;

acl_data_fifo rnode_37to38_bb1_mul_0_reg_38_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_37to38_bb1_mul_0_reg_38_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_37to38_bb1_mul_0_stall_in_0_reg_38_NO_SHIFT_REG),
	.valid_out(rnode_37to38_bb1_mul_0_valid_out_0_reg_38_NO_SHIFT_REG),
	.stall_out(rnode_37to38_bb1_mul_0_stall_out_reg_38_NO_SHIFT_REG),
	.data_in(rnode_36to37_bb1_mul_1_NO_SHIFT_REG),
	.data_out(rnode_37to38_bb1_mul_0_reg_38_NO_SHIFT_REG)
);

defparam rnode_37to38_bb1_mul_0_reg_38_fifo.DEPTH = 1;
defparam rnode_37to38_bb1_mul_0_reg_38_fifo.DATA_WIDTH = 32;
defparam rnode_37to38_bb1_mul_0_reg_38_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_37to38_bb1_mul_0_reg_38_fifo.IMPL = "shift_reg";

assign rnode_37to38_bb1_mul_0_reg_38_inputs_ready_NO_SHIFT_REG = 1'b1;
assign rnode_36to37_bb1_mul_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_37to38_bb1_mul_0_stall_in_0_reg_38_NO_SHIFT_REG = 1'b0;
assign rnode_37to38_bb1_mul_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_37to38_bb1_mul_0_NO_SHIFT_REG = rnode_37to38_bb1_mul_0_reg_38_NO_SHIFT_REG;
assign rnode_37to38_bb1_mul_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_37to38_bb1_mul_1_NO_SHIFT_REG = rnode_37to38_bb1_mul_0_reg_38_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_37to38_bb1_cmp_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_0_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_1_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_0_reg_38_inputs_ready_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_0_reg_38_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_0_valid_out_0_reg_38_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_0_stall_in_0_reg_38_NO_SHIFT_REG;
 logic rnode_37to38_bb1_cmp_0_stall_out_reg_38_NO_SHIFT_REG;

acl_data_fifo rnode_37to38_bb1_cmp_0_reg_38_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_37to38_bb1_cmp_0_reg_38_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_37to38_bb1_cmp_0_stall_in_0_reg_38_NO_SHIFT_REG),
	.valid_out(rnode_37to38_bb1_cmp_0_valid_out_0_reg_38_NO_SHIFT_REG),
	.stall_out(rnode_37to38_bb1_cmp_0_stall_out_reg_38_NO_SHIFT_REG),
	.data_in(local_bb1_cmp),
	.data_out(rnode_37to38_bb1_cmp_0_reg_38_NO_SHIFT_REG)
);

defparam rnode_37to38_bb1_cmp_0_reg_38_fifo.DEPTH = 1;
defparam rnode_37to38_bb1_cmp_0_reg_38_fifo.DATA_WIDTH = 1;
defparam rnode_37to38_bb1_cmp_0_reg_38_fifo.ALLOW_FULL_WRITE = 1;
defparam rnode_37to38_bb1_cmp_0_reg_38_fifo.IMPL = "shift_reg";

assign rnode_37to38_bb1_cmp_0_reg_38_inputs_ready_NO_SHIFT_REG = 1'b1;
assign local_bb1_cmp_stall_in = 1'b0;
assign rnode_37to38_bb1_cmp_0_stall_in_0_reg_38_NO_SHIFT_REG = 1'b0;
assign rnode_37to38_bb1_cmp_0_valid_out_0_NO_SHIFT_REG = 1'b1;
assign rnode_37to38_bb1_cmp_0_NO_SHIFT_REG = rnode_37to38_bb1_cmp_0_reg_38_NO_SHIFT_REG;
assign rnode_37to38_bb1_cmp_0_valid_out_1_NO_SHIFT_REG = 1'b1;
assign rnode_37to38_bb1_cmp_1_NO_SHIFT_REG = rnode_37to38_bb1_cmp_0_reg_38_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_var__stall_local;
wire [63:0] local_bb1_var_;

assign local_bb1_var_[32] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[33] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[34] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[35] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[36] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[37] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[38] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[39] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[40] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[41] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[42] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[43] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[44] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[45] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[46] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[47] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[48] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[49] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[50] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[51] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[52] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[53] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[54] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[55] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[56] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[57] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[58] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[59] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[60] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[61] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[62] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[63] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG[31];
assign local_bb1_var_[31:0] = rnode_37to38_bb1_mul_0_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi1_stall_local;
wire [319:0] local_bb1_c0_exi1;

assign local_bb1_c0_exi1[31:0] = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
assign local_bb1_c0_exi1[63:32] = rnode_37to38_bb1_mul_1_NO_SHIFT_REG;
assign local_bb1_c0_exi1[319:64] = 256'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;

// This section implements an unregistered operation.
// 
wire local_bb1_var__u0_stall_local;
wire local_bb1_var__u0;

assign local_bb1_var__u0 = (rnode_37to38_bb1_cmp_0_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi2_stall_local;
wire [319:0] local_bb1_c0_exi2;

assign local_bb1_c0_exi2[63:0] = local_bb1_c0_exi1[63:0];
assign local_bb1_c0_exi2[64] = rnode_37to38_bb1_cmp_1_NO_SHIFT_REG;
assign local_bb1_c0_exi2[319:65] = local_bb1_c0_exi1[319:65];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi3_stall_local;
wire [319:0] local_bb1_c0_exi3;

assign local_bb1_c0_exi3[95:0] = local_bb1_c0_exi2[95:0];
assign local_bb1_c0_exi3[127:96] = rnode_37to38_bb1_sub_0_NO_SHIFT_REG;
assign local_bb1_c0_exi3[319:128] = local_bb1_c0_exi2[319:128];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi4_stall_local;
wire [319:0] local_bb1_c0_exi4;

assign local_bb1_c0_exi4[127:0] = local_bb1_c0_exi3[127:0];
assign local_bb1_c0_exi4[159:128] = local_bb1_div;
assign local_bb1_c0_exi4[319:160] = local_bb1_c0_exi3[319:160];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi5_stall_local;
wire [319:0] local_bb1_c0_exi5;

assign local_bb1_c0_exi5[159:0] = local_bb1_c0_exi4[159:0];
assign local_bb1_c0_exi5[191:160] = local_bb1_add3;
assign local_bb1_c0_exi5[319:192] = local_bb1_c0_exi4[319:192];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi6_stall_local;
wire [319:0] local_bb1_c0_exi6;

assign local_bb1_c0_exi6[191:0] = local_bb1_c0_exi5[191:0];
assign local_bb1_c0_exi6[255:192] = local_bb1_var_;
assign local_bb1_c0_exi6[319:256] = local_bb1_c0_exi5[319:256];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exi7_valid_out;
wire local_bb1_c0_exi7_stall_in;
wire local_bb1_c0_exi7_inputs_ready;
wire local_bb1_c0_exi7_stall_local;
wire [319:0] local_bb1_c0_exi7;

assign local_bb1_c0_exi7_inputs_ready = (local_bb1_div_valid_out_0_NO_SHIFT_REG & local_bb1_div_valid_out_1_NO_SHIFT_REG & rnode_37to38_bb1_sub_0_valid_out_NO_SHIFT_REG & rnode_37to38_bb1_mul_0_valid_out_0_NO_SHIFT_REG & rnode_37to38_bb1_cmp_0_valid_out_0_NO_SHIFT_REG & rnode_37to38_bb1_mul_0_valid_out_1_NO_SHIFT_REG & rnode_37to38_bb1_cmp_0_valid_out_1_NO_SHIFT_REG);
assign local_bb1_c0_exi7[255:0] = local_bb1_c0_exi6[255:0];
assign local_bb1_c0_exi7[256] = local_bb1_var__u0;
assign local_bb1_c0_exi7[319:257] = local_bb1_c0_exi6[319:257];
assign local_bb1_c0_exi7_valid_out = 1'b1;
assign local_bb1_div_stall_in_0 = 1'b0;
assign local_bb1_div_stall_in_1 = 1'b0;
assign rnode_37to38_bb1_sub_0_stall_in_NO_SHIFT_REG = 1'b0;
assign rnode_37to38_bb1_mul_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_37to38_bb1_cmp_0_stall_in_0_NO_SHIFT_REG = 1'b0;
assign rnode_37to38_bb1_mul_0_stall_in_1_NO_SHIFT_REG = 1'b0;
assign rnode_37to38_bb1_cmp_0_stall_in_1_NO_SHIFT_REG = 1'b0;

// This section implements a registered operation.
// 
wire local_bb1_c0_exit_c0_exi7_inputs_ready;
 reg local_bb1_c0_exit_c0_exi7_valid_out_0_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi7_stall_in_0;
 reg local_bb1_c0_exit_c0_exi7_valid_out_1_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi7_stall_in_1;
 reg local_bb1_c0_exit_c0_exi7_valid_out_2_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi7_stall_in_2;
 reg local_bb1_c0_exit_c0_exi7_valid_out_3_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi7_stall_in_3;
 reg local_bb1_c0_exit_c0_exi7_valid_out_4_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi7_stall_in_4;
 reg local_bb1_c0_exit_c0_exi7_valid_out_5_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi7_stall_in_5;
 reg local_bb1_c0_exit_c0_exi7_valid_out_6_NO_SHIFT_REG;
wire local_bb1_c0_exit_c0_exi7_stall_in_6;
 reg [319:0] local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG;
wire [319:0] local_bb1_c0_exit_c0_exi7_in;
wire local_bb1_c0_exit_c0_exi7_valid;
wire local_bb1_c0_exit_c0_exi7_causedstall;

acl_stall_free_sink local_bb1_c0_exit_c0_exi7_instance (
	.clock(clock),
	.resetn(resetn),
	.data_in(local_bb1_c0_exi7),
	.data_out(local_bb1_c0_exit_c0_exi7_in),
	.input_accepted(local_bb1_c0_enter_c0_eni1_input_accepted),
	.valid_out(local_bb1_c0_exit_c0_exi7_valid),
	.stall_in(~(local_bb1_c0_exit_c0_exi7_output_regs_ready)),
	.stall_entry(local_bb1_c0_exit_c0_exi7_entry_stall),
	.valids(local_bb1_c0_exit_c0_exi7_valid_bits),
	.IIphases(local_bb1_c0_exit_c0_exi7_phases),
	.inc_pipelined_thread(local_bb1_c0_enter_c0_eni1_inc_pipelined_thread),
	.dec_pipelined_thread(local_bb1_c0_enter_c0_eni1_dec_pipelined_thread)
);

defparam local_bb1_c0_exit_c0_exi7_instance.DATA_WIDTH = 320;
defparam local_bb1_c0_exit_c0_exi7_instance.PIPELINE_DEPTH = 42;
defparam local_bb1_c0_exit_c0_exi7_instance.SHARINGII = 1;
defparam local_bb1_c0_exit_c0_exi7_instance.SCHEDULEII = 1;

assign local_bb1_c0_exit_c0_exi7_inputs_ready = 1'b1;
assign local_bb1_c0_exit_c0_exi7_output_regs_ready = ((~(local_bb1_c0_exit_c0_exi7_valid_out_0_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi7_stall_in_0)) & (~(local_bb1_c0_exit_c0_exi7_valid_out_1_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi7_stall_in_1)) & (~(local_bb1_c0_exit_c0_exi7_valid_out_2_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi7_stall_in_2)) & (~(local_bb1_c0_exit_c0_exi7_valid_out_3_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi7_stall_in_3)) & (~(local_bb1_c0_exit_c0_exi7_valid_out_4_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi7_stall_in_4)) & (~(local_bb1_c0_exit_c0_exi7_valid_out_5_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi7_stall_in_5)) & (~(local_bb1_c0_exit_c0_exi7_valid_out_6_NO_SHIFT_REG) | ~(local_bb1_c0_exit_c0_exi7_stall_in_6)));
assign local_bb1_c0_exi7_stall_in = 1'b0;
assign local_bb1_c0_exit_c0_exi7_causedstall = (1'b1 && (1'b0 && !(~(local_bb1_c0_exit_c0_exi7_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG <= 'x;
		local_bb1_c0_exit_c0_exi7_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exit_c0_exi7_valid_out_1_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exit_c0_exi7_valid_out_2_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exit_c0_exi7_valid_out_3_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exit_c0_exi7_valid_out_4_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exit_c0_exi7_valid_out_5_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exit_c0_exi7_valid_out_6_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb1_c0_exit_c0_exi7_output_regs_ready)
		begin
			local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi7_in;
			local_bb1_c0_exit_c0_exi7_valid_out_0_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi7_valid;
			local_bb1_c0_exit_c0_exi7_valid_out_1_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi7_valid;
			local_bb1_c0_exit_c0_exi7_valid_out_2_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi7_valid;
			local_bb1_c0_exit_c0_exi7_valid_out_3_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi7_valid;
			local_bb1_c0_exit_c0_exi7_valid_out_4_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi7_valid;
			local_bb1_c0_exit_c0_exi7_valid_out_5_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi7_valid;
			local_bb1_c0_exit_c0_exi7_valid_out_6_NO_SHIFT_REG <= local_bb1_c0_exit_c0_exi7_valid;
		end
		else
		begin
			if (~(local_bb1_c0_exit_c0_exi7_stall_in_0))
			begin
				local_bb1_c0_exit_c0_exi7_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_exit_c0_exi7_stall_in_1))
			begin
				local_bb1_c0_exit_c0_exi7_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_exit_c0_exi7_stall_in_2))
			begin
				local_bb1_c0_exit_c0_exi7_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_exit_c0_exi7_stall_in_3))
			begin
				local_bb1_c0_exit_c0_exi7_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_exit_c0_exi7_stall_in_4))
			begin
				local_bb1_c0_exit_c0_exi7_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_exit_c0_exi7_stall_in_5))
			begin
				local_bb1_c0_exit_c0_exi7_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(local_bb1_c0_exit_c0_exi7_stall_in_6))
			begin
				local_bb1_c0_exit_c0_exi7_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe1_stall_local;
wire [31:0] local_bb1_c0_exe1;

assign local_bb1_c0_exe1 = local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG[63:32];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe2_stall_local;
wire local_bb1_c0_exe2;

assign local_bb1_c0_exe2 = local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG[64];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe3_stall_local;
wire [31:0] local_bb1_c0_exe3;

assign local_bb1_c0_exe3 = local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG[127:96];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe4_stall_local;
wire [31:0] local_bb1_c0_exe4;

assign local_bb1_c0_exe4 = local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG[159:128];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe5_stall_local;
wire [31:0] local_bb1_c0_exe5;

assign local_bb1_c0_exe5 = local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG[191:160];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe6_stall_local;
wire [63:0] local_bb1_c0_exe6;

assign local_bb1_c0_exe6 = local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG[255:192];

// This section implements an unregistered operation.
// 
wire local_bb1_c0_exe7_valid_out;
wire local_bb1_c0_exe7_stall_in;
 reg local_bb1_c0_exe7_consumed_0_NO_SHIFT_REG;
wire local_bb1_c0_exe6_valid_out;
wire local_bb1_c0_exe6_stall_in;
 reg local_bb1_c0_exe6_consumed_0_NO_SHIFT_REG;
wire local_bb1_c0_exe5_valid_out;
wire local_bb1_c0_exe5_stall_in;
 reg local_bb1_c0_exe5_consumed_0_NO_SHIFT_REG;
wire local_bb1_c0_exe4_valid_out;
wire local_bb1_c0_exe4_stall_in;
 reg local_bb1_c0_exe4_consumed_0_NO_SHIFT_REG;
wire local_bb1_c0_exe3_valid_out;
wire local_bb1_c0_exe3_stall_in;
 reg local_bb1_c0_exe3_consumed_0_NO_SHIFT_REG;
wire local_bb1_c0_exe2_valid_out;
wire local_bb1_c0_exe2_stall_in;
 reg local_bb1_c0_exe2_consumed_0_NO_SHIFT_REG;
wire local_bb1_c0_exe1_valid_out;
wire local_bb1_c0_exe1_stall_in;
 reg local_bb1_c0_exe1_consumed_0_NO_SHIFT_REG;
wire local_bb1_c0_exe7_inputs_ready;
wire local_bb1_c0_exe7_stall_local;
wire local_bb1_c0_exe7;

assign local_bb1_c0_exe7_inputs_ready = (local_bb1_c0_exit_c0_exi7_valid_out_6_NO_SHIFT_REG & local_bb1_c0_exit_c0_exi7_valid_out_5_NO_SHIFT_REG & local_bb1_c0_exit_c0_exi7_valid_out_4_NO_SHIFT_REG & local_bb1_c0_exit_c0_exi7_valid_out_3_NO_SHIFT_REG & local_bb1_c0_exit_c0_exi7_valid_out_2_NO_SHIFT_REG & local_bb1_c0_exit_c0_exi7_valid_out_1_NO_SHIFT_REG & local_bb1_c0_exit_c0_exi7_valid_out_0_NO_SHIFT_REG);
assign local_bb1_c0_exe7 = local_bb1_c0_exit_c0_exi7_NO_SHIFT_REG[256];
assign local_bb1_c0_exe7_stall_local = ((local_bb1_c0_exe7_stall_in & ~(local_bb1_c0_exe7_consumed_0_NO_SHIFT_REG)) | (local_bb1_c0_exe6_stall_in & ~(local_bb1_c0_exe6_consumed_0_NO_SHIFT_REG)) | (local_bb1_c0_exe5_stall_in & ~(local_bb1_c0_exe5_consumed_0_NO_SHIFT_REG)) | (local_bb1_c0_exe4_stall_in & ~(local_bb1_c0_exe4_consumed_0_NO_SHIFT_REG)) | (local_bb1_c0_exe3_stall_in & ~(local_bb1_c0_exe3_consumed_0_NO_SHIFT_REG)) | (local_bb1_c0_exe2_stall_in & ~(local_bb1_c0_exe2_consumed_0_NO_SHIFT_REG)) | (local_bb1_c0_exe1_stall_in & ~(local_bb1_c0_exe1_consumed_0_NO_SHIFT_REG)));
assign local_bb1_c0_exe7_valid_out = (local_bb1_c0_exe7_inputs_ready & ~(local_bb1_c0_exe7_consumed_0_NO_SHIFT_REG));
assign local_bb1_c0_exe6_valid_out = (local_bb1_c0_exe7_inputs_ready & ~(local_bb1_c0_exe6_consumed_0_NO_SHIFT_REG));
assign local_bb1_c0_exe5_valid_out = (local_bb1_c0_exe7_inputs_ready & ~(local_bb1_c0_exe5_consumed_0_NO_SHIFT_REG));
assign local_bb1_c0_exe4_valid_out = (local_bb1_c0_exe7_inputs_ready & ~(local_bb1_c0_exe4_consumed_0_NO_SHIFT_REG));
assign local_bb1_c0_exe3_valid_out = (local_bb1_c0_exe7_inputs_ready & ~(local_bb1_c0_exe3_consumed_0_NO_SHIFT_REG));
assign local_bb1_c0_exe2_valid_out = (local_bb1_c0_exe7_inputs_ready & ~(local_bb1_c0_exe2_consumed_0_NO_SHIFT_REG));
assign local_bb1_c0_exe1_valid_out = (local_bb1_c0_exe7_inputs_ready & ~(local_bb1_c0_exe1_consumed_0_NO_SHIFT_REG));
assign local_bb1_c0_exit_c0_exi7_stall_in_6 = (local_bb1_c0_exe7_stall_local | ~(local_bb1_c0_exe7_inputs_ready));
assign local_bb1_c0_exit_c0_exi7_stall_in_5 = (local_bb1_c0_exe7_stall_local | ~(local_bb1_c0_exe7_inputs_ready));
assign local_bb1_c0_exit_c0_exi7_stall_in_4 = (local_bb1_c0_exe7_stall_local | ~(local_bb1_c0_exe7_inputs_ready));
assign local_bb1_c0_exit_c0_exi7_stall_in_3 = (local_bb1_c0_exe7_stall_local | ~(local_bb1_c0_exe7_inputs_ready));
assign local_bb1_c0_exit_c0_exi7_stall_in_2 = (local_bb1_c0_exe7_stall_local | ~(local_bb1_c0_exe7_inputs_ready));
assign local_bb1_c0_exit_c0_exi7_stall_in_1 = (local_bb1_c0_exe7_stall_local | ~(local_bb1_c0_exe7_inputs_ready));
assign local_bb1_c0_exit_c0_exi7_stall_in_0 = (local_bb1_c0_exe7_stall_local | ~(local_bb1_c0_exe7_inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb1_c0_exe7_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exe6_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exe5_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exe4_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exe3_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exe2_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb1_c0_exe1_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb1_c0_exe7_consumed_0_NO_SHIFT_REG <= (local_bb1_c0_exe7_inputs_ready & (local_bb1_c0_exe7_consumed_0_NO_SHIFT_REG | ~(local_bb1_c0_exe7_stall_in)) & local_bb1_c0_exe7_stall_local);
		local_bb1_c0_exe6_consumed_0_NO_SHIFT_REG <= (local_bb1_c0_exe7_inputs_ready & (local_bb1_c0_exe6_consumed_0_NO_SHIFT_REG | ~(local_bb1_c0_exe6_stall_in)) & local_bb1_c0_exe7_stall_local);
		local_bb1_c0_exe5_consumed_0_NO_SHIFT_REG <= (local_bb1_c0_exe7_inputs_ready & (local_bb1_c0_exe5_consumed_0_NO_SHIFT_REG | ~(local_bb1_c0_exe5_stall_in)) & local_bb1_c0_exe7_stall_local);
		local_bb1_c0_exe4_consumed_0_NO_SHIFT_REG <= (local_bb1_c0_exe7_inputs_ready & (local_bb1_c0_exe4_consumed_0_NO_SHIFT_REG | ~(local_bb1_c0_exe4_stall_in)) & local_bb1_c0_exe7_stall_local);
		local_bb1_c0_exe3_consumed_0_NO_SHIFT_REG <= (local_bb1_c0_exe7_inputs_ready & (local_bb1_c0_exe3_consumed_0_NO_SHIFT_REG | ~(local_bb1_c0_exe3_stall_in)) & local_bb1_c0_exe7_stall_local);
		local_bb1_c0_exe2_consumed_0_NO_SHIFT_REG <= (local_bb1_c0_exe7_inputs_ready & (local_bb1_c0_exe2_consumed_0_NO_SHIFT_REG | ~(local_bb1_c0_exe2_stall_in)) & local_bb1_c0_exe7_stall_local);
		local_bb1_c0_exe1_consumed_0_NO_SHIFT_REG <= (local_bb1_c0_exe7_inputs_ready & (local_bb1_c0_exe1_consumed_0_NO_SHIFT_REG | ~(local_bb1_c0_exe1_stall_in)) & local_bb1_c0_exe7_stall_local);
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_bb1_c0_exe1_reg_NO_SHIFT_REG;
 reg lvb_bb1_c0_exe2_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb1_c0_exe3_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb1_c0_exe4_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb1_c0_exe5_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb1_c0_exe6_reg_NO_SHIFT_REG;
 reg lvb_bb1_c0_exe7_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb1_c0_exe7_valid_out & local_bb1_c0_exe6_valid_out & local_bb1_c0_exe5_valid_out & local_bb1_c0_exe4_valid_out & local_bb1_c0_exe3_valid_out & local_bb1_c0_exe2_valid_out & local_bb1_c0_exe1_valid_out & rnode_42to43_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb1_c0_exe7_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_c0_exe6_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_c0_exe5_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_c0_exe4_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_c0_exe3_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_c0_exe2_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_c0_exe1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_42to43_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb1_c0_exe1 = lvb_bb1_c0_exe1_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe2 = lvb_bb1_c0_exe2_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe3 = lvb_bb1_c0_exe3_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe4 = lvb_bb1_c0_exe4_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe5 = lvb_bb1_c0_exe5_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe6 = lvb_bb1_c0_exe6_reg_NO_SHIFT_REG;
assign lvb_bb1_c0_exe7 = lvb_bb1_c0_exe7_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_bb1_c0_exe1_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_c0_exe2_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_c0_exe3_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_c0_exe4_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_c0_exe5_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_c0_exe6_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_c0_exe7_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb1_c0_exe1_reg_NO_SHIFT_REG <= local_bb1_c0_exe1;
			lvb_bb1_c0_exe2_reg_NO_SHIFT_REG <= local_bb1_c0_exe2;
			lvb_bb1_c0_exe3_reg_NO_SHIFT_REG <= local_bb1_c0_exe3;
			lvb_bb1_c0_exe4_reg_NO_SHIFT_REG <= local_bb1_c0_exe4;
			lvb_bb1_c0_exe5_reg_NO_SHIFT_REG <= local_bb1_c0_exe5;
			lvb_bb1_c0_exe6_reg_NO_SHIFT_REG <= local_bb1_c0_exe6;
			lvb_bb1_c0_exe7_reg_NO_SHIFT_REG <= local_bb1_c0_exe7;
			lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= rnode_42to43_input_acl_hw_wg_id_0_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_2
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_data,
		input 		valid_in_0,
		output 		stall_out_0,
		input [31:0] 		input_c0_exe1_0,
		input 		input_c0_exe2_0,
		input [31:0] 		input_c0_exe3_0,
		input [31:0] 		input_c0_exe4_0,
		input [63:0] 		input_c0_exe6_0,
		input 		input_c0_exe7_0,
		input [63:0] 		input_indvars_iv21_0,
		input [31:0] 		input_right_lower_0_ph_0,
		input [31:0] 		input_temp_index_0_ph_0,
		input [63:0] 		input_var__0,
		input [31:0] 		input_acl_hw_wg_id_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [31:0] 		input_c0_exe1_1,
		input 		input_c0_exe2_1,
		input [31:0] 		input_c0_exe3_1,
		input [31:0] 		input_c0_exe4_1,
		input [63:0] 		input_c0_exe6_1,
		input 		input_c0_exe7_1,
		input [63:0] 		input_indvars_iv21_1,
		input [31:0] 		input_right_lower_0_ph_1,
		input [31:0] 		input_temp_index_0_ph_1,
		input [63:0] 		input_var__1,
		input [31:0] 		input_acl_hw_wg_id_1,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_c0_exe1,
		output 		lvb_c0_exe2,
		output [31:0] 		lvb_c0_exe3,
		output [31:0] 		lvb_c0_exe4,
		output [63:0] 		lvb_c0_exe6,
		output 		lvb_c0_exe7,
		output [63:0] 		lvb_indvars_iv21,
		output [31:0] 		lvb_right_lower_0_ph,
		output [31:0] 		lvb_temp_index_0_ph,
		output [63:0] 		lvb_var_,
		output [63:0] 		lvb_bb2_var_,
		output 		lvb_bb2_cmp4,
		output 		lvb_bb2_var__u1,
		output [31:0] 		lvb_bb2_ld_,
		output [31:0] 		lvb_input_acl_hw_wg_id,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb2_ld__readdata,
		input 		avm_local_bb2_ld__readdatavalid,
		input 		avm_local_bb2_ld__waitrequest,
		output [29:0] 		avm_local_bb2_ld__address,
		output 		avm_local_bb2_ld__read,
		output 		avm_local_bb2_ld__write,
		input 		avm_local_bb2_ld__writeack,
		output [255:0] 		avm_local_bb2_ld__writedata,
		output [31:0] 		avm_local_bb2_ld__byteenable,
		output [4:0] 		avm_local_bb2_ld__burstcount,
		output 		local_bb2_ld__active,
		input 		clock2x
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_node_stall_in_5;
 reg merge_node_valid_out_5_NO_SHIFT_REG;
wire merge_node_stall_in_6;
 reg merge_node_valid_out_6_NO_SHIFT_REG;
wire merge_node_stall_in_7;
 reg merge_node_valid_out_7_NO_SHIFT_REG;
wire merge_node_stall_in_8;
 reg merge_node_valid_out_8_NO_SHIFT_REG;
wire merge_node_stall_in_9;
 reg merge_node_valid_out_9_NO_SHIFT_REG;
wire merge_node_stall_in_10;
 reg merge_node_valid_out_10_NO_SHIFT_REG;
wire merge_node_stall_in_11;
 reg merge_node_valid_out_11_NO_SHIFT_REG;
wire merge_node_stall_in_12;
 reg merge_node_valid_out_12_NO_SHIFT_REG;
wire merge_node_stall_in_13;
 reg merge_node_valid_out_13_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_0_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe2_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe4_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_c0_exe6_0_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv21_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_right_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_temp_index_0_ph_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_var__0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe1_NO_SHIFT_REG;
 reg local_lvm_c0_exe2_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe3_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe4_NO_SHIFT_REG;
 reg [63:0] local_lvm_c0_exe6_NO_SHIFT_REG;
 reg local_lvm_c0_exe7_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv21_NO_SHIFT_REG;
 reg [31:0] local_lvm_right_lower_0_ph_NO_SHIFT_REG;
 reg [31:0] local_lvm_temp_index_0_ph_NO_SHIFT_REG;
 reg [63:0] local_lvm_var__NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_1_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe2_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe4_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_c0_exe6_1_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv21_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_right_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_temp_index_0_ph_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_var__1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG) | (merge_node_stall_in_9 & merge_node_valid_out_9_NO_SHIFT_REG) | (merge_node_stall_in_10 & merge_node_valid_out_10_NO_SHIFT_REG) | (merge_node_stall_in_11 & merge_node_valid_out_11_NO_SHIFT_REG) | (merge_node_stall_in_12 & merge_node_valid_out_12_NO_SHIFT_REG) | (merge_node_stall_in_13 & merge_node_valid_out_13_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_c0_exe1_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe3_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe4_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv21_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_c0_exe1_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe3_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe4_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv21_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe1_0_staging_reg_NO_SHIFT_REG <= input_c0_exe1_0;
				input_c0_exe2_0_staging_reg_NO_SHIFT_REG <= input_c0_exe2_0;
				input_c0_exe3_0_staging_reg_NO_SHIFT_REG <= input_c0_exe3_0;
				input_c0_exe4_0_staging_reg_NO_SHIFT_REG <= input_c0_exe4_0;
				input_c0_exe6_0_staging_reg_NO_SHIFT_REG <= input_c0_exe6_0;
				input_c0_exe7_0_staging_reg_NO_SHIFT_REG <= input_c0_exe7_0;
				input_indvars_iv21_0_staging_reg_NO_SHIFT_REG <= input_indvars_iv21_0;
				input_right_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph_0;
				input_temp_index_0_ph_0_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph_0;
				input_var__0_staging_reg_NO_SHIFT_REG <= input_var__0;
				input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe1_1_staging_reg_NO_SHIFT_REG <= input_c0_exe1_1;
				input_c0_exe2_1_staging_reg_NO_SHIFT_REG <= input_c0_exe2_1;
				input_c0_exe3_1_staging_reg_NO_SHIFT_REG <= input_c0_exe3_1;
				input_c0_exe4_1_staging_reg_NO_SHIFT_REG <= input_c0_exe4_1;
				input_c0_exe6_1_staging_reg_NO_SHIFT_REG <= input_c0_exe6_1;
				input_c0_exe7_1_staging_reg_NO_SHIFT_REG <= input_c0_exe7_1;
				input_indvars_iv21_1_staging_reg_NO_SHIFT_REG <= input_indvars_iv21_1;
				input_right_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph_1;
				input_temp_index_0_ph_1_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph_1;
				input_var__1_staging_reg_NO_SHIFT_REG <= input_var__1;
				input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_0_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph_NO_SHIFT_REG <= input_right_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph_NO_SHIFT_REG <= input_temp_index_0_ph_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_0;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_0;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_0;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_0;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_0;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_0;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_0;
					local_lvm_right_lower_0_ph_NO_SHIFT_REG <= input_right_lower_0_ph_0;
					local_lvm_temp_index_0_ph_NO_SHIFT_REG <= input_temp_index_0_ph_0;
					local_lvm_var__NO_SHIFT_REG <= input_var__0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_1_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph_NO_SHIFT_REG <= input_right_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph_NO_SHIFT_REG <= input_temp_index_0_ph_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_1;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_1;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_1;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_1;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_1;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_1;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_1;
					local_lvm_right_lower_0_ph_NO_SHIFT_REG <= input_right_lower_0_ph_1;
					local_lvm_temp_index_0_ph_NO_SHIFT_REG <= input_temp_index_0_ph_1;
					local_lvm_var__NO_SHIFT_REG <= input_var__1;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_9_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_10_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_11_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_12_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_13_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_5_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_6_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_7_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_8_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_9_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_10_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_11_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_12_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_13_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_5))
			begin
				merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_6))
			begin
				merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_7))
			begin
				merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_8))
			begin
				merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_9))
			begin
				merge_node_valid_out_9_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_10))
			begin
				merge_node_valid_out_10_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_11))
			begin
				merge_node_valid_out_11_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_12))
			begin
				merge_node_valid_out_12_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_13))
			begin
				merge_node_valid_out_13_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb2_var__u2_stall_local;
wire [31:0] local_bb2_var__u2;

assign local_bb2_var__u2 = local_lvm_indvars_iv21_NO_SHIFT_REG[31:0];

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_right_lower_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_right_lower_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_right_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_1to161_right_lower_0_ph_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_right_lower_0_ph_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_right_lower_0_ph_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_right_lower_0_ph_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_right_lower_0_ph_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_right_lower_0_ph_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_right_lower_0_ph_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_right_lower_0_ph_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_right_lower_0_ph_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_right_lower_0_ph_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_right_lower_0_ph_NO_SHIFT_REG),
	.data_out(rnode_1to161_right_lower_0_ph_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_right_lower_0_ph_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_right_lower_0_ph_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_1to161_right_lower_0_ph_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_right_lower_0_ph_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_right_lower_0_ph_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to161_right_lower_0_ph_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_right_lower_0_ph_0_NO_SHIFT_REG = rnode_1to161_right_lower_0_ph_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_right_lower_0_ph_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_right_lower_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_right_lower_0_ph_0_valid_out_NO_SHIFT_REG = rnode_1to161_right_lower_0_ph_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_input_data_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_input_data_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_input_data_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_input_data_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_input_data_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_input_data_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_1to2_input_data_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_input_data_0_reg_2_fifo.DATA_WIDTH = 0;
defparam rnode_1to2_input_data_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_input_data_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_input_data_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to2_input_data_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_input_data_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_input_data_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_input_data_0_valid_out_NO_SHIFT_REG = rnode_1to2_input_data_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_c0_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_c0_exe1_0_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe1_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_c0_exe1_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe1_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe1_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe1_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_c0_exe1_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_c0_exe1_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_c0_exe1_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_c0_exe1_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_c0_exe1_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe1_NO_SHIFT_REG),
	.data_out(rnode_1to161_c0_exe1_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_c0_exe1_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_c0_exe1_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_1to161_c0_exe1_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_c0_exe1_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_c0_exe1_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to161_c0_exe1_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe1_0_NO_SHIFT_REG = rnode_1to161_c0_exe1_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe1_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_c0_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_c0_exe1_0_valid_out_NO_SHIFT_REG = rnode_1to161_c0_exe1_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_c0_exe2_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe2_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe2_0_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe2_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe2_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe2_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe2_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe2_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_c0_exe2_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_c0_exe2_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_c0_exe2_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_c0_exe2_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_c0_exe2_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe2_NO_SHIFT_REG),
	.data_out(rnode_1to161_c0_exe2_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_c0_exe2_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_c0_exe2_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_1to161_c0_exe2_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_c0_exe2_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_c0_exe2_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to161_c0_exe2_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe2_0_NO_SHIFT_REG = rnode_1to161_c0_exe2_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe2_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_c0_exe2_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_c0_exe2_0_valid_out_NO_SHIFT_REG = rnode_1to161_c0_exe2_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe3_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_c0_exe3_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe3_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe3_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe3_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_c0_exe3_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_c0_exe3_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_c0_exe3_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_c0_exe3_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_c0_exe3_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe3_NO_SHIFT_REG),
	.data_out(rnode_1to161_c0_exe3_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_c0_exe3_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_c0_exe3_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_1to161_c0_exe3_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_c0_exe3_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_c0_exe3_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to161_c0_exe3_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe3_0_NO_SHIFT_REG = rnode_1to161_c0_exe3_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe3_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_1to161_c0_exe3_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_c0_exe4_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_c0_exe4_0_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe4_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_c0_exe4_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe4_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe4_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe4_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_c0_exe4_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_c0_exe4_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_c0_exe4_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_c0_exe4_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_c0_exe4_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe4_NO_SHIFT_REG),
	.data_out(rnode_1to161_c0_exe4_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_c0_exe4_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_c0_exe4_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_1to161_c0_exe4_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_c0_exe4_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_c0_exe4_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to161_c0_exe4_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe4_0_NO_SHIFT_REG = rnode_1to161_c0_exe4_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe4_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_c0_exe4_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_c0_exe4_0_valid_out_NO_SHIFT_REG = rnode_1to161_c0_exe4_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_c0_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to161_c0_exe6_0_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe6_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to161_c0_exe6_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe6_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe6_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_c0_exe6_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_c0_exe6_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_c0_exe6_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_c0_exe6_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_c0_exe6_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_c0_exe6_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe6_NO_SHIFT_REG),
	.data_out(rnode_1to161_c0_exe6_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_c0_exe6_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_c0_exe6_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_1to161_c0_exe6_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_c0_exe6_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_c0_exe6_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to161_c0_exe6_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe6_0_NO_SHIFT_REG = rnode_1to161_c0_exe6_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_c0_exe6_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_c0_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_c0_exe6_0_valid_out_NO_SHIFT_REG = rnode_1to161_c0_exe6_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_temp_index_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_temp_index_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_temp_index_0_ph_0_NO_SHIFT_REG;
 logic rnode_1to161_temp_index_0_ph_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_temp_index_0_ph_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_temp_index_0_ph_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_temp_index_0_ph_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_temp_index_0_ph_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_temp_index_0_ph_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_temp_index_0_ph_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_temp_index_0_ph_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_temp_index_0_ph_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_temp_index_0_ph_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_temp_index_0_ph_NO_SHIFT_REG),
	.data_out(rnode_1to161_temp_index_0_ph_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_temp_index_0_ph_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_temp_index_0_ph_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_1to161_temp_index_0_ph_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_temp_index_0_ph_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_temp_index_0_ph_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_9_NO_SHIFT_REG;
assign merge_node_stall_in_9 = rnode_1to161_temp_index_0_ph_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_temp_index_0_ph_0_NO_SHIFT_REG = rnode_1to161_temp_index_0_ph_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_temp_index_0_ph_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_temp_index_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_temp_index_0_ph_0_valid_out_NO_SHIFT_REG = rnode_1to161_temp_index_0_ph_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_var__0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to161_var__0_NO_SHIFT_REG;
 logic rnode_1to161_var__0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to161_var__0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_var__0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_var__0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_var__0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_var__0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_var__0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_var__0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_var__0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_var__0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_var__NO_SHIFT_REG),
	.data_out(rnode_1to161_var__0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_var__0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_var__0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_1to161_var__0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_var__0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_var__0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_10_NO_SHIFT_REG;
assign merge_node_stall_in_10 = rnode_1to161_var__0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_var__0_NO_SHIFT_REG = rnode_1to161_var__0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_var__0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_var__0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_var__0_valid_out_NO_SHIFT_REG = rnode_1to161_var__0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to161_input_acl_hw_wg_id_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_input_acl_hw_wg_id_0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_input_acl_hw_wg_id_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_input_acl_hw_wg_id_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_input_acl_hw_wg_id_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_input_acl_hw_wg_id_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_input_acl_hw_wg_id_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_input_acl_hw_wg_id_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_input_acl_hw_wg_id_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_input_acl_hw_wg_id_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to161_input_acl_hw_wg_id_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_input_acl_hw_wg_id_0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_input_acl_hw_wg_id_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_1to161_input_acl_hw_wg_id_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_input_acl_hw_wg_id_0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_input_acl_hw_wg_id_0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_11_NO_SHIFT_REG;
assign merge_node_stall_in_11 = rnode_1to161_input_acl_hw_wg_id_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to161_input_acl_hw_wg_id_0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_input_acl_hw_wg_id_0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to161_input_acl_hw_wg_id_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_indvars_iv21_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv21_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_indvars_iv21_0_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv21_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv21_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_indvars_iv21_1_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv21_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_indvars_iv21_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv21_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv21_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv21_0_stall_out_reg_2_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_indvars_iv21_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_indvars_iv21_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_indvars_iv21_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_indvars_iv21_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_indvars_iv21_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_indvars_iv21_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_indvars_iv21_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_indvars_iv21_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_indvars_iv21_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_indvars_iv21_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_indvars_iv21_0_reg_2_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_1to2_indvars_iv21_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_indvars_iv21_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_indvars_iv21_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_indvars_iv21_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_indvars_iv21_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_indvars_iv21_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv21_NO_SHIFT_REG),
	.data_out(rnode_1to2_indvars_iv21_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_indvars_iv21_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_indvars_iv21_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_indvars_iv21_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_indvars_iv21_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_indvars_iv21_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_12_NO_SHIFT_REG;
assign merge_node_stall_in_12 = rnode_1to2_indvars_iv21_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_indvars_iv21_0_NO_SHIFT_REG = rnode_1to2_indvars_iv21_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_indvars_iv21_1_NO_SHIFT_REG = rnode_1to2_indvars_iv21_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_c0_exe7_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_1_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_c0_exe7_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_c0_exe7_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_c0_exe7_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_c0_exe7_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_c0_exe7_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_c0_exe7_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_c0_exe7_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_c0_exe7_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_c0_exe7_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_c0_exe7_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_c0_exe7_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_c0_exe7_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_c0_exe7_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_c0_exe7_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe7_NO_SHIFT_REG),
	.data_out(rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_c0_exe7_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_c0_exe7_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_c0_exe7_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_c0_exe7_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_c0_exe7_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_13_NO_SHIFT_REG;
assign merge_node_stall_in_13 = rnode_1to2_c0_exe7_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_c0_exe7_0_NO_SHIFT_REG = rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_c0_exe7_1_NO_SHIFT_REG = rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb2_cmp4_valid_out;
wire local_bb2_cmp4_stall_in;
wire local_bb2_cmp4_inputs_ready;
wire local_bb2_cmp4_stall_local;
wire local_bb2_cmp4;

assign local_bb2_cmp4_inputs_ready = (merge_node_valid_out_0_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG);
assign local_bb2_cmp4 = ($signed(local_bb2_var__u2) > $signed(local_lvm_c0_exe4_NO_SHIFT_REG));
assign local_bb2_cmp4_valid_out = local_bb2_cmp4_inputs_ready;
assign local_bb2_cmp4_stall_local = local_bb2_cmp4_stall_in;
assign merge_node_stall_in_0 = (local_bb2_cmp4_stall_local | ~(local_bb2_cmp4_inputs_ready));
assign merge_node_stall_in_1 = (local_bb2_cmp4_stall_local | ~(local_bb2_cmp4_inputs_ready));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_right_lower_0_ph_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_161to162_right_lower_0_ph_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_161to162_right_lower_0_ph_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_161to162_right_lower_0_ph_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_right_lower_0_ph_1_NO_SHIFT_REG;
 logic rnode_161to162_right_lower_0_ph_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_right_lower_0_ph_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_right_lower_0_ph_0_valid_out_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_right_lower_0_ph_0_stall_in_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_right_lower_0_ph_0_stall_out_reg_162_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_right_lower_0_ph_0_reg_162_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_161to162_right_lower_0_ph_0_reg_162_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_161to162_right_lower_0_ph_0_reg_162_NO_SHIFT_REG),
	.valid_in(rnode_161to162_right_lower_0_ph_0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_right_lower_0_ph_0_stall_in_0_reg_162_NO_SHIFT_REG),
	.data_out(rnode_161to162_right_lower_0_ph_0_reg_162_NO_SHIFT_REG_fa),
	.valid_out({rnode_161to162_right_lower_0_ph_0_valid_out_0_NO_SHIFT_REG, rnode_161to162_right_lower_0_ph_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_161to162_right_lower_0_ph_0_stall_in_0_NO_SHIFT_REG, rnode_161to162_right_lower_0_ph_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_161to162_right_lower_0_ph_0_reg_162_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_161to162_right_lower_0_ph_0_reg_162_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_161to162_right_lower_0_ph_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_right_lower_0_ph_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_right_lower_0_ph_0_stall_in_0_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_right_lower_0_ph_0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_right_lower_0_ph_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_right_lower_0_ph_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_right_lower_0_ph_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_right_lower_0_ph_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_right_lower_0_ph_0_reg_162_fifo.DATA_WIDTH = 32;
defparam rnode_161to162_right_lower_0_ph_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_right_lower_0_ph_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_right_lower_0_ph_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_right_lower_0_ph_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_right_lower_0_ph_0_stall_in_NO_SHIFT_REG = rnode_161to162_right_lower_0_ph_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG = rnode_161to162_right_lower_0_ph_0_reg_162_NO_SHIFT_REG_fa;
assign rnode_161to162_right_lower_0_ph_1_NO_SHIFT_REG = rnode_161to162_right_lower_0_ph_0_reg_162_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_c0_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_c0_exe1_0_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe1_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_c0_exe1_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe1_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe1_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe1_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_c0_exe1_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_c0_exe1_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_c0_exe1_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_c0_exe1_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_c0_exe1_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_c0_exe1_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_c0_exe1_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_c0_exe1_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_c0_exe1_0_reg_162_fifo.DATA_WIDTH = 32;
defparam rnode_161to162_c0_exe1_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_c0_exe1_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_c0_exe1_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_c0_exe1_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_c0_exe1_0_stall_in_NO_SHIFT_REG = rnode_161to162_c0_exe1_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe1_0_NO_SHIFT_REG = rnode_161to162_c0_exe1_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe1_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_c0_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_c0_exe1_0_valid_out_NO_SHIFT_REG = rnode_161to162_c0_exe1_0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_c0_exe2_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe2_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe2_0_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe2_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe2_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe2_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe2_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe2_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_c0_exe2_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_c0_exe2_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_c0_exe2_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_c0_exe2_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_c0_exe2_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_c0_exe2_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_c0_exe2_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_c0_exe2_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_c0_exe2_0_reg_162_fifo.DATA_WIDTH = 1;
defparam rnode_161to162_c0_exe2_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_c0_exe2_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_c0_exe2_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_c0_exe2_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_c0_exe2_0_stall_in_NO_SHIFT_REG = rnode_161to162_c0_exe2_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe2_0_NO_SHIFT_REG = rnode_161to162_c0_exe2_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe2_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_c0_exe2_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_c0_exe2_0_valid_out_NO_SHIFT_REG = rnode_161to162_c0_exe2_0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe3_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_c0_exe3_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe3_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe3_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe3_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_c0_exe3_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_c0_exe3_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_c0_exe3_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_c0_exe3_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_c0_exe3_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_c0_exe3_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_c0_exe3_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_c0_exe3_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_c0_exe3_0_reg_162_fifo.DATA_WIDTH = 32;
defparam rnode_161to162_c0_exe3_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_c0_exe3_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_c0_exe3_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_c0_exe3_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_c0_exe3_0_stall_in_NO_SHIFT_REG = rnode_161to162_c0_exe3_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe3_0_NO_SHIFT_REG = rnode_161to162_c0_exe3_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe3_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_161to162_c0_exe3_0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_c0_exe4_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_c0_exe4_0_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe4_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_c0_exe4_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe4_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe4_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe4_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_c0_exe4_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_c0_exe4_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_c0_exe4_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_c0_exe4_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_c0_exe4_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_c0_exe4_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_c0_exe4_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_c0_exe4_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_c0_exe4_0_reg_162_fifo.DATA_WIDTH = 32;
defparam rnode_161to162_c0_exe4_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_c0_exe4_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_c0_exe4_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_c0_exe4_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_c0_exe4_0_stall_in_NO_SHIFT_REG = rnode_161to162_c0_exe4_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe4_0_NO_SHIFT_REG = rnode_161to162_c0_exe4_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe4_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_c0_exe4_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_c0_exe4_0_valid_out_NO_SHIFT_REG = rnode_161to162_c0_exe4_0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_c0_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_161to162_c0_exe6_0_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe6_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_161to162_c0_exe6_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe6_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe6_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe6_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_c0_exe6_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_c0_exe6_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_c0_exe6_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_c0_exe6_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_c0_exe6_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_c0_exe6_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_c0_exe6_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_c0_exe6_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_c0_exe6_0_reg_162_fifo.DATA_WIDTH = 64;
defparam rnode_161to162_c0_exe6_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_c0_exe6_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_c0_exe6_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_c0_exe6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_c0_exe6_0_stall_in_NO_SHIFT_REG = rnode_161to162_c0_exe6_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe6_0_NO_SHIFT_REG = rnode_161to162_c0_exe6_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe6_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_c0_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_c0_exe6_0_valid_out_NO_SHIFT_REG = rnode_161to162_c0_exe6_0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_temp_index_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_temp_index_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_temp_index_0_ph_0_NO_SHIFT_REG;
 logic rnode_161to162_temp_index_0_ph_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_temp_index_0_ph_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_temp_index_0_ph_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_temp_index_0_ph_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_temp_index_0_ph_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_temp_index_0_ph_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_temp_index_0_ph_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_temp_index_0_ph_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_temp_index_0_ph_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_temp_index_0_ph_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_temp_index_0_ph_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_temp_index_0_ph_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_temp_index_0_ph_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_temp_index_0_ph_0_reg_162_fifo.DATA_WIDTH = 32;
defparam rnode_161to162_temp_index_0_ph_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_temp_index_0_ph_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_temp_index_0_ph_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_temp_index_0_ph_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_temp_index_0_ph_0_stall_in_NO_SHIFT_REG = rnode_161to162_temp_index_0_ph_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_temp_index_0_ph_0_NO_SHIFT_REG = rnode_161to162_temp_index_0_ph_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_temp_index_0_ph_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_temp_index_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_temp_index_0_ph_0_valid_out_NO_SHIFT_REG = rnode_161to162_temp_index_0_ph_0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_var__0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_161to162_var__0_NO_SHIFT_REG;
 logic rnode_161to162_var__0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_161to162_var__0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_var__0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_var__0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_var__0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_var__0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_var__0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_var__0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_var__0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_var__0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_var__0_NO_SHIFT_REG),
	.data_out(rnode_161to162_var__0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_var__0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_var__0_reg_162_fifo.DATA_WIDTH = 64;
defparam rnode_161to162_var__0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_var__0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_var__0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_var__0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_var__0_stall_in_NO_SHIFT_REG = rnode_161to162_var__0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_var__0_NO_SHIFT_REG = rnode_161to162_var__0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_var__0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_var__0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_var__0_valid_out_NO_SHIFT_REG = rnode_161to162_var__0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_161to162_input_acl_hw_wg_id_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_input_acl_hw_wg_id_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_input_acl_hw_wg_id_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_input_acl_hw_wg_id_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_input_acl_hw_wg_id_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_input_acl_hw_wg_id_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_input_acl_hw_wg_id_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_input_acl_hw_wg_id_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_input_acl_hw_wg_id_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_input_acl_hw_wg_id_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_input_acl_hw_wg_id_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_input_acl_hw_wg_id_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_input_acl_hw_wg_id_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_input_acl_hw_wg_id_0_reg_162_fifo.DATA_WIDTH = 32;
defparam rnode_161to162_input_acl_hw_wg_id_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_input_acl_hw_wg_id_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_input_acl_hw_wg_id_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = rnode_161to162_input_acl_hw_wg_id_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_161to162_input_acl_hw_wg_id_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_input_acl_hw_wg_id_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_161to162_input_acl_hw_wg_id_0_valid_out_reg_162_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb2_arrayidx11_valid_out;
wire local_bb2_arrayidx11_stall_in;
wire local_bb2_arrayidx11_inputs_ready;
wire local_bb2_arrayidx11_stall_local;
wire [63:0] local_bb2_arrayidx11;

assign local_bb2_arrayidx11_inputs_ready = (rnode_1to2_input_data_0_valid_out_NO_SHIFT_REG & rnode_1to2_indvars_iv21_0_valid_out_0_NO_SHIFT_REG);
assign local_bb2_arrayidx11 = (input_data + (rnode_1to2_indvars_iv21_0_NO_SHIFT_REG << 6'h2));
assign local_bb2_arrayidx11_valid_out = local_bb2_arrayidx11_inputs_ready;
assign local_bb2_arrayidx11_stall_local = local_bb2_arrayidx11_stall_in;
assign rnode_1to2_input_data_0_stall_in_NO_SHIFT_REG = (local_bb2_arrayidx11_stall_local | ~(local_bb2_arrayidx11_inputs_ready));
assign rnode_1to2_indvars_iv21_0_stall_in_0_NO_SHIFT_REG = (local_bb2_arrayidx11_stall_local | ~(local_bb2_arrayidx11_inputs_ready));

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_2to161_indvars_iv21_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to161_indvars_iv21_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_2to161_indvars_iv21_0_NO_SHIFT_REG;
 logic rnode_2to161_indvars_iv21_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_2to161_indvars_iv21_0_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_indvars_iv21_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_indvars_iv21_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_indvars_iv21_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_2to161_indvars_iv21_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to161_indvars_iv21_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to161_indvars_iv21_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_2to161_indvars_iv21_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_2to161_indvars_iv21_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to2_indvars_iv21_1_NO_SHIFT_REG),
	.data_out(rnode_2to161_indvars_iv21_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_2to161_indvars_iv21_0_reg_161_fifo.DEPTH = 160;
defparam rnode_2to161_indvars_iv21_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_2to161_indvars_iv21_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to161_indvars_iv21_0_reg_161_fifo.IMPL = "ram";

assign rnode_2to161_indvars_iv21_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to2_indvars_iv21_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_indvars_iv21_0_stall_in_1_NO_SHIFT_REG = rnode_2to161_indvars_iv21_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_2to161_indvars_iv21_0_NO_SHIFT_REG = rnode_2to161_indvars_iv21_0_reg_161_NO_SHIFT_REG;
assign rnode_2to161_indvars_iv21_0_stall_in_reg_161_NO_SHIFT_REG = rnode_2to161_indvars_iv21_0_stall_in_NO_SHIFT_REG;
assign rnode_2to161_indvars_iv21_0_valid_out_NO_SHIFT_REG = rnode_2to161_indvars_iv21_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_2to161_c0_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to161_c0_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to161_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_2to161_c0_exe7_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to161_c0_exe7_0_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_c0_exe7_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_c0_exe7_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_c0_exe7_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_2to161_c0_exe7_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to161_c0_exe7_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to161_c0_exe7_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_2to161_c0_exe7_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_2to161_c0_exe7_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to2_c0_exe7_1_NO_SHIFT_REG),
	.data_out(rnode_2to161_c0_exe7_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_2to161_c0_exe7_0_reg_161_fifo.DEPTH = 160;
defparam rnode_2to161_c0_exe7_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_2to161_c0_exe7_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to161_c0_exe7_0_reg_161_fifo.IMPL = "ram";

assign rnode_2to161_c0_exe7_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to2_c0_exe7_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_c0_exe7_0_stall_in_1_NO_SHIFT_REG = rnode_2to161_c0_exe7_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_2to161_c0_exe7_0_NO_SHIFT_REG = rnode_2to161_c0_exe7_0_reg_161_NO_SHIFT_REG;
assign rnode_2to161_c0_exe7_0_stall_in_reg_161_NO_SHIFT_REG = rnode_2to161_c0_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_2to161_c0_exe7_0_valid_out_NO_SHIFT_REG = rnode_2to161_c0_exe7_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_cmp4_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp4_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_bb2_cmp4_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_bb2_cmp4_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_bb2_cmp4_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_cmp4_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_bb2_cmp4_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_bb2_cmp4_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_bb2_cmp4_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_bb2_cmp4_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_bb2_cmp4_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_bb2_cmp4_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_bb2_cmp4_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_bb2_cmp4_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_cmp4_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_cmp4_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_cmp4_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_cmp4_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_cmp4),
	.data_out(rnode_1to2_bb2_cmp4_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_cmp4_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb2_cmp4_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb2_cmp4_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb2_cmp4_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb2_cmp4_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb2_cmp4_valid_out;
assign local_bb2_cmp4_stall_in = rnode_1to2_bb2_cmp4_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_cmp4_0_NO_SHIFT_REG = rnode_1to2_bb2_cmp4_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_bb2_cmp4_1_NO_SHIFT_REG = rnode_1to2_bb2_cmp4_0_reg_2_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb2_var__valid_out;
wire local_bb2_var__stall_in;
wire local_bb2_var__inputs_ready;
wire local_bb2_var__stall_local;
wire [63:0] local_bb2_var_;

assign local_bb2_var__inputs_ready = rnode_161to162_right_lower_0_ph_0_valid_out_0_NO_SHIFT_REG;
assign local_bb2_var_[32] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[33] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[34] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[35] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[36] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[37] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[38] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[39] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[40] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[41] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[42] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[43] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[44] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[45] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[46] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[47] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[48] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[49] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[50] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[51] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[52] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[53] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[54] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[55] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[56] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[57] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[58] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[59] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[60] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[61] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[62] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[63] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG[31];
assign local_bb2_var_[31:0] = rnode_161to162_right_lower_0_ph_0_NO_SHIFT_REG;
assign local_bb2_var__valid_out = local_bb2_var__inputs_ready;
assign local_bb2_var__stall_local = local_bb2_var__stall_in;
assign rnode_161to162_right_lower_0_ph_0_stall_in_0_NO_SHIFT_REG = (|local_bb2_var__stall_local);

// This section implements a staging register.
// 
wire rstag_2to2_bb2_arrayidx11_valid_out;
wire rstag_2to2_bb2_arrayidx11_stall_in;
wire rstag_2to2_bb2_arrayidx11_inputs_ready;
wire rstag_2to2_bb2_arrayidx11_stall_local;
 reg rstag_2to2_bb2_arrayidx11_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb2_arrayidx11_combined_valid;
 reg [63:0] rstag_2to2_bb2_arrayidx11_staging_reg_NO_SHIFT_REG;
wire [63:0] rstag_2to2_bb2_arrayidx11;

assign rstag_2to2_bb2_arrayidx11_inputs_ready = local_bb2_arrayidx11_valid_out;
assign rstag_2to2_bb2_arrayidx11 = (rstag_2to2_bb2_arrayidx11_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb2_arrayidx11_staging_reg_NO_SHIFT_REG : local_bb2_arrayidx11);
assign rstag_2to2_bb2_arrayidx11_combined_valid = (rstag_2to2_bb2_arrayidx11_staging_valid_NO_SHIFT_REG | rstag_2to2_bb2_arrayidx11_inputs_ready);
assign rstag_2to2_bb2_arrayidx11_valid_out = rstag_2to2_bb2_arrayidx11_combined_valid;
assign rstag_2to2_bb2_arrayidx11_stall_local = rstag_2to2_bb2_arrayidx11_stall_in;
assign local_bb2_arrayidx11_stall_in = (|rstag_2to2_bb2_arrayidx11_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb2_arrayidx11_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb2_arrayidx11_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb2_arrayidx11_stall_local)
		begin
			if (~(rstag_2to2_bb2_arrayidx11_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb2_arrayidx11_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb2_arrayidx11_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb2_arrayidx11_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb2_arrayidx11_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb2_arrayidx11_staging_reg_NO_SHIFT_REG <= local_bb2_arrayidx11;
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_indvars_iv21_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_indvars_iv21_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_161to162_indvars_iv21_0_NO_SHIFT_REG;
 logic rnode_161to162_indvars_iv21_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_161to162_indvars_iv21_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_indvars_iv21_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_indvars_iv21_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_indvars_iv21_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_indvars_iv21_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_indvars_iv21_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_indvars_iv21_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_indvars_iv21_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_indvars_iv21_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_2to161_indvars_iv21_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_indvars_iv21_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_indvars_iv21_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_indvars_iv21_0_reg_162_fifo.DATA_WIDTH = 64;
defparam rnode_161to162_indvars_iv21_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_indvars_iv21_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_indvars_iv21_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_2to161_indvars_iv21_0_valid_out_NO_SHIFT_REG;
assign rnode_2to161_indvars_iv21_0_stall_in_NO_SHIFT_REG = rnode_161to162_indvars_iv21_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_indvars_iv21_0_NO_SHIFT_REG = rnode_161to162_indvars_iv21_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_indvars_iv21_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_indvars_iv21_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_indvars_iv21_0_valid_out_NO_SHIFT_REG = rnode_161to162_indvars_iv21_0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_c0_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe7_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe7_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe7_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe7_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_c0_exe7_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_c0_exe7_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_c0_exe7_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_c0_exe7_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_c0_exe7_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_c0_exe7_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_2to161_c0_exe7_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_c0_exe7_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_c0_exe7_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_c0_exe7_0_reg_162_fifo.DATA_WIDTH = 1;
defparam rnode_161to162_c0_exe7_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_c0_exe7_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_c0_exe7_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_2to161_c0_exe7_0_valid_out_NO_SHIFT_REG;
assign rnode_2to161_c0_exe7_0_stall_in_NO_SHIFT_REG = rnode_161to162_c0_exe7_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe7_0_NO_SHIFT_REG = rnode_161to162_c0_exe7_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_c0_exe7_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_c0_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_c0_exe7_0_valid_out_NO_SHIFT_REG = rnode_161to162_c0_exe7_0_valid_out_reg_162_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb2_var__u1_valid_out;
wire local_bb2_var__u1_stall_in;
wire local_bb2_var__u1_inputs_ready;
wire local_bb2_var__u1_stall_local;
wire local_bb2_var__u1;

assign local_bb2_var__u1_inputs_ready = (rnode_1to2_c0_exe7_0_valid_out_0_NO_SHIFT_REG & rnode_1to2_bb2_cmp4_0_valid_out_0_NO_SHIFT_REG);
assign local_bb2_var__u1 = (rnode_1to2_bb2_cmp4_0_NO_SHIFT_REG | rnode_1to2_c0_exe7_0_NO_SHIFT_REG);
assign local_bb2_var__u1_valid_out = local_bb2_var__u1_inputs_ready;
assign local_bb2_var__u1_stall_local = local_bb2_var__u1_stall_in;
assign rnode_1to2_c0_exe7_0_stall_in_0_NO_SHIFT_REG = (local_bb2_var__u1_stall_local | ~(local_bb2_var__u1_inputs_ready));
assign rnode_1to2_bb2_cmp4_0_stall_in_0_NO_SHIFT_REG = (local_bb2_var__u1_stall_local | ~(local_bb2_var__u1_inputs_ready));

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_2to161_bb2_cmp4_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to161_bb2_cmp4_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to161_bb2_cmp4_0_NO_SHIFT_REG;
 logic rnode_2to161_bb2_cmp4_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to161_bb2_cmp4_0_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_bb2_cmp4_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_bb2_cmp4_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_bb2_cmp4_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_2to161_bb2_cmp4_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to161_bb2_cmp4_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to161_bb2_cmp4_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_2to161_bb2_cmp4_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_2to161_bb2_cmp4_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to2_bb2_cmp4_1_NO_SHIFT_REG),
	.data_out(rnode_2to161_bb2_cmp4_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_2to161_bb2_cmp4_0_reg_161_fifo.DEPTH = 160;
defparam rnode_2to161_bb2_cmp4_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_2to161_bb2_cmp4_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to161_bb2_cmp4_0_reg_161_fifo.IMPL = "ram";

assign rnode_2to161_bb2_cmp4_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to2_bb2_cmp4_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_bb2_cmp4_0_stall_in_1_NO_SHIFT_REG = rnode_2to161_bb2_cmp4_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_2to161_bb2_cmp4_0_NO_SHIFT_REG = rnode_2to161_bb2_cmp4_0_reg_161_NO_SHIFT_REG;
assign rnode_2to161_bb2_cmp4_0_stall_in_reg_161_NO_SHIFT_REG = rnode_2to161_bb2_cmp4_0_stall_in_NO_SHIFT_REG;
assign rnode_2to161_bb2_cmp4_0_valid_out_NO_SHIFT_REG = rnode_2to161_bb2_cmp4_0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_2to2_bb2_var__u1_valid_out_0;
wire rstag_2to2_bb2_var__u1_stall_in_0;
 reg rstag_2to2_bb2_var__u1_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb2_var__u1_valid_out_1;
wire rstag_2to2_bb2_var__u1_stall_in_1;
 reg rstag_2to2_bb2_var__u1_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb2_var__u1_inputs_ready;
wire rstag_2to2_bb2_var__u1_stall_local;
 reg rstag_2to2_bb2_var__u1_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb2_var__u1_combined_valid;
 reg rstag_2to2_bb2_var__u1_staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb2_var__u1;

assign rstag_2to2_bb2_var__u1_inputs_ready = local_bb2_var__u1_valid_out;
assign rstag_2to2_bb2_var__u1 = (rstag_2to2_bb2_var__u1_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb2_var__u1_staging_reg_NO_SHIFT_REG : local_bb2_var__u1);
assign rstag_2to2_bb2_var__u1_combined_valid = (rstag_2to2_bb2_var__u1_staging_valid_NO_SHIFT_REG | rstag_2to2_bb2_var__u1_inputs_ready);
assign rstag_2to2_bb2_var__u1_stall_local = ((rstag_2to2_bb2_var__u1_stall_in_0 & ~(rstag_2to2_bb2_var__u1_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb2_var__u1_stall_in_1 & ~(rstag_2to2_bb2_var__u1_consumed_1_NO_SHIFT_REG)));
assign rstag_2to2_bb2_var__u1_valid_out_0 = (rstag_2to2_bb2_var__u1_combined_valid & ~(rstag_2to2_bb2_var__u1_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb2_var__u1_valid_out_1 = (rstag_2to2_bb2_var__u1_combined_valid & ~(rstag_2to2_bb2_var__u1_consumed_1_NO_SHIFT_REG));
assign local_bb2_var__u1_stall_in = (|rstag_2to2_bb2_var__u1_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb2_var__u1_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb2_var__u1_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb2_var__u1_stall_local)
		begin
			if (~(rstag_2to2_bb2_var__u1_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb2_var__u1_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb2_var__u1_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb2_var__u1_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb2_var__u1_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb2_var__u1_staging_reg_NO_SHIFT_REG <= local_bb2_var__u1;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb2_var__u1_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb2_var__u1_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb2_var__u1_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb2_var__u1_combined_valid & (rstag_2to2_bb2_var__u1_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb2_var__u1_stall_in_0)) & rstag_2to2_bb2_var__u1_stall_local);
		rstag_2to2_bb2_var__u1_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb2_var__u1_combined_valid & (rstag_2to2_bb2_var__u1_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb2_var__u1_stall_in_1)) & rstag_2to2_bb2_var__u1_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_bb2_cmp4_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_bb2_cmp4_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to162_bb2_cmp4_0_NO_SHIFT_REG;
 logic rnode_161to162_bb2_cmp4_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to162_bb2_cmp4_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb2_cmp4_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb2_cmp4_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb2_cmp4_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_bb2_cmp4_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_bb2_cmp4_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_bb2_cmp4_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_bb2_cmp4_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_bb2_cmp4_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_2to161_bb2_cmp4_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_bb2_cmp4_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_bb2_cmp4_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_bb2_cmp4_0_reg_162_fifo.DATA_WIDTH = 1;
defparam rnode_161to162_bb2_cmp4_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_bb2_cmp4_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_bb2_cmp4_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_2to161_bb2_cmp4_0_valid_out_NO_SHIFT_REG;
assign rnode_2to161_bb2_cmp4_0_stall_in_NO_SHIFT_REG = rnode_161to162_bb2_cmp4_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_bb2_cmp4_0_NO_SHIFT_REG = rnode_161to162_bb2_cmp4_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_bb2_cmp4_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_bb2_cmp4_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_bb2_cmp4_0_valid_out_NO_SHIFT_REG = rnode_161to162_bb2_cmp4_0_valid_out_reg_162_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_2to161_bb2_var__u1_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to161_bb2_var__u1_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to161_bb2_var__u1_0_NO_SHIFT_REG;
 logic rnode_2to161_bb2_var__u1_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to161_bb2_var__u1_0_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_bb2_var__u1_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_bb2_var__u1_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_2to161_bb2_var__u1_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_2to161_bb2_var__u1_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to161_bb2_var__u1_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to161_bb2_var__u1_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_2to161_bb2_var__u1_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_2to161_bb2_var__u1_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rstag_2to2_bb2_var__u1),
	.data_out(rnode_2to161_bb2_var__u1_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_2to161_bb2_var__u1_0_reg_161_fifo.DEPTH = 160;
defparam rnode_2to161_bb2_var__u1_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_2to161_bb2_var__u1_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to161_bb2_var__u1_0_reg_161_fifo.IMPL = "ram";

assign rnode_2to161_bb2_var__u1_0_reg_161_inputs_ready_NO_SHIFT_REG = rstag_2to2_bb2_var__u1_valid_out_0;
assign rstag_2to2_bb2_var__u1_stall_in_0 = rnode_2to161_bb2_var__u1_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_2to161_bb2_var__u1_0_NO_SHIFT_REG = rnode_2to161_bb2_var__u1_0_reg_161_NO_SHIFT_REG;
assign rnode_2to161_bb2_var__u1_0_stall_in_reg_161_NO_SHIFT_REG = rnode_2to161_bb2_var__u1_0_stall_in_NO_SHIFT_REG;
assign rnode_2to161_bb2_var__u1_0_valid_out_NO_SHIFT_REG = rnode_2to161_bb2_var__u1_0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb2_ld__inputs_ready;
 reg local_bb2_ld__valid_out_NO_SHIFT_REG;
wire local_bb2_ld__stall_in;
wire local_bb2_ld__output_regs_ready;
wire local_bb2_ld__fu_stall_out;
wire local_bb2_ld__fu_valid_out;
wire [31:0] local_bb2_ld__lsu_dataout;
 reg [31:0] local_bb2_ld__NO_SHIFT_REG;
wire local_bb2_ld__causedstall;

lsu_top lsu_local_bb2_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb2_ld__fu_stall_out),
	.i_valid(local_bb2_ld__inputs_ready),
	.i_address(rstag_2to2_bb2_arrayidx11),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_2to2_bb2_var__u1),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb2_ld__output_regs_ready)),
	.o_valid(local_bb2_ld__fu_valid_out),
	.o_readdata(local_bb2_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb2_ld__active),
	.avm_address(avm_local_bb2_ld__address),
	.avm_read(avm_local_bb2_ld__read),
	.avm_readdata(avm_local_bb2_ld__readdata),
	.avm_write(avm_local_bb2_ld__write),
	.avm_writeack(avm_local_bb2_ld__writeack),
	.avm_burstcount(avm_local_bb2_ld__burstcount),
	.avm_writedata(avm_local_bb2_ld__writedata),
	.avm_byteenable(avm_local_bb2_ld__byteenable),
	.avm_waitrequest(avm_local_bb2_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb2_ld__readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb2_ld_.AWIDTH = 30;
defparam lsu_local_bb2_ld_.WIDTH_BYTES = 4;
defparam lsu_local_bb2_ld_.MWIDTH_BYTES = 32;
defparam lsu_local_bb2_ld_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb2_ld_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb2_ld_.READ = 1;
defparam lsu_local_bb2_ld_.ATOMIC = 0;
defparam lsu_local_bb2_ld_.WIDTH = 32;
defparam lsu_local_bb2_ld_.MWIDTH = 256;
defparam lsu_local_bb2_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb2_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb2_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb2_ld_.MEMORY_SIDE_MEM_LATENCY = 138;
defparam lsu_local_bb2_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb2_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb2_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb2_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb2_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb2_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb2_ld_.USECACHING = 0;
defparam lsu_local_bb2_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb2_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb2_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb2_ld_.ADDRSPACE = 1;
defparam lsu_local_bb2_ld_.STYLE = "BURST-COALESCED";

assign local_bb2_ld__inputs_ready = (rstag_2to2_bb2_var__u1_valid_out_1 & rstag_2to2_bb2_arrayidx11_valid_out);
assign local_bb2_ld__output_regs_ready = (&(~(local_bb2_ld__valid_out_NO_SHIFT_REG) | ~(local_bb2_ld__stall_in)));
assign rstag_2to2_bb2_var__u1_stall_in_1 = (local_bb2_ld__fu_stall_out | ~(local_bb2_ld__inputs_ready));
assign rstag_2to2_bb2_arrayidx11_stall_in = (local_bb2_ld__fu_stall_out | ~(local_bb2_ld__inputs_ready));
assign local_bb2_ld__causedstall = (local_bb2_ld__inputs_ready && (local_bb2_ld__fu_stall_out && !(~(local_bb2_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_ld__NO_SHIFT_REG <= 'x;
		local_bb2_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb2_ld__output_regs_ready)
		begin
			local_bb2_ld__NO_SHIFT_REG <= local_bb2_ld__lsu_dataout;
			local_bb2_ld__valid_out_NO_SHIFT_REG <= local_bb2_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb2_ld__stall_in))
			begin
				local_bb2_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_bb2_var__u1_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to162_bb2_var__u1_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to162_bb2_var__u1_0_NO_SHIFT_REG;
 logic rnode_161to162_bb2_var__u1_0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to162_bb2_var__u1_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb2_var__u1_0_valid_out_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb2_var__u1_0_stall_in_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_bb2_var__u1_0_stall_out_reg_162_NO_SHIFT_REG;

acl_data_fifo rnode_161to162_bb2_var__u1_0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_bb2_var__u1_0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_bb2_var__u1_0_stall_in_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_bb2_var__u1_0_valid_out_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_bb2_var__u1_0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_2to161_bb2_var__u1_0_NO_SHIFT_REG),
	.data_out(rnode_161to162_bb2_var__u1_0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_bb2_var__u1_0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_bb2_var__u1_0_reg_162_fifo.DATA_WIDTH = 1;
defparam rnode_161to162_bb2_var__u1_0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_bb2_var__u1_0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_bb2_var__u1_0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_2to161_bb2_var__u1_0_valid_out_NO_SHIFT_REG;
assign rnode_2to161_bb2_var__u1_0_stall_in_NO_SHIFT_REG = rnode_161to162_bb2_var__u1_0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_bb2_var__u1_0_NO_SHIFT_REG = rnode_161to162_bb2_var__u1_0_reg_162_NO_SHIFT_REG;
assign rnode_161to162_bb2_var__u1_0_stall_in_reg_162_NO_SHIFT_REG = rnode_161to162_bb2_var__u1_0_stall_in_NO_SHIFT_REG;
assign rnode_161to162_bb2_var__u1_0_valid_out_NO_SHIFT_REG = rnode_161to162_bb2_var__u1_0_valid_out_reg_162_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_162to162_bb2_ld__valid_out;
wire rstag_162to162_bb2_ld__stall_in;
wire rstag_162to162_bb2_ld__inputs_ready;
wire rstag_162to162_bb2_ld__stall_local;
 reg rstag_162to162_bb2_ld__staging_valid_NO_SHIFT_REG;
wire rstag_162to162_bb2_ld__combined_valid;
 reg [31:0] rstag_162to162_bb2_ld__staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_162to162_bb2_ld_;

assign rstag_162to162_bb2_ld__inputs_ready = local_bb2_ld__valid_out_NO_SHIFT_REG;
assign rstag_162to162_bb2_ld_ = (rstag_162to162_bb2_ld__staging_valid_NO_SHIFT_REG ? rstag_162to162_bb2_ld__staging_reg_NO_SHIFT_REG : local_bb2_ld__NO_SHIFT_REG);
assign rstag_162to162_bb2_ld__combined_valid = (rstag_162to162_bb2_ld__staging_valid_NO_SHIFT_REG | rstag_162to162_bb2_ld__inputs_ready);
assign rstag_162to162_bb2_ld__valid_out = rstag_162to162_bb2_ld__combined_valid;
assign rstag_162to162_bb2_ld__stall_local = rstag_162to162_bb2_ld__stall_in;
assign local_bb2_ld__stall_in = (|rstag_162to162_bb2_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb2_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb2_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_162to162_bb2_ld__stall_local)
		begin
			if (~(rstag_162to162_bb2_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_162to162_bb2_ld__staging_valid_NO_SHIFT_REG <= rstag_162to162_bb2_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_162to162_bb2_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_162to162_bb2_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_162to162_bb2_ld__staging_reg_NO_SHIFT_REG <= local_bb2_ld__NO_SHIFT_REG;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_c0_exe1_reg_NO_SHIFT_REG;
 reg lvb_c0_exe2_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe3_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe4_reg_NO_SHIFT_REG;
 reg [63:0] lvb_c0_exe6_reg_NO_SHIFT_REG;
 reg lvb_c0_exe7_reg_NO_SHIFT_REG;
 reg [63:0] lvb_indvars_iv21_reg_NO_SHIFT_REG;
 reg [31:0] lvb_right_lower_0_ph_reg_NO_SHIFT_REG;
 reg [31:0] lvb_temp_index_0_ph_reg_NO_SHIFT_REG;
 reg [63:0] lvb_var__reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb2_var__reg_NO_SHIFT_REG;
 reg lvb_bb2_cmp4_reg_NO_SHIFT_REG;
 reg lvb_bb2_var__u1_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb2_ld__reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb2_var__valid_out & rnode_161to162_right_lower_0_ph_0_valid_out_1_NO_SHIFT_REG & rnode_161to162_c0_exe1_0_valid_out_NO_SHIFT_REG & rnode_161to162_c0_exe2_0_valid_out_NO_SHIFT_REG & rnode_161to162_c0_exe3_0_valid_out_NO_SHIFT_REG & rnode_161to162_c0_exe4_0_valid_out_NO_SHIFT_REG & rnode_161to162_c0_exe6_0_valid_out_NO_SHIFT_REG & rnode_161to162_temp_index_0_ph_0_valid_out_NO_SHIFT_REG & rnode_161to162_var__0_valid_out_NO_SHIFT_REG & rnode_161to162_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rnode_161to162_indvars_iv21_0_valid_out_NO_SHIFT_REG & rnode_161to162_c0_exe7_0_valid_out_NO_SHIFT_REG & rnode_161to162_bb2_cmp4_0_valid_out_NO_SHIFT_REG & rnode_161to162_bb2_var__u1_0_valid_out_NO_SHIFT_REG & rstag_162to162_bb2_ld__valid_out);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb2_var__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_right_lower_0_ph_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_c0_exe1_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_c0_exe2_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_c0_exe3_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_c0_exe4_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_c0_exe6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_temp_index_0_ph_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_var__0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_indvars_iv21_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_c0_exe7_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_bb2_cmp4_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to162_bb2_var__u1_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_162to162_bb2_ld__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_c0_exe1 = lvb_c0_exe1_reg_NO_SHIFT_REG;
assign lvb_c0_exe2 = lvb_c0_exe2_reg_NO_SHIFT_REG;
assign lvb_c0_exe3 = lvb_c0_exe3_reg_NO_SHIFT_REG;
assign lvb_c0_exe4 = lvb_c0_exe4_reg_NO_SHIFT_REG;
assign lvb_c0_exe6 = lvb_c0_exe6_reg_NO_SHIFT_REG;
assign lvb_c0_exe7 = lvb_c0_exe7_reg_NO_SHIFT_REG;
assign lvb_indvars_iv21 = lvb_indvars_iv21_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph = lvb_right_lower_0_ph_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph = lvb_temp_index_0_ph_reg_NO_SHIFT_REG;
assign lvb_var_ = lvb_var__reg_NO_SHIFT_REG;
assign lvb_bb2_var_ = lvb_bb2_var__reg_NO_SHIFT_REG;
assign lvb_bb2_cmp4 = lvb_bb2_cmp4_reg_NO_SHIFT_REG;
assign lvb_bb2_var__u1 = lvb_bb2_var__u1_reg_NO_SHIFT_REG;
assign lvb_bb2_ld_ = lvb_bb2_ld__reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_c0_exe1_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe2_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe3_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe4_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe6_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe7_reg_NO_SHIFT_REG <= 'x;
		lvb_indvars_iv21_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph_reg_NO_SHIFT_REG <= 'x;
		lvb_temp_index_0_ph_reg_NO_SHIFT_REG <= 'x;
		lvb_var__reg_NO_SHIFT_REG <= 'x;
		lvb_bb2_var__reg_NO_SHIFT_REG <= 'x;
		lvb_bb2_cmp4_reg_NO_SHIFT_REG <= 'x;
		lvb_bb2_var__u1_reg_NO_SHIFT_REG <= 'x;
		lvb_bb2_ld__reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_c0_exe1_reg_NO_SHIFT_REG <= rnode_161to162_c0_exe1_0_NO_SHIFT_REG;
			lvb_c0_exe2_reg_NO_SHIFT_REG <= rnode_161to162_c0_exe2_0_NO_SHIFT_REG;
			lvb_c0_exe3_reg_NO_SHIFT_REG <= rnode_161to162_c0_exe3_0_NO_SHIFT_REG;
			lvb_c0_exe4_reg_NO_SHIFT_REG <= rnode_161to162_c0_exe4_0_NO_SHIFT_REG;
			lvb_c0_exe6_reg_NO_SHIFT_REG <= rnode_161to162_c0_exe6_0_NO_SHIFT_REG;
			lvb_c0_exe7_reg_NO_SHIFT_REG <= rnode_161to162_c0_exe7_0_NO_SHIFT_REG;
			lvb_indvars_iv21_reg_NO_SHIFT_REG <= rnode_161to162_indvars_iv21_0_NO_SHIFT_REG;
			lvb_right_lower_0_ph_reg_NO_SHIFT_REG <= rnode_161to162_right_lower_0_ph_1_NO_SHIFT_REG;
			lvb_temp_index_0_ph_reg_NO_SHIFT_REG <= rnode_161to162_temp_index_0_ph_0_NO_SHIFT_REG;
			lvb_var__reg_NO_SHIFT_REG <= rnode_161to162_var__0_NO_SHIFT_REG;
			lvb_bb2_var__reg_NO_SHIFT_REG <= local_bb2_var_;
			lvb_bb2_cmp4_reg_NO_SHIFT_REG <= rnode_161to162_bb2_cmp4_0_NO_SHIFT_REG;
			lvb_bb2_var__u1_reg_NO_SHIFT_REG <= rnode_161to162_bb2_var__u1_0_NO_SHIFT_REG;
			lvb_bb2_ld__reg_NO_SHIFT_REG <= rstag_162to162_bb2_ld_;
			lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= rnode_161to162_input_acl_hw_wg_id_0_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_3
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_data,
		input 		valid_in_0,
		output 		stall_out_0,
		input [31:0] 		input_c0_exe1_0,
		input 		input_c0_exe2_0,
		input [31:0] 		input_c0_exe3_0,
		input [31:0] 		input_c0_exe4_0,
		input [63:0] 		input_c0_exe6_0,
		input 		input_c0_exe7_0,
		input [63:0] 		input_indvars_iv21_0,
		input 		input_cmp4_0,
		input 		input_var__0,
		input [31:0] 		input_ld__0,
		input [63:0] 		input_indvars_iv19_0,
		input [63:0] 		input_indvars_iv17_0,
		input [31:0] 		input_right_lower_0_ph7_0,
		input [31:0] 		input_temp_index_0_ph8_0,
		input [31:0] 		input_acl_hw_wg_id_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [31:0] 		input_c0_exe1_1,
		input 		input_c0_exe2_1,
		input [31:0] 		input_c0_exe3_1,
		input [31:0] 		input_c0_exe4_1,
		input [63:0] 		input_c0_exe6_1,
		input 		input_c0_exe7_1,
		input [63:0] 		input_indvars_iv21_1,
		input 		input_cmp4_1,
		input 		input_var__1,
		input [31:0] 		input_ld__1,
		input [63:0] 		input_indvars_iv19_1,
		input [63:0] 		input_indvars_iv17_1,
		input [31:0] 		input_right_lower_0_ph7_1,
		input [31:0] 		input_temp_index_0_ph8_1,
		input [31:0] 		input_acl_hw_wg_id_1,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_c0_exe1,
		output 		lvb_c0_exe2,
		output [31:0] 		lvb_c0_exe3,
		output [31:0] 		lvb_c0_exe4,
		output [63:0] 		lvb_c0_exe6,
		output 		lvb_c0_exe7,
		output [63:0] 		lvb_indvars_iv21,
		output 		lvb_cmp4,
		output 		lvb_var_,
		output [31:0] 		lvb_ld_,
		output [63:0] 		lvb_indvars_iv19,
		output [63:0] 		lvb_indvars_iv17,
		output [31:0] 		lvb_right_lower_0_ph7,
		output [31:0] 		lvb_temp_index_0_ph8,
		output 		lvb_bb3_or_cond,
		output 		lvb_bb3_var_,
		output [31:0] 		lvb_bb3_ld__pre_pre,
		output 		lvb_bb3_var__u3,
		output 		lvb_bb3_var__u4,
		output 		lvb_bb3_var__u5,
		output [31:0] 		lvb_input_acl_hw_wg_id,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb3_ld__pre_pre_readdata,
		input 		avm_local_bb3_ld__pre_pre_readdatavalid,
		input 		avm_local_bb3_ld__pre_pre_waitrequest,
		output [29:0] 		avm_local_bb3_ld__pre_pre_address,
		output 		avm_local_bb3_ld__pre_pre_read,
		output 		avm_local_bb3_ld__pre_pre_write,
		input 		avm_local_bb3_ld__pre_pre_writeack,
		output [255:0] 		avm_local_bb3_ld__pre_pre_writedata,
		output [31:0] 		avm_local_bb3_ld__pre_pre_byteenable,
		output [4:0] 		avm_local_bb3_ld__pre_pre_burstcount,
		output 		local_bb3_ld__pre_pre_active,
		input 		clock2x
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_node_stall_in_5;
 reg merge_node_valid_out_5_NO_SHIFT_REG;
wire merge_node_stall_in_6;
 reg merge_node_valid_out_6_NO_SHIFT_REG;
wire merge_node_stall_in_7;
 reg merge_node_valid_out_7_NO_SHIFT_REG;
wire merge_node_stall_in_8;
 reg merge_node_valid_out_8_NO_SHIFT_REG;
wire merge_node_stall_in_9;
 reg merge_node_valid_out_9_NO_SHIFT_REG;
wire merge_node_stall_in_10;
 reg merge_node_valid_out_10_NO_SHIFT_REG;
wire merge_node_stall_in_11;
 reg merge_node_valid_out_11_NO_SHIFT_REG;
wire merge_node_stall_in_12;
 reg merge_node_valid_out_12_NO_SHIFT_REG;
wire merge_node_stall_in_13;
 reg merge_node_valid_out_13_NO_SHIFT_REG;
wire merge_node_stall_in_14;
 reg merge_node_valid_out_14_NO_SHIFT_REG;
wire merge_node_stall_in_15;
 reg merge_node_valid_out_15_NO_SHIFT_REG;
wire merge_node_stall_in_16;
 reg merge_node_valid_out_16_NO_SHIFT_REG;
wire merge_node_stall_in_17;
 reg merge_node_valid_out_17_NO_SHIFT_REG;
wire merge_node_stall_in_18;
 reg merge_node_valid_out_18_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_0_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe2_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe4_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_c0_exe6_0_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv21_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp4_0_staging_reg_NO_SHIFT_REG;
 reg input_var__0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv19_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv17_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_right_lower_0_ph7_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_temp_index_0_ph8_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe1_NO_SHIFT_REG;
 reg local_lvm_c0_exe2_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe3_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe4_NO_SHIFT_REG;
 reg [63:0] local_lvm_c0_exe6_NO_SHIFT_REG;
 reg local_lvm_c0_exe7_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv21_NO_SHIFT_REG;
 reg local_lvm_cmp4_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv19_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv17_NO_SHIFT_REG;
 reg [31:0] local_lvm_right_lower_0_ph7_NO_SHIFT_REG;
 reg [31:0] local_lvm_temp_index_0_ph8_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_1_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe2_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe4_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_c0_exe6_1_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv21_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp4_1_staging_reg_NO_SHIFT_REG;
 reg input_var__1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv19_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv17_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_right_lower_0_ph7_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_temp_index_0_ph8_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG) | (merge_node_stall_in_9 & merge_node_valid_out_9_NO_SHIFT_REG) | (merge_node_stall_in_10 & merge_node_valid_out_10_NO_SHIFT_REG) | (merge_node_stall_in_11 & merge_node_valid_out_11_NO_SHIFT_REG) | (merge_node_stall_in_12 & merge_node_valid_out_12_NO_SHIFT_REG) | (merge_node_stall_in_13 & merge_node_valid_out_13_NO_SHIFT_REG) | (merge_node_stall_in_14 & merge_node_valid_out_14_NO_SHIFT_REG) | (merge_node_stall_in_15 & merge_node_valid_out_15_NO_SHIFT_REG) | (merge_node_stall_in_16 & merge_node_valid_out_16_NO_SHIFT_REG) | (merge_node_stall_in_17 & merge_node_valid_out_17_NO_SHIFT_REG) | (merge_node_stall_in_18 & merge_node_valid_out_18_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_c0_exe1_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe3_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe4_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv21_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp4_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv19_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv17_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph8_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_c0_exe1_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe3_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe4_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv21_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp4_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv19_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv17_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph8_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe1_0_staging_reg_NO_SHIFT_REG <= input_c0_exe1_0;
				input_c0_exe2_0_staging_reg_NO_SHIFT_REG <= input_c0_exe2_0;
				input_c0_exe3_0_staging_reg_NO_SHIFT_REG <= input_c0_exe3_0;
				input_c0_exe4_0_staging_reg_NO_SHIFT_REG <= input_c0_exe4_0;
				input_c0_exe6_0_staging_reg_NO_SHIFT_REG <= input_c0_exe6_0;
				input_c0_exe7_0_staging_reg_NO_SHIFT_REG <= input_c0_exe7_0;
				input_indvars_iv21_0_staging_reg_NO_SHIFT_REG <= input_indvars_iv21_0;
				input_cmp4_0_staging_reg_NO_SHIFT_REG <= input_cmp4_0;
				input_var__0_staging_reg_NO_SHIFT_REG <= input_var__0;
				input_ld__0_staging_reg_NO_SHIFT_REG <= input_ld__0;
				input_indvars_iv19_0_staging_reg_NO_SHIFT_REG <= input_indvars_iv19_0;
				input_indvars_iv17_0_staging_reg_NO_SHIFT_REG <= input_indvars_iv17_0;
				input_right_lower_0_ph7_0_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph7_0;
				input_temp_index_0_ph8_0_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph8_0;
				input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe1_1_staging_reg_NO_SHIFT_REG <= input_c0_exe1_1;
				input_c0_exe2_1_staging_reg_NO_SHIFT_REG <= input_c0_exe2_1;
				input_c0_exe3_1_staging_reg_NO_SHIFT_REG <= input_c0_exe3_1;
				input_c0_exe4_1_staging_reg_NO_SHIFT_REG <= input_c0_exe4_1;
				input_c0_exe6_1_staging_reg_NO_SHIFT_REG <= input_c0_exe6_1;
				input_c0_exe7_1_staging_reg_NO_SHIFT_REG <= input_c0_exe7_1;
				input_indvars_iv21_1_staging_reg_NO_SHIFT_REG <= input_indvars_iv21_1;
				input_cmp4_1_staging_reg_NO_SHIFT_REG <= input_cmp4_1;
				input_var__1_staging_reg_NO_SHIFT_REG <= input_var__1;
				input_ld__1_staging_reg_NO_SHIFT_REG <= input_ld__1;
				input_indvars_iv19_1_staging_reg_NO_SHIFT_REG <= input_indvars_iv19_1;
				input_indvars_iv17_1_staging_reg_NO_SHIFT_REG <= input_indvars_iv17_1;
				input_right_lower_0_ph7_1_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph7_1;
				input_temp_index_0_ph8_1_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph8_1;
				input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__0_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19_0_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17_0_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_0;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_0;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_0;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_0;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_0;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_0;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_0;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4_0;
					local_lvm_var__NO_SHIFT_REG <= input_var__0;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19_0;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17_0;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_0;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__1_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19_1_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17_1_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_1;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_1;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_1;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_1;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_1;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_1;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_1;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4_1;
					local_lvm_var__NO_SHIFT_REG <= input_var__1;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19_1;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17_1;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_1;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_1;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_9_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_10_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_11_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_12_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_13_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_14_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_15_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_16_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_17_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_18_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_5_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_6_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_7_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_8_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_9_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_10_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_11_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_12_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_13_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_14_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_15_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_16_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_17_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_18_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_5))
			begin
				merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_6))
			begin
				merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_7))
			begin
				merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_8))
			begin
				merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_9))
			begin
				merge_node_valid_out_9_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_10))
			begin
				merge_node_valid_out_10_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_11))
			begin
				merge_node_valid_out_11_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_12))
			begin
				merge_node_valid_out_12_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_13))
			begin
				merge_node_valid_out_13_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_14))
			begin
				merge_node_valid_out_14_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_15))
			begin
				merge_node_valid_out_15_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_16))
			begin
				merge_node_valid_out_16_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_17))
			begin
				merge_node_valid_out_17_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_18))
			begin
				merge_node_valid_out_18_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3_var__u6_stall_local;
wire [31:0] local_bb3_var__u6;

assign local_bb3_var__u6 = local_lvm_indvars_iv17_NO_SHIFT_REG[31:0];

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_input_data_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_data_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_input_data_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_input_data_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_input_data_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_input_data_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_input_data_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_1to2_input_data_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_input_data_0_reg_2_fifo.DATA_WIDTH = 0;
defparam rnode_1to2_input_data_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_input_data_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_input_data_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to2_input_data_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_input_data_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_input_data_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_input_data_0_valid_out_NO_SHIFT_REG = rnode_1to2_input_data_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_1to164_var__0_NO_SHIFT_REG;
 logic rnode_1to164_var__0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to164_var__0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_var__0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_var__0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_var__0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_var__0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_var__0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_var__0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_var__0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_var__0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_var__NO_SHIFT_REG),
	.data_out(rnode_1to164_var__0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_var__0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_var__0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_1to164_var__0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_var__0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_var__0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to164_var__0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_var__0_NO_SHIFT_REG = rnode_1to164_var__0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_var__0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_var__0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_var__0_valid_out_NO_SHIFT_REG = rnode_1to164_var__0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_c0_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_c0_exe1_0_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe1_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_c0_exe1_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe1_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe1_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe1_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_c0_exe1_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_c0_exe1_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_c0_exe1_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_c0_exe1_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_c0_exe1_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe1_NO_SHIFT_REG),
	.data_out(rnode_1to164_c0_exe1_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_c0_exe1_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_c0_exe1_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_1to164_c0_exe1_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_c0_exe1_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_c0_exe1_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to164_c0_exe1_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe1_0_NO_SHIFT_REG = rnode_1to164_c0_exe1_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe1_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_c0_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_c0_exe1_0_valid_out_NO_SHIFT_REG = rnode_1to164_c0_exe1_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_c0_exe2_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe2_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe2_0_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe2_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe2_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe2_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe2_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe2_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_c0_exe2_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_c0_exe2_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_c0_exe2_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_c0_exe2_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_c0_exe2_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe2_NO_SHIFT_REG),
	.data_out(rnode_1to164_c0_exe2_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_c0_exe2_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_c0_exe2_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_1to164_c0_exe2_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_c0_exe2_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_c0_exe2_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to164_c0_exe2_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe2_0_NO_SHIFT_REG = rnode_1to164_c0_exe2_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe2_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_c0_exe2_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_c0_exe2_0_valid_out_NO_SHIFT_REG = rnode_1to164_c0_exe2_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe3_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_c0_exe3_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe3_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe3_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe3_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_c0_exe3_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_c0_exe3_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_c0_exe3_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_c0_exe3_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_c0_exe3_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe3_NO_SHIFT_REG),
	.data_out(rnode_1to164_c0_exe3_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_c0_exe3_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_c0_exe3_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_1to164_c0_exe3_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_c0_exe3_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_c0_exe3_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to164_c0_exe3_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe3_0_NO_SHIFT_REG = rnode_1to164_c0_exe3_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe3_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_1to164_c0_exe3_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_c0_exe4_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_c0_exe4_0_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe4_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_c0_exe4_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe4_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe4_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe4_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_c0_exe4_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_c0_exe4_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_c0_exe4_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_c0_exe4_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_c0_exe4_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe4_NO_SHIFT_REG),
	.data_out(rnode_1to164_c0_exe4_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_c0_exe4_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_c0_exe4_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_1to164_c0_exe4_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_c0_exe4_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_c0_exe4_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to164_c0_exe4_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe4_0_NO_SHIFT_REG = rnode_1to164_c0_exe4_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe4_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_c0_exe4_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_c0_exe4_0_valid_out_NO_SHIFT_REG = rnode_1to164_c0_exe4_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_c0_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_c0_exe6_0_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe6_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_c0_exe6_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe6_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe6_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe6_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_c0_exe6_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_c0_exe6_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_c0_exe6_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_c0_exe6_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_c0_exe6_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe6_NO_SHIFT_REG),
	.data_out(rnode_1to164_c0_exe6_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_c0_exe6_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_c0_exe6_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_1to164_c0_exe6_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_c0_exe6_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_c0_exe6_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_9_NO_SHIFT_REG;
assign merge_node_stall_in_9 = rnode_1to164_c0_exe6_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe6_0_NO_SHIFT_REG = rnode_1to164_c0_exe6_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe6_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_c0_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_c0_exe6_0_valid_out_NO_SHIFT_REG = rnode_1to164_c0_exe6_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_indvars_iv21_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv21_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_indvars_iv21_0_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv21_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_indvars_iv21_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv21_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv21_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv21_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_indvars_iv21_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_indvars_iv21_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_indvars_iv21_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_indvars_iv21_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_indvars_iv21_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv21_NO_SHIFT_REG),
	.data_out(rnode_1to164_indvars_iv21_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_indvars_iv21_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_indvars_iv21_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_1to164_indvars_iv21_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_indvars_iv21_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_indvars_iv21_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_10_NO_SHIFT_REG;
assign merge_node_stall_in_10 = rnode_1to164_indvars_iv21_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_indvars_iv21_0_NO_SHIFT_REG = rnode_1to164_indvars_iv21_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_indvars_iv21_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_indvars_iv21_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_indvars_iv21_0_valid_out_NO_SHIFT_REG = rnode_1to164_indvars_iv21_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_indvars_iv19_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv19_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_indvars_iv19_0_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv19_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_indvars_iv19_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv19_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv19_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_indvars_iv19_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_indvars_iv19_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_indvars_iv19_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_indvars_iv19_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_indvars_iv19_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_indvars_iv19_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv19_NO_SHIFT_REG),
	.data_out(rnode_1to164_indvars_iv19_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_indvars_iv19_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_indvars_iv19_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_1to164_indvars_iv19_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_indvars_iv19_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_indvars_iv19_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_11_NO_SHIFT_REG;
assign merge_node_stall_in_11 = rnode_1to164_indvars_iv19_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_indvars_iv19_0_NO_SHIFT_REG = rnode_1to164_indvars_iv19_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_indvars_iv19_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_indvars_iv19_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_indvars_iv19_0_valid_out_NO_SHIFT_REG = rnode_1to164_indvars_iv19_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_right_lower_0_ph7_0_NO_SHIFT_REG;
 logic rnode_1to164_right_lower_0_ph7_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_right_lower_0_ph7_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_right_lower_0_ph7_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_right_lower_0_ph7_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_right_lower_0_ph7_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_right_lower_0_ph7_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_right_lower_0_ph7_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_right_lower_0_ph7_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_right_lower_0_ph7_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_right_lower_0_ph7_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_right_lower_0_ph7_NO_SHIFT_REG),
	.data_out(rnode_1to164_right_lower_0_ph7_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_right_lower_0_ph7_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_right_lower_0_ph7_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_1to164_right_lower_0_ph7_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_right_lower_0_ph7_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_right_lower_0_ph7_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_12_NO_SHIFT_REG;
assign merge_node_stall_in_12 = rnode_1to164_right_lower_0_ph7_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_right_lower_0_ph7_0_NO_SHIFT_REG = rnode_1to164_right_lower_0_ph7_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_right_lower_0_ph7_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG = rnode_1to164_right_lower_0_ph7_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_temp_index_0_ph8_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph8_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_temp_index_0_ph8_0_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph8_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_temp_index_0_ph8_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph8_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph8_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph8_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_temp_index_0_ph8_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_temp_index_0_ph8_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_temp_index_0_ph8_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_temp_index_0_ph8_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_temp_index_0_ph8_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_temp_index_0_ph8_NO_SHIFT_REG),
	.data_out(rnode_1to164_temp_index_0_ph8_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_temp_index_0_ph8_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_temp_index_0_ph8_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_1to164_temp_index_0_ph8_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_temp_index_0_ph8_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_temp_index_0_ph8_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_13_NO_SHIFT_REG;
assign merge_node_stall_in_13 = rnode_1to164_temp_index_0_ph8_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_temp_index_0_ph8_0_NO_SHIFT_REG = rnode_1to164_temp_index_0_ph8_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_temp_index_0_ph8_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_temp_index_0_ph8_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_temp_index_0_ph8_0_valid_out_NO_SHIFT_REG = rnode_1to164_temp_index_0_ph8_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_input_acl_hw_wg_id_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_input_acl_hw_wg_id_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_input_acl_hw_wg_id_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_input_acl_hw_wg_id_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_input_acl_hw_wg_id_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to164_input_acl_hw_wg_id_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_input_acl_hw_wg_id_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_14_NO_SHIFT_REG;
assign merge_node_stall_in_14 = rnode_1to164_input_acl_hw_wg_id_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_cmp4_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_1_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_cmp4_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_cmp4_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_cmp4_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_cmp4_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_cmp4_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_cmp4_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_cmp4_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_cmp4_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_cmp4_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_cmp4_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_cmp4_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_cmp4_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_cmp4_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_cmp4_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_cmp4_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_cmp4_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_cmp4_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_cmp4_NO_SHIFT_REG),
	.data_out(rnode_1to2_cmp4_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_cmp4_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_cmp4_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_cmp4_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_cmp4_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_cmp4_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_15_NO_SHIFT_REG;
assign merge_node_stall_in_15 = rnode_1to2_cmp4_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_cmp4_0_NO_SHIFT_REG = rnode_1to2_cmp4_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_cmp4_1_NO_SHIFT_REG = rnode_1to2_cmp4_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_c0_exe7_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_1_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_c0_exe7_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_c0_exe7_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_c0_exe7_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_c0_exe7_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_c0_exe7_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_c0_exe7_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_c0_exe7_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_c0_exe7_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_c0_exe7_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_c0_exe7_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_c0_exe7_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_c0_exe7_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_c0_exe7_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_c0_exe7_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe7_NO_SHIFT_REG),
	.data_out(rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_c0_exe7_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_c0_exe7_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_c0_exe7_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_c0_exe7_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_c0_exe7_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_16_NO_SHIFT_REG;
assign merge_node_stall_in_16 = rnode_1to2_c0_exe7_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_c0_exe7_0_NO_SHIFT_REG = rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_c0_exe7_1_NO_SHIFT_REG = rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_indvars_iv17_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv17_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_indvars_iv17_0_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv17_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv17_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_indvars_iv17_1_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv17_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_indvars_iv17_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv17_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv17_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_indvars_iv17_0_stall_out_reg_2_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_indvars_iv17_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_indvars_iv17_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_indvars_iv17_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_indvars_iv17_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_indvars_iv17_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_indvars_iv17_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_indvars_iv17_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_indvars_iv17_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_indvars_iv17_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_indvars_iv17_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_indvars_iv17_0_reg_2_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_1to2_indvars_iv17_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_indvars_iv17_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_indvars_iv17_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_indvars_iv17_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_indvars_iv17_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_indvars_iv17_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv17_NO_SHIFT_REG),
	.data_out(rnode_1to2_indvars_iv17_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_indvars_iv17_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_indvars_iv17_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_indvars_iv17_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_indvars_iv17_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_indvars_iv17_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_17_NO_SHIFT_REG;
assign merge_node_stall_in_17 = rnode_1to2_indvars_iv17_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_indvars_iv17_0_NO_SHIFT_REG = rnode_1to2_indvars_iv17_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_indvars_iv17_1_NO_SHIFT_REG = rnode_1to2_indvars_iv17_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 160
//  * capacity = 160
 logic rnode_1to161_ld__0_valid_out_NO_SHIFT_REG;
 logic rnode_1to161_ld__0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_ld__0_NO_SHIFT_REG;
 logic rnode_1to161_ld__0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to161_ld__0_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_ld__0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_ld__0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_1to161_ld__0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_1to161_ld__0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to161_ld__0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to161_ld__0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_1to161_ld__0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_1to161_ld__0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(local_lvm_ld__NO_SHIFT_REG),
	.data_out(rnode_1to161_ld__0_reg_161_NO_SHIFT_REG)
);

defparam rnode_1to161_ld__0_reg_161_fifo.DEPTH = 161;
defparam rnode_1to161_ld__0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_1to161_ld__0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to161_ld__0_reg_161_fifo.IMPL = "ram";

assign rnode_1to161_ld__0_reg_161_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_18_NO_SHIFT_REG;
assign merge_node_stall_in_18 = rnode_1to161_ld__0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_1to161_ld__0_NO_SHIFT_REG = rnode_1to161_ld__0_reg_161_NO_SHIFT_REG;
assign rnode_1to161_ld__0_stall_in_reg_161_NO_SHIFT_REG = rnode_1to161_ld__0_stall_in_NO_SHIFT_REG;
assign rnode_1to161_ld__0_valid_out_NO_SHIFT_REG = rnode_1to161_ld__0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_cmp6_stall_local;
wire local_bb3_cmp6;

assign local_bb3_cmp6 = ($signed(local_bb3_var__u6) > $signed(local_lvm_c0_exe3_NO_SHIFT_REG));

// This section implements an unregistered operation.
// 
wire local_bb3_cmp6_valid_out;
wire local_bb3_cmp6_stall_in;
 reg local_bb3_cmp6_consumed_0_NO_SHIFT_REG;
wire local_bb3_cmp20_valid_out;
wire local_bb3_cmp20_stall_in;
 reg local_bb3_cmp20_consumed_0_NO_SHIFT_REG;
wire local_bb3_cmp20_inputs_ready;
wire local_bb3_cmp20_stall_local;
wire local_bb3_cmp20;

assign local_bb3_cmp20_inputs_ready = (merge_node_valid_out_0_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG & merge_node_valid_out_2_NO_SHIFT_REG);
assign local_bb3_cmp20 = ($signed(local_bb3_var__u6) <= $signed(local_lvm_c0_exe3_NO_SHIFT_REG));
assign local_bb3_cmp20_stall_local = ((local_bb3_cmp6_stall_in & ~(local_bb3_cmp6_consumed_0_NO_SHIFT_REG)) | (local_bb3_cmp20_stall_in & ~(local_bb3_cmp20_consumed_0_NO_SHIFT_REG)));
assign local_bb3_cmp6_valid_out = (local_bb3_cmp20_inputs_ready & ~(local_bb3_cmp6_consumed_0_NO_SHIFT_REG));
assign local_bb3_cmp20_valid_out = (local_bb3_cmp20_inputs_ready & ~(local_bb3_cmp20_consumed_0_NO_SHIFT_REG));
assign merge_node_stall_in_0 = (local_bb3_cmp20_stall_local | ~(local_bb3_cmp20_inputs_ready));
assign merge_node_stall_in_1 = (local_bb3_cmp20_stall_local | ~(local_bb3_cmp20_inputs_ready));
assign merge_node_stall_in_2 = (local_bb3_cmp20_stall_local | ~(local_bb3_cmp20_inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp6_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb3_cmp20_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb3_cmp6_consumed_0_NO_SHIFT_REG <= (local_bb3_cmp20_inputs_ready & (local_bb3_cmp6_consumed_0_NO_SHIFT_REG | ~(local_bb3_cmp6_stall_in)) & local_bb3_cmp20_stall_local);
		local_bb3_cmp20_consumed_0_NO_SHIFT_REG <= (local_bb3_cmp20_inputs_ready & (local_bb3_cmp20_consumed_0_NO_SHIFT_REG | ~(local_bb3_cmp20_stall_in)) & local_bb3_cmp20_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_var__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_var__0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_var__0_NO_SHIFT_REG;
 logic rnode_164to165_var__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_var__0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_var__1_NO_SHIFT_REG;
 logic rnode_164to165_var__0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_var__0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_var__0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_var__0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_var__0_stall_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_var__0_reg_165_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_164to165_var__0_reg_165_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_164to165_var__0_reg_165_NO_SHIFT_REG),
	.valid_in(rnode_164to165_var__0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_var__0_stall_in_0_reg_165_NO_SHIFT_REG),
	.data_out(rnode_164to165_var__0_reg_165_NO_SHIFT_REG_fa),
	.valid_out({rnode_164to165_var__0_valid_out_0_NO_SHIFT_REG, rnode_164to165_var__0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_164to165_var__0_stall_in_0_NO_SHIFT_REG, rnode_164to165_var__0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_164to165_var__0_reg_165_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_164to165_var__0_reg_165_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_164to165_var__0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_var__0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_var__0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_var__0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_var__0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_var__0_NO_SHIFT_REG),
	.data_out(rnode_164to165_var__0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_var__0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_var__0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_var__0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_var__0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_var__0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_var__0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_var__0_stall_in_NO_SHIFT_REG = rnode_164to165_var__0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_var__0_NO_SHIFT_REG = rnode_164to165_var__0_reg_165_NO_SHIFT_REG_fa;
assign rnode_164to165_var__1_NO_SHIFT_REG = rnode_164to165_var__0_reg_165_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_c0_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_c0_exe1_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe1_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_c0_exe1_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe1_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe1_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe1_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_c0_exe1_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_c0_exe1_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_c0_exe1_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_c0_exe1_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_c0_exe1_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_c0_exe1_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_c0_exe1_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_c0_exe1_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_c0_exe1_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_c0_exe1_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_c0_exe1_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_c0_exe1_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_c0_exe1_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_c0_exe1_0_stall_in_NO_SHIFT_REG = rnode_164to165_c0_exe1_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe1_0_NO_SHIFT_REG = rnode_164to165_c0_exe1_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe1_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_c0_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_c0_exe1_0_valid_out_NO_SHIFT_REG = rnode_164to165_c0_exe1_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_c0_exe2_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe2_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe2_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe2_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe2_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe2_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe2_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe2_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_c0_exe2_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_c0_exe2_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_c0_exe2_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_c0_exe2_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_c0_exe2_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_c0_exe2_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_c0_exe2_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_c0_exe2_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_c0_exe2_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_c0_exe2_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_c0_exe2_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_c0_exe2_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_c0_exe2_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_c0_exe2_0_stall_in_NO_SHIFT_REG = rnode_164to165_c0_exe2_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe2_0_NO_SHIFT_REG = rnode_164to165_c0_exe2_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe2_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_c0_exe2_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_c0_exe2_0_valid_out_NO_SHIFT_REG = rnode_164to165_c0_exe2_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_c0_exe3_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_c0_exe3_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_c0_exe3_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_c0_exe3_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_c0_exe3_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_c0_exe3_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_c0_exe3_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_c0_exe3_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_c0_exe3_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_c0_exe3_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_c0_exe3_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_c0_exe3_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_c0_exe3_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_c0_exe3_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_c0_exe3_0_stall_in_NO_SHIFT_REG = rnode_164to165_c0_exe3_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe3_0_NO_SHIFT_REG = rnode_164to165_c0_exe3_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe3_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_164to165_c0_exe3_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_c0_exe4_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_c0_exe4_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe4_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_c0_exe4_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe4_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe4_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe4_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_c0_exe4_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_c0_exe4_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_c0_exe4_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_c0_exe4_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_c0_exe4_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_c0_exe4_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_c0_exe4_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_c0_exe4_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_c0_exe4_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_c0_exe4_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_c0_exe4_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_c0_exe4_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_c0_exe4_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_c0_exe4_0_stall_in_NO_SHIFT_REG = rnode_164to165_c0_exe4_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe4_0_NO_SHIFT_REG = rnode_164to165_c0_exe4_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe4_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_c0_exe4_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_c0_exe4_0_valid_out_NO_SHIFT_REG = rnode_164to165_c0_exe4_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_c0_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_c0_exe6_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe6_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_c0_exe6_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe6_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe6_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe6_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_c0_exe6_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_c0_exe6_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_c0_exe6_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_c0_exe6_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_c0_exe6_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_c0_exe6_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_c0_exe6_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_c0_exe6_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_c0_exe6_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_c0_exe6_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_c0_exe6_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_c0_exe6_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_c0_exe6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_c0_exe6_0_stall_in_NO_SHIFT_REG = rnode_164to165_c0_exe6_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe6_0_NO_SHIFT_REG = rnode_164to165_c0_exe6_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe6_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_c0_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_c0_exe6_0_valid_out_NO_SHIFT_REG = rnode_164to165_c0_exe6_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_indvars_iv21_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv21_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_indvars_iv21_0_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv21_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_indvars_iv21_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv21_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv21_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv21_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_indvars_iv21_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_indvars_iv21_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_indvars_iv21_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_indvars_iv21_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_indvars_iv21_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_indvars_iv21_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_indvars_iv21_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_indvars_iv21_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_indvars_iv21_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_indvars_iv21_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_indvars_iv21_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_indvars_iv21_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_indvars_iv21_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_indvars_iv21_0_stall_in_NO_SHIFT_REG = rnode_164to165_indvars_iv21_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_indvars_iv21_0_NO_SHIFT_REG = rnode_164to165_indvars_iv21_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_indvars_iv21_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_indvars_iv21_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_indvars_iv21_0_valid_out_NO_SHIFT_REG = rnode_164to165_indvars_iv21_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_indvars_iv19_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv19_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_indvars_iv19_0_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv19_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_indvars_iv19_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv19_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv19_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv19_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_indvars_iv19_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_indvars_iv19_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_indvars_iv19_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_indvars_iv19_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_indvars_iv19_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_indvars_iv19_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_indvars_iv19_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_indvars_iv19_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_indvars_iv19_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_indvars_iv19_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_indvars_iv19_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_indvars_iv19_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_indvars_iv19_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_indvars_iv19_0_stall_in_NO_SHIFT_REG = rnode_164to165_indvars_iv19_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_indvars_iv19_0_NO_SHIFT_REG = rnode_164to165_indvars_iv19_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_indvars_iv19_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_indvars_iv19_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_indvars_iv19_0_valid_out_NO_SHIFT_REG = rnode_164to165_indvars_iv19_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_right_lower_0_ph7_0_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph7_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_right_lower_0_ph7_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph7_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph7_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph7_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_right_lower_0_ph7_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_right_lower_0_ph7_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_right_lower_0_ph7_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_right_lower_0_ph7_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_right_lower_0_ph7_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_right_lower_0_ph7_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_right_lower_0_ph7_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_right_lower_0_ph7_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_right_lower_0_ph7_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_right_lower_0_ph7_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_right_lower_0_ph7_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_right_lower_0_ph7_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG = rnode_164to165_right_lower_0_ph7_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_right_lower_0_ph7_0_NO_SHIFT_REG = rnode_164to165_right_lower_0_ph7_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_right_lower_0_ph7_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG = rnode_164to165_right_lower_0_ph7_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_temp_index_0_ph8_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph8_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_temp_index_0_ph8_0_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph8_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_temp_index_0_ph8_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph8_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph8_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph8_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_temp_index_0_ph8_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_temp_index_0_ph8_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_temp_index_0_ph8_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_temp_index_0_ph8_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_temp_index_0_ph8_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_temp_index_0_ph8_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_temp_index_0_ph8_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_temp_index_0_ph8_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_temp_index_0_ph8_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_temp_index_0_ph8_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_temp_index_0_ph8_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_temp_index_0_ph8_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_temp_index_0_ph8_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_temp_index_0_ph8_0_stall_in_NO_SHIFT_REG = rnode_164to165_temp_index_0_ph8_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_temp_index_0_ph8_0_NO_SHIFT_REG = rnode_164to165_temp_index_0_ph8_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_temp_index_0_ph8_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_temp_index_0_ph8_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_temp_index_0_ph8_0_valid_out_NO_SHIFT_REG = rnode_164to165_temp_index_0_ph8_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_input_acl_hw_wg_id_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_input_acl_hw_wg_id_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_input_acl_hw_wg_id_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_input_acl_hw_wg_id_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_input_acl_hw_wg_id_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_input_acl_hw_wg_id_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_input_acl_hw_wg_id_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_input_acl_hw_wg_id_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = rnode_164to165_input_acl_hw_wg_id_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_164to165_input_acl_hw_wg_id_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_input_acl_hw_wg_id_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_164to165_input_acl_hw_wg_id_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_cmp4_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_cmp4_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to164_cmp4_0_NO_SHIFT_REG;
 logic rnode_2to164_cmp4_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to164_cmp4_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_cmp4_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_cmp4_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_cmp4_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_cmp4_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_cmp4_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_cmp4_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_cmp4_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_cmp4_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rnode_1to2_cmp4_1_NO_SHIFT_REG),
	.data_out(rnode_2to164_cmp4_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_cmp4_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_cmp4_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_2to164_cmp4_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_cmp4_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_cmp4_0_reg_164_inputs_ready_NO_SHIFT_REG = rnode_1to2_cmp4_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_cmp4_0_stall_in_1_NO_SHIFT_REG = rnode_2to164_cmp4_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_cmp4_0_NO_SHIFT_REG = rnode_2to164_cmp4_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_cmp4_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_cmp4_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_cmp4_0_valid_out_NO_SHIFT_REG = rnode_2to164_cmp4_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_c0_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_c0_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to164_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_2to164_c0_exe7_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to164_c0_exe7_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_c0_exe7_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_c0_exe7_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_c0_exe7_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_c0_exe7_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_c0_exe7_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_c0_exe7_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_c0_exe7_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_c0_exe7_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rnode_1to2_c0_exe7_1_NO_SHIFT_REG),
	.data_out(rnode_2to164_c0_exe7_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_c0_exe7_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_c0_exe7_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_2to164_c0_exe7_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_c0_exe7_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_c0_exe7_0_reg_164_inputs_ready_NO_SHIFT_REG = rnode_1to2_c0_exe7_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_c0_exe7_0_stall_in_1_NO_SHIFT_REG = rnode_2to164_c0_exe7_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_c0_exe7_0_NO_SHIFT_REG = rnode_2to164_c0_exe7_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_c0_exe7_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_c0_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_c0_exe7_0_valid_out_NO_SHIFT_REG = rnode_2to164_c0_exe7_0_valid_out_reg_164_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_arrayidx_valid_out;
wire local_bb3_arrayidx_stall_in;
wire local_bb3_arrayidx_inputs_ready;
wire local_bb3_arrayidx_stall_local;
wire [63:0] local_bb3_arrayidx;

assign local_bb3_arrayidx_inputs_ready = (rnode_1to2_input_data_0_valid_out_NO_SHIFT_REG & rnode_1to2_indvars_iv17_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3_arrayidx = (input_data + (rnode_1to2_indvars_iv17_0_NO_SHIFT_REG << 6'h2));
assign local_bb3_arrayidx_valid_out = local_bb3_arrayidx_inputs_ready;
assign local_bb3_arrayidx_stall_local = local_bb3_arrayidx_stall_in;
assign rnode_1to2_input_data_0_stall_in_NO_SHIFT_REG = (local_bb3_arrayidx_stall_local | ~(local_bb3_arrayidx_inputs_ready));
assign rnode_1to2_indvars_iv17_0_stall_in_0_NO_SHIFT_REG = (local_bb3_arrayidx_stall_local | ~(local_bb3_arrayidx_inputs_ready));

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_indvars_iv17_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_indvars_iv17_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_2to164_indvars_iv17_0_NO_SHIFT_REG;
 logic rnode_2to164_indvars_iv17_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_2to164_indvars_iv17_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_indvars_iv17_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_indvars_iv17_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_indvars_iv17_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_indvars_iv17_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_indvars_iv17_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_indvars_iv17_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_indvars_iv17_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_indvars_iv17_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rnode_1to2_indvars_iv17_1_NO_SHIFT_REG),
	.data_out(rnode_2to164_indvars_iv17_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_indvars_iv17_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_indvars_iv17_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_2to164_indvars_iv17_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_indvars_iv17_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_indvars_iv17_0_reg_164_inputs_ready_NO_SHIFT_REG = rnode_1to2_indvars_iv17_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_indvars_iv17_0_stall_in_1_NO_SHIFT_REG = rnode_2to164_indvars_iv17_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_indvars_iv17_0_NO_SHIFT_REG = rnode_2to164_indvars_iv17_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_indvars_iv17_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_indvars_iv17_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_indvars_iv17_0_valid_out_NO_SHIFT_REG = rnode_2to164_indvars_iv17_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_161to162_ld__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_161to162_ld__0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_ld__0_NO_SHIFT_REG;
 logic rnode_161to162_ld__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_161to162_ld__0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_ld__1_NO_SHIFT_REG;
 logic rnode_161to162_ld__0_valid_out_2_NO_SHIFT_REG;
 logic rnode_161to162_ld__0_stall_in_2_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_ld__2_NO_SHIFT_REG;
 logic rnode_161to162_ld__0_reg_162_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_ld__0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_ld__0_valid_out_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_ld__0_stall_in_0_reg_162_NO_SHIFT_REG;
 logic rnode_161to162_ld__0_stall_out_reg_162_NO_SHIFT_REG;
 logic [31:0] rnode_161to162_ld__0_reg_162_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_161to162_ld__0_reg_162_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_161to162_ld__0_reg_162_NO_SHIFT_REG),
	.valid_in(rnode_161to162_ld__0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_ld__0_stall_in_0_reg_162_NO_SHIFT_REG),
	.data_out(rnode_161to162_ld__0_reg_162_NO_SHIFT_REG_fa),
	.valid_out({rnode_161to162_ld__0_valid_out_0_NO_SHIFT_REG, rnode_161to162_ld__0_valid_out_1_NO_SHIFT_REG, rnode_161to162_ld__0_valid_out_2_NO_SHIFT_REG}),
	.stall_in({rnode_161to162_ld__0_stall_in_0_NO_SHIFT_REG, rnode_161to162_ld__0_stall_in_1_NO_SHIFT_REG, rnode_161to162_ld__0_stall_in_2_NO_SHIFT_REG})
);

defparam rnode_161to162_ld__0_reg_162_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_161to162_ld__0_reg_162_fanout_adaptor.NUM_FANOUTS = 3;

acl_data_fifo rnode_161to162_ld__0_reg_162_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to162_ld__0_reg_162_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to162_ld__0_stall_in_0_reg_162_NO_SHIFT_REG),
	.valid_out(rnode_161to162_ld__0_valid_out_0_reg_162_NO_SHIFT_REG),
	.stall_out(rnode_161to162_ld__0_stall_out_reg_162_NO_SHIFT_REG),
	.data_in(rnode_1to161_ld__0_NO_SHIFT_REG),
	.data_out(rnode_161to162_ld__0_reg_162_NO_SHIFT_REG)
);

defparam rnode_161to162_ld__0_reg_162_fifo.DEPTH = 2;
defparam rnode_161to162_ld__0_reg_162_fifo.DATA_WIDTH = 32;
defparam rnode_161to162_ld__0_reg_162_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to162_ld__0_reg_162_fifo.IMPL = "ll_reg";

assign rnode_161to162_ld__0_reg_162_inputs_ready_NO_SHIFT_REG = rnode_1to161_ld__0_valid_out_NO_SHIFT_REG;
assign rnode_1to161_ld__0_stall_in_NO_SHIFT_REG = rnode_161to162_ld__0_stall_out_reg_162_NO_SHIFT_REG;
assign rnode_161to162_ld__0_NO_SHIFT_REG = rnode_161to162_ld__0_reg_162_NO_SHIFT_REG_fa;
assign rnode_161to162_ld__1_NO_SHIFT_REG = rnode_161to162_ld__0_reg_162_NO_SHIFT_REG_fa;
assign rnode_161to162_ld__2_NO_SHIFT_REG = rnode_161to162_ld__0_reg_162_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb3_cmp6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp6_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp6_0_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp6_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp6_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp6_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp6_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp6_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb3_cmp6_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb3_cmp6_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb3_cmp6_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb3_cmp6_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb3_cmp6_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb3_cmp6),
	.data_out(rnode_1to2_bb3_cmp6_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb3_cmp6_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb3_cmp6_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb3_cmp6_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb3_cmp6_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb3_cmp6_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb3_cmp6_valid_out;
assign local_bb3_cmp6_stall_in = rnode_1to2_bb3_cmp6_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb3_cmp6_0_NO_SHIFT_REG = rnode_1to2_bb3_cmp6_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb3_cmp6_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_bb3_cmp6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_bb3_cmp6_0_valid_out_NO_SHIFT_REG = rnode_1to2_bb3_cmp6_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_bb3_cmp20_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_bb3_cmp20_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to164_bb3_cmp20_0_NO_SHIFT_REG;
 logic rnode_1to164_bb3_cmp20_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to164_bb3_cmp20_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_bb3_cmp20_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_bb3_cmp20_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_bb3_cmp20_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_bb3_cmp20_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_bb3_cmp20_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_bb3_cmp20_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_bb3_cmp20_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_bb3_cmp20_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb3_cmp20),
	.data_out(rnode_1to164_bb3_cmp20_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_bb3_cmp20_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_bb3_cmp20_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_1to164_bb3_cmp20_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_bb3_cmp20_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_bb3_cmp20_0_reg_164_inputs_ready_NO_SHIFT_REG = local_bb3_cmp20_valid_out;
assign local_bb3_cmp20_stall_in = rnode_1to164_bb3_cmp20_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_bb3_cmp20_0_NO_SHIFT_REG = rnode_1to164_bb3_cmp20_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_bb3_cmp20_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_bb3_cmp20_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_bb3_cmp20_0_valid_out_NO_SHIFT_REG = rnode_1to164_bb3_cmp20_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_cmp4_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_cmp4_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_cmp4_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp4_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_cmp4_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp4_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp4_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp4_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_cmp4_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_cmp4_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_cmp4_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_cmp4_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_cmp4_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_cmp4_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_cmp4_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_cmp4_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_cmp4_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_cmp4_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_cmp4_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_cmp4_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_cmp4_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_cmp4_0_stall_in_NO_SHIFT_REG = rnode_164to165_cmp4_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_cmp4_0_NO_SHIFT_REG = rnode_164to165_cmp4_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_cmp4_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_cmp4_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_cmp4_0_valid_out_NO_SHIFT_REG = rnode_164to165_cmp4_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_c0_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_c0_exe7_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_c0_exe7_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_c0_exe7_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_c0_exe7_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_c0_exe7_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_c0_exe7_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_c0_exe7_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_c0_exe7_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_c0_exe7_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_c0_exe7_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_c0_exe7_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_c0_exe7_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_c0_exe7_0_stall_in_NO_SHIFT_REG = rnode_164to165_c0_exe7_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe7_0_NO_SHIFT_REG = rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe7_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_c0_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_c0_exe7_0_valid_out_NO_SHIFT_REG = rnode_164to165_c0_exe7_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_2to2_bb3_arrayidx_valid_out;
wire rstag_2to2_bb3_arrayidx_stall_in;
wire rstag_2to2_bb3_arrayidx_inputs_ready;
wire rstag_2to2_bb3_arrayidx_stall_local;
 reg rstag_2to2_bb3_arrayidx_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb3_arrayidx_combined_valid;
 reg [63:0] rstag_2to2_bb3_arrayidx_staging_reg_NO_SHIFT_REG;
wire [63:0] rstag_2to2_bb3_arrayidx;

assign rstag_2to2_bb3_arrayidx_inputs_ready = local_bb3_arrayidx_valid_out;
assign rstag_2to2_bb3_arrayidx = (rstag_2to2_bb3_arrayidx_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb3_arrayidx_staging_reg_NO_SHIFT_REG : local_bb3_arrayidx);
assign rstag_2to2_bb3_arrayidx_combined_valid = (rstag_2to2_bb3_arrayidx_staging_valid_NO_SHIFT_REG | rstag_2to2_bb3_arrayidx_inputs_ready);
assign rstag_2to2_bb3_arrayidx_valid_out = rstag_2to2_bb3_arrayidx_combined_valid;
assign rstag_2to2_bb3_arrayidx_stall_local = rstag_2to2_bb3_arrayidx_stall_in;
assign local_bb3_arrayidx_stall_in = (|rstag_2to2_bb3_arrayidx_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb3_arrayidx_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb3_arrayidx_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb3_arrayidx_stall_local)
		begin
			if (~(rstag_2to2_bb3_arrayidx_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb3_arrayidx_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb3_arrayidx_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb3_arrayidx_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb3_arrayidx_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb3_arrayidx_staging_reg_NO_SHIFT_REG <= local_bb3_arrayidx;
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_indvars_iv17_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv17_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_indvars_iv17_0_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv17_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_indvars_iv17_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv17_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv17_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_indvars_iv17_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_indvars_iv17_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_indvars_iv17_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_indvars_iv17_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_indvars_iv17_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_indvars_iv17_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_indvars_iv17_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_indvars_iv17_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_indvars_iv17_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_indvars_iv17_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_indvars_iv17_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_indvars_iv17_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_indvars_iv17_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_indvars_iv17_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_indvars_iv17_0_stall_in_NO_SHIFT_REG = rnode_164to165_indvars_iv17_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_indvars_iv17_0_NO_SHIFT_REG = rnode_164to165_indvars_iv17_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_indvars_iv17_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_indvars_iv17_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_indvars_iv17_0_valid_out_NO_SHIFT_REG = rnode_164to165_indvars_iv17_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_162to165_ld__0_valid_out_NO_SHIFT_REG;
 logic rnode_162to165_ld__0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_162to165_ld__0_NO_SHIFT_REG;
 logic rnode_162to165_ld__0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_162to165_ld__0_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_ld__0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_ld__0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_ld__0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_162to165_ld__0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_162to165_ld__0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_162to165_ld__0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_162to165_ld__0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_162to165_ld__0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_161to162_ld__2_NO_SHIFT_REG),
	.data_out(rnode_162to165_ld__0_reg_165_NO_SHIFT_REG)
);

defparam rnode_162to165_ld__0_reg_165_fifo.DEPTH = 4;
defparam rnode_162to165_ld__0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_162to165_ld__0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_162to165_ld__0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_162to165_ld__0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_161to162_ld__0_valid_out_2_NO_SHIFT_REG;
assign rnode_161to162_ld__0_stall_in_2_NO_SHIFT_REG = rnode_162to165_ld__0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_162to165_ld__0_NO_SHIFT_REG = rnode_162to165_ld__0_reg_165_NO_SHIFT_REG;
assign rnode_162to165_ld__0_stall_in_reg_165_NO_SHIFT_REG = rnode_162to165_ld__0_stall_in_NO_SHIFT_REG;
assign rnode_162to165_ld__0_valid_out_NO_SHIFT_REG = rnode_162to165_ld__0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or_cond_stall_local;
wire local_bb3_or_cond;

assign local_bb3_or_cond = (rnode_1to2_cmp4_0_NO_SHIFT_REG & rnode_1to2_bb3_cmp6_0_NO_SHIFT_REG);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb3_cmp20_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp20_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp20_0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp20_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp20_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp20_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp20_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp20_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb3_cmp20_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb3_cmp20_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb3_cmp20_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb3_cmp20_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb3_cmp20_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_bb3_cmp20_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb3_cmp20_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb3_cmp20_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb3_cmp20_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb3_cmp20_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb3_cmp20_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb3_cmp20_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_bb3_cmp20_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_bb3_cmp20_0_stall_in_NO_SHIFT_REG = rnode_164to165_bb3_cmp20_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_cmp20_0_NO_SHIFT_REG = rnode_164to165_bb3_cmp20_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_cmp20_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_bb3_cmp20_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_bb3_cmp20_0_valid_out_NO_SHIFT_REG = rnode_164to165_bb3_cmp20_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or_cond_valid_out_1;
wire local_bb3_or_cond_stall_in_1;
 reg local_bb3_or_cond_consumed_1_NO_SHIFT_REG;
wire local_bb3_var__valid_out;
wire local_bb3_var__stall_in;
 reg local_bb3_var__consumed_0_NO_SHIFT_REG;
wire local_bb3_var__inputs_ready;
wire local_bb3_var__stall_local;
wire local_bb3_var_;

assign local_bb3_var__inputs_ready = (rnode_1to2_bb3_cmp6_0_valid_out_NO_SHIFT_REG & rnode_1to2_cmp4_0_valid_out_0_NO_SHIFT_REG & rnode_1to2_c0_exe7_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3_var_ = (local_bb3_or_cond | rnode_1to2_c0_exe7_0_NO_SHIFT_REG);
assign local_bb3_var__stall_local = ((local_bb3_or_cond_stall_in_1 & ~(local_bb3_or_cond_consumed_1_NO_SHIFT_REG)) | (local_bb3_var__stall_in & ~(local_bb3_var__consumed_0_NO_SHIFT_REG)));
assign local_bb3_or_cond_valid_out_1 = (local_bb3_var__inputs_ready & ~(local_bb3_or_cond_consumed_1_NO_SHIFT_REG));
assign local_bb3_var__valid_out = (local_bb3_var__inputs_ready & ~(local_bb3_var__consumed_0_NO_SHIFT_REG));
assign rnode_1to2_bb3_cmp6_0_stall_in_NO_SHIFT_REG = (local_bb3_var__stall_local | ~(local_bb3_var__inputs_ready));
assign rnode_1to2_cmp4_0_stall_in_0_NO_SHIFT_REG = (local_bb3_var__stall_local | ~(local_bb3_var__inputs_ready));
assign rnode_1to2_c0_exe7_0_stall_in_0_NO_SHIFT_REG = (local_bb3_var__stall_local | ~(local_bb3_var__inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_or_cond_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb3_var__consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb3_or_cond_consumed_1_NO_SHIFT_REG <= (local_bb3_var__inputs_ready & (local_bb3_or_cond_consumed_1_NO_SHIFT_REG | ~(local_bb3_or_cond_stall_in_1)) & local_bb3_var__stall_local);
		local_bb3_var__consumed_0_NO_SHIFT_REG <= (local_bb3_var__inputs_ready & (local_bb3_var__consumed_0_NO_SHIFT_REG | ~(local_bb3_var__stall_in)) & local_bb3_var__stall_local);
	end
end


// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_bb3_or_cond_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_bb3_or_cond_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to164_bb3_or_cond_0_NO_SHIFT_REG;
 logic rnode_2to164_bb3_or_cond_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to164_bb3_or_cond_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_or_cond_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_or_cond_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_or_cond_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_bb3_or_cond_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_bb3_or_cond_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_bb3_or_cond_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_bb3_or_cond_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_bb3_or_cond_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb3_or_cond),
	.data_out(rnode_2to164_bb3_or_cond_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_bb3_or_cond_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_bb3_or_cond_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_2to164_bb3_or_cond_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_bb3_or_cond_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_bb3_or_cond_0_reg_164_inputs_ready_NO_SHIFT_REG = local_bb3_or_cond_valid_out_1;
assign local_bb3_or_cond_stall_in_1 = rnode_2to164_bb3_or_cond_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_or_cond_0_NO_SHIFT_REG = rnode_2to164_bb3_or_cond_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_or_cond_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_bb3_or_cond_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_bb3_or_cond_0_valid_out_NO_SHIFT_REG = rnode_2to164_bb3_or_cond_0_valid_out_reg_164_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_2to2_bb3_var__valid_out_0;
wire rstag_2to2_bb3_var__stall_in_0;
 reg rstag_2to2_bb3_var__consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb3_var__valid_out_1;
wire rstag_2to2_bb3_var__stall_in_1;
 reg rstag_2to2_bb3_var__consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb3_var__inputs_ready;
wire rstag_2to2_bb3_var__stall_local;
 reg rstag_2to2_bb3_var__staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb3_var__combined_valid;
 reg rstag_2to2_bb3_var__staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb3_var_;

assign rstag_2to2_bb3_var__inputs_ready = local_bb3_var__valid_out;
assign rstag_2to2_bb3_var_ = (rstag_2to2_bb3_var__staging_valid_NO_SHIFT_REG ? rstag_2to2_bb3_var__staging_reg_NO_SHIFT_REG : local_bb3_var_);
assign rstag_2to2_bb3_var__combined_valid = (rstag_2to2_bb3_var__staging_valid_NO_SHIFT_REG | rstag_2to2_bb3_var__inputs_ready);
assign rstag_2to2_bb3_var__stall_local = ((rstag_2to2_bb3_var__stall_in_0 & ~(rstag_2to2_bb3_var__consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb3_var__stall_in_1 & ~(rstag_2to2_bb3_var__consumed_1_NO_SHIFT_REG)));
assign rstag_2to2_bb3_var__valid_out_0 = (rstag_2to2_bb3_var__combined_valid & ~(rstag_2to2_bb3_var__consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb3_var__valid_out_1 = (rstag_2to2_bb3_var__combined_valid & ~(rstag_2to2_bb3_var__consumed_1_NO_SHIFT_REG));
assign local_bb3_var__stall_in = (|rstag_2to2_bb3_var__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb3_var__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb3_var__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb3_var__stall_local)
		begin
			if (~(rstag_2to2_bb3_var__staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb3_var__staging_valid_NO_SHIFT_REG <= rstag_2to2_bb3_var__inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb3_var__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb3_var__staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb3_var__staging_reg_NO_SHIFT_REG <= local_bb3_var_;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb3_var__consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb3_var__consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb3_var__consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb3_var__combined_valid & (rstag_2to2_bb3_var__consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb3_var__stall_in_0)) & rstag_2to2_bb3_var__stall_local);
		rstag_2to2_bb3_var__consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb3_var__combined_valid & (rstag_2to2_bb3_var__consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb3_var__stall_in_1)) & rstag_2to2_bb3_var__stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb3_or_cond_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb3_or_cond_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_bb3_or_cond_0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_or_cond_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb3_or_cond_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_or_cond_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_or_cond_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_or_cond_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb3_or_cond_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb3_or_cond_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb3_or_cond_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb3_or_cond_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb3_or_cond_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_bb3_or_cond_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb3_or_cond_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb3_or_cond_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb3_or_cond_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb3_or_cond_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb3_or_cond_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb3_or_cond_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_bb3_or_cond_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_bb3_or_cond_0_stall_in_NO_SHIFT_REG = rnode_164to165_bb3_or_cond_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_or_cond_0_NO_SHIFT_REG = rnode_164to165_bb3_or_cond_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_or_cond_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_bb3_or_cond_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_bb3_or_cond_0_valid_out_NO_SHIFT_REG = rnode_164to165_bb3_or_cond_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_bb3_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__0_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_bb3_var__0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_bb3_var__0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_bb3_var__0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_bb3_var__0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_bb3_var__0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rstag_2to2_bb3_var_),
	.data_out(rnode_2to164_bb3_var__0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_bb3_var__0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_bb3_var__0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_2to164_bb3_var__0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_bb3_var__0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_bb3_var__0_reg_164_inputs_ready_NO_SHIFT_REG = rstag_2to2_bb3_var__valid_out_0;
assign rstag_2to2_bb3_var__stall_in_0 = rnode_2to164_bb3_var__0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_var__0_NO_SHIFT_REG = rnode_2to164_bb3_var__0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_var__0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_bb3_var__0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_bb3_var__0_valid_out_NO_SHIFT_REG = rnode_2to164_bb3_var__0_valid_out_reg_164_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb3_ld__pre_pre_inputs_ready;
 reg local_bb3_ld__pre_pre_valid_out_NO_SHIFT_REG;
wire local_bb3_ld__pre_pre_stall_in;
wire local_bb3_ld__pre_pre_output_regs_ready;
wire local_bb3_ld__pre_pre_fu_stall_out;
wire local_bb3_ld__pre_pre_fu_valid_out;
wire [31:0] local_bb3_ld__pre_pre_lsu_dataout;
 reg [31:0] local_bb3_ld__pre_pre_NO_SHIFT_REG;
wire local_bb3_ld__pre_pre_causedstall;

lsu_top lsu_local_bb3_ld__pre_pre (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb3_ld__pre_pre_fu_stall_out),
	.i_valid(local_bb3_ld__pre_pre_inputs_ready),
	.i_address(rstag_2to2_bb3_arrayidx),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_2to2_bb3_var_),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb3_ld__pre_pre_output_regs_ready)),
	.o_valid(local_bb3_ld__pre_pre_fu_valid_out),
	.o_readdata(local_bb3_ld__pre_pre_lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb3_ld__pre_pre_active),
	.avm_address(avm_local_bb3_ld__pre_pre_address),
	.avm_read(avm_local_bb3_ld__pre_pre_read),
	.avm_readdata(avm_local_bb3_ld__pre_pre_readdata),
	.avm_write(avm_local_bb3_ld__pre_pre_write),
	.avm_writeack(avm_local_bb3_ld__pre_pre_writeack),
	.avm_burstcount(avm_local_bb3_ld__pre_pre_burstcount),
	.avm_writedata(avm_local_bb3_ld__pre_pre_writedata),
	.avm_byteenable(avm_local_bb3_ld__pre_pre_byteenable),
	.avm_waitrequest(avm_local_bb3_ld__pre_pre_waitrequest),
	.avm_readdatavalid(avm_local_bb3_ld__pre_pre_readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb3_ld__pre_pre.AWIDTH = 30;
defparam lsu_local_bb3_ld__pre_pre.WIDTH_BYTES = 4;
defparam lsu_local_bb3_ld__pre_pre.MWIDTH_BYTES = 32;
defparam lsu_local_bb3_ld__pre_pre.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb3_ld__pre_pre.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb3_ld__pre_pre.READ = 1;
defparam lsu_local_bb3_ld__pre_pre.ATOMIC = 0;
defparam lsu_local_bb3_ld__pre_pre.WIDTH = 32;
defparam lsu_local_bb3_ld__pre_pre.MWIDTH = 256;
defparam lsu_local_bb3_ld__pre_pre.ATOMIC_WIDTH = 3;
defparam lsu_local_bb3_ld__pre_pre.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb3_ld__pre_pre.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb3_ld__pre_pre.MEMORY_SIDE_MEM_LATENCY = 138;
defparam lsu_local_bb3_ld__pre_pre.USE_WRITE_ACK = 0;
defparam lsu_local_bb3_ld__pre_pre.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb3_ld__pre_pre.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb3_ld__pre_pre.NUMBER_BANKS = 1;
defparam lsu_local_bb3_ld__pre_pre.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb3_ld__pre_pre.USEINPUTFIFO = 0;
defparam lsu_local_bb3_ld__pre_pre.USECACHING = 0;
defparam lsu_local_bb3_ld__pre_pre.USEOUTPUTFIFO = 1;
defparam lsu_local_bb3_ld__pre_pre.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb3_ld__pre_pre.HIGH_FMAX = 1;
defparam lsu_local_bb3_ld__pre_pre.ADDRSPACE = 1;
defparam lsu_local_bb3_ld__pre_pre.STYLE = "BURST-COALESCED";

assign local_bb3_ld__pre_pre_inputs_ready = (rstag_2to2_bb3_var__valid_out_1 & rstag_2to2_bb3_arrayidx_valid_out);
assign local_bb3_ld__pre_pre_output_regs_ready = (&(~(local_bb3_ld__pre_pre_valid_out_NO_SHIFT_REG) | ~(local_bb3_ld__pre_pre_stall_in)));
assign rstag_2to2_bb3_var__stall_in_1 = (local_bb3_ld__pre_pre_fu_stall_out | ~(local_bb3_ld__pre_pre_inputs_ready));
assign rstag_2to2_bb3_arrayidx_stall_in = (local_bb3_ld__pre_pre_fu_stall_out | ~(local_bb3_ld__pre_pre_inputs_ready));
assign local_bb3_ld__pre_pre_causedstall = (local_bb3_ld__pre_pre_inputs_ready && (local_bb3_ld__pre_pre_fu_stall_out && !(~(local_bb3_ld__pre_pre_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_ld__pre_pre_NO_SHIFT_REG <= 'x;
		local_bb3_ld__pre_pre_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_ld__pre_pre_output_regs_ready)
		begin
			local_bb3_ld__pre_pre_NO_SHIFT_REG <= local_bb3_ld__pre_pre_lsu_dataout;
			local_bb3_ld__pre_pre_valid_out_NO_SHIFT_REG <= local_bb3_ld__pre_pre_fu_valid_out;
		end
		else
		begin
			if (~(local_bb3_ld__pre_pre_stall_in))
			begin
				local_bb3_ld__pre_pre_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb3_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb3_var__0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb3_var__0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb3_var__0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb3_var__0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb3_var__0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_bb3_var__0_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb3_var__0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb3_var__0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb3_var__0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb3_var__0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb3_var__0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb3_var__0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_bb3_var__0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_bb3_var__0_stall_in_NO_SHIFT_REG = rnode_164to165_bb3_var__0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_var__0_NO_SHIFT_REG = rnode_164to165_bb3_var__0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_var__0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_bb3_var__0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_bb3_var__0_valid_out_NO_SHIFT_REG = rnode_164to165_bb3_var__0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_162to162_bb3_ld__pre_pre_valid_out_0;
wire rstag_162to162_bb3_ld__pre_pre_stall_in_0;
 reg rstag_162to162_bb3_ld__pre_pre_consumed_0_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__pre_pre_valid_out_1;
wire rstag_162to162_bb3_ld__pre_pre_stall_in_1;
 reg rstag_162to162_bb3_ld__pre_pre_consumed_1_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__pre_pre_valid_out_2;
wire rstag_162to162_bb3_ld__pre_pre_stall_in_2;
 reg rstag_162to162_bb3_ld__pre_pre_consumed_2_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__pre_pre_inputs_ready;
wire rstag_162to162_bb3_ld__pre_pre_stall_local;
 reg rstag_162to162_bb3_ld__pre_pre_staging_valid_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__pre_pre_combined_valid;
 reg [31:0] rstag_162to162_bb3_ld__pre_pre_staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_162to162_bb3_ld__pre_pre;

assign rstag_162to162_bb3_ld__pre_pre_inputs_ready = local_bb3_ld__pre_pre_valid_out_NO_SHIFT_REG;
assign rstag_162to162_bb3_ld__pre_pre = (rstag_162to162_bb3_ld__pre_pre_staging_valid_NO_SHIFT_REG ? rstag_162to162_bb3_ld__pre_pre_staging_reg_NO_SHIFT_REG : local_bb3_ld__pre_pre_NO_SHIFT_REG);
assign rstag_162to162_bb3_ld__pre_pre_combined_valid = (rstag_162to162_bb3_ld__pre_pre_staging_valid_NO_SHIFT_REG | rstag_162to162_bb3_ld__pre_pre_inputs_ready);
assign rstag_162to162_bb3_ld__pre_pre_stall_local = ((rstag_162to162_bb3_ld__pre_pre_stall_in_0 & ~(rstag_162to162_bb3_ld__pre_pre_consumed_0_NO_SHIFT_REG)) | (rstag_162to162_bb3_ld__pre_pre_stall_in_1 & ~(rstag_162to162_bb3_ld__pre_pre_consumed_1_NO_SHIFT_REG)) | (rstag_162to162_bb3_ld__pre_pre_stall_in_2 & ~(rstag_162to162_bb3_ld__pre_pre_consumed_2_NO_SHIFT_REG)));
assign rstag_162to162_bb3_ld__pre_pre_valid_out_0 = (rstag_162to162_bb3_ld__pre_pre_combined_valid & ~(rstag_162to162_bb3_ld__pre_pre_consumed_0_NO_SHIFT_REG));
assign rstag_162to162_bb3_ld__pre_pre_valid_out_1 = (rstag_162to162_bb3_ld__pre_pre_combined_valid & ~(rstag_162to162_bb3_ld__pre_pre_consumed_1_NO_SHIFT_REG));
assign rstag_162to162_bb3_ld__pre_pre_valid_out_2 = (rstag_162to162_bb3_ld__pre_pre_combined_valid & ~(rstag_162to162_bb3_ld__pre_pre_consumed_2_NO_SHIFT_REG));
assign local_bb3_ld__pre_pre_stall_in = (|rstag_162to162_bb3_ld__pre_pre_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb3_ld__pre_pre_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb3_ld__pre_pre_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_162to162_bb3_ld__pre_pre_stall_local)
		begin
			if (~(rstag_162to162_bb3_ld__pre_pre_staging_valid_NO_SHIFT_REG))
			begin
				rstag_162to162_bb3_ld__pre_pre_staging_valid_NO_SHIFT_REG <= rstag_162to162_bb3_ld__pre_pre_inputs_ready;
			end
		end
		else
		begin
			rstag_162to162_bb3_ld__pre_pre_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_162to162_bb3_ld__pre_pre_staging_valid_NO_SHIFT_REG))
		begin
			rstag_162to162_bb3_ld__pre_pre_staging_reg_NO_SHIFT_REG <= local_bb3_ld__pre_pre_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb3_ld__pre_pre_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb3_ld__pre_pre_consumed_1_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb3_ld__pre_pre_consumed_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_162to162_bb3_ld__pre_pre_consumed_0_NO_SHIFT_REG <= (rstag_162to162_bb3_ld__pre_pre_combined_valid & (rstag_162to162_bb3_ld__pre_pre_consumed_0_NO_SHIFT_REG | ~(rstag_162to162_bb3_ld__pre_pre_stall_in_0)) & rstag_162to162_bb3_ld__pre_pre_stall_local);
		rstag_162to162_bb3_ld__pre_pre_consumed_1_NO_SHIFT_REG <= (rstag_162to162_bb3_ld__pre_pre_combined_valid & (rstag_162to162_bb3_ld__pre_pre_consumed_1_NO_SHIFT_REG | ~(rstag_162to162_bb3_ld__pre_pre_stall_in_1)) & rstag_162to162_bb3_ld__pre_pre_stall_local);
		rstag_162to162_bb3_ld__pre_pre_consumed_2_NO_SHIFT_REG <= (rstag_162to162_bb3_ld__pre_pre_combined_valid & (rstag_162to162_bb3_ld__pre_pre_consumed_2_NO_SHIFT_REG | ~(rstag_162to162_bb3_ld__pre_pre_stall_in_2)) & rstag_162to162_bb3_ld__pre_pre_stall_local);
	end
end


// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_162to165_bb3_ld__pre_pre_0_valid_out_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__pre_pre_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_162to165_bb3_ld__pre_pre_0_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__pre_pre_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_162to165_bb3_ld__pre_pre_0_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__pre_pre_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__pre_pre_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__pre_pre_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_162to165_bb3_ld__pre_pre_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_162to165_bb3_ld__pre_pre_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_162to165_bb3_ld__pre_pre_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_162to165_bb3_ld__pre_pre_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_162to165_bb3_ld__pre_pre_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rstag_162to162_bb3_ld__pre_pre),
	.data_out(rnode_162to165_bb3_ld__pre_pre_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_162to165_bb3_ld__pre_pre_0_reg_165_fifo.DEPTH = 4;
defparam rnode_162to165_bb3_ld__pre_pre_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_162to165_bb3_ld__pre_pre_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_162to165_bb3_ld__pre_pre_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_162to165_bb3_ld__pre_pre_0_reg_165_inputs_ready_NO_SHIFT_REG = rstag_162to162_bb3_ld__pre_pre_valid_out_0;
assign rstag_162to162_bb3_ld__pre_pre_stall_in_0 = rnode_162to165_bb3_ld__pre_pre_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_162to165_bb3_ld__pre_pre_0_NO_SHIFT_REG = rnode_162to165_bb3_ld__pre_pre_0_reg_165_NO_SHIFT_REG;
assign rnode_162to165_bb3_ld__pre_pre_0_stall_in_reg_165_NO_SHIFT_REG = rnode_162to165_bb3_ld__pre_pre_0_stall_in_NO_SHIFT_REG;
assign rnode_162to165_bb3_ld__pre_pre_0_valid_out_NO_SHIFT_REG = rnode_162to165_bb3_ld__pre_pre_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb3_cmp27_inputs_ready;
 reg local_bb3_cmp27_valid_out_NO_SHIFT_REG;
wire local_bb3_cmp27_stall_in;
wire local_bb3_cmp27_output_regs_ready;
wire local_bb3_cmp27;
 reg local_bb3_cmp27_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb3_cmp27_valid_pipe_1_NO_SHIFT_REG;
wire local_bb3_cmp27_causedstall;

acl_fp_cmp fp_module_local_bb3_cmp27 (
	.clock(clock),
	.dataa(rnode_161to162_ld__1_NO_SHIFT_REG),
	.datab(rstag_162to162_bb3_ld__pre_pre),
	.enable(local_bb3_cmp27_output_regs_ready),
	.result(local_bb3_cmp27)
);

defparam fp_module_local_bb3_cmp27.UNORDERED_MODE = 1;
defparam fp_module_local_bb3_cmp27.COMPARISON_MODE = 3;

assign local_bb3_cmp27_inputs_ready = (rnode_161to162_ld__0_valid_out_1_NO_SHIFT_REG & rstag_162to162_bb3_ld__pre_pre_valid_out_1);
assign local_bb3_cmp27_output_regs_ready = (&(~(local_bb3_cmp27_valid_out_NO_SHIFT_REG) | ~(local_bb3_cmp27_stall_in)));
assign rnode_161to162_ld__0_stall_in_1_NO_SHIFT_REG = (~(local_bb3_cmp27_output_regs_ready) | ~(local_bb3_cmp27_inputs_ready));
assign rstag_162to162_bb3_ld__pre_pre_stall_in_1 = (~(local_bb3_cmp27_output_regs_ready) | ~(local_bb3_cmp27_inputs_ready));
assign local_bb3_cmp27_causedstall = (local_bb3_cmp27_inputs_ready && (~(local_bb3_cmp27_output_regs_ready) && !(~(local_bb3_cmp27_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp27_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb3_cmp27_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp27_output_regs_ready)
		begin
			local_bb3_cmp27_valid_pipe_0_NO_SHIFT_REG <= local_bb3_cmp27_inputs_ready;
			local_bb3_cmp27_valid_pipe_1_NO_SHIFT_REG <= local_bb3_cmp27_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp27_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp27_output_regs_ready)
		begin
			local_bb3_cmp27_valid_out_NO_SHIFT_REG <= local_bb3_cmp27_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb3_cmp27_stall_in))
			begin
				local_bb3_cmp27_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb3_cmp12_inputs_ready;
 reg local_bb3_cmp12_valid_out_NO_SHIFT_REG;
wire local_bb3_cmp12_stall_in;
wire local_bb3_cmp12_output_regs_ready;
wire local_bb3_cmp12;
 reg local_bb3_cmp12_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb3_cmp12_valid_pipe_1_NO_SHIFT_REG;
wire local_bb3_cmp12_causedstall;

acl_fp_cmp fp_module_local_bb3_cmp12 (
	.clock(clock),
	.dataa(rstag_162to162_bb3_ld__pre_pre),
	.datab(rnode_161to162_ld__0_NO_SHIFT_REG),
	.enable(local_bb3_cmp12_output_regs_ready),
	.result(local_bb3_cmp12)
);

defparam fp_module_local_bb3_cmp12.COMPARISON_MODE = 5;

assign local_bb3_cmp12_inputs_ready = (rnode_161to162_ld__0_valid_out_0_NO_SHIFT_REG & rstag_162to162_bb3_ld__pre_pre_valid_out_2);
assign local_bb3_cmp12_output_regs_ready = (&(~(local_bb3_cmp12_valid_out_NO_SHIFT_REG) | ~(local_bb3_cmp12_stall_in)));
assign rnode_161to162_ld__0_stall_in_0_NO_SHIFT_REG = (~(local_bb3_cmp12_output_regs_ready) | ~(local_bb3_cmp12_inputs_ready));
assign rstag_162to162_bb3_ld__pre_pre_stall_in_2 = (~(local_bb3_cmp12_output_regs_ready) | ~(local_bb3_cmp12_inputs_ready));
assign local_bb3_cmp12_causedstall = (local_bb3_cmp12_inputs_ready && (~(local_bb3_cmp12_output_regs_ready) && !(~(local_bb3_cmp12_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp12_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb3_cmp12_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp12_output_regs_ready)
		begin
			local_bb3_cmp12_valid_pipe_0_NO_SHIFT_REG <= local_bb3_cmp12_inputs_ready;
			local_bb3_cmp12_valid_pipe_1_NO_SHIFT_REG <= local_bb3_cmp12_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp12_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp12_output_regs_ready)
		begin
			local_bb3_cmp12_valid_out_NO_SHIFT_REG <= local_bb3_cmp12_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb3_cmp12_stall_in))
			begin
				local_bb3_cmp12_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_165to165_bb3_cmp27_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp27_0_stall_in_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp27_0_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp27_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp27_0_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp27_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp27_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp27_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_165to165_bb3_cmp27_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to165_bb3_cmp27_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to165_bb3_cmp27_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_165to165_bb3_cmp27_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_165to165_bb3_cmp27_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb3_cmp27),
	.data_out(rnode_165to165_bb3_cmp27_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_165to165_bb3_cmp27_0_reg_165_fifo.DEPTH = 3;
defparam rnode_165to165_bb3_cmp27_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_165to165_bb3_cmp27_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to165_bb3_cmp27_0_reg_165_fifo.IMPL = "zl_reg";

assign rnode_165to165_bb3_cmp27_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb3_cmp27_valid_out_NO_SHIFT_REG;
assign local_bb3_cmp27_stall_in = rnode_165to165_bb3_cmp27_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp27_0_NO_SHIFT_REG = rnode_165to165_bb3_cmp27_0_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp27_0_stall_in_reg_165_NO_SHIFT_REG = rnode_165to165_bb3_cmp27_0_stall_in_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp27_0_valid_out_NO_SHIFT_REG = rnode_165to165_bb3_cmp27_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_165to165_bb3_cmp12_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp12_0_stall_in_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp12_0_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp12_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp12_0_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp12_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp12_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp12_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_165to165_bb3_cmp12_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to165_bb3_cmp12_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to165_bb3_cmp12_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_165to165_bb3_cmp12_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_165to165_bb3_cmp12_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb3_cmp12),
	.data_out(rnode_165to165_bb3_cmp12_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_165to165_bb3_cmp12_0_reg_165_fifo.DEPTH = 3;
defparam rnode_165to165_bb3_cmp12_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_165to165_bb3_cmp12_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to165_bb3_cmp12_0_reg_165_fifo.IMPL = "zl_reg";

assign rnode_165to165_bb3_cmp12_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb3_cmp12_valid_out_NO_SHIFT_REG;
assign local_bb3_cmp12_stall_in = rnode_165to165_bb3_cmp12_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp12_0_NO_SHIFT_REG = rnode_165to165_bb3_cmp12_0_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp12_0_stall_in_reg_165_NO_SHIFT_REG = rnode_165to165_bb3_cmp12_0_stall_in_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp12_0_valid_out_NO_SHIFT_REG = rnode_165to165_bb3_cmp12_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_or_cond3_stall_local;
wire local_bb3_or_cond3;

assign local_bb3_or_cond3 = (rnode_164to165_bb3_cmp20_0_NO_SHIFT_REG & rnode_165to165_bb3_cmp27_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u3_stall_local;
wire local_bb3_var__u3;

assign local_bb3_var__u3 = (rnode_164to165_var__0_NO_SHIFT_REG | rnode_165to165_bb3_cmp12_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u4_stall_local;
wire local_bb3_var__u4;

assign local_bb3_var__u4 = (local_bb3_var__u3 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u3_valid_out_1;
wire local_bb3_var__u3_stall_in_1;
 reg local_bb3_var__u3_consumed_1_NO_SHIFT_REG;
wire local_bb3_var__u4_valid_out_1;
wire local_bb3_var__u4_stall_in_1;
 reg local_bb3_var__u4_consumed_1_NO_SHIFT_REG;
wire local_bb3_var__u5_valid_out;
wire local_bb3_var__u5_stall_in;
 reg local_bb3_var__u5_consumed_0_NO_SHIFT_REG;
wire local_bb3_var__u5_inputs_ready;
wire local_bb3_var__u5_stall_local;
wire local_bb3_var__u5;

assign local_bb3_var__u5_inputs_ready = (rnode_164to165_var__0_valid_out_0_NO_SHIFT_REG & rnode_165to165_bb3_cmp12_0_valid_out_NO_SHIFT_REG & rnode_164to165_bb3_cmp20_0_valid_out_NO_SHIFT_REG & rnode_165to165_bb3_cmp27_0_valid_out_NO_SHIFT_REG);
assign local_bb3_var__u5 = (local_bb3_or_cond3 & local_bb3_var__u4);
assign local_bb3_var__u5_stall_local = ((local_bb3_var__u3_stall_in_1 & ~(local_bb3_var__u3_consumed_1_NO_SHIFT_REG)) | (local_bb3_var__u4_stall_in_1 & ~(local_bb3_var__u4_consumed_1_NO_SHIFT_REG)) | (local_bb3_var__u5_stall_in & ~(local_bb3_var__u5_consumed_0_NO_SHIFT_REG)));
assign local_bb3_var__u3_valid_out_1 = (local_bb3_var__u5_inputs_ready & ~(local_bb3_var__u3_consumed_1_NO_SHIFT_REG));
assign local_bb3_var__u4_valid_out_1 = (local_bb3_var__u5_inputs_ready & ~(local_bb3_var__u4_consumed_1_NO_SHIFT_REG));
assign local_bb3_var__u5_valid_out = (local_bb3_var__u5_inputs_ready & ~(local_bb3_var__u5_consumed_0_NO_SHIFT_REG));
assign rnode_164to165_var__0_stall_in_0_NO_SHIFT_REG = (local_bb3_var__u5_stall_local | ~(local_bb3_var__u5_inputs_ready));
assign rnode_165to165_bb3_cmp12_0_stall_in_NO_SHIFT_REG = (local_bb3_var__u5_stall_local | ~(local_bb3_var__u5_inputs_ready));
assign rnode_164to165_bb3_cmp20_0_stall_in_NO_SHIFT_REG = (local_bb3_var__u5_stall_local | ~(local_bb3_var__u5_inputs_ready));
assign rnode_165to165_bb3_cmp27_0_stall_in_NO_SHIFT_REG = (local_bb3_var__u5_stall_local | ~(local_bb3_var__u5_inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_var__u3_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb3_var__u4_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb3_var__u5_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb3_var__u3_consumed_1_NO_SHIFT_REG <= (local_bb3_var__u5_inputs_ready & (local_bb3_var__u3_consumed_1_NO_SHIFT_REG | ~(local_bb3_var__u3_stall_in_1)) & local_bb3_var__u5_stall_local);
		local_bb3_var__u4_consumed_1_NO_SHIFT_REG <= (local_bb3_var__u5_inputs_ready & (local_bb3_var__u4_consumed_1_NO_SHIFT_REG | ~(local_bb3_var__u4_stall_in_1)) & local_bb3_var__u5_stall_local);
		local_bb3_var__u5_consumed_0_NO_SHIFT_REG <= (local_bb3_var__u5_inputs_ready & (local_bb3_var__u5_consumed_0_NO_SHIFT_REG | ~(local_bb3_var__u5_stall_in)) & local_bb3_var__u5_stall_local);
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_c0_exe1_reg_NO_SHIFT_REG;
 reg lvb_c0_exe2_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe3_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe4_reg_NO_SHIFT_REG;
 reg [63:0] lvb_c0_exe6_reg_NO_SHIFT_REG;
 reg lvb_c0_exe7_reg_NO_SHIFT_REG;
 reg [63:0] lvb_indvars_iv21_reg_NO_SHIFT_REG;
 reg lvb_cmp4_reg_NO_SHIFT_REG;
 reg lvb_var__reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__reg_NO_SHIFT_REG;
 reg [63:0] lvb_indvars_iv19_reg_NO_SHIFT_REG;
 reg [63:0] lvb_indvars_iv17_reg_NO_SHIFT_REG;
 reg [31:0] lvb_right_lower_0_ph7_reg_NO_SHIFT_REG;
 reg [31:0] lvb_temp_index_0_ph8_reg_NO_SHIFT_REG;
 reg lvb_bb3_or_cond_reg_NO_SHIFT_REG;
 reg lvb_bb3_var__reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb3_ld__pre_pre_reg_NO_SHIFT_REG;
 reg lvb_bb3_var__u3_reg_NO_SHIFT_REG;
 reg lvb_bb3_var__u4_reg_NO_SHIFT_REG;
 reg lvb_bb3_var__u5_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb3_var__u5_valid_out & local_bb3_var__u3_valid_out_1 & local_bb3_var__u4_valid_out_1 & rnode_162to165_bb3_ld__pre_pre_0_valid_out_NO_SHIFT_REG & rnode_162to165_ld__0_valid_out_NO_SHIFT_REG & rnode_164to165_var__0_valid_out_1_NO_SHIFT_REG & rnode_164to165_c0_exe1_0_valid_out_NO_SHIFT_REG & rnode_164to165_c0_exe2_0_valid_out_NO_SHIFT_REG & rnode_164to165_c0_exe3_0_valid_out_NO_SHIFT_REG & rnode_164to165_c0_exe4_0_valid_out_NO_SHIFT_REG & rnode_164to165_c0_exe6_0_valid_out_NO_SHIFT_REG & rnode_164to165_indvars_iv21_0_valid_out_NO_SHIFT_REG & rnode_164to165_indvars_iv19_0_valid_out_NO_SHIFT_REG & rnode_164to165_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG & rnode_164to165_temp_index_0_ph8_0_valid_out_NO_SHIFT_REG & rnode_164to165_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rnode_164to165_cmp4_0_valid_out_NO_SHIFT_REG & rnode_164to165_c0_exe7_0_valid_out_NO_SHIFT_REG & rnode_164to165_indvars_iv17_0_valid_out_NO_SHIFT_REG & rnode_164to165_bb3_or_cond_0_valid_out_NO_SHIFT_REG & rnode_164to165_bb3_var__0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb3_var__u5_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb3_var__u3_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb3_var__u4_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_162to165_bb3_ld__pre_pre_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_162to165_ld__0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_var__0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_c0_exe1_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_c0_exe2_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_c0_exe3_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_c0_exe4_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_c0_exe6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_indvars_iv21_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_indvars_iv19_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_temp_index_0_ph8_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_cmp4_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_c0_exe7_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_indvars_iv17_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_bb3_or_cond_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_bb3_var__0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_c0_exe1 = lvb_c0_exe1_reg_NO_SHIFT_REG;
assign lvb_c0_exe2 = lvb_c0_exe2_reg_NO_SHIFT_REG;
assign lvb_c0_exe3 = lvb_c0_exe3_reg_NO_SHIFT_REG;
assign lvb_c0_exe4 = lvb_c0_exe4_reg_NO_SHIFT_REG;
assign lvb_c0_exe6 = lvb_c0_exe6_reg_NO_SHIFT_REG;
assign lvb_c0_exe7 = lvb_c0_exe7_reg_NO_SHIFT_REG;
assign lvb_indvars_iv21 = lvb_indvars_iv21_reg_NO_SHIFT_REG;
assign lvb_cmp4 = lvb_cmp4_reg_NO_SHIFT_REG;
assign lvb_var_ = lvb_var__reg_NO_SHIFT_REG;
assign lvb_ld_ = lvb_ld__reg_NO_SHIFT_REG;
assign lvb_indvars_iv19 = lvb_indvars_iv19_reg_NO_SHIFT_REG;
assign lvb_indvars_iv17 = lvb_indvars_iv17_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph7 = lvb_right_lower_0_ph7_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph8 = lvb_temp_index_0_ph8_reg_NO_SHIFT_REG;
assign lvb_bb3_or_cond = lvb_bb3_or_cond_reg_NO_SHIFT_REG;
assign lvb_bb3_var_ = lvb_bb3_var__reg_NO_SHIFT_REG;
assign lvb_bb3_ld__pre_pre = lvb_bb3_ld__pre_pre_reg_NO_SHIFT_REG;
assign lvb_bb3_var__u3 = lvb_bb3_var__u3_reg_NO_SHIFT_REG;
assign lvb_bb3_var__u4 = lvb_bb3_var__u4_reg_NO_SHIFT_REG;
assign lvb_bb3_var__u5 = lvb_bb3_var__u5_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_c0_exe1_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe2_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe3_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe4_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe6_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe7_reg_NO_SHIFT_REG <= 'x;
		lvb_indvars_iv21_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp4_reg_NO_SHIFT_REG <= 'x;
		lvb_var__reg_NO_SHIFT_REG <= 'x;
		lvb_ld__reg_NO_SHIFT_REG <= 'x;
		lvb_indvars_iv19_reg_NO_SHIFT_REG <= 'x;
		lvb_indvars_iv17_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph7_reg_NO_SHIFT_REG <= 'x;
		lvb_temp_index_0_ph8_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_or_cond_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_var__reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_ld__pre_pre_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_var__u3_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_var__u4_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_var__u5_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_c0_exe1_reg_NO_SHIFT_REG <= rnode_164to165_c0_exe1_0_NO_SHIFT_REG;
			lvb_c0_exe2_reg_NO_SHIFT_REG <= rnode_164to165_c0_exe2_0_NO_SHIFT_REG;
			lvb_c0_exe3_reg_NO_SHIFT_REG <= rnode_164to165_c0_exe3_0_NO_SHIFT_REG;
			lvb_c0_exe4_reg_NO_SHIFT_REG <= rnode_164to165_c0_exe4_0_NO_SHIFT_REG;
			lvb_c0_exe6_reg_NO_SHIFT_REG <= rnode_164to165_c0_exe6_0_NO_SHIFT_REG;
			lvb_c0_exe7_reg_NO_SHIFT_REG <= rnode_164to165_c0_exe7_0_NO_SHIFT_REG;
			lvb_indvars_iv21_reg_NO_SHIFT_REG <= rnode_164to165_indvars_iv21_0_NO_SHIFT_REG;
			lvb_cmp4_reg_NO_SHIFT_REG <= rnode_164to165_cmp4_0_NO_SHIFT_REG;
			lvb_var__reg_NO_SHIFT_REG <= rnode_164to165_var__1_NO_SHIFT_REG;
			lvb_ld__reg_NO_SHIFT_REG <= rnode_162to165_ld__0_NO_SHIFT_REG;
			lvb_indvars_iv19_reg_NO_SHIFT_REG <= rnode_164to165_indvars_iv19_0_NO_SHIFT_REG;
			lvb_indvars_iv17_reg_NO_SHIFT_REG <= rnode_164to165_indvars_iv17_0_NO_SHIFT_REG;
			lvb_right_lower_0_ph7_reg_NO_SHIFT_REG <= rnode_164to165_right_lower_0_ph7_0_NO_SHIFT_REG;
			lvb_temp_index_0_ph8_reg_NO_SHIFT_REG <= rnode_164to165_temp_index_0_ph8_0_NO_SHIFT_REG;
			lvb_bb3_or_cond_reg_NO_SHIFT_REG <= rnode_164to165_bb3_or_cond_0_NO_SHIFT_REG;
			lvb_bb3_var__reg_NO_SHIFT_REG <= rnode_164to165_bb3_var__0_NO_SHIFT_REG;
			lvb_bb3_ld__pre_pre_reg_NO_SHIFT_REG <= rnode_162to165_bb3_ld__pre_pre_0_NO_SHIFT_REG;
			lvb_bb3_var__u3_reg_NO_SHIFT_REG <= local_bb3_var__u3;
			lvb_bb3_var__u4_reg_NO_SHIFT_REG <= local_bb3_var__u4;
			lvb_bb3_var__u5_reg_NO_SHIFT_REG <= local_bb3_var__u5;
			lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= rnode_164to165_input_acl_hw_wg_id_0_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_4
	(
		input 		clock,
		input 		resetn,
		input 		valid_in_0,
		output 		stall_out_0,
		input [31:0] 		input_c0_exe1_0,
		input 		input_c0_exe2_0,
		input [31:0] 		input_c0_exe3_0,
		input [31:0] 		input_c0_exe4_0,
		input [63:0] 		input_c0_exe6_0,
		input 		input_c0_exe7_0,
		input [63:0] 		input_indvars_iv21_0,
		input 		input_cmp4_0,
		input 		input_var__0,
		input [31:0] 		input_ld__0,
		input [63:0] 		input_indvars_iv19_0,
		input [63:0] 		input_indvars_iv17_0,
		input [31:0] 		input_right_lower_0_ph7_0,
		input [31:0] 		input_temp_index_0_ph8_0,
		input 		input_or_cond_0,
		input 		input_var__u7_0,
		input [31:0] 		input_ld__pre_pre_0,
		input 		input_var__u8_0,
		input 		input_var__u9_0,
		input 		input_var__u10_0,
		input [31:0] 		input_acl_hw_wg_id_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [31:0] 		input_c0_exe1_1,
		input 		input_c0_exe2_1,
		input [31:0] 		input_c0_exe3_1,
		input [31:0] 		input_c0_exe4_1,
		input [63:0] 		input_c0_exe6_1,
		input 		input_c0_exe7_1,
		input [63:0] 		input_indvars_iv21_1,
		input 		input_cmp4_1,
		input 		input_var__1,
		input [31:0] 		input_ld__1,
		input [63:0] 		input_indvars_iv19_1,
		input [63:0] 		input_indvars_iv17_1,
		input [31:0] 		input_right_lower_0_ph7_1,
		input [31:0] 		input_temp_index_0_ph8_1,
		input 		input_or_cond_1,
		input 		input_var__u7_1,
		input [31:0] 		input_ld__pre_pre_1,
		input 		input_var__u8_1,
		input 		input_var__u9_1,
		input 		input_var__u10_1,
		input [31:0] 		input_acl_hw_wg_id_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output [31:0] 		lvb_c0_exe1_0,
		output 		lvb_c0_exe2_0,
		output [31:0] 		lvb_c0_exe3_0,
		output [31:0] 		lvb_c0_exe4_0,
		output [63:0] 		lvb_c0_exe6_0,
		output 		lvb_c0_exe7_0,
		output [63:0] 		lvb_indvars_iv21_0,
		output 		lvb_cmp4_0,
		output 		lvb_var__0,
		output [31:0] 		lvb_ld__0,
		output [63:0] 		lvb_indvars_iv19_0,
		output [63:0] 		lvb_indvars_iv17_0,
		output [31:0] 		lvb_right_lower_0_ph7_0,
		output [31:0] 		lvb_temp_index_0_ph8_0,
		output 		lvb_or_cond_0,
		output 		lvb_var__u7_0,
		output [31:0] 		lvb_ld__pre_pre_0,
		output 		lvb_var__u8_0,
		output 		lvb_var__u9_0,
		output 		lvb_var__u10_0,
		output [31:0] 		lvb_input_acl_hw_wg_id_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [31:0] 		lvb_c0_exe1_1,
		output 		lvb_c0_exe2_1,
		output [31:0] 		lvb_c0_exe3_1,
		output [31:0] 		lvb_c0_exe4_1,
		output [63:0] 		lvb_c0_exe6_1,
		output 		lvb_c0_exe7_1,
		output [63:0] 		lvb_indvars_iv21_1,
		output 		lvb_cmp4_1,
		output 		lvb_var__1,
		output [31:0] 		lvb_ld__1,
		output [63:0] 		lvb_indvars_iv19_1,
		output [63:0] 		lvb_indvars_iv17_1,
		output [31:0] 		lvb_right_lower_0_ph7_1,
		output [31:0] 		lvb_temp_index_0_ph8_1,
		output 		lvb_or_cond_1,
		output 		lvb_var__u7_1,
		output [31:0] 		lvb_ld__pre_pre_1,
		output 		lvb_var__u8_1,
		output 		lvb_var__u9_1,
		output 		lvb_var__u10_1,
		output [31:0] 		lvb_input_acl_hw_wg_id_1,
		input [31:0] 		workgroup_size,
		input 		start
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in;
 reg merge_node_valid_out_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_0_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe2_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe4_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_c0_exe6_0_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv21_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp4_0_staging_reg_NO_SHIFT_REG;
 reg input_var__0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv19_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv17_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_right_lower_0_ph7_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_temp_index_0_ph8_0_staging_reg_NO_SHIFT_REG;
 reg input_or_cond_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u7_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__pre_pre_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u8_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u9_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u10_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe1_NO_SHIFT_REG;
 reg local_lvm_c0_exe2_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe3_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe4_NO_SHIFT_REG;
 reg [63:0] local_lvm_c0_exe6_NO_SHIFT_REG;
 reg local_lvm_c0_exe7_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv21_NO_SHIFT_REG;
 reg local_lvm_cmp4_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv19_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv17_NO_SHIFT_REG;
 reg [31:0] local_lvm_right_lower_0_ph7_NO_SHIFT_REG;
 reg [31:0] local_lvm_temp_index_0_ph8_NO_SHIFT_REG;
 reg local_lvm_or_cond_NO_SHIFT_REG;
 reg local_lvm_var__u7_NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__pre_pre_NO_SHIFT_REG;
 reg local_lvm_var__u8_NO_SHIFT_REG;
 reg local_lvm_var__u9_NO_SHIFT_REG;
 reg local_lvm_var__u10_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_1_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe2_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe4_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_c0_exe6_1_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv21_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp4_1_staging_reg_NO_SHIFT_REG;
 reg input_var__1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv19_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv17_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_right_lower_0_ph7_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_temp_index_0_ph8_1_staging_reg_NO_SHIFT_REG;
 reg input_or_cond_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u7_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__pre_pre_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u8_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u9_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u10_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = (|(merge_node_stall_in & merge_node_valid_out_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_c0_exe1_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe3_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe4_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv21_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp4_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv19_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv17_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph8_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_or_cond_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__pre_pre_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u8_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u9_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u10_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_c0_exe1_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe3_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe4_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv21_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp4_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv19_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv17_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph8_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_or_cond_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__pre_pre_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u8_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u9_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u10_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe1_0_staging_reg_NO_SHIFT_REG <= input_c0_exe1_0;
				input_c0_exe2_0_staging_reg_NO_SHIFT_REG <= input_c0_exe2_0;
				input_c0_exe3_0_staging_reg_NO_SHIFT_REG <= input_c0_exe3_0;
				input_c0_exe4_0_staging_reg_NO_SHIFT_REG <= input_c0_exe4_0;
				input_c0_exe6_0_staging_reg_NO_SHIFT_REG <= input_c0_exe6_0;
				input_c0_exe7_0_staging_reg_NO_SHIFT_REG <= input_c0_exe7_0;
				input_indvars_iv21_0_staging_reg_NO_SHIFT_REG <= input_indvars_iv21_0;
				input_cmp4_0_staging_reg_NO_SHIFT_REG <= input_cmp4_0;
				input_var__0_staging_reg_NO_SHIFT_REG <= input_var__0;
				input_ld__0_staging_reg_NO_SHIFT_REG <= input_ld__0;
				input_indvars_iv19_0_staging_reg_NO_SHIFT_REG <= input_indvars_iv19_0;
				input_indvars_iv17_0_staging_reg_NO_SHIFT_REG <= input_indvars_iv17_0;
				input_right_lower_0_ph7_0_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph7_0;
				input_temp_index_0_ph8_0_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph8_0;
				input_or_cond_0_staging_reg_NO_SHIFT_REG <= input_or_cond_0;
				input_var__u7_0_staging_reg_NO_SHIFT_REG <= input_var__u7_0;
				input_ld__pre_pre_0_staging_reg_NO_SHIFT_REG <= input_ld__pre_pre_0;
				input_var__u8_0_staging_reg_NO_SHIFT_REG <= input_var__u8_0;
				input_var__u9_0_staging_reg_NO_SHIFT_REG <= input_var__u9_0;
				input_var__u10_0_staging_reg_NO_SHIFT_REG <= input_var__u10_0;
				input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe1_1_staging_reg_NO_SHIFT_REG <= input_c0_exe1_1;
				input_c0_exe2_1_staging_reg_NO_SHIFT_REG <= input_c0_exe2_1;
				input_c0_exe3_1_staging_reg_NO_SHIFT_REG <= input_c0_exe3_1;
				input_c0_exe4_1_staging_reg_NO_SHIFT_REG <= input_c0_exe4_1;
				input_c0_exe6_1_staging_reg_NO_SHIFT_REG <= input_c0_exe6_1;
				input_c0_exe7_1_staging_reg_NO_SHIFT_REG <= input_c0_exe7_1;
				input_indvars_iv21_1_staging_reg_NO_SHIFT_REG <= input_indvars_iv21_1;
				input_cmp4_1_staging_reg_NO_SHIFT_REG <= input_cmp4_1;
				input_var__1_staging_reg_NO_SHIFT_REG <= input_var__1;
				input_ld__1_staging_reg_NO_SHIFT_REG <= input_ld__1;
				input_indvars_iv19_1_staging_reg_NO_SHIFT_REG <= input_indvars_iv19_1;
				input_indvars_iv17_1_staging_reg_NO_SHIFT_REG <= input_indvars_iv17_1;
				input_right_lower_0_ph7_1_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph7_1;
				input_temp_index_0_ph8_1_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph8_1;
				input_or_cond_1_staging_reg_NO_SHIFT_REG <= input_or_cond_1;
				input_var__u7_1_staging_reg_NO_SHIFT_REG <= input_var__u7_1;
				input_ld__pre_pre_1_staging_reg_NO_SHIFT_REG <= input_ld__pre_pre_1;
				input_var__u8_1_staging_reg_NO_SHIFT_REG <= input_var__u8_1;
				input_var__u9_1_staging_reg_NO_SHIFT_REG <= input_var__u9_1;
				input_var__u10_1_staging_reg_NO_SHIFT_REG <= input_var__u10_1;
				input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__0_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19_0_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17_0_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_0_staging_reg_NO_SHIFT_REG;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u7_NO_SHIFT_REG <= input_var__u7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__pre_pre_NO_SHIFT_REG <= input_ld__pre_pre_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u8_NO_SHIFT_REG <= input_var__u8_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u9_NO_SHIFT_REG <= input_var__u9_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u10_NO_SHIFT_REG <= input_var__u10_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_0;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_0;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_0;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_0;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_0;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_0;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_0;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4_0;
					local_lvm_var__NO_SHIFT_REG <= input_var__0;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19_0;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17_0;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_0;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_0;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_0;
					local_lvm_var__u7_NO_SHIFT_REG <= input_var__u7_0;
					local_lvm_ld__pre_pre_NO_SHIFT_REG <= input_ld__pre_pre_0;
					local_lvm_var__u8_NO_SHIFT_REG <= input_var__u8_0;
					local_lvm_var__u9_NO_SHIFT_REG <= input_var__u9_0;
					local_lvm_var__u10_NO_SHIFT_REG <= input_var__u10_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__1_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19_1_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17_1_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_1_staging_reg_NO_SHIFT_REG;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u7_NO_SHIFT_REG <= input_var__u7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__pre_pre_NO_SHIFT_REG <= input_ld__pre_pre_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u8_NO_SHIFT_REG <= input_var__u8_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u9_NO_SHIFT_REG <= input_var__u9_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u10_NO_SHIFT_REG <= input_var__u10_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_1;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_1;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_1;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_1;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_1;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_1;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_1;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4_1;
					local_lvm_var__NO_SHIFT_REG <= input_var__1;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19_1;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17_1;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_1;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_1;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_1;
					local_lvm_var__u7_NO_SHIFT_REG <= input_var__u7_1;
					local_lvm_ld__pre_pre_NO_SHIFT_REG <= input_ld__pre_pre_1;
					local_lvm_var__u8_NO_SHIFT_REG <= input_var__u8_1;
					local_lvm_var__u9_NO_SHIFT_REG <= input_var__u9_1;
					local_lvm_var__u10_NO_SHIFT_REG <= input_var__u10_1;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in))
			begin
				merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_c0_exe1_0_reg_NO_SHIFT_REG;
 reg lvb_c0_exe2_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe3_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe4_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_c0_exe6_0_reg_NO_SHIFT_REG;
 reg lvb_c0_exe7_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_indvars_iv21_0_reg_NO_SHIFT_REG;
 reg lvb_cmp4_0_reg_NO_SHIFT_REG;
 reg lvb_var__0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_indvars_iv19_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_indvars_iv17_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG;
 reg lvb_or_cond_0_reg_NO_SHIFT_REG;
 reg lvb_var__u7_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__pre_pre_0_reg_NO_SHIFT_REG;
 reg lvb_var__u8_0_reg_NO_SHIFT_REG;
 reg lvb_var__u9_0_reg_NO_SHIFT_REG;
 reg lvb_var__u10_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_c0_exe1_0 = lvb_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe1_1 = lvb_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe2_0 = lvb_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe2_1 = lvb_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe3_0 = lvb_c0_exe3_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe3_1 = lvb_c0_exe3_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe4_0 = lvb_c0_exe4_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe4_1 = lvb_c0_exe4_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe6_0 = lvb_c0_exe6_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe6_1 = lvb_c0_exe6_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe7_0 = lvb_c0_exe7_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe7_1 = lvb_c0_exe7_0_reg_NO_SHIFT_REG;
assign lvb_indvars_iv21_0 = lvb_indvars_iv21_0_reg_NO_SHIFT_REG;
assign lvb_indvars_iv21_1 = lvb_indvars_iv21_0_reg_NO_SHIFT_REG;
assign lvb_cmp4_0 = lvb_cmp4_0_reg_NO_SHIFT_REG;
assign lvb_cmp4_1 = lvb_cmp4_0_reg_NO_SHIFT_REG;
assign lvb_var__0 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_var__1 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_ld__0 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_ld__1 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_indvars_iv19_0 = lvb_indvars_iv19_0_reg_NO_SHIFT_REG;
assign lvb_indvars_iv19_1 = lvb_indvars_iv19_0_reg_NO_SHIFT_REG;
assign lvb_indvars_iv17_0 = lvb_indvars_iv17_0_reg_NO_SHIFT_REG;
assign lvb_indvars_iv17_1 = lvb_indvars_iv17_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph7_0 = lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph7_1 = lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph8_0 = lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph8_1 = lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG;
assign lvb_or_cond_0 = lvb_or_cond_0_reg_NO_SHIFT_REG;
assign lvb_or_cond_1 = lvb_or_cond_0_reg_NO_SHIFT_REG;
assign lvb_var__u7_0 = lvb_var__u7_0_reg_NO_SHIFT_REG;
assign lvb_var__u7_1 = lvb_var__u7_0_reg_NO_SHIFT_REG;
assign lvb_ld__pre_pre_0 = lvb_ld__pre_pre_0_reg_NO_SHIFT_REG;
assign lvb_ld__pre_pre_1 = lvb_ld__pre_pre_0_reg_NO_SHIFT_REG;
assign lvb_var__u8_0 = lvb_var__u8_0_reg_NO_SHIFT_REG;
assign lvb_var__u8_1 = lvb_var__u8_0_reg_NO_SHIFT_REG;
assign lvb_var__u9_0 = lvb_var__u9_0_reg_NO_SHIFT_REG;
assign lvb_var__u9_1 = lvb_var__u9_0_reg_NO_SHIFT_REG;
assign lvb_var__u10_0 = lvb_var__u10_0_reg_NO_SHIFT_REG;
assign lvb_var__u10_1 = lvb_var__u10_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_0 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_1 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		lvb_c0_exe1_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe2_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe3_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe4_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_indvars_iv21_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp4_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__0_reg_NO_SHIFT_REG <= 'x;
		lvb_ld__0_reg_NO_SHIFT_REG <= 'x;
		lvb_indvars_iv19_0_reg_NO_SHIFT_REG <= 'x;
		lvb_indvars_iv17_0_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG <= 'x;
		lvb_or_cond_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_ld__pre_pre_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u8_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u9_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u10_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_c0_exe1_0_reg_NO_SHIFT_REG <= local_lvm_c0_exe1_NO_SHIFT_REG;
			lvb_c0_exe2_0_reg_NO_SHIFT_REG <= local_lvm_c0_exe2_NO_SHIFT_REG;
			lvb_c0_exe3_0_reg_NO_SHIFT_REG <= local_lvm_c0_exe3_NO_SHIFT_REG;
			lvb_c0_exe4_0_reg_NO_SHIFT_REG <= local_lvm_c0_exe4_NO_SHIFT_REG;
			lvb_c0_exe6_0_reg_NO_SHIFT_REG <= local_lvm_c0_exe6_NO_SHIFT_REG;
			lvb_c0_exe7_0_reg_NO_SHIFT_REG <= local_lvm_c0_exe7_NO_SHIFT_REG;
			lvb_indvars_iv21_0_reg_NO_SHIFT_REG <= local_lvm_indvars_iv21_NO_SHIFT_REG;
			lvb_cmp4_0_reg_NO_SHIFT_REG <= local_lvm_cmp4_NO_SHIFT_REG;
			lvb_var__0_reg_NO_SHIFT_REG <= local_lvm_var__NO_SHIFT_REG;
			lvb_ld__0_reg_NO_SHIFT_REG <= local_lvm_ld__NO_SHIFT_REG;
			lvb_indvars_iv19_0_reg_NO_SHIFT_REG <= local_lvm_indvars_iv19_NO_SHIFT_REG;
			lvb_indvars_iv17_0_reg_NO_SHIFT_REG <= local_lvm_indvars_iv17_NO_SHIFT_REG;
			lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG <= local_lvm_right_lower_0_ph7_NO_SHIFT_REG;
			lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG <= local_lvm_temp_index_0_ph8_NO_SHIFT_REG;
			lvb_or_cond_0_reg_NO_SHIFT_REG <= local_lvm_or_cond_NO_SHIFT_REG;
			lvb_var__u7_0_reg_NO_SHIFT_REG <= local_lvm_var__u7_NO_SHIFT_REG;
			lvb_ld__pre_pre_0_reg_NO_SHIFT_REG <= local_lvm_ld__pre_pre_NO_SHIFT_REG;
			lvb_var__u8_0_reg_NO_SHIFT_REG <= local_lvm_var__u8_NO_SHIFT_REG;
			lvb_var__u9_0_reg_NO_SHIFT_REG <= local_lvm_var__u9_NO_SHIFT_REG;
			lvb_var__u10_0_reg_NO_SHIFT_REG <= local_lvm_var__u10_NO_SHIFT_REG;
			lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= local_lvm_var__u10_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_5
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_temp,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_c0_exe1,
		input 		input_c0_exe2,
		input [31:0] 		input_c0_exe3,
		input [31:0] 		input_c0_exe4,
		input [63:0] 		input_c0_exe6,
		input 		input_c0_exe7,
		input [63:0] 		input_indvars_iv21,
		input 		input_cmp4,
		input 		input_var_,
		input [31:0] 		input_ld_,
		input [63:0] 		input_indvars_iv19,
		input [63:0] 		input_indvars_iv17,
		input [31:0] 		input_right_lower_0_ph7,
		input [31:0] 		input_temp_index_0_ph8,
		input 		input_or_cond,
		input 		input_var__u11,
		input [31:0] 		input_ld__pre_pre,
		input 		input_var__u12,
		input 		input_var__u13,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out_0,
		input 		stall_in_0,
		output [31:0] 		lvb_c0_exe1_0,
		output 		lvb_c0_exe2_0,
		output [31:0] 		lvb_c0_exe3_0,
		output [31:0] 		lvb_c0_exe4_0,
		output [63:0] 		lvb_c0_exe6_0,
		output 		lvb_c0_exe7_0,
		output [63:0] 		lvb_indvars_iv21_0,
		output 		lvb_cmp4_0,
		output 		lvb_var__0,
		output [31:0] 		lvb_ld__0,
		output [31:0] 		lvb_right_lower_0_ph7_0,
		output [31:0] 		lvb_temp_index_0_ph8_0,
		output 		lvb_var__u12_0,
		output 		lvb_var__u13_0,
		output [63:0] 		lvb_bb5_indvars_iv_next18_0,
		output [31:0] 		lvb_bb5_inc_0,
		output [63:0] 		lvb_bb5_indvars_iv_next20_0,
		output [31:0] 		lvb_bb5_inc17_0,
		output [31:0] 		lvb_input_acl_hw_wg_id_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [31:0] 		lvb_c0_exe1_1,
		output 		lvb_c0_exe2_1,
		output [31:0] 		lvb_c0_exe3_1,
		output [31:0] 		lvb_c0_exe4_1,
		output [63:0] 		lvb_c0_exe6_1,
		output 		lvb_c0_exe7_1,
		output [63:0] 		lvb_indvars_iv21_1,
		output 		lvb_cmp4_1,
		output 		lvb_var__1,
		output [31:0] 		lvb_ld__1,
		output [31:0] 		lvb_right_lower_0_ph7_1,
		output [31:0] 		lvb_temp_index_0_ph8_1,
		output 		lvb_var__u12_1,
		output 		lvb_var__u13_1,
		output [63:0] 		lvb_bb5_indvars_iv_next18_1,
		output [31:0] 		lvb_bb5_inc_1,
		output [63:0] 		lvb_bb5_indvars_iv_next20_1,
		output [31:0] 		lvb_bb5_inc17_1,
		output [31:0] 		lvb_input_acl_hw_wg_id_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb5_st__pre_pre_readdata,
		input 		avm_local_bb5_st__pre_pre_readdatavalid,
		input 		avm_local_bb5_st__pre_pre_waitrequest,
		output [29:0] 		avm_local_bb5_st__pre_pre_address,
		output 		avm_local_bb5_st__pre_pre_read,
		output 		avm_local_bb5_st__pre_pre_write,
		input 		avm_local_bb5_st__pre_pre_writeack,
		output [255:0] 		avm_local_bb5_st__pre_pre_writedata,
		output [31:0] 		avm_local_bb5_st__pre_pre_byteenable,
		output [4:0] 		avm_local_bb5_st__pre_pre_burstcount,
		output 		local_bb5_st__pre_pre_active,
		input 		clock2x
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_node_stall_in_5;
 reg merge_node_valid_out_5_NO_SHIFT_REG;
wire merge_node_stall_in_6;
 reg merge_node_valid_out_6_NO_SHIFT_REG;
wire merge_node_stall_in_7;
 reg merge_node_valid_out_7_NO_SHIFT_REG;
wire merge_node_stall_in_8;
 reg merge_node_valid_out_8_NO_SHIFT_REG;
wire merge_node_stall_in_9;
 reg merge_node_valid_out_9_NO_SHIFT_REG;
wire merge_node_stall_in_10;
 reg merge_node_valid_out_10_NO_SHIFT_REG;
wire merge_node_stall_in_11;
 reg merge_node_valid_out_11_NO_SHIFT_REG;
wire merge_node_stall_in_12;
 reg merge_node_valid_out_12_NO_SHIFT_REG;
wire merge_node_stall_in_13;
 reg merge_node_valid_out_13_NO_SHIFT_REG;
wire merge_node_stall_in_14;
 reg merge_node_valid_out_14_NO_SHIFT_REG;
wire merge_node_stall_in_15;
 reg merge_node_valid_out_15_NO_SHIFT_REG;
wire merge_node_stall_in_16;
 reg merge_node_valid_out_16_NO_SHIFT_REG;
wire merge_node_stall_in_17;
 reg merge_node_valid_out_17_NO_SHIFT_REG;
wire merge_node_stall_in_18;
 reg merge_node_valid_out_18_NO_SHIFT_REG;
wire merge_node_stall_in_19;
 reg merge_node_valid_out_19_NO_SHIFT_REG;
wire merge_node_stall_in_20;
 reg merge_node_valid_out_20_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe2_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe4_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_c0_exe6_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv21_staging_reg_NO_SHIFT_REG;
 reg input_cmp4_staging_reg_NO_SHIFT_REG;
 reg input_var__staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv19_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv17_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_right_lower_0_ph7_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_temp_index_0_ph8_staging_reg_NO_SHIFT_REG;
 reg input_or_cond_staging_reg_NO_SHIFT_REG;
 reg input_var__u11_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__pre_pre_staging_reg_NO_SHIFT_REG;
 reg input_var__u12_staging_reg_NO_SHIFT_REG;
 reg input_var__u13_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe1_NO_SHIFT_REG;
 reg local_lvm_c0_exe2_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe3_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe4_NO_SHIFT_REG;
 reg [63:0] local_lvm_c0_exe6_NO_SHIFT_REG;
 reg local_lvm_c0_exe7_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv21_NO_SHIFT_REG;
 reg local_lvm_cmp4_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv19_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv17_NO_SHIFT_REG;
 reg [31:0] local_lvm_right_lower_0_ph7_NO_SHIFT_REG;
 reg [31:0] local_lvm_temp_index_0_ph8_NO_SHIFT_REG;
 reg local_lvm_or_cond_NO_SHIFT_REG;
 reg local_lvm_var__u11_NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__pre_pre_NO_SHIFT_REG;
 reg local_lvm_var__u12_NO_SHIFT_REG;
 reg local_lvm_var__u13_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG) | (merge_node_stall_in_9 & merge_node_valid_out_9_NO_SHIFT_REG) | (merge_node_stall_in_10 & merge_node_valid_out_10_NO_SHIFT_REG) | (merge_node_stall_in_11 & merge_node_valid_out_11_NO_SHIFT_REG) | (merge_node_stall_in_12 & merge_node_valid_out_12_NO_SHIFT_REG) | (merge_node_stall_in_13 & merge_node_valid_out_13_NO_SHIFT_REG) | (merge_node_stall_in_14 & merge_node_valid_out_14_NO_SHIFT_REG) | (merge_node_stall_in_15 & merge_node_valid_out_15_NO_SHIFT_REG) | (merge_node_stall_in_16 & merge_node_valid_out_16_NO_SHIFT_REG) | (merge_node_stall_in_17 & merge_node_valid_out_17_NO_SHIFT_REG) | (merge_node_stall_in_18 & merge_node_valid_out_18_NO_SHIFT_REG) | (merge_node_stall_in_19 & merge_node_valid_out_19_NO_SHIFT_REG) | (merge_node_stall_in_20 & merge_node_valid_out_20_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_c0_exe1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe3_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe4_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe6_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv21_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp4_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv19_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv17_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph7_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph8_staging_reg_NO_SHIFT_REG <= 'x;
		input_or_cond_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u11_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__pre_pre_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u12_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u13_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe1_staging_reg_NO_SHIFT_REG <= input_c0_exe1;
				input_c0_exe2_staging_reg_NO_SHIFT_REG <= input_c0_exe2;
				input_c0_exe3_staging_reg_NO_SHIFT_REG <= input_c0_exe3;
				input_c0_exe4_staging_reg_NO_SHIFT_REG <= input_c0_exe4;
				input_c0_exe6_staging_reg_NO_SHIFT_REG <= input_c0_exe6;
				input_c0_exe7_staging_reg_NO_SHIFT_REG <= input_c0_exe7;
				input_indvars_iv21_staging_reg_NO_SHIFT_REG <= input_indvars_iv21;
				input_cmp4_staging_reg_NO_SHIFT_REG <= input_cmp4;
				input_var__staging_reg_NO_SHIFT_REG <= input_var_;
				input_ld__staging_reg_NO_SHIFT_REG <= input_ld_;
				input_indvars_iv19_staging_reg_NO_SHIFT_REG <= input_indvars_iv19;
				input_indvars_iv17_staging_reg_NO_SHIFT_REG <= input_indvars_iv17;
				input_right_lower_0_ph7_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph7;
				input_temp_index_0_ph8_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph8;
				input_or_cond_staging_reg_NO_SHIFT_REG <= input_or_cond;
				input_var__u11_staging_reg_NO_SHIFT_REG <= input_var__u11;
				input_ld__pre_pre_staging_reg_NO_SHIFT_REG <= input_ld__pre_pre;
				input_var__u12_staging_reg_NO_SHIFT_REG <= input_var__u12;
				input_var__u13_staging_reg_NO_SHIFT_REG <= input_var__u13;
				input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_staging_reg_NO_SHIFT_REG;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u11_NO_SHIFT_REG <= input_var__u11_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__pre_pre_NO_SHIFT_REG <= input_ld__pre_pre_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u12_NO_SHIFT_REG <= input_var__u12_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u13_NO_SHIFT_REG <= input_var__u13_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21;
					local_lvm_cmp4_NO_SHIFT_REG <= input_cmp4;
					local_lvm_var__NO_SHIFT_REG <= input_var_;
					local_lvm_ld__NO_SHIFT_REG <= input_ld_;
					local_lvm_indvars_iv19_NO_SHIFT_REG <= input_indvars_iv19;
					local_lvm_indvars_iv17_NO_SHIFT_REG <= input_indvars_iv17;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond;
					local_lvm_var__u11_NO_SHIFT_REG <= input_var__u11;
					local_lvm_ld__pre_pre_NO_SHIFT_REG <= input_ld__pre_pre;
					local_lvm_var__u12_NO_SHIFT_REG <= input_var__u12;
					local_lvm_var__u13_NO_SHIFT_REG <= input_var__u13;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_9_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_10_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_11_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_12_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_13_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_14_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_15_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_16_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_17_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_18_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_19_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_20_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_5_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_6_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_7_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_8_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_9_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_10_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_11_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_12_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_13_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_14_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_15_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_16_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_17_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_18_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_19_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_20_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_5))
			begin
				merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_6))
			begin
				merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_7))
			begin
				merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_8))
			begin
				merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_9))
			begin
				merge_node_valid_out_9_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_10))
			begin
				merge_node_valid_out_10_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_11))
			begin
				merge_node_valid_out_11_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_12))
			begin
				merge_node_valid_out_12_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_13))
			begin
				merge_node_valid_out_13_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_14))
			begin
				merge_node_valid_out_14_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_15))
			begin
				merge_node_valid_out_15_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_16))
			begin
				merge_node_valid_out_16_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_17))
			begin
				merge_node_valid_out_17_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_18))
			begin
				merge_node_valid_out_18_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_19))
			begin
				merge_node_valid_out_19_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_20))
			begin
				merge_node_valid_out_20_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb5_do_directly_if_then14_select_valid_out;
wire local_bb5_do_directly_if_then14_select_stall_in;
wire local_bb5_do_directly_if_then14_select_inputs_ready;
wire local_bb5_do_directly_if_then14_select_stall_local;
wire local_bb5_do_directly_if_then14_select;

assign local_bb5_do_directly_if_then14_select_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb5_do_directly_if_then14_select = (local_lvm_var__u11_NO_SHIFT_REG | local_lvm_var__u13_NO_SHIFT_REG);
assign local_bb5_do_directly_if_then14_select_valid_out = local_bb5_do_directly_if_then14_select_inputs_ready;
assign local_bb5_do_directly_if_then14_select_stall_local = local_bb5_do_directly_if_then14_select_stall_in;
assign merge_node_stall_in_0 = (|local_bb5_do_directly_if_then14_select_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb5_arrayidx19_valid_out;
wire local_bb5_arrayidx19_stall_in;
wire local_bb5_arrayidx19_inputs_ready;
wire local_bb5_arrayidx19_stall_local;
wire [63:0] local_bb5_arrayidx19;

assign local_bb5_arrayidx19_inputs_ready = merge_node_valid_out_1_NO_SHIFT_REG;
assign local_bb5_arrayidx19 = (input_temp + (local_lvm_indvars_iv19_NO_SHIFT_REG << 6'h2));
assign local_bb5_arrayidx19_valid_out = local_bb5_arrayidx19_inputs_ready;
assign local_bb5_arrayidx19_stall_local = local_bb5_arrayidx19_stall_in;
assign merge_node_stall_in_1 = (|local_bb5_arrayidx19_stall_local);

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_or_cond_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_or_cond_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_or_cond_0_NO_SHIFT_REG;
 logic rnode_1to160_or_cond_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_or_cond_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_or_cond_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_or_cond_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_or_cond_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_or_cond_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_or_cond_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_or_cond_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_or_cond_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_or_cond_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_or_cond_NO_SHIFT_REG),
	.data_out(rnode_1to160_or_cond_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_or_cond_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_or_cond_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_or_cond_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_or_cond_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_or_cond_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to160_or_cond_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_or_cond_0_NO_SHIFT_REG = rnode_1to160_or_cond_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_or_cond_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_or_cond_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_or_cond_0_valid_out_NO_SHIFT_REG = rnode_1to160_or_cond_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe2_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe2_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe2_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe2_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe2_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe2_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe2_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe2_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe2_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe2_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_c0_exe2_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe2_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe2_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to160_c0_exe2_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe2_0_NO_SHIFT_REG = rnode_1to160_c0_exe2_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe2_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe2_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe2_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe2_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_indvars_iv17_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv17_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv17_0_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv17_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv17_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv17_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv17_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv17_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_indvars_iv17_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_indvars_iv17_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_indvars_iv17_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_indvars_iv17_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_indvars_iv17_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv17_NO_SHIFT_REG),
	.data_out(rnode_1to160_indvars_iv17_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_indvars_iv17_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_indvars_iv17_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_indvars_iv17_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_indvars_iv17_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_indvars_iv17_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to160_indvars_iv17_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv17_0_NO_SHIFT_REG = rnode_1to160_indvars_iv17_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv17_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_indvars_iv17_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv17_0_valid_out_NO_SHIFT_REG = rnode_1to160_indvars_iv17_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_right_lower_0_ph7_0_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_right_lower_0_ph7_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_right_lower_0_ph7_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_right_lower_0_ph7_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_right_lower_0_ph7_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_right_lower_0_ph7_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_right_lower_0_ph7_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_right_lower_0_ph7_NO_SHIFT_REG),
	.data_out(rnode_1to160_right_lower_0_ph7_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_right_lower_0_ph7_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_right_lower_0_ph7_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_right_lower_0_ph7_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_right_lower_0_ph7_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_right_lower_0_ph7_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to160_right_lower_0_ph7_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_right_lower_0_ph7_0_NO_SHIFT_REG = rnode_1to160_right_lower_0_ph7_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_right_lower_0_ph7_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG = rnode_1to160_right_lower_0_ph7_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_indvars_iv19_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv19_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv19_0_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv19_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv19_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv19_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv19_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv19_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_indvars_iv19_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_indvars_iv19_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_indvars_iv19_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_indvars_iv19_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_indvars_iv19_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv19_NO_SHIFT_REG),
	.data_out(rnode_1to160_indvars_iv19_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_indvars_iv19_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_indvars_iv19_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_indvars_iv19_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_indvars_iv19_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_indvars_iv19_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to160_indvars_iv19_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv19_0_NO_SHIFT_REG = rnode_1to160_indvars_iv19_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv19_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_indvars_iv19_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv19_0_valid_out_NO_SHIFT_REG = rnode_1to160_indvars_iv19_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_temp_index_0_ph8_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph8_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_temp_index_0_ph8_0_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph8_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_temp_index_0_ph8_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph8_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph8_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph8_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_temp_index_0_ph8_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_temp_index_0_ph8_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_temp_index_0_ph8_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_temp_index_0_ph8_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_temp_index_0_ph8_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_temp_index_0_ph8_NO_SHIFT_REG),
	.data_out(rnode_1to160_temp_index_0_ph8_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_temp_index_0_ph8_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_temp_index_0_ph8_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_temp_index_0_ph8_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_temp_index_0_ph8_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_temp_index_0_ph8_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to160_temp_index_0_ph8_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_temp_index_0_ph8_0_NO_SHIFT_REG = rnode_1to160_temp_index_0_ph8_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_temp_index_0_ph8_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_temp_index_0_ph8_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_temp_index_0_ph8_0_valid_out_NO_SHIFT_REG = rnode_1to160_temp_index_0_ph8_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_var__u12_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_var__u12_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_var__u12_0_NO_SHIFT_REG;
 logic rnode_1to160_var__u12_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_var__u12_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__u12_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__u12_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__u12_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_var__u12_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_var__u12_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_var__u12_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_var__u12_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_var__u12_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_var__u12_NO_SHIFT_REG),
	.data_out(rnode_1to160_var__u12_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_var__u12_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_var__u12_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_var__u12_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_var__u12_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_var__u12_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_9_NO_SHIFT_REG;
assign merge_node_stall_in_9 = rnode_1to160_var__u12_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_var__u12_0_NO_SHIFT_REG = rnode_1to160_var__u12_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_var__u12_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_var__u12_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_var__u12_0_valid_out_NO_SHIFT_REG = rnode_1to160_var__u12_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe1_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe1_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe1_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe1_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe1_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe1_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe1_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe1_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe1_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe1_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe1_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_c0_exe1_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe1_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe1_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_10_NO_SHIFT_REG;
assign merge_node_stall_in_10 = rnode_1to160_c0_exe1_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe1_0_NO_SHIFT_REG = rnode_1to160_c0_exe1_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe1_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe1_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe1_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe3_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe3_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe3_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe3_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe3_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe3_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe3_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe3_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe3_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe3_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_c0_exe3_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe3_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe3_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_11_NO_SHIFT_REG;
assign merge_node_stall_in_11 = rnode_1to160_c0_exe3_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe3_0_NO_SHIFT_REG = rnode_1to160_c0_exe3_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe3_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe3_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe4_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe4_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe4_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe4_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe4_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe4_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe4_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe4_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe4_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe4_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe4_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe4_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_c0_exe4_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe4_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe4_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_12_NO_SHIFT_REG;
assign merge_node_stall_in_12 = rnode_1to160_c0_exe4_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe4_0_NO_SHIFT_REG = rnode_1to160_c0_exe4_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe4_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe4_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe4_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe4_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_c0_exe6_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_c0_exe6_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe6_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe6_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe6_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe6_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe6_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe6_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe6_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe6_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe6_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_c0_exe6_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe6_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe6_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_13_NO_SHIFT_REG;
assign merge_node_stall_in_13 = rnode_1to160_c0_exe6_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe6_0_NO_SHIFT_REG = rnode_1to160_c0_exe6_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe6_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe6_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe6_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe7_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe7_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe7_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe7_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe7_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe7_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe7_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe7_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe7_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_c0_exe7_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe7_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe7_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_14_NO_SHIFT_REG;
assign merge_node_stall_in_14 = rnode_1to160_c0_exe7_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe7_0_NO_SHIFT_REG = rnode_1to160_c0_exe7_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe7_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe7_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe7_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_indvars_iv21_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv21_0_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv21_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_indvars_iv21_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_indvars_iv21_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_indvars_iv21_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_indvars_iv21_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_indvars_iv21_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv21_NO_SHIFT_REG),
	.data_out(rnode_1to160_indvars_iv21_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_indvars_iv21_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_indvars_iv21_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_indvars_iv21_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_indvars_iv21_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_indvars_iv21_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_15_NO_SHIFT_REG;
assign merge_node_stall_in_15 = rnode_1to160_indvars_iv21_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv21_0_NO_SHIFT_REG = rnode_1to160_indvars_iv21_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv21_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_indvars_iv21_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv21_0_valid_out_NO_SHIFT_REG = rnode_1to160_indvars_iv21_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_cmp4_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_cmp4_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_cmp4_0_NO_SHIFT_REG;
 logic rnode_1to160_cmp4_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_cmp4_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp4_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp4_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp4_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_cmp4_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_cmp4_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_cmp4_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_cmp4_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_cmp4_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_cmp4_NO_SHIFT_REG),
	.data_out(rnode_1to160_cmp4_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_cmp4_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_cmp4_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_cmp4_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_cmp4_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_cmp4_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_16_NO_SHIFT_REG;
assign merge_node_stall_in_16 = rnode_1to160_cmp4_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp4_0_NO_SHIFT_REG = rnode_1to160_cmp4_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp4_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_cmp4_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_cmp4_0_valid_out_NO_SHIFT_REG = rnode_1to160_cmp4_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_var__0_NO_SHIFT_REG;
 logic rnode_1to160_var__0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_var__0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_var__0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_var__0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_var__0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_var__0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_var__0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_var__NO_SHIFT_REG),
	.data_out(rnode_1to160_var__0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_var__0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_var__0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_var__0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_var__0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_var__0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_17_NO_SHIFT_REG;
assign merge_node_stall_in_17 = rnode_1to160_var__0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_var__0_NO_SHIFT_REG = rnode_1to160_var__0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_var__0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_var__0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_var__0_valid_out_NO_SHIFT_REG = rnode_1to160_var__0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_ld__0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_ld__0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_ld__0_NO_SHIFT_REG;
 logic rnode_1to160_ld__0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_ld__0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_ld__0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_ld__0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_ld__0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_ld__0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_ld__0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_ld__0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_ld__0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_ld__0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_ld__NO_SHIFT_REG),
	.data_out(rnode_1to160_ld__0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_ld__0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_ld__0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_ld__0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_ld__0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_ld__0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_18_NO_SHIFT_REG;
assign merge_node_stall_in_18 = rnode_1to160_ld__0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_ld__0_NO_SHIFT_REG = rnode_1to160_ld__0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_ld__0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_ld__0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_ld__0_valid_out_NO_SHIFT_REG = rnode_1to160_ld__0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_var__u13_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_var__u13_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_var__u13_0_NO_SHIFT_REG;
 logic rnode_1to160_var__u13_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_var__u13_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__u13_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__u13_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__u13_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_var__u13_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_var__u13_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_var__u13_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_var__u13_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_var__u13_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_var__u13_NO_SHIFT_REG),
	.data_out(rnode_1to160_var__u13_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_var__u13_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_var__u13_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_var__u13_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_var__u13_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_var__u13_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_19_NO_SHIFT_REG;
assign merge_node_stall_in_19 = rnode_1to160_var__u13_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_var__u13_0_NO_SHIFT_REG = rnode_1to160_var__u13_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_var__u13_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_var__u13_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_var__u13_0_valid_out_NO_SHIFT_REG = rnode_1to160_var__u13_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_input_acl_hw_wg_id_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_input_acl_hw_wg_id_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_input_acl_hw_wg_id_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_input_acl_hw_wg_id_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_input_acl_hw_wg_id_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to160_input_acl_hw_wg_id_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_input_acl_hw_wg_id_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_20_NO_SHIFT_REG;
assign merge_node_stall_in_20 = rnode_1to160_input_acl_hw_wg_id_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to160_input_acl_hw_wg_id_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_input_acl_hw_wg_id_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to160_input_acl_hw_wg_id_0_valid_out_reg_160_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb5_st__pre_pre_inputs_ready;
 reg local_bb5_st__pre_pre_valid_out_NO_SHIFT_REG;
wire local_bb5_st__pre_pre_stall_in;
wire local_bb5_st__pre_pre_output_regs_ready;
wire local_bb5_st__pre_pre_fu_stall_out;
wire local_bb5_st__pre_pre_fu_valid_out;
wire local_bb5_st__pre_pre_causedstall;

lsu_top lsu_local_bb5_st__pre_pre (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb5_st__pre_pre_fu_stall_out),
	.i_valid(local_bb5_st__pre_pre_inputs_ready),
	.i_address(local_bb5_arrayidx19),
	.i_writedata(local_lvm_ld__pre_pre_NO_SHIFT_REG),
	.i_cmpdata(),
	.i_predicate(local_bb5_do_directly_if_then14_select),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb5_st__pre_pre_output_regs_ready)),
	.o_valid(local_bb5_st__pre_pre_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb5_st__pre_pre_active),
	.avm_address(avm_local_bb5_st__pre_pre_address),
	.avm_read(avm_local_bb5_st__pre_pre_read),
	.avm_readdata(avm_local_bb5_st__pre_pre_readdata),
	.avm_write(avm_local_bb5_st__pre_pre_write),
	.avm_writeack(avm_local_bb5_st__pre_pre_writeack),
	.avm_burstcount(avm_local_bb5_st__pre_pre_burstcount),
	.avm_writedata(avm_local_bb5_st__pre_pre_writedata),
	.avm_byteenable(avm_local_bb5_st__pre_pre_byteenable),
	.avm_waitrequest(avm_local_bb5_st__pre_pre_waitrequest),
	.avm_readdatavalid(avm_local_bb5_st__pre_pre_readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb5_st__pre_pre.AWIDTH = 30;
defparam lsu_local_bb5_st__pre_pre.WIDTH_BYTES = 4;
defparam lsu_local_bb5_st__pre_pre.MWIDTH_BYTES = 32;
defparam lsu_local_bb5_st__pre_pre.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb5_st__pre_pre.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb5_st__pre_pre.READ = 0;
defparam lsu_local_bb5_st__pre_pre.ATOMIC = 0;
defparam lsu_local_bb5_st__pre_pre.WIDTH = 32;
defparam lsu_local_bb5_st__pre_pre.MWIDTH = 256;
defparam lsu_local_bb5_st__pre_pre.ATOMIC_WIDTH = 3;
defparam lsu_local_bb5_st__pre_pre.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb5_st__pre_pre.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb5_st__pre_pre.MEMORY_SIDE_MEM_LATENCY = 12;
defparam lsu_local_bb5_st__pre_pre.USE_WRITE_ACK = 1;
defparam lsu_local_bb5_st__pre_pre.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb5_st__pre_pre.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb5_st__pre_pre.NUMBER_BANKS = 1;
defparam lsu_local_bb5_st__pre_pre.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb5_st__pre_pre.USEINPUTFIFO = 0;
defparam lsu_local_bb5_st__pre_pre.USECACHING = 0;
defparam lsu_local_bb5_st__pre_pre.USEOUTPUTFIFO = 1;
defparam lsu_local_bb5_st__pre_pre.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb5_st__pre_pre.HIGH_FMAX = 1;
defparam lsu_local_bb5_st__pre_pre.ADDRSPACE = 1;
defparam lsu_local_bb5_st__pre_pre.STYLE = "BURST-COALESCED";
defparam lsu_local_bb5_st__pre_pre.USE_BYTE_EN = 0;

assign local_bb5_st__pre_pre_inputs_ready = (merge_node_valid_out_2_NO_SHIFT_REG & local_bb5_arrayidx19_valid_out & local_bb5_do_directly_if_then14_select_valid_out);
assign local_bb5_st__pre_pre_output_regs_ready = (&(~(local_bb5_st__pre_pre_valid_out_NO_SHIFT_REG) | ~(local_bb5_st__pre_pre_stall_in)));
assign merge_node_stall_in_2 = (local_bb5_st__pre_pre_fu_stall_out | ~(local_bb5_st__pre_pre_inputs_ready));
assign local_bb5_arrayidx19_stall_in = (local_bb5_st__pre_pre_fu_stall_out | ~(local_bb5_st__pre_pre_inputs_ready));
assign local_bb5_do_directly_if_then14_select_stall_in = (local_bb5_st__pre_pre_fu_stall_out | ~(local_bb5_st__pre_pre_inputs_ready));
assign local_bb5_st__pre_pre_causedstall = (local_bb5_st__pre_pre_inputs_ready && (local_bb5_st__pre_pre_fu_stall_out && !(~(local_bb5_st__pre_pre_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_st__pre_pre_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_st__pre_pre_output_regs_ready)
		begin
			local_bb5_st__pre_pre_valid_out_NO_SHIFT_REG <= local_bb5_st__pre_pre_fu_valid_out;
		end
		else
		begin
			if (~(local_bb5_st__pre_pre_stall_in))
			begin
				local_bb5_st__pre_pre_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_or_cond_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_or_cond_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_or_cond_0_NO_SHIFT_REG;
 logic rnode_160to161_or_cond_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_or_cond_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_or_cond_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_or_cond_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_or_cond_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_or_cond_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_or_cond_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_or_cond_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_or_cond_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_or_cond_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_or_cond_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_or_cond_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_or_cond_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_or_cond_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_or_cond_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_or_cond_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_or_cond_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_or_cond_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_or_cond_0_stall_in_NO_SHIFT_REG = rnode_160to161_or_cond_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_or_cond_0_NO_SHIFT_REG = rnode_160to161_or_cond_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_or_cond_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_or_cond_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_or_cond_0_valid_out_NO_SHIFT_REG = rnode_160to161_or_cond_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_1_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_stall_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_c0_exe2_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_c0_exe2_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe2_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_c0_exe2_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_c0_exe2_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_c0_exe2_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_c0_exe2_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_c0_exe2_0_reg_161_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_160to161_c0_exe2_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_c0_exe2_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe2_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe2_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe2_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe2_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe2_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe2_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe2_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_c0_exe2_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe2_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe2_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe2_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe2_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe2_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe2_0_NO_SHIFT_REG = rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_c0_exe2_1_NO_SHIFT_REG = rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_indvars_iv17_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv17_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv17_0_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv17_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv17_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv17_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv17_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv17_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_indvars_iv17_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_indvars_iv17_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_indvars_iv17_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_indvars_iv17_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_indvars_iv17_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_indvars_iv17_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_indvars_iv17_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_indvars_iv17_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_indvars_iv17_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_indvars_iv17_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_indvars_iv17_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_indvars_iv17_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_indvars_iv17_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv17_0_stall_in_NO_SHIFT_REG = rnode_160to161_indvars_iv17_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv17_0_NO_SHIFT_REG = rnode_160to161_indvars_iv17_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv17_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_indvars_iv17_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv17_0_valid_out_NO_SHIFT_REG = rnode_160to161_indvars_iv17_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_right_lower_0_ph7_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_right_lower_0_ph7_0_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_right_lower_0_ph7_1_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_stall_out_reg_161_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_right_lower_0_ph7_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_right_lower_0_ph7_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_right_lower_0_ph7_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_right_lower_0_ph7_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_right_lower_0_ph7_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_right_lower_0_ph7_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_right_lower_0_ph7_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_right_lower_0_ph7_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_right_lower_0_ph7_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_right_lower_0_ph7_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_right_lower_0_ph7_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_right_lower_0_ph7_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_right_lower_0_ph7_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_right_lower_0_ph7_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG = rnode_160to161_right_lower_0_ph7_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_right_lower_0_ph7_0_NO_SHIFT_REG = rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_right_lower_0_ph7_1_NO_SHIFT_REG = rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_indvars_iv19_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv19_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv19_0_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv19_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv19_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv19_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv19_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv19_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_indvars_iv19_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_indvars_iv19_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_indvars_iv19_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_indvars_iv19_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_indvars_iv19_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_indvars_iv19_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_indvars_iv19_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_indvars_iv19_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_indvars_iv19_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_indvars_iv19_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_indvars_iv19_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_indvars_iv19_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_indvars_iv19_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv19_0_stall_in_NO_SHIFT_REG = rnode_160to161_indvars_iv19_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv19_0_NO_SHIFT_REG = rnode_160to161_indvars_iv19_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv19_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_indvars_iv19_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv19_0_valid_out_NO_SHIFT_REG = rnode_160to161_indvars_iv19_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_temp_index_0_ph8_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph8_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_temp_index_0_ph8_0_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph8_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph8_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_temp_index_0_ph8_1_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph8_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_temp_index_0_ph8_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph8_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph8_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph8_0_stall_out_reg_161_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_temp_index_0_ph8_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_temp_index_0_ph8_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_temp_index_0_ph8_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_temp_index_0_ph8_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_temp_index_0_ph8_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_temp_index_0_ph8_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_temp_index_0_ph8_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_temp_index_0_ph8_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_temp_index_0_ph8_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_temp_index_0_ph8_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_temp_index_0_ph8_0_reg_161_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_160to161_temp_index_0_ph8_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_temp_index_0_ph8_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_temp_index_0_ph8_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_temp_index_0_ph8_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_temp_index_0_ph8_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_temp_index_0_ph8_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_temp_index_0_ph8_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_temp_index_0_ph8_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_temp_index_0_ph8_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_temp_index_0_ph8_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_temp_index_0_ph8_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_temp_index_0_ph8_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_temp_index_0_ph8_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_temp_index_0_ph8_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_temp_index_0_ph8_0_stall_in_NO_SHIFT_REG = rnode_160to161_temp_index_0_ph8_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_temp_index_0_ph8_0_NO_SHIFT_REG = rnode_160to161_temp_index_0_ph8_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_temp_index_0_ph8_1_NO_SHIFT_REG = rnode_160to161_temp_index_0_ph8_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_var__u12_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_1_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_stall_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u12_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_var__u12_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_var__u12_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_var__u12_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_var__u12_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_var__u12_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_var__u12_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_var__u12_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_var__u12_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_var__u12_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_var__u12_0_reg_161_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_160to161_var__u12_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_var__u12_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_var__u12_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_var__u12_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_var__u12_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_var__u12_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_var__u12_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_var__u12_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_var__u12_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_var__u12_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_var__u12_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_var__u12_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_var__u12_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_var__u12_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_var__u12_0_stall_in_NO_SHIFT_REG = rnode_160to161_var__u12_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_var__u12_0_NO_SHIFT_REG = rnode_160to161_var__u12_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_var__u12_1_NO_SHIFT_REG = rnode_160to161_var__u12_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe1_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe1_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe1_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe1_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe1_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe1_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe1_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe1_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe1_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe1_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe1_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_c0_exe1_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe1_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe1_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe1_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe1_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe1_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe1_0_NO_SHIFT_REG = rnode_160to161_c0_exe1_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe1_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe1_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe1_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe3_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe3_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe3_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe3_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe3_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe3_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe3_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe3_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe3_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe3_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_c0_exe3_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe3_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe3_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe3_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe3_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe3_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe3_0_NO_SHIFT_REG = rnode_160to161_c0_exe3_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe3_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe3_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe4_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe4_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe4_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe4_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe4_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe4_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe4_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe4_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe4_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe4_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe4_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe4_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_c0_exe4_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe4_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe4_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe4_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe4_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe4_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe4_0_NO_SHIFT_REG = rnode_160to161_c0_exe4_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe4_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe4_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe4_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe4_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_c0_exe6_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_c0_exe6_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe6_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe6_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe6_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe6_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe6_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe6_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe6_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe6_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe6_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_c0_exe6_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe6_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe6_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe6_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe6_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe6_0_NO_SHIFT_REG = rnode_160to161_c0_exe6_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe6_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe6_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe6_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe7_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe7_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe7_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe7_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe7_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe7_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe7_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe7_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe7_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_c0_exe7_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe7_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe7_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe7_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe7_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe7_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe7_0_NO_SHIFT_REG = rnode_160to161_c0_exe7_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe7_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe7_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe7_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_indvars_iv21_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv21_0_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv21_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_indvars_iv21_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_indvars_iv21_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_indvars_iv21_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_indvars_iv21_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_indvars_iv21_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_indvars_iv21_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_indvars_iv21_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_indvars_iv21_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_indvars_iv21_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_indvars_iv21_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_indvars_iv21_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_indvars_iv21_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_indvars_iv21_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv21_0_stall_in_NO_SHIFT_REG = rnode_160to161_indvars_iv21_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv21_0_NO_SHIFT_REG = rnode_160to161_indvars_iv21_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv21_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_indvars_iv21_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv21_0_valid_out_NO_SHIFT_REG = rnode_160to161_indvars_iv21_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_cmp4_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_cmp4_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_cmp4_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp4_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_cmp4_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp4_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp4_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp4_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_cmp4_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_cmp4_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_cmp4_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_cmp4_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_cmp4_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_cmp4_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_cmp4_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_cmp4_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_cmp4_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_cmp4_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_cmp4_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_cmp4_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_cmp4_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_cmp4_0_stall_in_NO_SHIFT_REG = rnode_160to161_cmp4_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_cmp4_0_NO_SHIFT_REG = rnode_160to161_cmp4_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_cmp4_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_cmp4_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_cmp4_0_valid_out_NO_SHIFT_REG = rnode_160to161_cmp4_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_var__0_NO_SHIFT_REG;
 logic rnode_160to161_var__0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_var__0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_var__0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_var__0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_var__0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_var__0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_var__0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_var__0_NO_SHIFT_REG),
	.data_out(rnode_160to161_var__0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_var__0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_var__0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_var__0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_var__0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_var__0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_var__0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_var__0_stall_in_NO_SHIFT_REG = rnode_160to161_var__0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_var__0_NO_SHIFT_REG = rnode_160to161_var__0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_var__0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_var__0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_var__0_valid_out_NO_SHIFT_REG = rnode_160to161_var__0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_ld__0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_ld__0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_ld__0_NO_SHIFT_REG;
 logic rnode_160to161_ld__0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_ld__0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_ld__0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_ld__0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_ld__0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_ld__0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_ld__0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_ld__0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_ld__0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_ld__0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_ld__0_NO_SHIFT_REG),
	.data_out(rnode_160to161_ld__0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_ld__0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_ld__0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_ld__0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_ld__0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_ld__0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_ld__0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_ld__0_stall_in_NO_SHIFT_REG = rnode_160to161_ld__0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_ld__0_NO_SHIFT_REG = rnode_160to161_ld__0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_ld__0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_ld__0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_ld__0_valid_out_NO_SHIFT_REG = rnode_160to161_ld__0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_var__u13_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_var__u13_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_var__u13_0_NO_SHIFT_REG;
 logic rnode_160to161_var__u13_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_var__u13_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u13_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u13_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u13_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_var__u13_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_var__u13_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_var__u13_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_var__u13_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_var__u13_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_var__u13_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_var__u13_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_var__u13_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_var__u13_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_var__u13_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_var__u13_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_var__u13_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_var__u13_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_var__u13_0_stall_in_NO_SHIFT_REG = rnode_160to161_var__u13_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_var__u13_0_NO_SHIFT_REG = rnode_160to161_var__u13_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_var__u13_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_var__u13_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_var__u13_0_valid_out_NO_SHIFT_REG = rnode_160to161_var__u13_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_input_acl_hw_wg_id_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_input_acl_hw_wg_id_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_input_acl_hw_wg_id_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_input_acl_hw_wg_id_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_input_acl_hw_wg_id_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_input_acl_hw_wg_id_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_input_acl_hw_wg_id_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_input_acl_hw_wg_id_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = rnode_160to161_input_acl_hw_wg_id_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_160to161_input_acl_hw_wg_id_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_input_acl_hw_wg_id_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_160to161_input_acl_hw_wg_id_0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_161to161_bb5_st__pre_pre_valid_out;
wire rstag_161to161_bb5_st__pre_pre_stall_in;
wire rstag_161to161_bb5_st__pre_pre_inputs_ready;
wire rstag_161to161_bb5_st__pre_pre_stall_local;
 reg rstag_161to161_bb5_st__pre_pre_staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb5_st__pre_pre_combined_valid;

assign rstag_161to161_bb5_st__pre_pre_inputs_ready = local_bb5_st__pre_pre_valid_out_NO_SHIFT_REG;
assign rstag_161to161_bb5_st__pre_pre_combined_valid = (rstag_161to161_bb5_st__pre_pre_staging_valid_NO_SHIFT_REG | rstag_161to161_bb5_st__pre_pre_inputs_ready);
assign rstag_161to161_bb5_st__pre_pre_valid_out = rstag_161to161_bb5_st__pre_pre_combined_valid;
assign rstag_161to161_bb5_st__pre_pre_stall_local = rstag_161to161_bb5_st__pre_pre_stall_in;
assign local_bb5_st__pre_pre_stall_in = (|rstag_161to161_bb5_st__pre_pre_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb5_st__pre_pre_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_161to161_bb5_st__pre_pre_stall_local)
		begin
			if (~(rstag_161to161_bb5_st__pre_pre_staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb5_st__pre_pre_staging_valid_NO_SHIFT_REG <= rstag_161to161_bb5_st__pre_pre_inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb5_st__pre_pre_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb5_or_cond_not_stall_local;
wire local_bb5_or_cond_not;

assign local_bb5_or_cond_not = (rnode_160to161_or_cond_0_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb5_indvars_iv_next18_valid_out;
wire local_bb5_indvars_iv_next18_stall_in;
wire local_bb5_indvars_iv_next18_inputs_ready;
wire local_bb5_indvars_iv_next18_stall_local;
wire [63:0] local_bb5_indvars_iv_next18;

assign local_bb5_indvars_iv_next18_inputs_ready = rnode_160to161_indvars_iv17_0_valid_out_NO_SHIFT_REG;
assign local_bb5_indvars_iv_next18 = (rnode_160to161_indvars_iv17_0_NO_SHIFT_REG + 64'h1);
assign local_bb5_indvars_iv_next18_valid_out = local_bb5_indvars_iv_next18_inputs_ready;
assign local_bb5_indvars_iv_next18_stall_local = local_bb5_indvars_iv_next18_stall_in;
assign rnode_160to161_indvars_iv17_0_stall_in_NO_SHIFT_REG = (|local_bb5_indvars_iv_next18_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb5_inc_valid_out;
wire local_bb5_inc_stall_in;
wire local_bb5_inc_inputs_ready;
wire local_bb5_inc_stall_local;
wire [31:0] local_bb5_inc;

assign local_bb5_inc_inputs_ready = rnode_160to161_right_lower_0_ph7_0_valid_out_0_NO_SHIFT_REG;
assign local_bb5_inc = (rnode_160to161_right_lower_0_ph7_0_NO_SHIFT_REG + 32'h1);
assign local_bb5_inc_valid_out = local_bb5_inc_inputs_ready;
assign local_bb5_inc_stall_local = local_bb5_inc_stall_in;
assign rnode_160to161_right_lower_0_ph7_0_stall_in_0_NO_SHIFT_REG = (|local_bb5_inc_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb5_indvars_iv_next20_valid_out;
wire local_bb5_indvars_iv_next20_stall_in;
wire local_bb5_indvars_iv_next20_inputs_ready;
wire local_bb5_indvars_iv_next20_stall_local;
wire [63:0] local_bb5_indvars_iv_next20;

assign local_bb5_indvars_iv_next20_inputs_ready = rnode_160to161_indvars_iv19_0_valid_out_NO_SHIFT_REG;
assign local_bb5_indvars_iv_next20 = (rnode_160to161_indvars_iv19_0_NO_SHIFT_REG + 64'h1);
assign local_bb5_indvars_iv_next20_valid_out = local_bb5_indvars_iv_next20_inputs_ready;
assign local_bb5_indvars_iv_next20_stall_local = local_bb5_indvars_iv_next20_stall_in;
assign rnode_160to161_indvars_iv19_0_stall_in_NO_SHIFT_REG = (|local_bb5_indvars_iv_next20_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb5_inc17_valid_out;
wire local_bb5_inc17_stall_in;
wire local_bb5_inc17_inputs_ready;
wire local_bb5_inc17_stall_local;
wire [31:0] local_bb5_inc17;

assign local_bb5_inc17_inputs_ready = rnode_160to161_temp_index_0_ph8_0_valid_out_0_NO_SHIFT_REG;
assign local_bb5_inc17 = (rnode_160to161_temp_index_0_ph8_0_NO_SHIFT_REG + 32'h1);
assign local_bb5_inc17_valid_out = local_bb5_inc17_inputs_ready;
assign local_bb5_inc17_stall_local = local_bb5_inc17_stall_in;
assign rnode_160to161_temp_index_0_ph8_0_stall_in_0_NO_SHIFT_REG = (|local_bb5_inc17_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb5_not__stall_local;
wire local_bb5_not_;

assign local_bb5_not_ = (rnode_160to161_c0_exe2_0_NO_SHIFT_REG & local_bb5_or_cond_not);

// This section implements an unregistered operation.
// 
wire local_bb5_while_cond_outer6_branch_back_valid_out;
wire local_bb5_while_cond_outer6_branch_back_stall_in;
wire local_bb5_while_cond_outer6_branch_back_inputs_ready;
wire local_bb5_while_cond_outer6_branch_back_stall_local;
wire local_bb5_while_cond_outer6_branch_back;

assign local_bb5_while_cond_outer6_branch_back_inputs_ready = (rnode_160to161_or_cond_0_valid_out_NO_SHIFT_REG & rnode_160to161_c0_exe2_0_valid_out_0_NO_SHIFT_REG & rnode_160to161_var__u12_0_valid_out_0_NO_SHIFT_REG);
assign local_bb5_while_cond_outer6_branch_back = (local_bb5_not_ & rnode_160to161_var__u12_0_NO_SHIFT_REG);
assign local_bb5_while_cond_outer6_branch_back_valid_out = local_bb5_while_cond_outer6_branch_back_inputs_ready;
assign local_bb5_while_cond_outer6_branch_back_stall_local = local_bb5_while_cond_outer6_branch_back_stall_in;
assign rnode_160to161_or_cond_0_stall_in_NO_SHIFT_REG = (local_bb5_while_cond_outer6_branch_back_stall_local | ~(local_bb5_while_cond_outer6_branch_back_inputs_ready));
assign rnode_160to161_c0_exe2_0_stall_in_0_NO_SHIFT_REG = (local_bb5_while_cond_outer6_branch_back_stall_local | ~(local_bb5_while_cond_outer6_branch_back_inputs_ready));
assign rnode_160to161_var__u12_0_stall_in_0_NO_SHIFT_REG = (local_bb5_while_cond_outer6_branch_back_stall_local | ~(local_bb5_while_cond_outer6_branch_back_inputs_ready));

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_c0_exe1_0_reg_NO_SHIFT_REG;
 reg lvb_c0_exe2_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe3_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe4_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_c0_exe6_0_reg_NO_SHIFT_REG;
 reg lvb_c0_exe7_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_indvars_iv21_0_reg_NO_SHIFT_REG;
 reg lvb_cmp4_0_reg_NO_SHIFT_REG;
 reg lvb_var__0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG;
 reg lvb_var__u12_0_reg_NO_SHIFT_REG;
 reg lvb_var__u13_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb5_indvars_iv_next18_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb5_inc_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb5_indvars_iv_next20_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb5_inc17_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb5_while_cond_outer6_branch_back_valid_out & local_bb5_inc17_valid_out & local_bb5_indvars_iv_next20_valid_out & local_bb5_inc_valid_out & local_bb5_indvars_iv_next18_valid_out & rnode_160to161_c0_exe2_0_valid_out_1_NO_SHIFT_REG & rnode_160to161_right_lower_0_ph7_0_valid_out_1_NO_SHIFT_REG & rnode_160to161_temp_index_0_ph8_0_valid_out_1_NO_SHIFT_REG & rnode_160to161_var__u12_0_valid_out_1_NO_SHIFT_REG & rnode_160to161_c0_exe1_0_valid_out_NO_SHIFT_REG & rnode_160to161_c0_exe3_0_valid_out_NO_SHIFT_REG & rnode_160to161_c0_exe4_0_valid_out_NO_SHIFT_REG & rnode_160to161_c0_exe6_0_valid_out_NO_SHIFT_REG & rnode_160to161_c0_exe7_0_valid_out_NO_SHIFT_REG & rnode_160to161_indvars_iv21_0_valid_out_NO_SHIFT_REG & rnode_160to161_cmp4_0_valid_out_NO_SHIFT_REG & rnode_160to161_var__0_valid_out_NO_SHIFT_REG & rnode_160to161_ld__0_valid_out_NO_SHIFT_REG & rnode_160to161_var__u13_0_valid_out_NO_SHIFT_REG & rnode_160to161_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rstag_161to161_bb5_st__pre_pre_valid_out);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb5_while_cond_outer6_branch_back_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb5_inc17_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb5_indvars_iv_next20_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb5_inc_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb5_indvars_iv_next18_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe2_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_right_lower_0_ph7_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_temp_index_0_ph8_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_var__u12_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe1_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe3_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe4_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe7_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_indvars_iv21_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_cmp4_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_var__0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_ld__0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_var__u13_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_161to161_bb5_st__pre_pre_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_c0_exe1_0 = lvb_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe1_1 = lvb_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe2_0 = lvb_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe2_1 = lvb_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe3_0 = lvb_c0_exe3_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe3_1 = lvb_c0_exe3_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe4_0 = lvb_c0_exe4_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe4_1 = lvb_c0_exe4_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe6_0 = lvb_c0_exe6_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe6_1 = lvb_c0_exe6_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe7_0 = lvb_c0_exe7_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe7_1 = lvb_c0_exe7_0_reg_NO_SHIFT_REG;
assign lvb_indvars_iv21_0 = lvb_indvars_iv21_0_reg_NO_SHIFT_REG;
assign lvb_indvars_iv21_1 = lvb_indvars_iv21_0_reg_NO_SHIFT_REG;
assign lvb_cmp4_0 = lvb_cmp4_0_reg_NO_SHIFT_REG;
assign lvb_cmp4_1 = lvb_cmp4_0_reg_NO_SHIFT_REG;
assign lvb_var__0 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_var__1 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_ld__0 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_ld__1 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph7_0 = lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph7_1 = lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph8_0 = lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph8_1 = lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG;
assign lvb_var__u12_0 = lvb_var__u12_0_reg_NO_SHIFT_REG;
assign lvb_var__u12_1 = lvb_var__u12_0_reg_NO_SHIFT_REG;
assign lvb_var__u13_0 = lvb_var__u13_0_reg_NO_SHIFT_REG;
assign lvb_var__u13_1 = lvb_var__u13_0_reg_NO_SHIFT_REG;
assign lvb_bb5_indvars_iv_next18_0 = lvb_bb5_indvars_iv_next18_0_reg_NO_SHIFT_REG;
assign lvb_bb5_indvars_iv_next18_1 = lvb_bb5_indvars_iv_next18_0_reg_NO_SHIFT_REG;
assign lvb_bb5_inc_0 = lvb_bb5_inc_0_reg_NO_SHIFT_REG;
assign lvb_bb5_inc_1 = lvb_bb5_inc_0_reg_NO_SHIFT_REG;
assign lvb_bb5_indvars_iv_next20_0 = lvb_bb5_indvars_iv_next20_0_reg_NO_SHIFT_REG;
assign lvb_bb5_indvars_iv_next20_1 = lvb_bb5_indvars_iv_next20_0_reg_NO_SHIFT_REG;
assign lvb_bb5_inc17_0 = lvb_bb5_inc17_0_reg_NO_SHIFT_REG;
assign lvb_bb5_inc17_1 = lvb_bb5_inc17_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_0 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_1 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		lvb_c0_exe1_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe2_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe3_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe4_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_indvars_iv21_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp4_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__0_reg_NO_SHIFT_REG <= 'x;
		lvb_ld__0_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u12_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u13_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb5_indvars_iv_next18_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb5_inc_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb5_indvars_iv_next20_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb5_inc17_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_c0_exe1_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe1_0_NO_SHIFT_REG;
			lvb_c0_exe2_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe2_1_NO_SHIFT_REG;
			lvb_c0_exe3_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe3_0_NO_SHIFT_REG;
			lvb_c0_exe4_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe4_0_NO_SHIFT_REG;
			lvb_c0_exe6_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe6_0_NO_SHIFT_REG;
			lvb_c0_exe7_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe7_0_NO_SHIFT_REG;
			lvb_indvars_iv21_0_reg_NO_SHIFT_REG <= rnode_160to161_indvars_iv21_0_NO_SHIFT_REG;
			lvb_cmp4_0_reg_NO_SHIFT_REG <= rnode_160to161_cmp4_0_NO_SHIFT_REG;
			lvb_var__0_reg_NO_SHIFT_REG <= rnode_160to161_var__0_NO_SHIFT_REG;
			lvb_ld__0_reg_NO_SHIFT_REG <= rnode_160to161_ld__0_NO_SHIFT_REG;
			lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG <= rnode_160to161_right_lower_0_ph7_1_NO_SHIFT_REG;
			lvb_temp_index_0_ph8_0_reg_NO_SHIFT_REG <= rnode_160to161_temp_index_0_ph8_1_NO_SHIFT_REG;
			lvb_var__u12_0_reg_NO_SHIFT_REG <= rnode_160to161_var__u12_1_NO_SHIFT_REG;
			lvb_var__u13_0_reg_NO_SHIFT_REG <= rnode_160to161_var__u13_0_NO_SHIFT_REG;
			lvb_bb5_indvars_iv_next18_0_reg_NO_SHIFT_REG <= local_bb5_indvars_iv_next18;
			lvb_bb5_inc_0_reg_NO_SHIFT_REG <= local_bb5_inc;
			lvb_bb5_indvars_iv_next20_0_reg_NO_SHIFT_REG <= local_bb5_indvars_iv_next20;
			lvb_bb5_inc17_0_reg_NO_SHIFT_REG <= local_bb5_inc17;
			lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= rnode_160to161_input_acl_hw_wg_id_0_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= local_bb5_while_cond_outer6_branch_back;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_6
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_temp,
		input [63:0] 		input_data,
		input 		valid_in_0,
		output 		stall_out_0,
		input [31:0] 		input_c0_exe3_0,
		input 		input_c0_exe7_0,
		input [63:0] 		input_indvars_iv_0,
		input 		input_cmp424_0,
		input 		input_cmp_phi_decision80_xor_or_0,
		input [31:0] 		input_acl_hw_wg_id_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [31:0] 		input_c0_exe3_1,
		input 		input_c0_exe7_1,
		input [63:0] 		input_indvars_iv_1,
		input 		input_cmp424_1,
		input 		input_cmp_phi_decision80_xor_or_1,
		input [31:0] 		input_acl_hw_wg_id_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output [31:0] 		lvb_c0_exe3_0,
		output 		lvb_c0_exe7_0,
		output [63:0] 		lvb_bb6_indvars_iv_next_0,
		output 		lvb_cmp424_0,
		output 		lvb_cmp_phi_decision80_xor_or_0,
		output [31:0] 		lvb_input_acl_hw_wg_id_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [31:0] 		lvb_c0_exe3_1,
		output 		lvb_c0_exe7_1,
		output [63:0] 		lvb_bb6_indvars_iv_next_1,
		output 		lvb_cmp424_1,
		output 		lvb_cmp_phi_decision80_xor_or_1,
		output [31:0] 		lvb_input_acl_hw_wg_id_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb6_ld__readdata,
		input 		avm_local_bb6_ld__readdatavalid,
		input 		avm_local_bb6_ld__waitrequest,
		output [29:0] 		avm_local_bb6_ld__address,
		output 		avm_local_bb6_ld__read,
		output 		avm_local_bb6_ld__write,
		input 		avm_local_bb6_ld__writeack,
		output [255:0] 		avm_local_bb6_ld__writedata,
		output [31:0] 		avm_local_bb6_ld__byteenable,
		output [4:0] 		avm_local_bb6_ld__burstcount,
		output 		local_bb6_ld__active,
		input 		clock2x,
		input [255:0] 		avm_local_bb6_st__readdata,
		input 		avm_local_bb6_st__readdatavalid,
		input 		avm_local_bb6_st__waitrequest,
		output [29:0] 		avm_local_bb6_st__address,
		output 		avm_local_bb6_st__read,
		output 		avm_local_bb6_st__write,
		input 		avm_local_bb6_st__writeack,
		output [255:0] 		avm_local_bb6_st__writedata,
		output [31:0] 		avm_local_bb6_st__byteenable,
		output [4:0] 		avm_local_bb6_st__burstcount,
		output 		local_bb6_st__active
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((valid_in_0 & valid_in_1) & ~((stall_out_0 | stall_out_1)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_node_stall_in_5;
 reg merge_node_valid_out_5_NO_SHIFT_REG;
wire merge_node_stall_in_6;
 reg merge_node_valid_out_6_NO_SHIFT_REG;
wire merge_node_stall_in_7;
 reg merge_node_valid_out_7_NO_SHIFT_REG;
wire merge_node_stall_in_8;
 reg merge_node_valid_out_8_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_0_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp424_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp_phi_decision80_xor_or_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe3_NO_SHIFT_REG;
 reg local_lvm_c0_exe7_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv_NO_SHIFT_REG;
 reg local_lvm_cmp424_NO_SHIFT_REG;
 reg local_lvm_cmp_phi_decision80_xor_or_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_1_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp424_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp_phi_decision80_xor_or_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG));
assign stall_out_0 = merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
assign stall_out_1 = merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_0_staging_reg_NO_SHIFT_REG | valid_in_0))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		if ((merge_node_valid_in_1_staging_reg_NO_SHIFT_REG | valid_in_1))
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b1;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
		end
		else
		begin
			merge_block_selector_NO_SHIFT_REG = 1'b0;
			is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_c0_exe3_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp424_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_phi_decision80_xor_or_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_c0_exe3_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp424_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_phi_decision80_xor_or_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe3_0_staging_reg_NO_SHIFT_REG <= input_c0_exe3_0;
				input_c0_exe7_0_staging_reg_NO_SHIFT_REG <= input_c0_exe7_0;
				input_indvars_iv_0_staging_reg_NO_SHIFT_REG <= input_indvars_iv_0;
				input_cmp424_0_staging_reg_NO_SHIFT_REG <= input_cmp424_0;
				input_cmp_phi_decision80_xor_or_0_staging_reg_NO_SHIFT_REG <= input_cmp_phi_decision80_xor_or_0;
				input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= valid_in_0;
			end
		end
		else
		begin
			merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
		if (((merge_block_selector_NO_SHIFT_REG != 1'b1) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_1_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe3_1_staging_reg_NO_SHIFT_REG <= input_c0_exe3_1;
				input_c0_exe7_1_staging_reg_NO_SHIFT_REG <= input_c0_exe7_1;
				input_indvars_iv_1_staging_reg_NO_SHIFT_REG <= input_indvars_iv_1;
				input_cmp424_1_staging_reg_NO_SHIFT_REG <= input_cmp424_1;
				input_cmp_phi_decision80_xor_or_1_staging_reg_NO_SHIFT_REG <= input_cmp_phi_decision80_xor_or_1;
				input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
				merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= valid_in_1;
			end
		end
		else
		begin
			merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_0_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_0_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv_NO_SHIFT_REG <= input_indvars_iv_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp424_NO_SHIFT_REG <= input_cmp424_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_phi_decision80_xor_or_NO_SHIFT_REG <= input_cmp_phi_decision80_xor_or_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_0;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_0;
					local_lvm_indvars_iv_NO_SHIFT_REG <= input_indvars_iv_0;
					local_lvm_cmp424_NO_SHIFT_REG <= input_cmp424_0;
					local_lvm_cmp_phi_decision80_xor_or_NO_SHIFT_REG <= input_cmp_phi_decision80_xor_or_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv_NO_SHIFT_REG <= input_indvars_iv_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp424_NO_SHIFT_REG <= input_cmp424_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_phi_decision80_xor_or_NO_SHIFT_REG <= input_cmp_phi_decision80_xor_or_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_1;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_1;
					local_lvm_indvars_iv_NO_SHIFT_REG <= input_indvars_iv_1;
					local_lvm_cmp424_NO_SHIFT_REG <= input_cmp424_1;
					local_lvm_cmp_phi_decision80_xor_or_NO_SHIFT_REG <= input_cmp_phi_decision80_xor_or_1;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_5_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_6_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_7_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_8_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_5))
			begin
				merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_6))
			begin
				merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_7))
			begin
				merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_8))
			begin
				merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb6_arrayidx45_valid_out;
wire local_bb6_arrayidx45_stall_in;
wire local_bb6_arrayidx45_inputs_ready;
wire local_bb6_arrayidx45_stall_local;
wire [63:0] local_bb6_arrayidx45;

assign local_bb6_arrayidx45_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb6_arrayidx45 = (input_temp + (local_lvm_indvars_iv_NO_SHIFT_REG << 6'h2));
assign local_bb6_arrayidx45_valid_out = local_bb6_arrayidx45_inputs_ready;
assign local_bb6_arrayidx45_stall_local = local_bb6_arrayidx45_stall_in;
assign merge_node_stall_in_0 = (|local_bb6_arrayidx45_stall_local);

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_input_data_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_input_data_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_input_data_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_input_data_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_data_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_data_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_input_data_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_input_data_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_input_data_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_input_data_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_input_data_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_1to160_input_data_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_input_data_0_reg_160_fifo.DATA_WIDTH = 0;
defparam rnode_1to160_input_data_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_input_data_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_input_data_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to160_input_data_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_input_data_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_input_data_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_input_data_0_valid_out_NO_SHIFT_REG = rnode_1to160_input_data_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_cmp424_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_cmp424_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to164_cmp424_0_NO_SHIFT_REG;
 logic rnode_1to164_cmp424_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to164_cmp424_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp424_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp424_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp424_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_cmp424_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_cmp424_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_cmp424_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_cmp424_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_cmp424_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_cmp424_NO_SHIFT_REG),
	.data_out(rnode_1to164_cmp424_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_cmp424_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_cmp424_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_1to164_cmp424_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_cmp424_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_cmp424_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to164_cmp424_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_cmp424_0_NO_SHIFT_REG = rnode_1to164_cmp424_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_cmp424_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_cmp424_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_cmp424_0_valid_out_NO_SHIFT_REG = rnode_1to164_cmp424_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_c0_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe7_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe7_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe7_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe7_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_c0_exe7_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_c0_exe7_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_c0_exe7_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_c0_exe7_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_c0_exe7_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_c0_exe7_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe7_NO_SHIFT_REG),
	.data_out(rnode_1to164_c0_exe7_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_c0_exe7_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_c0_exe7_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_1to164_c0_exe7_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_c0_exe7_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_c0_exe7_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to164_c0_exe7_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe7_0_NO_SHIFT_REG = rnode_1to164_c0_exe7_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_c0_exe7_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_c0_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_c0_exe7_0_valid_out_NO_SHIFT_REG = rnode_1to164_c0_exe7_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to164_input_acl_hw_wg_id_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_input_acl_hw_wg_id_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_input_acl_hw_wg_id_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_input_acl_hw_wg_id_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_input_acl_hw_wg_id_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_input_acl_hw_wg_id_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to164_input_acl_hw_wg_id_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_input_acl_hw_wg_id_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_input_acl_hw_wg_id_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to164_input_acl_hw_wg_id_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_indvars_iv_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv_0_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_indvars_iv_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_indvars_iv_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_indvars_iv_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_indvars_iv_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_indvars_iv_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv_NO_SHIFT_REG),
	.data_out(rnode_1to160_indvars_iv_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_indvars_iv_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_indvars_iv_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_indvars_iv_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_indvars_iv_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_indvars_iv_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to160_indvars_iv_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv_0_NO_SHIFT_REG = rnode_1to160_indvars_iv_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_indvars_iv_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv_0_valid_out_NO_SHIFT_REG = rnode_1to160_indvars_iv_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_cmp_phi_decision80_xor_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision80_xor_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision80_xor_or_0_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision80_xor_or_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision80_xor_or_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision80_xor_or_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_cmp_phi_decision80_xor_or_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_cmp_phi_decision80_xor_or_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_cmp_phi_decision80_xor_or_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_cmp_phi_decision80_xor_or_NO_SHIFT_REG),
	.data_out(rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to160_cmp_phi_decision80_xor_or_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp_phi_decision80_xor_or_0_NO_SHIFT_REG = rnode_1to160_cmp_phi_decision80_xor_or_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp_phi_decision80_xor_or_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_cmp_phi_decision80_xor_or_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_cmp_phi_decision80_xor_or_0_valid_out_NO_SHIFT_REG = rnode_1to160_cmp_phi_decision80_xor_or_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_1to163_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to163_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to163_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_1to163_c0_exe3_0_reg_163_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to163_c0_exe3_0_reg_163_NO_SHIFT_REG;
 logic rnode_1to163_c0_exe3_0_valid_out_reg_163_NO_SHIFT_REG;
 logic rnode_1to163_c0_exe3_0_stall_in_reg_163_NO_SHIFT_REG;
 logic rnode_1to163_c0_exe3_0_stall_out_reg_163_NO_SHIFT_REG;

acl_data_fifo rnode_1to163_c0_exe3_0_reg_163_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to163_c0_exe3_0_reg_163_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to163_c0_exe3_0_stall_in_reg_163_NO_SHIFT_REG),
	.valid_out(rnode_1to163_c0_exe3_0_valid_out_reg_163_NO_SHIFT_REG),
	.stall_out(rnode_1to163_c0_exe3_0_stall_out_reg_163_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe3_NO_SHIFT_REG),
	.data_out(rnode_1to163_c0_exe3_0_reg_163_NO_SHIFT_REG)
);

defparam rnode_1to163_c0_exe3_0_reg_163_fifo.DEPTH = 163;
defparam rnode_1to163_c0_exe3_0_reg_163_fifo.DATA_WIDTH = 32;
defparam rnode_1to163_c0_exe3_0_reg_163_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to163_c0_exe3_0_reg_163_fifo.IMPL = "ram";

assign rnode_1to163_c0_exe3_0_reg_163_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to163_c0_exe3_0_stall_out_reg_163_NO_SHIFT_REG;
assign rnode_1to163_c0_exe3_0_NO_SHIFT_REG = rnode_1to163_c0_exe3_0_reg_163_NO_SHIFT_REG;
assign rnode_1to163_c0_exe3_0_stall_in_reg_163_NO_SHIFT_REG = rnode_1to163_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_1to163_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_1to163_c0_exe3_0_valid_out_reg_163_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb6_ld__inputs_ready;
 reg local_bb6_ld__valid_out_NO_SHIFT_REG;
wire local_bb6_ld__stall_in;
wire local_bb6_ld__output_regs_ready;
wire local_bb6_ld__fu_stall_out;
wire local_bb6_ld__fu_valid_out;
wire [31:0] local_bb6_ld__lsu_dataout;
 reg [31:0] local_bb6_ld__NO_SHIFT_REG;
wire local_bb6_ld__causedstall;

lsu_top lsu_local_bb6_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb6_ld__fu_stall_out),
	.i_valid(local_bb6_ld__inputs_ready),
	.i_address(local_bb6_arrayidx45),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(local_lvm_cmp_phi_decision80_xor_or_NO_SHIFT_REG),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb6_ld__output_regs_ready)),
	.o_valid(local_bb6_ld__fu_valid_out),
	.o_readdata(local_bb6_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb6_ld__active),
	.avm_address(avm_local_bb6_ld__address),
	.avm_read(avm_local_bb6_ld__read),
	.avm_readdata(avm_local_bb6_ld__readdata),
	.avm_write(avm_local_bb6_ld__write),
	.avm_writeack(avm_local_bb6_ld__writeack),
	.avm_burstcount(avm_local_bb6_ld__burstcount),
	.avm_writedata(avm_local_bb6_ld__writedata),
	.avm_byteenable(avm_local_bb6_ld__byteenable),
	.avm_waitrequest(avm_local_bb6_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb6_ld__readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb6_ld_.AWIDTH = 30;
defparam lsu_local_bb6_ld_.WIDTH_BYTES = 4;
defparam lsu_local_bb6_ld_.MWIDTH_BYTES = 32;
defparam lsu_local_bb6_ld_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb6_ld_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb6_ld_.READ = 1;
defparam lsu_local_bb6_ld_.ATOMIC = 0;
defparam lsu_local_bb6_ld_.WIDTH = 32;
defparam lsu_local_bb6_ld_.MWIDTH = 256;
defparam lsu_local_bb6_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb6_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb6_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb6_ld_.MEMORY_SIDE_MEM_LATENCY = 138;
defparam lsu_local_bb6_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb6_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb6_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb6_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb6_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb6_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb6_ld_.USECACHING = 0;
defparam lsu_local_bb6_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb6_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb6_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb6_ld_.ADDRSPACE = 1;
defparam lsu_local_bb6_ld_.STYLE = "BURST-COALESCED";

assign local_bb6_ld__inputs_ready = (local_bb6_arrayidx45_valid_out & merge_node_valid_out_1_NO_SHIFT_REG);
assign local_bb6_ld__output_regs_ready = (&(~(local_bb6_ld__valid_out_NO_SHIFT_REG) | ~(local_bb6_ld__stall_in)));
assign local_bb6_arrayidx45_stall_in = (local_bb6_ld__fu_stall_out | ~(local_bb6_ld__inputs_ready));
assign merge_node_stall_in_1 = (local_bb6_ld__fu_stall_out | ~(local_bb6_ld__inputs_ready));
assign local_bb6_ld__causedstall = (local_bb6_ld__inputs_ready && (local_bb6_ld__fu_stall_out && !(~(local_bb6_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb6_ld__NO_SHIFT_REG <= 'x;
		local_bb6_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb6_ld__output_regs_ready)
		begin
			local_bb6_ld__NO_SHIFT_REG <= local_bb6_ld__lsu_dataout;
			local_bb6_ld__valid_out_NO_SHIFT_REG <= local_bb6_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb6_ld__stall_in))
			begin
				local_bb6_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_input_data_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_input_data_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_input_data_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_input_data_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_data_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_data_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_input_data_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_input_data_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_input_data_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_input_data_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_input_data_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_160to161_input_data_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_input_data_0_reg_161_fifo.DATA_WIDTH = 0;
defparam rnode_160to161_input_data_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_input_data_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_input_data_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_input_data_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_input_data_0_stall_in_NO_SHIFT_REG = rnode_160to161_input_data_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_input_data_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_input_data_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_input_data_0_valid_out_NO_SHIFT_REG = rnode_160to161_input_data_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_cmp424_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_1_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_stall_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp424_0_reg_165_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_164to165_cmp424_0_reg_165_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_164to165_cmp424_0_reg_165_NO_SHIFT_REG),
	.valid_in(rnode_164to165_cmp424_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_cmp424_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.data_out(rnode_164to165_cmp424_0_reg_165_NO_SHIFT_REG_fa),
	.valid_out({rnode_164to165_cmp424_0_valid_out_0_NO_SHIFT_REG, rnode_164to165_cmp424_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_164to165_cmp424_0_stall_in_0_NO_SHIFT_REG, rnode_164to165_cmp424_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_164to165_cmp424_0_reg_165_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_164to165_cmp424_0_reg_165_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_164to165_cmp424_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_cmp424_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_cmp424_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_cmp424_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_cmp424_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_cmp424_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_cmp424_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_cmp424_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_cmp424_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_cmp424_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_cmp424_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_cmp424_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_cmp424_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_cmp424_0_stall_in_NO_SHIFT_REG = rnode_164to165_cmp424_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_cmp424_0_NO_SHIFT_REG = rnode_164to165_cmp424_0_reg_165_NO_SHIFT_REG_fa;
assign rnode_164to165_cmp424_1_NO_SHIFT_REG = rnode_164to165_cmp424_0_reg_165_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_c0_exe7_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_1_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_stall_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_164to165_c0_exe7_0_reg_165_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG),
	.valid_in(rnode_164to165_c0_exe7_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_c0_exe7_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.data_out(rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG_fa),
	.valid_out({rnode_164to165_c0_exe7_0_valid_out_0_NO_SHIFT_REG, rnode_164to165_c0_exe7_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_164to165_c0_exe7_0_stall_in_0_NO_SHIFT_REG, rnode_164to165_c0_exe7_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_164to165_c0_exe7_0_reg_165_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_164to165_c0_exe7_0_reg_165_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_164to165_c0_exe7_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_c0_exe7_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_c0_exe7_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_c0_exe7_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_c0_exe7_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_c0_exe7_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_c0_exe7_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_c0_exe7_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_c0_exe7_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_c0_exe7_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_c0_exe7_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_c0_exe7_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_c0_exe7_0_stall_in_NO_SHIFT_REG = rnode_164to165_c0_exe7_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe7_0_NO_SHIFT_REG = rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG_fa;
assign rnode_164to165_c0_exe7_1_NO_SHIFT_REG = rnode_164to165_c0_exe7_0_reg_165_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_input_acl_hw_wg_id_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_input_acl_hw_wg_id_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_input_acl_hw_wg_id_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_input_acl_hw_wg_id_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_input_acl_hw_wg_id_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_input_acl_hw_wg_id_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_input_acl_hw_wg_id_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_input_acl_hw_wg_id_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_input_acl_hw_wg_id_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_input_acl_hw_wg_id_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = rnode_164to165_input_acl_hw_wg_id_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_164to165_input_acl_hw_wg_id_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_input_acl_hw_wg_id_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_164to165_input_acl_hw_wg_id_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_indvars_iv_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv_0_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv_1_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv_0_stall_out_reg_161_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_indvars_iv_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_indvars_iv_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_indvars_iv_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_indvars_iv_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_indvars_iv_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_indvars_iv_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_indvars_iv_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_indvars_iv_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_indvars_iv_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_indvars_iv_0_reg_161_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_160to161_indvars_iv_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_indvars_iv_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_indvars_iv_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_indvars_iv_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_indvars_iv_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_indvars_iv_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_indvars_iv_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_indvars_iv_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_indvars_iv_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_indvars_iv_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_indvars_iv_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_indvars_iv_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_indvars_iv_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_indvars_iv_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv_0_stall_in_NO_SHIFT_REG = rnode_160to161_indvars_iv_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv_0_NO_SHIFT_REG = rnode_160to161_indvars_iv_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_indvars_iv_1_NO_SHIFT_REG = rnode_160to161_indvars_iv_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_stall_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_cmp_phi_decision80_xor_or_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_cmp_phi_decision80_xor_or_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_cmp_phi_decision80_xor_or_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_cmp_phi_decision80_xor_or_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_cmp_phi_decision80_xor_or_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_cmp_phi_decision80_xor_or_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_cmp_phi_decision80_xor_or_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_cmp_phi_decision80_xor_or_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_cmp_phi_decision80_xor_or_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_cmp_phi_decision80_xor_or_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_cmp_phi_decision80_xor_or_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_cmp_phi_decision80_xor_or_0_stall_in_NO_SHIFT_REG = rnode_160to161_cmp_phi_decision80_xor_or_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_cmp_phi_decision80_xor_or_0_NO_SHIFT_REG = rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_cmp_phi_decision80_xor_or_1_NO_SHIFT_REG = rnode_160to161_cmp_phi_decision80_xor_or_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_c0_exe3_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_163to164_c0_exe3_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_163to164_c0_exe3_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_163to164_c0_exe3_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_c0_exe3_1_NO_SHIFT_REG;
 logic rnode_163to164_c0_exe3_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_c0_exe3_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_c0_exe3_0_valid_out_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_c0_exe3_0_stall_in_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_c0_exe3_0_stall_out_reg_164_NO_SHIFT_REG;
 logic [31:0] rnode_163to164_c0_exe3_0_reg_164_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_163to164_c0_exe3_0_reg_164_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_163to164_c0_exe3_0_reg_164_NO_SHIFT_REG),
	.valid_in(rnode_163to164_c0_exe3_0_valid_out_0_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_c0_exe3_0_stall_in_0_reg_164_NO_SHIFT_REG),
	.data_out(rnode_163to164_c0_exe3_0_reg_164_NO_SHIFT_REG_fa),
	.valid_out({rnode_163to164_c0_exe3_0_valid_out_0_NO_SHIFT_REG, rnode_163to164_c0_exe3_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_163to164_c0_exe3_0_stall_in_0_NO_SHIFT_REG, rnode_163to164_c0_exe3_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_163to164_c0_exe3_0_reg_164_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_163to164_c0_exe3_0_reg_164_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_163to164_c0_exe3_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_c0_exe3_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_c0_exe3_0_stall_in_0_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_c0_exe3_0_valid_out_0_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_c0_exe3_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rnode_1to163_c0_exe3_0_NO_SHIFT_REG),
	.data_out(rnode_163to164_c0_exe3_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_c0_exe3_0_reg_164_fifo.DEPTH = 2;
defparam rnode_163to164_c0_exe3_0_reg_164_fifo.DATA_WIDTH = 32;
defparam rnode_163to164_c0_exe3_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_163to164_c0_exe3_0_reg_164_fifo.IMPL = "ll_reg";

assign rnode_163to164_c0_exe3_0_reg_164_inputs_ready_NO_SHIFT_REG = rnode_1to163_c0_exe3_0_valid_out_NO_SHIFT_REG;
assign rnode_1to163_c0_exe3_0_stall_in_NO_SHIFT_REG = rnode_163to164_c0_exe3_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_163to164_c0_exe3_0_NO_SHIFT_REG = rnode_163to164_c0_exe3_0_reg_164_NO_SHIFT_REG_fa;
assign rnode_163to164_c0_exe3_1_NO_SHIFT_REG = rnode_163to164_c0_exe3_0_reg_164_NO_SHIFT_REG_fa;

// This section implements a staging register.
// 
wire rstag_161to161_bb6_ld__valid_out;
wire rstag_161to161_bb6_ld__stall_in;
wire rstag_161to161_bb6_ld__inputs_ready;
wire rstag_161to161_bb6_ld__stall_local;
 reg rstag_161to161_bb6_ld__staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb6_ld__combined_valid;
 reg [31:0] rstag_161to161_bb6_ld__staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_161to161_bb6_ld_;

assign rstag_161to161_bb6_ld__inputs_ready = local_bb6_ld__valid_out_NO_SHIFT_REG;
assign rstag_161to161_bb6_ld_ = (rstag_161to161_bb6_ld__staging_valid_NO_SHIFT_REG ? rstag_161to161_bb6_ld__staging_reg_NO_SHIFT_REG : local_bb6_ld__NO_SHIFT_REG);
assign rstag_161to161_bb6_ld__combined_valid = (rstag_161to161_bb6_ld__staging_valid_NO_SHIFT_REG | rstag_161to161_bb6_ld__inputs_ready);
assign rstag_161to161_bb6_ld__valid_out = rstag_161to161_bb6_ld__combined_valid;
assign rstag_161to161_bb6_ld__stall_local = rstag_161to161_bb6_ld__stall_in;
assign local_bb6_ld__stall_in = (|rstag_161to161_bb6_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb6_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb6_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb6_ld__stall_local)
		begin
			if (~(rstag_161to161_bb6_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb6_ld__staging_valid_NO_SHIFT_REG <= rstag_161to161_bb6_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb6_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb6_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb6_ld__staging_reg_NO_SHIFT_REG <= local_bb6_ld__NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb6_arrayidx47_valid_out;
wire local_bb6_arrayidx47_stall_in;
wire local_bb6_arrayidx47_inputs_ready;
wire local_bb6_arrayidx47_stall_local;
wire [63:0] local_bb6_arrayidx47;

assign local_bb6_arrayidx47_inputs_ready = (rnode_160to161_input_data_0_valid_out_NO_SHIFT_REG & rnode_160to161_indvars_iv_0_valid_out_0_NO_SHIFT_REG);
assign local_bb6_arrayidx47 = (input_data + (rnode_160to161_indvars_iv_0_NO_SHIFT_REG << 6'h2));
assign local_bb6_arrayidx47_valid_out = local_bb6_arrayidx47_inputs_ready;
assign local_bb6_arrayidx47_stall_local = local_bb6_arrayidx47_stall_in;
assign rnode_160to161_input_data_0_stall_in_NO_SHIFT_REG = (local_bb6_arrayidx47_stall_local | ~(local_bb6_arrayidx47_inputs_ready));
assign rnode_160to161_indvars_iv_0_stall_in_0_NO_SHIFT_REG = (local_bb6_arrayidx47_stall_local | ~(local_bb6_arrayidx47_inputs_ready));

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_161to163_indvars_iv_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to163_indvars_iv_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_161to163_indvars_iv_0_NO_SHIFT_REG;
 logic rnode_161to163_indvars_iv_0_reg_163_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_161to163_indvars_iv_0_reg_163_NO_SHIFT_REG;
 logic rnode_161to163_indvars_iv_0_valid_out_reg_163_NO_SHIFT_REG;
 logic rnode_161to163_indvars_iv_0_stall_in_reg_163_NO_SHIFT_REG;
 logic rnode_161to163_indvars_iv_0_stall_out_reg_163_NO_SHIFT_REG;

acl_data_fifo rnode_161to163_indvars_iv_0_reg_163_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to163_indvars_iv_0_reg_163_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to163_indvars_iv_0_stall_in_reg_163_NO_SHIFT_REG),
	.valid_out(rnode_161to163_indvars_iv_0_valid_out_reg_163_NO_SHIFT_REG),
	.stall_out(rnode_161to163_indvars_iv_0_stall_out_reg_163_NO_SHIFT_REG),
	.data_in(rnode_160to161_indvars_iv_1_NO_SHIFT_REG),
	.data_out(rnode_161to163_indvars_iv_0_reg_163_NO_SHIFT_REG)
);

defparam rnode_161to163_indvars_iv_0_reg_163_fifo.DEPTH = 3;
defparam rnode_161to163_indvars_iv_0_reg_163_fifo.DATA_WIDTH = 64;
defparam rnode_161to163_indvars_iv_0_reg_163_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to163_indvars_iv_0_reg_163_fifo.IMPL = "ll_reg";

assign rnode_161to163_indvars_iv_0_reg_163_inputs_ready_NO_SHIFT_REG = rnode_160to161_indvars_iv_0_valid_out_1_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv_0_stall_in_1_NO_SHIFT_REG = rnode_161to163_indvars_iv_0_stall_out_reg_163_NO_SHIFT_REG;
assign rnode_161to163_indvars_iv_0_NO_SHIFT_REG = rnode_161to163_indvars_iv_0_reg_163_NO_SHIFT_REG;
assign rnode_161to163_indvars_iv_0_stall_in_reg_163_NO_SHIFT_REG = rnode_161to163_indvars_iv_0_stall_in_NO_SHIFT_REG;
assign rnode_161to163_indvars_iv_0_valid_out_NO_SHIFT_REG = rnode_161to163_indvars_iv_0_valid_out_reg_163_NO_SHIFT_REG;

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_161to165_cmp_phi_decision80_xor_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision80_xor_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision80_xor_or_0_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision80_xor_or_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision80_xor_or_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision80_xor_or_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to165_cmp_phi_decision80_xor_or_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_161to165_cmp_phi_decision80_xor_or_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_161to165_cmp_phi_decision80_xor_or_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_160to161_cmp_phi_decision80_xor_or_1_NO_SHIFT_REG),
	.data_out(rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_fifo.DEPTH = 5;
defparam rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_160to161_cmp_phi_decision80_xor_or_0_valid_out_1_NO_SHIFT_REG;
assign rnode_160to161_cmp_phi_decision80_xor_or_0_stall_in_1_NO_SHIFT_REG = rnode_161to165_cmp_phi_decision80_xor_or_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_161to165_cmp_phi_decision80_xor_or_0_NO_SHIFT_REG = rnode_161to165_cmp_phi_decision80_xor_or_0_reg_165_NO_SHIFT_REG;
assign rnode_161to165_cmp_phi_decision80_xor_or_0_stall_in_reg_165_NO_SHIFT_REG = rnode_161to165_cmp_phi_decision80_xor_or_0_stall_in_NO_SHIFT_REG;
assign rnode_161to165_cmp_phi_decision80_xor_or_0_valid_out_NO_SHIFT_REG = rnode_161to165_cmp_phi_decision80_xor_or_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_164to165_c0_exe3_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_c0_exe3_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_c0_exe3_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_c0_exe3_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_c0_exe3_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_c0_exe3_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_c0_exe3_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_163to164_c0_exe3_1_NO_SHIFT_REG),
	.data_out(rnode_164to165_c0_exe3_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_c0_exe3_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_c0_exe3_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_164to165_c0_exe3_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_c0_exe3_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_c0_exe3_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_163to164_c0_exe3_0_valid_out_1_NO_SHIFT_REG;
assign rnode_163to164_c0_exe3_0_stall_in_1_NO_SHIFT_REG = rnode_164to165_c0_exe3_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe3_0_NO_SHIFT_REG = rnode_164to165_c0_exe3_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_c0_exe3_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_164to165_c0_exe3_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_161to161_bb6_arrayidx47_valid_out;
wire rstag_161to161_bb6_arrayidx47_stall_in;
wire rstag_161to161_bb6_arrayidx47_inputs_ready;
wire rstag_161to161_bb6_arrayidx47_stall_local;
 reg rstag_161to161_bb6_arrayidx47_staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb6_arrayidx47_combined_valid;
 reg [63:0] rstag_161to161_bb6_arrayidx47_staging_reg_NO_SHIFT_REG;
wire [63:0] rstag_161to161_bb6_arrayidx47;

assign rstag_161to161_bb6_arrayidx47_inputs_ready = local_bb6_arrayidx47_valid_out;
assign rstag_161to161_bb6_arrayidx47 = (rstag_161to161_bb6_arrayidx47_staging_valid_NO_SHIFT_REG ? rstag_161to161_bb6_arrayidx47_staging_reg_NO_SHIFT_REG : local_bb6_arrayidx47);
assign rstag_161to161_bb6_arrayidx47_combined_valid = (rstag_161to161_bb6_arrayidx47_staging_valid_NO_SHIFT_REG | rstag_161to161_bb6_arrayidx47_inputs_ready);
assign rstag_161to161_bb6_arrayidx47_valid_out = rstag_161to161_bb6_arrayidx47_combined_valid;
assign rstag_161to161_bb6_arrayidx47_stall_local = rstag_161to161_bb6_arrayidx47_stall_in;
assign local_bb6_arrayidx47_stall_in = (|rstag_161to161_bb6_arrayidx47_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb6_arrayidx47_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb6_arrayidx47_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb6_arrayidx47_stall_local)
		begin
			if (~(rstag_161to161_bb6_arrayidx47_staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb6_arrayidx47_staging_valid_NO_SHIFT_REG <= rstag_161to161_bb6_arrayidx47_inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb6_arrayidx47_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb6_arrayidx47_staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb6_arrayidx47_staging_reg_NO_SHIFT_REG <= local_bb6_arrayidx47;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb6_indvars_iv_next_valid_out;
wire local_bb6_indvars_iv_next_stall_in;
wire local_bb6_indvars_iv_next_inputs_ready;
wire local_bb6_indvars_iv_next_stall_local;
wire [63:0] local_bb6_indvars_iv_next;

assign local_bb6_indvars_iv_next_inputs_ready = rnode_161to163_indvars_iv_0_valid_out_NO_SHIFT_REG;
assign local_bb6_indvars_iv_next = (rnode_161to163_indvars_iv_0_NO_SHIFT_REG + 64'h1);
assign local_bb6_indvars_iv_next_valid_out = local_bb6_indvars_iv_next_inputs_ready;
assign local_bb6_indvars_iv_next_stall_local = local_bb6_indvars_iv_next_stall_in;
assign rnode_161to163_indvars_iv_0_stall_in_NO_SHIFT_REG = (|local_bb6_indvars_iv_next_stall_local);

// This section implements a registered operation.
// 
wire local_bb6_st__inputs_ready;
 reg local_bb6_st__valid_out_NO_SHIFT_REG;
wire local_bb6_st__stall_in;
wire local_bb6_st__output_regs_ready;
wire local_bb6_st__fu_stall_out;
wire local_bb6_st__fu_valid_out;
wire local_bb6_st__causedstall;

lsu_top lsu_local_bb6_st_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb6_st__fu_stall_out),
	.i_valid(local_bb6_st__inputs_ready),
	.i_address(rstag_161to161_bb6_arrayidx47),
	.i_writedata(rstag_161to161_bb6_ld_),
	.i_cmpdata(),
	.i_predicate(rnode_160to161_cmp_phi_decision80_xor_or_0_NO_SHIFT_REG),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb6_st__output_regs_ready)),
	.o_valid(local_bb6_st__fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb6_st__active),
	.avm_address(avm_local_bb6_st__address),
	.avm_read(avm_local_bb6_st__read),
	.avm_readdata(avm_local_bb6_st__readdata),
	.avm_write(avm_local_bb6_st__write),
	.avm_writeack(avm_local_bb6_st__writeack),
	.avm_burstcount(avm_local_bb6_st__burstcount),
	.avm_writedata(avm_local_bb6_st__writedata),
	.avm_byteenable(avm_local_bb6_st__byteenable),
	.avm_waitrequest(avm_local_bb6_st__waitrequest),
	.avm_readdatavalid(avm_local_bb6_st__readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb6_st_.AWIDTH = 30;
defparam lsu_local_bb6_st_.WIDTH_BYTES = 4;
defparam lsu_local_bb6_st_.MWIDTH_BYTES = 32;
defparam lsu_local_bb6_st_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb6_st_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb6_st_.READ = 0;
defparam lsu_local_bb6_st_.ATOMIC = 0;
defparam lsu_local_bb6_st_.WIDTH = 32;
defparam lsu_local_bb6_st_.MWIDTH = 256;
defparam lsu_local_bb6_st_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb6_st_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb6_st_.KERNEL_SIDE_MEM_LATENCY = 4;
defparam lsu_local_bb6_st_.MEMORY_SIDE_MEM_LATENCY = 12;
defparam lsu_local_bb6_st_.USE_WRITE_ACK = 0;
defparam lsu_local_bb6_st_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb6_st_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb6_st_.NUMBER_BANKS = 1;
defparam lsu_local_bb6_st_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb6_st_.USEINPUTFIFO = 0;
defparam lsu_local_bb6_st_.USECACHING = 0;
defparam lsu_local_bb6_st_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb6_st_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb6_st_.HIGH_FMAX = 1;
defparam lsu_local_bb6_st_.ADDRSPACE = 1;
defparam lsu_local_bb6_st_.STYLE = "BURST-COALESCED";
defparam lsu_local_bb6_st_.USE_BYTE_EN = 0;

assign local_bb6_st__inputs_ready = (rnode_160to161_cmp_phi_decision80_xor_or_0_valid_out_0_NO_SHIFT_REG & rstag_161to161_bb6_arrayidx47_valid_out & rstag_161to161_bb6_ld__valid_out);
assign local_bb6_st__output_regs_ready = (&(~(local_bb6_st__valid_out_NO_SHIFT_REG) | ~(local_bb6_st__stall_in)));
assign rnode_160to161_cmp_phi_decision80_xor_or_0_stall_in_0_NO_SHIFT_REG = (local_bb6_st__fu_stall_out | ~(local_bb6_st__inputs_ready));
assign rstag_161to161_bb6_arrayidx47_stall_in = (local_bb6_st__fu_stall_out | ~(local_bb6_st__inputs_ready));
assign rstag_161to161_bb6_ld__stall_in = (local_bb6_st__fu_stall_out | ~(local_bb6_st__inputs_ready));
assign local_bb6_st__causedstall = (local_bb6_st__inputs_ready && (local_bb6_st__fu_stall_out && !(~(local_bb6_st__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb6_st__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb6_st__output_regs_ready)
		begin
			local_bb6_st__valid_out_NO_SHIFT_REG <= local_bb6_st__fu_valid_out;
		end
		else
		begin
			if (~(local_bb6_st__stall_in))
			begin
				local_bb6_st__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_bb6_indvars_iv_next_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_163to164_bb6_indvars_iv_next_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_bb6_indvars_iv_next_0_NO_SHIFT_REG;
 logic rnode_163to164_bb6_indvars_iv_next_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_163to164_bb6_indvars_iv_next_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_bb6_indvars_iv_next_1_NO_SHIFT_REG;
 logic rnode_163to164_bb6_indvars_iv_next_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_bb6_indvars_iv_next_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb6_indvars_iv_next_0_valid_out_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb6_indvars_iv_next_0_stall_in_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb6_indvars_iv_next_0_stall_out_reg_164_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_bb6_indvars_iv_next_0_reg_164_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_163to164_bb6_indvars_iv_next_0_reg_164_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_163to164_bb6_indvars_iv_next_0_reg_164_NO_SHIFT_REG),
	.valid_in(rnode_163to164_bb6_indvars_iv_next_0_valid_out_0_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb6_indvars_iv_next_0_stall_in_0_reg_164_NO_SHIFT_REG),
	.data_out(rnode_163to164_bb6_indvars_iv_next_0_reg_164_NO_SHIFT_REG_fa),
	.valid_out({rnode_163to164_bb6_indvars_iv_next_0_valid_out_0_NO_SHIFT_REG, rnode_163to164_bb6_indvars_iv_next_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_163to164_bb6_indvars_iv_next_0_stall_in_0_NO_SHIFT_REG, rnode_163to164_bb6_indvars_iv_next_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_163to164_bb6_indvars_iv_next_0_reg_164_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_163to164_bb6_indvars_iv_next_0_reg_164_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_163to164_bb6_indvars_iv_next_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb6_indvars_iv_next_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb6_indvars_iv_next_0_stall_in_0_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb6_indvars_iv_next_0_valid_out_0_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb6_indvars_iv_next_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb6_indvars_iv_next),
	.data_out(rnode_163to164_bb6_indvars_iv_next_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb6_indvars_iv_next_0_reg_164_fifo.DEPTH = 2;
defparam rnode_163to164_bb6_indvars_iv_next_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_163to164_bb6_indvars_iv_next_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_163to164_bb6_indvars_iv_next_0_reg_164_fifo.IMPL = "ll_reg";

assign rnode_163to164_bb6_indvars_iv_next_0_reg_164_inputs_ready_NO_SHIFT_REG = local_bb6_indvars_iv_next_valid_out;
assign local_bb6_indvars_iv_next_stall_in = rnode_163to164_bb6_indvars_iv_next_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb6_indvars_iv_next_0_NO_SHIFT_REG = rnode_163to164_bb6_indvars_iv_next_0_reg_164_NO_SHIFT_REG_fa;
assign rnode_163to164_bb6_indvars_iv_next_1_NO_SHIFT_REG = rnode_163to164_bb6_indvars_iv_next_0_reg_164_NO_SHIFT_REG_fa;

// This section implements a staging register.
// 
wire rstag_165to165_bb6_st__valid_out;
wire rstag_165to165_bb6_st__stall_in;
wire rstag_165to165_bb6_st__inputs_ready;
wire rstag_165to165_bb6_st__stall_local;
 reg rstag_165to165_bb6_st__staging_valid_NO_SHIFT_REG;
wire rstag_165to165_bb6_st__combined_valid;

assign rstag_165to165_bb6_st__inputs_ready = local_bb6_st__valid_out_NO_SHIFT_REG;
assign rstag_165to165_bb6_st__combined_valid = (rstag_165to165_bb6_st__staging_valid_NO_SHIFT_REG | rstag_165to165_bb6_st__inputs_ready);
assign rstag_165to165_bb6_st__valid_out = rstag_165to165_bb6_st__combined_valid;
assign rstag_165to165_bb6_st__stall_local = rstag_165to165_bb6_st__stall_in;
assign local_bb6_st__stall_in = (|rstag_165to165_bb6_st__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_165to165_bb6_st__staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_165to165_bb6_st__stall_local)
		begin
			if (~(rstag_165to165_bb6_st__staging_valid_NO_SHIFT_REG))
			begin
				rstag_165to165_bb6_st__staging_valid_NO_SHIFT_REG <= rstag_165to165_bb6_st__inputs_ready;
			end
		end
		else
		begin
			rstag_165to165_bb6_st__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb6_var__stall_local;
wire [31:0] local_bb6_var_;

assign local_bb6_var_ = rnode_163to164_bb6_indvars_iv_next_0_NO_SHIFT_REG[31:0];

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb6_indvars_iv_next_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb6_indvars_iv_next_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_bb6_indvars_iv_next_0_NO_SHIFT_REG;
 logic rnode_164to165_bb6_indvars_iv_next_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_bb6_indvars_iv_next_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_indvars_iv_next_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_indvars_iv_next_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_indvars_iv_next_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb6_indvars_iv_next_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb6_indvars_iv_next_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb6_indvars_iv_next_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb6_indvars_iv_next_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb6_indvars_iv_next_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_163to164_bb6_indvars_iv_next_1_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb6_indvars_iv_next_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb6_indvars_iv_next_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb6_indvars_iv_next_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_bb6_indvars_iv_next_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb6_indvars_iv_next_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb6_indvars_iv_next_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_163to164_bb6_indvars_iv_next_0_valid_out_1_NO_SHIFT_REG;
assign rnode_163to164_bb6_indvars_iv_next_0_stall_in_1_NO_SHIFT_REG = rnode_164to165_bb6_indvars_iv_next_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb6_indvars_iv_next_0_NO_SHIFT_REG = rnode_164to165_bb6_indvars_iv_next_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb6_indvars_iv_next_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_bb6_indvars_iv_next_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_bb6_indvars_iv_next_0_valid_out_NO_SHIFT_REG = rnode_164to165_bb6_indvars_iv_next_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb6_cmp42_valid_out;
wire local_bb6_cmp42_stall_in;
wire local_bb6_cmp42_inputs_ready;
wire local_bb6_cmp42_stall_local;
wire local_bb6_cmp42;

assign local_bb6_cmp42_inputs_ready = (rnode_163to164_c0_exe3_0_valid_out_0_NO_SHIFT_REG & rnode_163to164_bb6_indvars_iv_next_0_valid_out_0_NO_SHIFT_REG);
assign local_bb6_cmp42 = ($signed(local_bb6_var_) > $signed(rnode_163to164_c0_exe3_0_NO_SHIFT_REG));
assign local_bb6_cmp42_valid_out = local_bb6_cmp42_inputs_ready;
assign local_bb6_cmp42_stall_local = local_bb6_cmp42_stall_in;
assign rnode_163to164_c0_exe3_0_stall_in_0_NO_SHIFT_REG = (local_bb6_cmp42_stall_local | ~(local_bb6_cmp42_inputs_ready));
assign rnode_163to164_bb6_indvars_iv_next_0_stall_in_0_NO_SHIFT_REG = (local_bb6_cmp42_stall_local | ~(local_bb6_cmp42_inputs_ready));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb6_cmp42_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp42_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp42_0_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp42_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp42_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp42_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp42_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp42_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb6_cmp42_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb6_cmp42_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb6_cmp42_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb6_cmp42_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb6_cmp42_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb6_cmp42),
	.data_out(rnode_164to165_bb6_cmp42_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb6_cmp42_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb6_cmp42_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb6_cmp42_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb6_cmp42_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb6_cmp42_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb6_cmp42_valid_out;
assign local_bb6_cmp42_stall_in = rnode_164to165_bb6_cmp42_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb6_cmp42_0_NO_SHIFT_REG = rnode_164to165_bb6_cmp42_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb6_cmp42_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_bb6_cmp42_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_bb6_cmp42_0_valid_out_NO_SHIFT_REG = rnode_164to165_bb6_cmp42_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb6_cmp42_GUARD_stall_local;
wire local_bb6_cmp42_GUARD;

assign local_bb6_cmp42_GUARD = (rnode_164to165_bb6_cmp42_0_NO_SHIFT_REG | rnode_164to165_cmp424_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb6_var__u14_valid_out;
wire local_bb6_var__u14_stall_in;
wire local_bb6_var__u14_inputs_ready;
wire local_bb6_var__u14_stall_local;
wire local_bb6_var__u14;

assign local_bb6_var__u14_inputs_ready = (rnode_164to165_bb6_cmp42_0_valid_out_NO_SHIFT_REG & rnode_164to165_cmp424_0_valid_out_0_NO_SHIFT_REG & rnode_164to165_c0_exe7_0_valid_out_0_NO_SHIFT_REG);
assign local_bb6_var__u14 = (local_bb6_cmp42_GUARD | rnode_164to165_c0_exe7_0_NO_SHIFT_REG);
assign local_bb6_var__u14_valid_out = local_bb6_var__u14_inputs_ready;
assign local_bb6_var__u14_stall_local = local_bb6_var__u14_stall_in;
assign rnode_164to165_bb6_cmp42_0_stall_in_NO_SHIFT_REG = (local_bb6_var__u14_stall_local | ~(local_bb6_var__u14_inputs_ready));
assign rnode_164to165_cmp424_0_stall_in_0_NO_SHIFT_REG = (local_bb6_var__u14_stall_local | ~(local_bb6_var__u14_inputs_ready));
assign rnode_164to165_c0_exe7_0_stall_in_0_NO_SHIFT_REG = (local_bb6_var__u14_stall_local | ~(local_bb6_var__u14_inputs_ready));

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_c0_exe3_0_reg_NO_SHIFT_REG;
 reg lvb_c0_exe7_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb6_indvars_iv_next_0_reg_NO_SHIFT_REG;
 reg lvb_cmp424_0_reg_NO_SHIFT_REG;
 reg lvb_cmp_phi_decision80_xor_or_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb6_var__u14_valid_out & rnode_161to165_cmp_phi_decision80_xor_or_0_valid_out_NO_SHIFT_REG & rnode_164to165_c0_exe3_0_valid_out_NO_SHIFT_REG & rnode_164to165_bb6_indvars_iv_next_0_valid_out_NO_SHIFT_REG & rnode_164to165_cmp424_0_valid_out_1_NO_SHIFT_REG & rnode_164to165_c0_exe7_0_valid_out_1_NO_SHIFT_REG & rnode_164to165_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rstag_165to165_bb6_st__valid_out);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb6_var__u14_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to165_cmp_phi_decision80_xor_or_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_c0_exe3_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_bb6_indvars_iv_next_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_cmp424_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_c0_exe7_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_165to165_bb6_st__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_c0_exe3_0 = lvb_c0_exe3_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe3_1 = lvb_c0_exe3_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe7_0 = lvb_c0_exe7_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe7_1 = lvb_c0_exe7_0_reg_NO_SHIFT_REG;
assign lvb_bb6_indvars_iv_next_0 = lvb_bb6_indvars_iv_next_0_reg_NO_SHIFT_REG;
assign lvb_bb6_indvars_iv_next_1 = lvb_bb6_indvars_iv_next_0_reg_NO_SHIFT_REG;
assign lvb_cmp424_0 = lvb_cmp424_0_reg_NO_SHIFT_REG;
assign lvb_cmp424_1 = lvb_cmp424_0_reg_NO_SHIFT_REG;
assign lvb_cmp_phi_decision80_xor_or_0 = lvb_cmp_phi_decision80_xor_or_0_reg_NO_SHIFT_REG;
assign lvb_cmp_phi_decision80_xor_or_1 = lvb_cmp_phi_decision80_xor_or_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_0 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_1 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		lvb_c0_exe3_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb6_indvars_iv_next_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp424_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp_phi_decision80_xor_or_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_c0_exe3_0_reg_NO_SHIFT_REG <= rnode_164to165_c0_exe3_0_NO_SHIFT_REG;
			lvb_c0_exe7_0_reg_NO_SHIFT_REG <= rnode_164to165_c0_exe7_1_NO_SHIFT_REG;
			lvb_bb6_indvars_iv_next_0_reg_NO_SHIFT_REG <= rnode_164to165_bb6_indvars_iv_next_0_NO_SHIFT_REG;
			lvb_cmp424_0_reg_NO_SHIFT_REG <= rnode_164to165_cmp424_1_NO_SHIFT_REG;
			lvb_cmp_phi_decision80_xor_or_0_reg_NO_SHIFT_REG <= rnode_161to165_cmp_phi_decision80_xor_or_0_NO_SHIFT_REG;
			lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= rnode_164to165_input_acl_hw_wg_id_0_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= local_bb6_var__u14;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_7
	(
		input 		clock,
		input 		resetn,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_input_acl_hw_wg_id,
		input [31:0] 		workgroup_size,
		input 		start
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in;
 reg merge_node_valid_out_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = (|(merge_node_stall_in & merge_node_valid_out_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in))
			begin
				merge_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
wire branch_var__output_regs_ready;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = ~(stall_in);
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign valid_out = branch_var__inputs_ready;
assign lvb_input_acl_hw_wg_id = local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_8
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_temp,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_c0_exe1,
		input 		input_c0_exe2,
		input [31:0] 		input_c0_exe3,
		input [31:0] 		input_c0_exe4,
		input [63:0] 		input_c0_exe6,
		input 		input_c0_exe7,
		input [63:0] 		input_indvars_iv21,
		input [31:0] 		input_ld_,
		input [31:0] 		input_right_lower_0_ph7,
		input [31:0] 		input_temp_index_0_ph8,
		input 		input_var_,
		input 		input_var__u15,
		input [31:0] 		input_inc17,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out_0,
		input 		stall_in_0,
		output [31:0] 		lvb_c0_exe1_0,
		output 		lvb_c0_exe2_0,
		output [31:0] 		lvb_c0_exe3_0,
		output [31:0] 		lvb_c0_exe4_0,
		output [63:0] 		lvb_c0_exe6_0,
		output 		lvb_c0_exe7_0,
		output [31:0] 		lvb_right_lower_0_ph7_0,
		output [31:0] 		lvb_inc17_0,
		output [63:0] 		lvb_bb8_indvars_iv_next22_0,
		output [63:0] 		lvb_bb8_var__0,
		output [31:0] 		lvb_input_acl_hw_wg_id_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [31:0] 		lvb_c0_exe1_1,
		output 		lvb_c0_exe2_1,
		output [31:0] 		lvb_c0_exe3_1,
		output [31:0] 		lvb_c0_exe4_1,
		output [63:0] 		lvb_c0_exe6_1,
		output 		lvb_c0_exe7_1,
		output [31:0] 		lvb_right_lower_0_ph7_1,
		output [31:0] 		lvb_inc17_1,
		output [63:0] 		lvb_bb8_indvars_iv_next22_1,
		output [63:0] 		lvb_bb8_var__1,
		output [31:0] 		lvb_input_acl_hw_wg_id_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb8_st__readdata,
		input 		avm_local_bb8_st__readdatavalid,
		input 		avm_local_bb8_st__waitrequest,
		output [29:0] 		avm_local_bb8_st__address,
		output 		avm_local_bb8_st__read,
		output 		avm_local_bb8_st__write,
		input 		avm_local_bb8_st__writeack,
		output [255:0] 		avm_local_bb8_st__writedata,
		output [31:0] 		avm_local_bb8_st__byteenable,
		output [4:0] 		avm_local_bb8_st__burstcount,
		output 		local_bb8_st__active,
		input 		clock2x
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((valid_out_0 & valid_out_1) & ~((stall_in_0 | stall_in_1)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_node_stall_in_5;
 reg merge_node_valid_out_5_NO_SHIFT_REG;
wire merge_node_stall_in_6;
 reg merge_node_valid_out_6_NO_SHIFT_REG;
wire merge_node_stall_in_7;
 reg merge_node_valid_out_7_NO_SHIFT_REG;
wire merge_node_stall_in_8;
 reg merge_node_valid_out_8_NO_SHIFT_REG;
wire merge_node_stall_in_9;
 reg merge_node_valid_out_9_NO_SHIFT_REG;
wire merge_node_stall_in_10;
 reg merge_node_valid_out_10_NO_SHIFT_REG;
wire merge_node_stall_in_11;
 reg merge_node_valid_out_11_NO_SHIFT_REG;
wire merge_node_stall_in_12;
 reg merge_node_valid_out_12_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe2_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe4_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_c0_exe6_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_indvars_iv21_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__staging_reg_NO_SHIFT_REG;
 reg [31:0] input_right_lower_0_ph7_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_temp_index_0_ph8_staging_reg_NO_SHIFT_REG;
 reg input_var__staging_reg_NO_SHIFT_REG;
 reg input_var__u15_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_inc17_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe1_NO_SHIFT_REG;
 reg local_lvm_c0_exe2_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe3_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe4_NO_SHIFT_REG;
 reg [63:0] local_lvm_c0_exe6_NO_SHIFT_REG;
 reg local_lvm_c0_exe7_NO_SHIFT_REG;
 reg [63:0] local_lvm_indvars_iv21_NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [31:0] local_lvm_right_lower_0_ph7_NO_SHIFT_REG;
 reg [31:0] local_lvm_temp_index_0_ph8_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg local_lvm_var__u15_NO_SHIFT_REG;
 reg [31:0] local_lvm_inc17_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG) | (merge_node_stall_in_9 & merge_node_valid_out_9_NO_SHIFT_REG) | (merge_node_stall_in_10 & merge_node_valid_out_10_NO_SHIFT_REG) | (merge_node_stall_in_11 & merge_node_valid_out_11_NO_SHIFT_REG) | (merge_node_stall_in_12 & merge_node_valid_out_12_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_c0_exe1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe2_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe3_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe4_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe6_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_staging_reg_NO_SHIFT_REG <= 'x;
		input_indvars_iv21_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph7_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph8_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u15_staging_reg_NO_SHIFT_REG <= 'x;
		input_inc17_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe1_staging_reg_NO_SHIFT_REG <= input_c0_exe1;
				input_c0_exe2_staging_reg_NO_SHIFT_REG <= input_c0_exe2;
				input_c0_exe3_staging_reg_NO_SHIFT_REG <= input_c0_exe3;
				input_c0_exe4_staging_reg_NO_SHIFT_REG <= input_c0_exe4;
				input_c0_exe6_staging_reg_NO_SHIFT_REG <= input_c0_exe6;
				input_c0_exe7_staging_reg_NO_SHIFT_REG <= input_c0_exe7;
				input_indvars_iv21_staging_reg_NO_SHIFT_REG <= input_indvars_iv21;
				input_ld__staging_reg_NO_SHIFT_REG <= input_ld_;
				input_right_lower_0_ph7_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph7;
				input_temp_index_0_ph8_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph8;
				input_var__staging_reg_NO_SHIFT_REG <= input_var_;
				input_var__u15_staging_reg_NO_SHIFT_REG <= input_var__u15;
				input_inc17_staging_reg_NO_SHIFT_REG <= input_inc17;
				input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_staging_reg_NO_SHIFT_REG;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__staging_reg_NO_SHIFT_REG;
					local_lvm_var__u15_NO_SHIFT_REG <= input_var__u15_staging_reg_NO_SHIFT_REG;
					local_lvm_inc17_NO_SHIFT_REG <= input_inc17_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1;
					local_lvm_c0_exe2_NO_SHIFT_REG <= input_c0_exe2;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3;
					local_lvm_c0_exe4_NO_SHIFT_REG <= input_c0_exe4;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7;
					local_lvm_indvars_iv21_NO_SHIFT_REG <= input_indvars_iv21;
					local_lvm_ld__NO_SHIFT_REG <= input_ld_;
					local_lvm_right_lower_0_ph7_NO_SHIFT_REG <= input_right_lower_0_ph7;
					local_lvm_temp_index_0_ph8_NO_SHIFT_REG <= input_temp_index_0_ph8;
					local_lvm_var__NO_SHIFT_REG <= input_var_;
					local_lvm_var__u15_NO_SHIFT_REG <= input_var__u15;
					local_lvm_inc17_NO_SHIFT_REG <= input_inc17;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_9_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_10_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_11_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_12_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_5_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_6_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_7_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_8_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_9_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_10_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_11_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_12_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_5))
			begin
				merge_node_valid_out_5_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_6))
			begin
				merge_node_valid_out_6_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_7))
			begin
				merge_node_valid_out_7_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_8))
			begin
				merge_node_valid_out_8_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_9))
			begin
				merge_node_valid_out_9_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_10))
			begin
				merge_node_valid_out_10_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_11))
			begin
				merge_node_valid_out_11_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_12))
			begin
				merge_node_valid_out_12_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb8_idxprom34_stall_local;
wire [63:0] local_bb8_idxprom34;

assign local_bb8_idxprom34[32] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[33] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[34] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[35] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[36] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[37] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[38] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[39] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[40] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[41] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[42] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[43] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[44] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[45] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[46] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[47] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[48] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[49] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[50] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[51] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[52] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[53] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[54] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[55] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[56] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[57] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[58] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[59] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[60] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[61] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[62] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[63] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG[31];
assign local_bb8_idxprom34[31:0] = local_lvm_temp_index_0_ph8_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_indvars_iv21_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv21_0_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_indvars_iv21_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_indvars_iv21_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_indvars_iv21_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_indvars_iv21_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_indvars_iv21_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_indvars_iv21_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_indvars_iv21_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_indvars_iv21_NO_SHIFT_REG),
	.data_out(rnode_1to160_indvars_iv21_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_indvars_iv21_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_indvars_iv21_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_indvars_iv21_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_indvars_iv21_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_indvars_iv21_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to160_indvars_iv21_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv21_0_NO_SHIFT_REG = rnode_1to160_indvars_iv21_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv21_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_indvars_iv21_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv21_0_valid_out_NO_SHIFT_REG = rnode_1to160_indvars_iv21_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_inc17_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_inc17_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_inc17_0_NO_SHIFT_REG;
 logic rnode_1to160_inc17_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_inc17_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_inc17_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_inc17_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_inc17_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_inc17_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_inc17_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_inc17_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_inc17_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_inc17_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_inc17_NO_SHIFT_REG),
	.data_out(rnode_1to160_inc17_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_inc17_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_inc17_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_inc17_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_inc17_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_inc17_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to160_inc17_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_inc17_0_NO_SHIFT_REG = rnode_1to160_inc17_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_inc17_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_inc17_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_inc17_0_valid_out_NO_SHIFT_REG = rnode_1to160_inc17_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe2_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe2_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe2_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe2_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe2_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe2_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe2_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe2_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe2_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe2_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe2_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_c0_exe2_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe2_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe2_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to160_c0_exe2_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe2_0_NO_SHIFT_REG = rnode_1to160_c0_exe2_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe2_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe2_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe2_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe2_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_var__u15_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_var__u15_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_var__u15_0_NO_SHIFT_REG;
 logic rnode_1to160_var__u15_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_var__u15_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__u15_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__u15_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_var__u15_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_var__u15_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_var__u15_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_var__u15_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_var__u15_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_var__u15_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_var__u15_NO_SHIFT_REG),
	.data_out(rnode_1to160_var__u15_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_var__u15_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_var__u15_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_var__u15_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_var__u15_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_var__u15_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to160_var__u15_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_var__u15_0_NO_SHIFT_REG = rnode_1to160_var__u15_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_var__u15_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_var__u15_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_var__u15_0_valid_out_NO_SHIFT_REG = rnode_1to160_var__u15_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe1_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe1_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe1_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe1_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe1_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe1_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe1_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe1_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe1_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe1_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe1_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe1_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_c0_exe1_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe1_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe1_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to160_c0_exe1_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe1_0_NO_SHIFT_REG = rnode_1to160_c0_exe1_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe1_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe1_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe1_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe3_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe3_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe3_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe3_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe3_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe3_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe3_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe3_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe3_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe3_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe3_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_c0_exe3_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe3_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe3_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to160_c0_exe3_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe3_0_NO_SHIFT_REG = rnode_1to160_c0_exe3_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe3_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe3_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe4_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe4_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_c0_exe4_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe4_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe4_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe4_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe4_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe4_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe4_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe4_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe4_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe4_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe4_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_c0_exe4_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe4_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe4_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to160_c0_exe4_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe4_0_NO_SHIFT_REG = rnode_1to160_c0_exe4_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe4_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe4_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe4_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe4_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_c0_exe6_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_c0_exe6_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe6_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe6_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe6_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe6_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe6_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe6_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe6_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe6_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe6_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe6_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_c0_exe6_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe6_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe6_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_9_NO_SHIFT_REG;
assign merge_node_stall_in_9 = rnode_1to160_c0_exe6_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe6_0_NO_SHIFT_REG = rnode_1to160_c0_exe6_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe6_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe6_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe6_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_c0_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_c0_exe7_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_c0_exe7_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_c0_exe7_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_c0_exe7_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_c0_exe7_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_c0_exe7_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe7_NO_SHIFT_REG),
	.data_out(rnode_1to160_c0_exe7_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_c0_exe7_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_c0_exe7_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_c0_exe7_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_c0_exe7_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_c0_exe7_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_10_NO_SHIFT_REG;
assign merge_node_stall_in_10 = rnode_1to160_c0_exe7_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe7_0_NO_SHIFT_REG = rnode_1to160_c0_exe7_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_c0_exe7_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_c0_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_c0_exe7_0_valid_out_NO_SHIFT_REG = rnode_1to160_c0_exe7_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_right_lower_0_ph7_0_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_right_lower_0_ph7_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_right_lower_0_ph7_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_right_lower_0_ph7_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_right_lower_0_ph7_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_right_lower_0_ph7_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_right_lower_0_ph7_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_right_lower_0_ph7_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_right_lower_0_ph7_NO_SHIFT_REG),
	.data_out(rnode_1to160_right_lower_0_ph7_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_right_lower_0_ph7_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_right_lower_0_ph7_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_right_lower_0_ph7_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_right_lower_0_ph7_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_right_lower_0_ph7_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_11_NO_SHIFT_REG;
assign merge_node_stall_in_11 = rnode_1to160_right_lower_0_ph7_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_right_lower_0_ph7_0_NO_SHIFT_REG = rnode_1to160_right_lower_0_ph7_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_right_lower_0_ph7_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG = rnode_1to160_right_lower_0_ph7_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to160_input_acl_hw_wg_id_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_acl_hw_wg_id_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_input_acl_hw_wg_id_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_input_acl_hw_wg_id_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_input_acl_hw_wg_id_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_input_acl_hw_wg_id_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to160_input_acl_hw_wg_id_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo.DATA_WIDTH = 32;
defparam rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_input_acl_hw_wg_id_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_input_acl_hw_wg_id_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_12_NO_SHIFT_REG;
assign merge_node_stall_in_12 = rnode_1to160_input_acl_hw_wg_id_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to160_input_acl_hw_wg_id_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_input_acl_hw_wg_id_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to160_input_acl_hw_wg_id_0_valid_out_reg_160_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb8_arrayidx35_valid_out;
wire local_bb8_arrayidx35_stall_in;
wire local_bb8_arrayidx35_inputs_ready;
wire local_bb8_arrayidx35_stall_local;
wire [63:0] local_bb8_arrayidx35;

assign local_bb8_arrayidx35_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb8_arrayidx35 = (input_temp + (local_bb8_idxprom34 << 6'h2));
assign local_bb8_arrayidx35_valid_out = local_bb8_arrayidx35_inputs_ready;
assign local_bb8_arrayidx35_stall_local = local_bb8_arrayidx35_stall_in;
assign merge_node_stall_in_0 = (|local_bb8_arrayidx35_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_indvars_iv21_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv21_0_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_indvars_iv21_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_indvars_iv21_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_indvars_iv21_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_indvars_iv21_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_indvars_iv21_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_indvars_iv21_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_indvars_iv21_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_indvars_iv21_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_indvars_iv21_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_indvars_iv21_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_indvars_iv21_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_indvars_iv21_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_indvars_iv21_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_indvars_iv21_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_indvars_iv21_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_indvars_iv21_0_stall_in_NO_SHIFT_REG = rnode_160to161_indvars_iv21_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv21_0_NO_SHIFT_REG = rnode_160to161_indvars_iv21_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv21_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_indvars_iv21_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_indvars_iv21_0_valid_out_NO_SHIFT_REG = rnode_160to161_indvars_iv21_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_inc17_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_inc17_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_inc17_0_NO_SHIFT_REG;
 logic rnode_160to161_inc17_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_inc17_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_inc17_1_NO_SHIFT_REG;
 logic rnode_160to161_inc17_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_inc17_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_inc17_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_inc17_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_inc17_0_stall_out_reg_161_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_inc17_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_inc17_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_inc17_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_inc17_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_inc17_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_inc17_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_inc17_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_inc17_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_inc17_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_inc17_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_inc17_0_reg_161_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_160to161_inc17_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_inc17_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_inc17_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_inc17_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_inc17_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_inc17_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_inc17_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_inc17_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_inc17_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_inc17_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_inc17_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_inc17_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_inc17_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_inc17_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_inc17_0_stall_in_NO_SHIFT_REG = rnode_160to161_inc17_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_inc17_0_NO_SHIFT_REG = rnode_160to161_inc17_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_inc17_1_NO_SHIFT_REG = rnode_160to161_inc17_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe2_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_1_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_stall_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_c0_exe2_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_c0_exe2_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe2_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_c0_exe2_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_c0_exe2_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_c0_exe2_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_c0_exe2_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_c0_exe2_0_reg_161_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_160to161_c0_exe2_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_c0_exe2_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe2_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe2_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe2_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe2_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe2_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe2_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe2_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_c0_exe2_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe2_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe2_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe2_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe2_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe2_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe2_0_NO_SHIFT_REG = rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_c0_exe2_1_NO_SHIFT_REG = rnode_160to161_c0_exe2_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_var__u15_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_var__u15_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_var__u15_0_NO_SHIFT_REG;
 logic rnode_160to161_var__u15_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_var__u15_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u15_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u15_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_var__u15_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_var__u15_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_var__u15_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_var__u15_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_var__u15_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_var__u15_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_var__u15_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_var__u15_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_var__u15_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_var__u15_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_var__u15_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_var__u15_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_var__u15_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_var__u15_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_var__u15_0_stall_in_NO_SHIFT_REG = rnode_160to161_var__u15_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_var__u15_0_NO_SHIFT_REG = rnode_160to161_var__u15_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_var__u15_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_var__u15_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_var__u15_0_valid_out_NO_SHIFT_REG = rnode_160to161_var__u15_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe1_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe1_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe1_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe1_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe1_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe1_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe1_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe1_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe1_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe1_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe1_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe1_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe1_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_c0_exe1_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe1_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe1_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe1_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe1_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe1_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe1_0_NO_SHIFT_REG = rnode_160to161_c0_exe1_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe1_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe1_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe1_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe1_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe3_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe3_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe3_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe3_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe3_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe3_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe3_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe3_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe3_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe3_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe3_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_c0_exe3_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe3_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe3_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe3_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe3_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe3_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe3_0_NO_SHIFT_REG = rnode_160to161_c0_exe3_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe3_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe3_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe4_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe4_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_c0_exe4_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe4_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe4_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe4_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe4_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe4_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe4_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe4_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe4_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe4_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe4_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_c0_exe4_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe4_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe4_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe4_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe4_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe4_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe4_0_NO_SHIFT_REG = rnode_160to161_c0_exe4_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe4_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe4_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe4_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe4_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_c0_exe6_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_c0_exe6_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe6_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe6_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe6_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe6_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe6_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe6_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe6_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe6_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe6_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe6_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_c0_exe6_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe6_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe6_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe6_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe6_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe6_0_NO_SHIFT_REG = rnode_160to161_c0_exe6_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe6_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe6_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe6_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_c0_exe7_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_c0_exe7_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_c0_exe7_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_c0_exe7_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_c0_exe7_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_c0_exe7_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_c0_exe7_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_c0_exe7_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_c0_exe7_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_c0_exe7_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_c0_exe7_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_c0_exe7_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_c0_exe7_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_c0_exe7_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_c0_exe7_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_c0_exe7_0_stall_in_NO_SHIFT_REG = rnode_160to161_c0_exe7_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe7_0_NO_SHIFT_REG = rnode_160to161_c0_exe7_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_c0_exe7_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_c0_exe7_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_c0_exe7_0_valid_out_NO_SHIFT_REG = rnode_160to161_c0_exe7_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_right_lower_0_ph7_0_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_right_lower_0_ph7_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_right_lower_0_ph7_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_right_lower_0_ph7_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_right_lower_0_ph7_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_right_lower_0_ph7_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_right_lower_0_ph7_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_right_lower_0_ph7_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_right_lower_0_ph7_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_right_lower_0_ph7_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG = rnode_160to161_right_lower_0_ph7_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_right_lower_0_ph7_0_NO_SHIFT_REG = rnode_160to161_right_lower_0_ph7_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_right_lower_0_ph7_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG = rnode_160to161_right_lower_0_ph7_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_160to161_input_acl_hw_wg_id_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_acl_hw_wg_id_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_input_acl_hw_wg_id_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_input_acl_hw_wg_id_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_input_acl_hw_wg_id_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_input_acl_hw_wg_id_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_input_acl_hw_wg_id_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_input_acl_hw_wg_id_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo.DATA_WIDTH = 32;
defparam rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_input_acl_hw_wg_id_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_input_acl_hw_wg_id_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = rnode_160to161_input_acl_hw_wg_id_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_160to161_input_acl_hw_wg_id_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_input_acl_hw_wg_id_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_160to161_input_acl_hw_wg_id_0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb8_st__inputs_ready;
 reg local_bb8_st__valid_out_NO_SHIFT_REG;
wire local_bb8_st__stall_in;
wire local_bb8_st__output_regs_ready;
wire local_bb8_st__fu_stall_out;
wire local_bb8_st__fu_valid_out;
wire local_bb8_st__causedstall;

lsu_top lsu_local_bb8_st_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb8_st__fu_stall_out),
	.i_valid(local_bb8_st__inputs_ready),
	.i_address(local_bb8_arrayidx35),
	.i_writedata(local_lvm_ld__NO_SHIFT_REG),
	.i_cmpdata(),
	.i_predicate(local_lvm_var__NO_SHIFT_REG),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb8_st__output_regs_ready)),
	.o_valid(local_bb8_st__fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb8_st__active),
	.avm_address(avm_local_bb8_st__address),
	.avm_read(avm_local_bb8_st__read),
	.avm_readdata(avm_local_bb8_st__readdata),
	.avm_write(avm_local_bb8_st__write),
	.avm_writeack(avm_local_bb8_st__writeack),
	.avm_burstcount(avm_local_bb8_st__burstcount),
	.avm_writedata(avm_local_bb8_st__writedata),
	.avm_byteenable(avm_local_bb8_st__byteenable),
	.avm_waitrequest(avm_local_bb8_st__waitrequest),
	.avm_readdatavalid(avm_local_bb8_st__readdatavalid),
	.profile_bw(),
	.profile_bw_incr(),
	.profile_total_ivalid(),
	.profile_total_req(),
	.profile_i_stall_count(),
	.profile_o_stall_count(),
	.profile_avm_readwrite_count(),
	.profile_avm_burstcount_total(),
	.profile_avm_burstcount_total_incr(),
	.profile_req_cache_hit_count(),
	.profile_extra_unaligned_reqs(),
	.profile_avm_stall()
);

defparam lsu_local_bb8_st_.AWIDTH = 30;
defparam lsu_local_bb8_st_.WIDTH_BYTES = 4;
defparam lsu_local_bb8_st_.MWIDTH_BYTES = 32;
defparam lsu_local_bb8_st_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb8_st_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb8_st_.READ = 0;
defparam lsu_local_bb8_st_.ATOMIC = 0;
defparam lsu_local_bb8_st_.WIDTH = 32;
defparam lsu_local_bb8_st_.MWIDTH = 256;
defparam lsu_local_bb8_st_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb8_st_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb8_st_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb8_st_.MEMORY_SIDE_MEM_LATENCY = 12;
defparam lsu_local_bb8_st_.USE_WRITE_ACK = 1;
defparam lsu_local_bb8_st_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb8_st_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb8_st_.NUMBER_BANKS = 1;
defparam lsu_local_bb8_st_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb8_st_.USEINPUTFIFO = 0;
defparam lsu_local_bb8_st_.USECACHING = 0;
defparam lsu_local_bb8_st_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb8_st_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb8_st_.HIGH_FMAX = 1;
defparam lsu_local_bb8_st_.ADDRSPACE = 1;
defparam lsu_local_bb8_st_.STYLE = "BURST-COALESCED";
defparam lsu_local_bb8_st_.USE_BYTE_EN = 0;

assign local_bb8_st__inputs_ready = (merge_node_valid_out_1_NO_SHIFT_REG & local_bb8_arrayidx35_valid_out);
assign local_bb8_st__output_regs_ready = (&(~(local_bb8_st__valid_out_NO_SHIFT_REG) | ~(local_bb8_st__stall_in)));
assign merge_node_stall_in_1 = (local_bb8_st__fu_stall_out | ~(local_bb8_st__inputs_ready));
assign local_bb8_arrayidx35_stall_in = (local_bb8_st__fu_stall_out | ~(local_bb8_st__inputs_ready));
assign local_bb8_st__causedstall = (local_bb8_st__inputs_ready && (local_bb8_st__fu_stall_out && !(~(local_bb8_st__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb8_st__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb8_st__output_regs_ready)
		begin
			local_bb8_st__valid_out_NO_SHIFT_REG <= local_bb8_st__fu_valid_out;
		end
		else
		begin
			if (~(local_bb8_st__stall_in))
			begin
				local_bb8_st__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb8_indvars_iv_next22_valid_out;
wire local_bb8_indvars_iv_next22_stall_in;
wire local_bb8_indvars_iv_next22_inputs_ready;
wire local_bb8_indvars_iv_next22_stall_local;
wire [63:0] local_bb8_indvars_iv_next22;

assign local_bb8_indvars_iv_next22_inputs_ready = rnode_160to161_indvars_iv21_0_valid_out_NO_SHIFT_REG;
assign local_bb8_indvars_iv_next22 = (rnode_160to161_indvars_iv21_0_NO_SHIFT_REG + 64'h1);
assign local_bb8_indvars_iv_next22_valid_out = local_bb8_indvars_iv_next22_inputs_ready;
assign local_bb8_indvars_iv_next22_stall_local = local_bb8_indvars_iv_next22_stall_in;
assign rnode_160to161_indvars_iv21_0_stall_in_NO_SHIFT_REG = (|local_bb8_indvars_iv_next22_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb8_var__valid_out;
wire local_bb8_var__stall_in;
wire local_bb8_var__inputs_ready;
wire local_bb8_var__stall_local;
wire [63:0] local_bb8_var_;

assign local_bb8_var__inputs_ready = rnode_160to161_inc17_0_valid_out_0_NO_SHIFT_REG;
assign local_bb8_var_[32] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[33] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[34] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[35] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[36] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[37] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[38] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[39] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[40] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[41] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[42] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[43] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[44] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[45] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[46] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[47] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[48] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[49] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[50] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[51] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[52] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[53] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[54] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[55] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[56] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[57] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[58] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[59] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[60] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[61] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[62] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[63] = rnode_160to161_inc17_0_NO_SHIFT_REG[31];
assign local_bb8_var_[31:0] = rnode_160to161_inc17_0_NO_SHIFT_REG;
assign local_bb8_var__valid_out = local_bb8_var__inputs_ready;
assign local_bb8_var__stall_local = local_bb8_var__stall_in;
assign rnode_160to161_inc17_0_stall_in_0_NO_SHIFT_REG = (|local_bb8_var__stall_local);

// This section implements an unregistered operation.
// 
wire local_bb8_var__u16_valid_out;
wire local_bb8_var__u16_stall_in;
wire local_bb8_var__u16_inputs_ready;
wire local_bb8_var__u16_stall_local;
wire local_bb8_var__u16;

assign local_bb8_var__u16_inputs_ready = (rnode_160to161_c0_exe2_0_valid_out_0_NO_SHIFT_REG & rnode_160to161_var__u15_0_valid_out_NO_SHIFT_REG);
assign local_bb8_var__u16 = (rnode_160to161_c0_exe2_0_NO_SHIFT_REG & rnode_160to161_var__u15_0_NO_SHIFT_REG);
assign local_bb8_var__u16_valid_out = local_bb8_var__u16_inputs_ready;
assign local_bb8_var__u16_stall_local = local_bb8_var__u16_stall_in;
assign rnode_160to161_c0_exe2_0_stall_in_0_NO_SHIFT_REG = (local_bb8_var__u16_stall_local | ~(local_bb8_var__u16_inputs_ready));
assign rnode_160to161_var__u15_0_stall_in_NO_SHIFT_REG = (local_bb8_var__u16_stall_local | ~(local_bb8_var__u16_inputs_ready));

// This section implements a staging register.
// 
wire rstag_161to161_bb8_st__valid_out;
wire rstag_161to161_bb8_st__stall_in;
wire rstag_161to161_bb8_st__inputs_ready;
wire rstag_161to161_bb8_st__stall_local;
 reg rstag_161to161_bb8_st__staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb8_st__combined_valid;

assign rstag_161to161_bb8_st__inputs_ready = local_bb8_st__valid_out_NO_SHIFT_REG;
assign rstag_161to161_bb8_st__combined_valid = (rstag_161to161_bb8_st__staging_valid_NO_SHIFT_REG | rstag_161to161_bb8_st__inputs_ready);
assign rstag_161to161_bb8_st__valid_out = rstag_161to161_bb8_st__combined_valid;
assign rstag_161to161_bb8_st__stall_local = rstag_161to161_bb8_st__stall_in;
assign local_bb8_st__stall_in = (|rstag_161to161_bb8_st__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb8_st__staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_161to161_bb8_st__stall_local)
		begin
			if (~(rstag_161to161_bb8_st__staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb8_st__staging_valid_NO_SHIFT_REG <= rstag_161to161_bb8_st__inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb8_st__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_c0_exe1_0_reg_NO_SHIFT_REG;
 reg lvb_c0_exe2_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe3_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_c0_exe4_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_c0_exe6_0_reg_NO_SHIFT_REG;
 reg lvb_c0_exe7_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_inc17_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb8_indvars_iv_next22_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb8_var__0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb8_var__u16_valid_out & local_bb8_var__valid_out & local_bb8_indvars_iv_next22_valid_out & rnode_160to161_inc17_0_valid_out_1_NO_SHIFT_REG & rnode_160to161_c0_exe2_0_valid_out_1_NO_SHIFT_REG & rnode_160to161_c0_exe1_0_valid_out_NO_SHIFT_REG & rnode_160to161_c0_exe3_0_valid_out_NO_SHIFT_REG & rnode_160to161_c0_exe4_0_valid_out_NO_SHIFT_REG & rnode_160to161_c0_exe6_0_valid_out_NO_SHIFT_REG & rnode_160to161_c0_exe7_0_valid_out_NO_SHIFT_REG & rnode_160to161_right_lower_0_ph7_0_valid_out_NO_SHIFT_REG & rnode_160to161_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rstag_161to161_bb8_st__valid_out);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb8_var__u16_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb8_var__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb8_indvars_iv_next22_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_inc17_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe2_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe1_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe3_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe4_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_c0_exe7_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_right_lower_0_ph7_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_160to161_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_161to161_bb8_st__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_c0_exe1_0 = lvb_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe1_1 = lvb_c0_exe1_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe2_0 = lvb_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe2_1 = lvb_c0_exe2_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe3_0 = lvb_c0_exe3_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe3_1 = lvb_c0_exe3_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe4_0 = lvb_c0_exe4_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe4_1 = lvb_c0_exe4_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe6_0 = lvb_c0_exe6_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe6_1 = lvb_c0_exe6_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe7_0 = lvb_c0_exe7_0_reg_NO_SHIFT_REG;
assign lvb_c0_exe7_1 = lvb_c0_exe7_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph7_0 = lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph7_1 = lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG;
assign lvb_inc17_0 = lvb_inc17_0_reg_NO_SHIFT_REG;
assign lvb_inc17_1 = lvb_inc17_0_reg_NO_SHIFT_REG;
assign lvb_bb8_indvars_iv_next22_0 = lvb_bb8_indvars_iv_next22_0_reg_NO_SHIFT_REG;
assign lvb_bb8_indvars_iv_next22_1 = lvb_bb8_indvars_iv_next22_0_reg_NO_SHIFT_REG;
assign lvb_bb8_var__0 = lvb_bb8_var__0_reg_NO_SHIFT_REG;
assign lvb_bb8_var__1 = lvb_bb8_var__0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_0 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id_1 = lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;
assign valid_out_0 = (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG);
assign valid_out_1 = ((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG);
assign combined_branch_stall_in_signal = ((((branch_compare_result_NO_SHIFT_REG != 1'b1) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_1) | ((~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & branch_node_valid_out_0_NO_SHIFT_REG) & stall_in_0));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		lvb_c0_exe1_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe2_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe3_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe4_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_inc17_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb8_indvars_iv_next22_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb8_var__0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_c0_exe1_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe1_0_NO_SHIFT_REG;
			lvb_c0_exe2_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe2_1_NO_SHIFT_REG;
			lvb_c0_exe3_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe3_0_NO_SHIFT_REG;
			lvb_c0_exe4_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe4_0_NO_SHIFT_REG;
			lvb_c0_exe6_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe6_0_NO_SHIFT_REG;
			lvb_c0_exe7_0_reg_NO_SHIFT_REG <= rnode_160to161_c0_exe7_0_NO_SHIFT_REG;
			lvb_right_lower_0_ph7_0_reg_NO_SHIFT_REG <= rnode_160to161_right_lower_0_ph7_0_NO_SHIFT_REG;
			lvb_inc17_0_reg_NO_SHIFT_REG <= rnode_160to161_inc17_1_NO_SHIFT_REG;
			lvb_bb8_indvars_iv_next22_0_reg_NO_SHIFT_REG <= local_bb8_indvars_iv_next22;
			lvb_bb8_var__0_reg_NO_SHIFT_REG <= local_bb8_var_;
			lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= rnode_160to161_input_acl_hw_wg_id_0_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= local_bb8_var__u16;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_basic_block_9
	(
		input 		clock,
		input 		resetn,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_c0_exe1,
		input [31:0] 		input_c0_exe3,
		input [63:0] 		input_c0_exe6,
		input 		input_c0_exe7,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out,
		input 		stall_in,
		output [31:0] 		lvb_c0_exe3,
		output [63:0] 		lvb_c0_exe6,
		output 		lvb_c0_exe7,
		output 		lvb_bb9_cmp424,
		output 		lvb_bb9_cmp_phi_decision80_xor_or,
		output [31:0] 		lvb_input_acl_hw_wg_id,
		input [31:0] 		workgroup_size,
		input 		start
	);


// Values used for debugging.  These are swept away by synthesis.
wire _entry;
wire _exit;
 reg [31:0] _num_entry_NO_SHIFT_REG;
 reg [31:0] _num_exit_NO_SHIFT_REG;
wire [31:0] _num_live;

assign _entry = ((&valid_in) & ~((|stall_out)));
assign _exit = ((&valid_out) & ~((|stall_in)));
assign _num_live = (_num_entry_NO_SHIFT_REG - _num_exit_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		_num_entry_NO_SHIFT_REG <= 32'h0;
		_num_exit_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		if (_entry)
		begin
			_num_entry_NO_SHIFT_REG <= (_num_entry_NO_SHIFT_REG + 2'h1);
		end
		if (_exit)
		begin
			_num_exit_NO_SHIFT_REG <= (_num_exit_NO_SHIFT_REG + 2'h1);
		end
	end
end



// This section defines the behaviour of the MERGE node
wire merge_node_stall_in_0;
 reg merge_node_valid_out_0_NO_SHIFT_REG;
wire merge_node_stall_in_1;
 reg merge_node_valid_out_1_NO_SHIFT_REG;
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_node_stall_in_3;
 reg merge_node_valid_out_3_NO_SHIFT_REG;
wire merge_node_stall_in_4;
 reg merge_node_valid_out_4_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_c0_exe3_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_c0_exe6_staging_reg_NO_SHIFT_REG;
 reg input_c0_exe7_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe1_NO_SHIFT_REG;
 reg [31:0] local_lvm_c0_exe3_NO_SHIFT_REG;
 reg [63:0] local_lvm_c0_exe6_NO_SHIFT_REG;
 reg local_lvm_c0_exe7_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG));
assign stall_out = merge_node_valid_in_staging_reg_NO_SHIFT_REG;

always @(*)
begin
	if ((merge_node_valid_in_staging_reg_NO_SHIFT_REG | valid_in))
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b1;
	end
	else
	begin
		merge_block_selector_NO_SHIFT_REG = 1'b0;
		is_merge_data_to_local_regs_valid_NO_SHIFT_REG = 1'b0;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		input_c0_exe1_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe3_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe6_staging_reg_NO_SHIFT_REG <= 'x;
		input_c0_exe7_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_c0_exe1_staging_reg_NO_SHIFT_REG <= input_c0_exe1;
				input_c0_exe3_staging_reg_NO_SHIFT_REG <= input_c0_exe3;
				input_c0_exe6_staging_reg_NO_SHIFT_REG <= input_c0_exe6;
				input_c0_exe7_staging_reg_NO_SHIFT_REG <= input_c0_exe7;
				input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= input_acl_hw_wg_id;
				merge_node_valid_in_staging_reg_NO_SHIFT_REG <= valid_in;
			end
		end
		else
		begin
			merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
		end
	end
end

always @(posedge clock)
begin
	if (~(merge_stalled_by_successors))
	begin
		case (merge_block_selector_NO_SHIFT_REG)
			1'b0:
			begin
				if (merge_node_valid_in_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6_staging_reg_NO_SHIFT_REG;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_c0_exe1_NO_SHIFT_REG <= input_c0_exe1;
					local_lvm_c0_exe3_NO_SHIFT_REG <= input_c0_exe3;
					local_lvm_c0_exe6_NO_SHIFT_REG <= input_c0_exe6;
					local_lvm_c0_exe7_NO_SHIFT_REG <= input_c0_exe7;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id;
				end
			end

			default:
			begin
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_3_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_4_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
		end
		else
		begin
			if (~(merge_node_stall_in_0))
			begin
				merge_node_valid_out_0_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_1))
			begin
				merge_node_valid_out_1_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_2))
			begin
				merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_3))
			begin
				merge_node_valid_out_3_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_4))
			begin
				merge_node_valid_out_4_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		invariant_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		invariant_valid_NO_SHIFT_REG <= (~(start) & (invariant_valid_NO_SHIFT_REG | is_merge_data_to_local_regs_valid_NO_SHIFT_REG));
	end
end


// This section implements an unregistered operation.
// 
wire local_bb9_cmp424_valid_out;
wire local_bb9_cmp424_stall_in;
wire local_bb9_cmp424_inputs_ready;
wire local_bb9_cmp424_stall_local;
wire local_bb9_cmp424;

assign local_bb9_cmp424_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb9_cmp424 = ($signed(local_lvm_c0_exe1_NO_SHIFT_REG) > $signed(local_lvm_c0_exe3_NO_SHIFT_REG));
assign local_bb9_cmp424_valid_out = local_bb9_cmp424_inputs_ready;
assign local_bb9_cmp424_stall_local = local_bb9_cmp424_stall_in;
assign merge_node_stall_in_0 = (|local_bb9_cmp424_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_c0_exe7_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_1_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_c0_exe7_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_c0_exe7_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_c0_exe7_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_c0_exe7_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_c0_exe7_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_c0_exe7_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_c0_exe7_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_c0_exe7_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_c0_exe7_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_c0_exe7_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_c0_exe7_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_c0_exe7_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_c0_exe7_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_c0_exe7_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe7_NO_SHIFT_REG),
	.data_out(rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_c0_exe7_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_c0_exe7_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_c0_exe7_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_c0_exe7_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_c0_exe7_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign merge_node_stall_in_1 = rnode_1to2_c0_exe7_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_c0_exe7_0_NO_SHIFT_REG = rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_c0_exe7_1_NO_SHIFT_REG = rnode_1to2_c0_exe7_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_c0_exe3_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe3_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_c0_exe3_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe3_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_c0_exe3_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe3_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe3_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe3_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_c0_exe3_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_c0_exe3_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_c0_exe3_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_c0_exe3_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_c0_exe3_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe3_NO_SHIFT_REG),
	.data_out(rnode_1to2_c0_exe3_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_c0_exe3_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_c0_exe3_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_c0_exe3_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_c0_exe3_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_c0_exe3_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to2_c0_exe3_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_c0_exe3_0_NO_SHIFT_REG = rnode_1to2_c0_exe3_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_c0_exe3_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_c0_exe3_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_c0_exe3_0_valid_out_NO_SHIFT_REG = rnode_1to2_c0_exe3_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_c0_exe6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_c0_exe6_0_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe6_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_c0_exe6_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe6_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe6_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_c0_exe6_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_c0_exe6_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_c0_exe6_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_c0_exe6_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_c0_exe6_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_c0_exe6_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_c0_exe6_NO_SHIFT_REG),
	.data_out(rnode_1to2_c0_exe6_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_c0_exe6_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_c0_exe6_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_c0_exe6_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_c0_exe6_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_c0_exe6_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to2_c0_exe6_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_c0_exe6_0_NO_SHIFT_REG = rnode_1to2_c0_exe6_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_c0_exe6_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_c0_exe6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_c0_exe6_0_valid_out_NO_SHIFT_REG = rnode_1to2_c0_exe6_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to2_input_acl_hw_wg_id_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_input_acl_hw_wg_id_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_acl_hw_wg_id_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_acl_hw_wg_id_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_input_acl_hw_wg_id_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_input_acl_hw_wg_id_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_input_acl_hw_wg_id_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_input_acl_hw_wg_id_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_input_acl_hw_wg_id_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_input_acl_hw_wg_id_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to2_input_acl_hw_wg_id_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_input_acl_hw_wg_id_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_input_acl_hw_wg_id_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_input_acl_hw_wg_id_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_input_acl_hw_wg_id_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_input_acl_hw_wg_id_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to2_input_acl_hw_wg_id_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to2_input_acl_hw_wg_id_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_input_acl_hw_wg_id_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to2_input_acl_hw_wg_id_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb9_cmp424_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_1_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp424_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_bb9_cmp424_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_bb9_cmp424_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_bb9_cmp424_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb9_cmp424_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_bb9_cmp424_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_bb9_cmp424_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_bb9_cmp424_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_bb9_cmp424_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_bb9_cmp424_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_bb9_cmp424_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_bb9_cmp424_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_bb9_cmp424_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb9_cmp424_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb9_cmp424_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb9_cmp424_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb9_cmp424_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb9_cmp424),
	.data_out(rnode_1to2_bb9_cmp424_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb9_cmp424_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb9_cmp424_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb9_cmp424_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb9_cmp424_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb9_cmp424_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb9_cmp424_valid_out;
assign local_bb9_cmp424_stall_in = rnode_1to2_bb9_cmp424_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb9_cmp424_0_NO_SHIFT_REG = rnode_1to2_bb9_cmp424_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_bb9_cmp424_1_NO_SHIFT_REG = rnode_1to2_bb9_cmp424_0_reg_2_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb9_cmp_phi_decision80_xor_or_valid_out;
wire local_bb9_cmp_phi_decision80_xor_or_stall_in;
wire local_bb9_cmp_phi_decision80_xor_or_inputs_ready;
wire local_bb9_cmp_phi_decision80_xor_or_stall_local;
wire local_bb9_cmp_phi_decision80_xor_or;

assign local_bb9_cmp_phi_decision80_xor_or_inputs_ready = (rnode_1to2_bb9_cmp424_0_valid_out_0_NO_SHIFT_REG & rnode_1to2_c0_exe7_0_valid_out_0_NO_SHIFT_REG);
assign local_bb9_cmp_phi_decision80_xor_or = (rnode_1to2_bb9_cmp424_0_NO_SHIFT_REG | rnode_1to2_c0_exe7_0_NO_SHIFT_REG);
assign local_bb9_cmp_phi_decision80_xor_or_valid_out = local_bb9_cmp_phi_decision80_xor_or_inputs_ready;
assign local_bb9_cmp_phi_decision80_xor_or_stall_local = local_bb9_cmp_phi_decision80_xor_or_stall_in;
assign rnode_1to2_bb9_cmp424_0_stall_in_0_NO_SHIFT_REG = (local_bb9_cmp_phi_decision80_xor_or_stall_local | ~(local_bb9_cmp_phi_decision80_xor_or_inputs_ready));
assign rnode_1to2_c0_exe7_0_stall_in_0_NO_SHIFT_REG = (local_bb9_cmp_phi_decision80_xor_or_stall_local | ~(local_bb9_cmp_phi_decision80_xor_or_inputs_ready));

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [31:0] lvb_c0_exe3_reg_NO_SHIFT_REG;
 reg [63:0] lvb_c0_exe6_reg_NO_SHIFT_REG;
 reg lvb_c0_exe7_reg_NO_SHIFT_REG;
 reg lvb_bb9_cmp424_reg_NO_SHIFT_REG;
 reg lvb_bb9_cmp_phi_decision80_xor_or_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb9_cmp_phi_decision80_xor_or_valid_out & rnode_1to2_c0_exe3_0_valid_out_NO_SHIFT_REG & rnode_1to2_c0_exe6_0_valid_out_NO_SHIFT_REG & rnode_1to2_c0_exe7_0_valid_out_1_NO_SHIFT_REG & rnode_1to2_bb9_cmp424_0_valid_out_1_NO_SHIFT_REG & rnode_1to2_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb9_cmp_phi_decision80_xor_or_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_c0_exe3_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_c0_exe6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_c0_exe7_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_bb9_cmp424_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_c0_exe3 = lvb_c0_exe3_reg_NO_SHIFT_REG;
assign lvb_c0_exe6 = lvb_c0_exe6_reg_NO_SHIFT_REG;
assign lvb_c0_exe7 = lvb_c0_exe7_reg_NO_SHIFT_REG;
assign lvb_bb9_cmp424 = lvb_bb9_cmp424_reg_NO_SHIFT_REG;
assign lvb_bb9_cmp_phi_decision80_xor_or = lvb_bb9_cmp_phi_decision80_xor_or_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_c0_exe3_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe6_reg_NO_SHIFT_REG <= 'x;
		lvb_c0_exe7_reg_NO_SHIFT_REG <= 'x;
		lvb_bb9_cmp424_reg_NO_SHIFT_REG <= 'x;
		lvb_bb9_cmp_phi_decision80_xor_or_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_c0_exe3_reg_NO_SHIFT_REG <= rnode_1to2_c0_exe3_0_NO_SHIFT_REG;
			lvb_c0_exe6_reg_NO_SHIFT_REG <= rnode_1to2_c0_exe6_0_NO_SHIFT_REG;
			lvb_c0_exe7_reg_NO_SHIFT_REG <= rnode_1to2_c0_exe7_1_NO_SHIFT_REG;
			lvb_bb9_cmp424_reg_NO_SHIFT_REG <= rnode_1to2_bb9_cmp424_1_NO_SHIFT_REG;
			lvb_bb9_cmp_phi_decision80_xor_or_reg_NO_SHIFT_REG <= local_bb9_cmp_phi_decision80_xor_or;
			lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= rnode_1to2_input_acl_hw_wg_id_0_NO_SHIFT_REG;
		end
		else
		begin
			if (~(combined_branch_stall_in_signal))
			begin
				branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_function
	(
		input 		clock,
		input 		resetn,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_acl_hw_wg_id,
		output 		stall_out,
		input 		valid_in,
		output [31:0] 		output_0,
		output 		valid_out,
		input 		stall_in,
		input [31:0] 		workgroup_size,
		input [255:0] 		avm_local_bb2_ld__readdata,
		input 		avm_local_bb2_ld__readdatavalid,
		input 		avm_local_bb2_ld__waitrequest,
		output [29:0] 		avm_local_bb2_ld__address,
		output 		avm_local_bb2_ld__read,
		output 		avm_local_bb2_ld__write,
		input 		avm_local_bb2_ld__writeack,
		output [255:0] 		avm_local_bb2_ld__writedata,
		output [31:0] 		avm_local_bb2_ld__byteenable,
		output [4:0] 		avm_local_bb2_ld__burstcount,
		input [255:0] 		avm_local_bb3_ld__pre_pre_readdata,
		input 		avm_local_bb3_ld__pre_pre_readdatavalid,
		input 		avm_local_bb3_ld__pre_pre_waitrequest,
		output [29:0] 		avm_local_bb3_ld__pre_pre_address,
		output 		avm_local_bb3_ld__pre_pre_read,
		output 		avm_local_bb3_ld__pre_pre_write,
		input 		avm_local_bb3_ld__pre_pre_writeack,
		output [255:0] 		avm_local_bb3_ld__pre_pre_writedata,
		output [31:0] 		avm_local_bb3_ld__pre_pre_byteenable,
		output [4:0] 		avm_local_bb3_ld__pre_pre_burstcount,
		input [255:0] 		avm_local_bb5_st__pre_pre_readdata,
		input 		avm_local_bb5_st__pre_pre_readdatavalid,
		input 		avm_local_bb5_st__pre_pre_waitrequest,
		output [29:0] 		avm_local_bb5_st__pre_pre_address,
		output 		avm_local_bb5_st__pre_pre_read,
		output 		avm_local_bb5_st__pre_pre_write,
		input 		avm_local_bb5_st__pre_pre_writeack,
		output [255:0] 		avm_local_bb5_st__pre_pre_writedata,
		output [31:0] 		avm_local_bb5_st__pre_pre_byteenable,
		output [4:0] 		avm_local_bb5_st__pre_pre_burstcount,
		input [255:0] 		avm_local_bb6_ld__readdata,
		input 		avm_local_bb6_ld__readdatavalid,
		input 		avm_local_bb6_ld__waitrequest,
		output [29:0] 		avm_local_bb6_ld__address,
		output 		avm_local_bb6_ld__read,
		output 		avm_local_bb6_ld__write,
		input 		avm_local_bb6_ld__writeack,
		output [255:0] 		avm_local_bb6_ld__writedata,
		output [31:0] 		avm_local_bb6_ld__byteenable,
		output [4:0] 		avm_local_bb6_ld__burstcount,
		input [255:0] 		avm_local_bb6_st__readdata,
		input 		avm_local_bb6_st__readdatavalid,
		input 		avm_local_bb6_st__waitrequest,
		output [29:0] 		avm_local_bb6_st__address,
		output 		avm_local_bb6_st__read,
		output 		avm_local_bb6_st__write,
		input 		avm_local_bb6_st__writeack,
		output [255:0] 		avm_local_bb6_st__writedata,
		output [31:0] 		avm_local_bb6_st__byteenable,
		output [4:0] 		avm_local_bb6_st__burstcount,
		input [255:0] 		avm_local_bb8_st__readdata,
		input 		avm_local_bb8_st__readdatavalid,
		input 		avm_local_bb8_st__waitrequest,
		output [29:0] 		avm_local_bb8_st__address,
		output 		avm_local_bb8_st__read,
		output 		avm_local_bb8_st__write,
		input 		avm_local_bb8_st__writeack,
		output [255:0] 		avm_local_bb8_st__writedata,
		output [31:0] 		avm_local_bb8_st__byteenable,
		output [4:0] 		avm_local_bb8_st__burstcount,
		input 		start,
		input [31:0] 		input_subarr_size,
		input [31:0] 		input_num_of_elements,
		input 		clock2x,
		input [63:0] 		input_data,
		input [63:0] 		input_temp,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire [31:0] bb_0_lvb_bb0_add;
wire [31:0] bb_0_lvb_input_global_id_0;
wire [31:0] bb_0_lvb_input_acl_hw_wg_id;
wire bb_1_stall_out;
wire bb_1_valid_out;
wire [31:0] bb_1_lvb_bb1_c0_exe1;
wire bb_1_lvb_bb1_c0_exe2;
wire [31:0] bb_1_lvb_bb1_c0_exe3;
wire [31:0] bb_1_lvb_bb1_c0_exe4;
wire [31:0] bb_1_lvb_bb1_c0_exe5;
wire [63:0] bb_1_lvb_bb1_c0_exe6;
wire bb_1_lvb_bb1_c0_exe7;
wire [31:0] bb_1_lvb_input_acl_hw_wg_id;
wire bb_2_stall_out_0;
wire bb_2_stall_out_1;
wire bb_2_valid_out;
wire [31:0] bb_2_lvb_c0_exe1;
wire bb_2_lvb_c0_exe2;
wire [31:0] bb_2_lvb_c0_exe3;
wire [31:0] bb_2_lvb_c0_exe4;
wire [63:0] bb_2_lvb_c0_exe6;
wire bb_2_lvb_c0_exe7;
wire [63:0] bb_2_lvb_indvars_iv21;
wire [31:0] bb_2_lvb_right_lower_0_ph;
wire [31:0] bb_2_lvb_temp_index_0_ph;
wire [63:0] bb_2_lvb_var_;
wire [63:0] bb_2_lvb_bb2_var_;
wire bb_2_lvb_bb2_cmp4;
wire bb_2_lvb_bb2_var__u1;
wire [31:0] bb_2_lvb_bb2_ld_;
wire [31:0] bb_2_lvb_input_acl_hw_wg_id;
wire bb_2_local_bb2_ld__active;
wire bb_3_stall_out_0;
wire bb_3_stall_out_1;
wire bb_3_valid_out;
wire [31:0] bb_3_lvb_c0_exe1;
wire bb_3_lvb_c0_exe2;
wire [31:0] bb_3_lvb_c0_exe3;
wire [31:0] bb_3_lvb_c0_exe4;
wire [63:0] bb_3_lvb_c0_exe6;
wire bb_3_lvb_c0_exe7;
wire [63:0] bb_3_lvb_indvars_iv21;
wire bb_3_lvb_cmp4;
wire bb_3_lvb_var_;
wire [31:0] bb_3_lvb_ld_;
wire [63:0] bb_3_lvb_indvars_iv19;
wire [63:0] bb_3_lvb_indvars_iv17;
wire [31:0] bb_3_lvb_right_lower_0_ph7;
wire [31:0] bb_3_lvb_temp_index_0_ph8;
wire bb_3_lvb_bb3_or_cond;
wire bb_3_lvb_bb3_var_;
wire [31:0] bb_3_lvb_bb3_ld__pre_pre;
wire bb_3_lvb_bb3_var__u3;
wire bb_3_lvb_bb3_var__u4;
wire bb_3_lvb_bb3_var__u5;
wire [31:0] bb_3_lvb_input_acl_hw_wg_id;
wire bb_3_local_bb3_ld__pre_pre_active;
wire bb_4_stall_out_0;
wire bb_4_stall_out_1;
wire bb_4_valid_out_0;
wire [31:0] bb_4_lvb_c0_exe1_0;
wire bb_4_lvb_c0_exe2_0;
wire [31:0] bb_4_lvb_c0_exe3_0;
wire [31:0] bb_4_lvb_c0_exe4_0;
wire [63:0] bb_4_lvb_c0_exe6_0;
wire bb_4_lvb_c0_exe7_0;
wire [63:0] bb_4_lvb_indvars_iv21_0;
wire bb_4_lvb_cmp4_0;
wire bb_4_lvb_var__0;
wire [31:0] bb_4_lvb_ld__0;
wire [63:0] bb_4_lvb_indvars_iv19_0;
wire [63:0] bb_4_lvb_indvars_iv17_0;
wire [31:0] bb_4_lvb_right_lower_0_ph7_0;
wire [31:0] bb_4_lvb_temp_index_0_ph8_0;
wire bb_4_lvb_or_cond_0;
wire bb_4_lvb_var__u7_0;
wire [31:0] bb_4_lvb_ld__pre_pre_0;
wire bb_4_lvb_var__u8_0;
wire bb_4_lvb_var__u9_0;
wire bb_4_lvb_var__u10_0;
wire [31:0] bb_4_lvb_input_acl_hw_wg_id_0;
wire bb_4_valid_out_1;
wire [31:0] bb_4_lvb_c0_exe1_1;
wire bb_4_lvb_c0_exe2_1;
wire [31:0] bb_4_lvb_c0_exe3_1;
wire [31:0] bb_4_lvb_c0_exe4_1;
wire [63:0] bb_4_lvb_c0_exe6_1;
wire bb_4_lvb_c0_exe7_1;
wire [63:0] bb_4_lvb_indvars_iv21_1;
wire bb_4_lvb_cmp4_1;
wire bb_4_lvb_var__1;
wire [31:0] bb_4_lvb_ld__1;
wire [63:0] bb_4_lvb_indvars_iv19_1;
wire [63:0] bb_4_lvb_indvars_iv17_1;
wire [31:0] bb_4_lvb_right_lower_0_ph7_1;
wire [31:0] bb_4_lvb_temp_index_0_ph8_1;
wire bb_4_lvb_or_cond_1;
wire bb_4_lvb_var__u7_1;
wire [31:0] bb_4_lvb_ld__pre_pre_1;
wire bb_4_lvb_var__u8_1;
wire bb_4_lvb_var__u9_1;
wire bb_4_lvb_var__u10_1;
wire [31:0] bb_4_lvb_input_acl_hw_wg_id_1;
wire bb_5_stall_out;
wire bb_5_valid_out_0;
wire [31:0] bb_5_lvb_c0_exe1_0;
wire bb_5_lvb_c0_exe2_0;
wire [31:0] bb_5_lvb_c0_exe3_0;
wire [31:0] bb_5_lvb_c0_exe4_0;
wire [63:0] bb_5_lvb_c0_exe6_0;
wire bb_5_lvb_c0_exe7_0;
wire [63:0] bb_5_lvb_indvars_iv21_0;
wire bb_5_lvb_cmp4_0;
wire bb_5_lvb_var__0;
wire [31:0] bb_5_lvb_ld__0;
wire [31:0] bb_5_lvb_right_lower_0_ph7_0;
wire [31:0] bb_5_lvb_temp_index_0_ph8_0;
wire bb_5_lvb_var__u12_0;
wire bb_5_lvb_var__u13_0;
wire [63:0] bb_5_lvb_bb5_indvars_iv_next18_0;
wire [31:0] bb_5_lvb_bb5_inc_0;
wire [63:0] bb_5_lvb_bb5_indvars_iv_next20_0;
wire [31:0] bb_5_lvb_bb5_inc17_0;
wire [31:0] bb_5_lvb_input_acl_hw_wg_id_0;
wire bb_5_valid_out_1;
wire [31:0] bb_5_lvb_c0_exe1_1;
wire bb_5_lvb_c0_exe2_1;
wire [31:0] bb_5_lvb_c0_exe3_1;
wire [31:0] bb_5_lvb_c0_exe4_1;
wire [63:0] bb_5_lvb_c0_exe6_1;
wire bb_5_lvb_c0_exe7_1;
wire [63:0] bb_5_lvb_indvars_iv21_1;
wire bb_5_lvb_cmp4_1;
wire bb_5_lvb_var__1;
wire [31:0] bb_5_lvb_ld__1;
wire [31:0] bb_5_lvb_right_lower_0_ph7_1;
wire [31:0] bb_5_lvb_temp_index_0_ph8_1;
wire bb_5_lvb_var__u12_1;
wire bb_5_lvb_var__u13_1;
wire [63:0] bb_5_lvb_bb5_indvars_iv_next18_1;
wire [31:0] bb_5_lvb_bb5_inc_1;
wire [63:0] bb_5_lvb_bb5_indvars_iv_next20_1;
wire [31:0] bb_5_lvb_bb5_inc17_1;
wire [31:0] bb_5_lvb_input_acl_hw_wg_id_1;
wire bb_5_local_bb5_st__pre_pre_active;
wire bb_6_stall_out_0;
wire bb_6_stall_out_1;
wire bb_6_valid_out_0;
wire [31:0] bb_6_lvb_c0_exe3_0;
wire bb_6_lvb_c0_exe7_0;
wire [63:0] bb_6_lvb_bb6_indvars_iv_next_0;
wire bb_6_lvb_cmp424_0;
wire bb_6_lvb_cmp_phi_decision80_xor_or_0;
wire [31:0] bb_6_lvb_input_acl_hw_wg_id_0;
wire bb_6_valid_out_1;
wire [31:0] bb_6_lvb_c0_exe3_1;
wire bb_6_lvb_c0_exe7_1;
wire [63:0] bb_6_lvb_bb6_indvars_iv_next_1;
wire bb_6_lvb_cmp424_1;
wire bb_6_lvb_cmp_phi_decision80_xor_or_1;
wire [31:0] bb_6_lvb_input_acl_hw_wg_id_1;
wire bb_6_local_bb6_ld__active;
wire bb_6_local_bb6_st__active;
wire bb_7_stall_out;
wire bb_7_valid_out;
wire [31:0] bb_7_lvb_input_acl_hw_wg_id;
wire bb_8_stall_out;
wire bb_8_valid_out_0;
wire [31:0] bb_8_lvb_c0_exe1_0;
wire bb_8_lvb_c0_exe2_0;
wire [31:0] bb_8_lvb_c0_exe3_0;
wire [31:0] bb_8_lvb_c0_exe4_0;
wire [63:0] bb_8_lvb_c0_exe6_0;
wire bb_8_lvb_c0_exe7_0;
wire [31:0] bb_8_lvb_right_lower_0_ph7_0;
wire [31:0] bb_8_lvb_inc17_0;
wire [63:0] bb_8_lvb_bb8_indvars_iv_next22_0;
wire [63:0] bb_8_lvb_bb8_var__0;
wire [31:0] bb_8_lvb_input_acl_hw_wg_id_0;
wire bb_8_valid_out_1;
wire [31:0] bb_8_lvb_c0_exe1_1;
wire bb_8_lvb_c0_exe2_1;
wire [31:0] bb_8_lvb_c0_exe3_1;
wire [31:0] bb_8_lvb_c0_exe4_1;
wire [63:0] bb_8_lvb_c0_exe6_1;
wire bb_8_lvb_c0_exe7_1;
wire [31:0] bb_8_lvb_right_lower_0_ph7_1;
wire [31:0] bb_8_lvb_inc17_1;
wire [63:0] bb_8_lvb_bb8_indvars_iv_next22_1;
wire [63:0] bb_8_lvb_bb8_var__1;
wire [31:0] bb_8_lvb_input_acl_hw_wg_id_1;
wire bb_8_local_bb8_st__active;
wire bb_9_stall_out;
wire bb_9_valid_out;
wire [31:0] bb_9_lvb_c0_exe3;
wire [63:0] bb_9_lvb_c0_exe6;
wire bb_9_lvb_c0_exe7;
wire bb_9_lvb_bb9_cmp424;
wire bb_9_lvb_bb9_cmp_phi_decision80_xor_or;
wire [31:0] bb_9_lvb_input_acl_hw_wg_id;
wire loop_limiter_0_stall_out;
wire loop_limiter_0_valid_out;
wire loop_limiter_1_stall_out;
wire loop_limiter_1_valid_out;
wire loop_limiter_2_stall_out;
wire loop_limiter_2_valid_out;
wire loop_limiter_3_stall_out;
wire loop_limiter_3_valid_out;
wire [2:0] writes_pending;
wire [5:0] lsus_active;

fpgasort_basic_block_0 fpgasort_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.input_subarr_size(input_subarr_size),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.input_global_id_0(input_global_id_0),
	.input_acl_hw_wg_id(input_acl_hw_wg_id),
	.valid_out(bb_0_valid_out),
	.stall_in(bb_1_stall_out),
	.lvb_bb0_add(bb_0_lvb_bb0_add),
	.lvb_input_global_id_0(bb_0_lvb_input_global_id_0),
	.lvb_input_acl_hw_wg_id(bb_0_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size)
);


fpgasort_basic_block_1 fpgasort_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_subarr_size(input_subarr_size),
	.input_num_of_elements(input_num_of_elements),
	.input_wii_add(bb_0_lvb_bb0_add),
	.valid_in(bb_0_valid_out),
	.stall_out(bb_1_stall_out),
	.input_global_id_0(bb_0_lvb_input_global_id_0),
	.input_acl_hw_wg_id(bb_0_lvb_input_acl_hw_wg_id),
	.valid_out(bb_1_valid_out),
	.stall_in(loop_limiter_0_stall_out),
	.lvb_bb1_c0_exe1(bb_1_lvb_bb1_c0_exe1),
	.lvb_bb1_c0_exe2(bb_1_lvb_bb1_c0_exe2),
	.lvb_bb1_c0_exe3(bb_1_lvb_bb1_c0_exe3),
	.lvb_bb1_c0_exe4(bb_1_lvb_bb1_c0_exe4),
	.lvb_bb1_c0_exe5(bb_1_lvb_bb1_c0_exe5),
	.lvb_bb1_c0_exe6(bb_1_lvb_bb1_c0_exe6),
	.lvb_bb1_c0_exe7(bb_1_lvb_bb1_c0_exe7),
	.lvb_input_acl_hw_wg_id(bb_1_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size),
	.start(start)
);


fpgasort_basic_block_2 fpgasort_basic_block_2 (
	.clock(clock),
	.resetn(resetn),
	.input_data(input_data),
	.valid_in_0(bb_8_valid_out_0),
	.stall_out_0(bb_2_stall_out_0),
	.input_c0_exe1_0(bb_8_lvb_c0_exe1_0),
	.input_c0_exe2_0(bb_8_lvb_c0_exe2_0),
	.input_c0_exe3_0(bb_8_lvb_c0_exe3_0),
	.input_c0_exe4_0(bb_8_lvb_c0_exe4_0),
	.input_c0_exe6_0(bb_8_lvb_c0_exe6_0),
	.input_c0_exe7_0(bb_8_lvb_c0_exe7_0),
	.input_indvars_iv21_0(bb_8_lvb_bb8_indvars_iv_next22_0),
	.input_right_lower_0_ph_0(bb_8_lvb_right_lower_0_ph7_0),
	.input_temp_index_0_ph_0(bb_8_lvb_inc17_0),
	.input_var__0(bb_8_lvb_bb8_var__0),
	.input_acl_hw_wg_id_0(bb_8_lvb_input_acl_hw_wg_id_0),
	.valid_in_1(loop_limiter_0_valid_out),
	.stall_out_1(bb_2_stall_out_1),
	.input_c0_exe1_1(bb_1_lvb_bb1_c0_exe1),
	.input_c0_exe2_1(bb_1_lvb_bb1_c0_exe2),
	.input_c0_exe3_1(bb_1_lvb_bb1_c0_exe3),
	.input_c0_exe4_1(bb_1_lvb_bb1_c0_exe4),
	.input_c0_exe6_1(bb_1_lvb_bb1_c0_exe6),
	.input_c0_exe7_1(bb_1_lvb_bb1_c0_exe7),
	.input_indvars_iv21_1(bb_1_lvb_bb1_c0_exe6),
	.input_right_lower_0_ph_1(bb_1_lvb_bb1_c0_exe5),
	.input_temp_index_0_ph_1(32'h0),
	.input_var__1(64'h0),
	.input_acl_hw_wg_id_1(bb_1_lvb_input_acl_hw_wg_id),
	.valid_out(bb_2_valid_out),
	.stall_in(loop_limiter_2_stall_out),
	.lvb_c0_exe1(bb_2_lvb_c0_exe1),
	.lvb_c0_exe2(bb_2_lvb_c0_exe2),
	.lvb_c0_exe3(bb_2_lvb_c0_exe3),
	.lvb_c0_exe4(bb_2_lvb_c0_exe4),
	.lvb_c0_exe6(bb_2_lvb_c0_exe6),
	.lvb_c0_exe7(bb_2_lvb_c0_exe7),
	.lvb_indvars_iv21(bb_2_lvb_indvars_iv21),
	.lvb_right_lower_0_ph(bb_2_lvb_right_lower_0_ph),
	.lvb_temp_index_0_ph(bb_2_lvb_temp_index_0_ph),
	.lvb_var_(bb_2_lvb_var_),
	.lvb_bb2_var_(bb_2_lvb_bb2_var_),
	.lvb_bb2_cmp4(bb_2_lvb_bb2_cmp4),
	.lvb_bb2_var__u1(bb_2_lvb_bb2_var__u1),
	.lvb_bb2_ld_(bb_2_lvb_bb2_ld_),
	.lvb_input_acl_hw_wg_id(bb_2_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb2_ld__readdata(avm_local_bb2_ld__readdata),
	.avm_local_bb2_ld__readdatavalid(avm_local_bb2_ld__readdatavalid),
	.avm_local_bb2_ld__waitrequest(avm_local_bb2_ld__waitrequest),
	.avm_local_bb2_ld__address(avm_local_bb2_ld__address),
	.avm_local_bb2_ld__read(avm_local_bb2_ld__read),
	.avm_local_bb2_ld__write(avm_local_bb2_ld__write),
	.avm_local_bb2_ld__writeack(avm_local_bb2_ld__writeack),
	.avm_local_bb2_ld__writedata(avm_local_bb2_ld__writedata),
	.avm_local_bb2_ld__byteenable(avm_local_bb2_ld__byteenable),
	.avm_local_bb2_ld__burstcount(avm_local_bb2_ld__burstcount),
	.local_bb2_ld__active(bb_2_local_bb2_ld__active),
	.clock2x(clock2x)
);


fpgasort_basic_block_3 fpgasort_basic_block_3 (
	.clock(clock),
	.resetn(resetn),
	.input_data(input_data),
	.valid_in_0(bb_5_valid_out_0),
	.stall_out_0(bb_3_stall_out_0),
	.input_c0_exe1_0(bb_5_lvb_c0_exe1_0),
	.input_c0_exe2_0(bb_5_lvb_c0_exe2_0),
	.input_c0_exe3_0(bb_5_lvb_c0_exe3_0),
	.input_c0_exe4_0(bb_5_lvb_c0_exe4_0),
	.input_c0_exe6_0(bb_5_lvb_c0_exe6_0),
	.input_c0_exe7_0(bb_5_lvb_c0_exe7_0),
	.input_indvars_iv21_0(bb_5_lvb_indvars_iv21_0),
	.input_cmp4_0(bb_5_lvb_cmp4_0),
	.input_var__0(bb_5_lvb_var__0),
	.input_ld__0(bb_5_lvb_ld__0),
	.input_indvars_iv19_0(bb_5_lvb_bb5_indvars_iv_next20_0),
	.input_indvars_iv17_0(bb_5_lvb_bb5_indvars_iv_next18_0),
	.input_right_lower_0_ph7_0(bb_5_lvb_bb5_inc_0),
	.input_temp_index_0_ph8_0(bb_5_lvb_bb5_inc17_0),
	.input_acl_hw_wg_id_0(bb_5_lvb_input_acl_hw_wg_id_0),
	.valid_in_1(loop_limiter_2_valid_out),
	.stall_out_1(bb_3_stall_out_1),
	.input_c0_exe1_1(bb_2_lvb_c0_exe1),
	.input_c0_exe2_1(bb_2_lvb_c0_exe2),
	.input_c0_exe3_1(bb_2_lvb_c0_exe3),
	.input_c0_exe4_1(bb_2_lvb_c0_exe4),
	.input_c0_exe6_1(bb_2_lvb_c0_exe6),
	.input_c0_exe7_1(bb_2_lvb_c0_exe7),
	.input_indvars_iv21_1(bb_2_lvb_indvars_iv21),
	.input_cmp4_1(bb_2_lvb_bb2_cmp4),
	.input_var__1(bb_2_lvb_bb2_var__u1),
	.input_ld__1(bb_2_lvb_bb2_ld_),
	.input_indvars_iv19_1(bb_2_lvb_var_),
	.input_indvars_iv17_1(bb_2_lvb_bb2_var_),
	.input_right_lower_0_ph7_1(bb_2_lvb_right_lower_0_ph),
	.input_temp_index_0_ph8_1(bb_2_lvb_temp_index_0_ph),
	.input_acl_hw_wg_id_1(bb_2_lvb_input_acl_hw_wg_id),
	.valid_out(bb_3_valid_out),
	.stall_in(loop_limiter_3_stall_out),
	.lvb_c0_exe1(bb_3_lvb_c0_exe1),
	.lvb_c0_exe2(bb_3_lvb_c0_exe2),
	.lvb_c0_exe3(bb_3_lvb_c0_exe3),
	.lvb_c0_exe4(bb_3_lvb_c0_exe4),
	.lvb_c0_exe6(bb_3_lvb_c0_exe6),
	.lvb_c0_exe7(bb_3_lvb_c0_exe7),
	.lvb_indvars_iv21(bb_3_lvb_indvars_iv21),
	.lvb_cmp4(bb_3_lvb_cmp4),
	.lvb_var_(bb_3_lvb_var_),
	.lvb_ld_(bb_3_lvb_ld_),
	.lvb_indvars_iv19(bb_3_lvb_indvars_iv19),
	.lvb_indvars_iv17(bb_3_lvb_indvars_iv17),
	.lvb_right_lower_0_ph7(bb_3_lvb_right_lower_0_ph7),
	.lvb_temp_index_0_ph8(bb_3_lvb_temp_index_0_ph8),
	.lvb_bb3_or_cond(bb_3_lvb_bb3_or_cond),
	.lvb_bb3_var_(bb_3_lvb_bb3_var_),
	.lvb_bb3_ld__pre_pre(bb_3_lvb_bb3_ld__pre_pre),
	.lvb_bb3_var__u3(bb_3_lvb_bb3_var__u3),
	.lvb_bb3_var__u4(bb_3_lvb_bb3_var__u4),
	.lvb_bb3_var__u5(bb_3_lvb_bb3_var__u5),
	.lvb_input_acl_hw_wg_id(bb_3_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb3_ld__pre_pre_readdata(avm_local_bb3_ld__pre_pre_readdata),
	.avm_local_bb3_ld__pre_pre_readdatavalid(avm_local_bb3_ld__pre_pre_readdatavalid),
	.avm_local_bb3_ld__pre_pre_waitrequest(avm_local_bb3_ld__pre_pre_waitrequest),
	.avm_local_bb3_ld__pre_pre_address(avm_local_bb3_ld__pre_pre_address),
	.avm_local_bb3_ld__pre_pre_read(avm_local_bb3_ld__pre_pre_read),
	.avm_local_bb3_ld__pre_pre_write(avm_local_bb3_ld__pre_pre_write),
	.avm_local_bb3_ld__pre_pre_writeack(avm_local_bb3_ld__pre_pre_writeack),
	.avm_local_bb3_ld__pre_pre_writedata(avm_local_bb3_ld__pre_pre_writedata),
	.avm_local_bb3_ld__pre_pre_byteenable(avm_local_bb3_ld__pre_pre_byteenable),
	.avm_local_bb3_ld__pre_pre_burstcount(avm_local_bb3_ld__pre_pre_burstcount),
	.local_bb3_ld__pre_pre_active(bb_3_local_bb3_ld__pre_pre_active),
	.clock2x(clock2x)
);


fpgasort_basic_block_4 fpgasort_basic_block_4 (
	.clock(clock),
	.resetn(resetn),
	.valid_in_0(bb_4_valid_out_0),
	.stall_out_0(bb_4_stall_out_0),
	.input_c0_exe1_0(bb_4_lvb_c0_exe1_0),
	.input_c0_exe2_0(bb_4_lvb_c0_exe2_0),
	.input_c0_exe3_0(bb_4_lvb_c0_exe3_0),
	.input_c0_exe4_0(bb_4_lvb_c0_exe4_0),
	.input_c0_exe6_0(bb_4_lvb_c0_exe6_0),
	.input_c0_exe7_0(bb_4_lvb_c0_exe7_0),
	.input_indvars_iv21_0(bb_4_lvb_indvars_iv21_0),
	.input_cmp4_0(bb_4_lvb_cmp4_0),
	.input_var__0(bb_4_lvb_var__0),
	.input_ld__0(bb_4_lvb_ld__0),
	.input_indvars_iv19_0(bb_4_lvb_indvars_iv19_0),
	.input_indvars_iv17_0(bb_4_lvb_indvars_iv17_0),
	.input_right_lower_0_ph7_0(bb_4_lvb_right_lower_0_ph7_0),
	.input_temp_index_0_ph8_0(bb_4_lvb_temp_index_0_ph8_0),
	.input_or_cond_0(bb_4_lvb_or_cond_0),
	.input_var__u7_0(bb_4_lvb_var__u7_0),
	.input_ld__pre_pre_0(bb_4_lvb_ld__pre_pre_0),
	.input_var__u8_0(bb_4_lvb_var__u8_0),
	.input_var__u9_0(bb_4_lvb_var__u9_0),
	.input_var__u10_0(bb_4_lvb_var__u10_0),
	.input_acl_hw_wg_id_0(bb_4_lvb_input_acl_hw_wg_id_0),
	.valid_in_1(loop_limiter_3_valid_out),
	.stall_out_1(bb_4_stall_out_1),
	.input_c0_exe1_1(bb_3_lvb_c0_exe1),
	.input_c0_exe2_1(bb_3_lvb_c0_exe2),
	.input_c0_exe3_1(bb_3_lvb_c0_exe3),
	.input_c0_exe4_1(bb_3_lvb_c0_exe4),
	.input_c0_exe6_1(bb_3_lvb_c0_exe6),
	.input_c0_exe7_1(bb_3_lvb_c0_exe7),
	.input_indvars_iv21_1(bb_3_lvb_indvars_iv21),
	.input_cmp4_1(bb_3_lvb_cmp4),
	.input_var__1(bb_3_lvb_var_),
	.input_ld__1(bb_3_lvb_ld_),
	.input_indvars_iv19_1(bb_3_lvb_indvars_iv19),
	.input_indvars_iv17_1(bb_3_lvb_indvars_iv17),
	.input_right_lower_0_ph7_1(bb_3_lvb_right_lower_0_ph7),
	.input_temp_index_0_ph8_1(bb_3_lvb_temp_index_0_ph8),
	.input_or_cond_1(bb_3_lvb_bb3_or_cond),
	.input_var__u7_1(bb_3_lvb_bb3_var_),
	.input_ld__pre_pre_1(bb_3_lvb_bb3_ld__pre_pre),
	.input_var__u8_1(bb_3_lvb_bb3_var__u3),
	.input_var__u9_1(bb_3_lvb_bb3_var__u4),
	.input_var__u10_1(bb_3_lvb_bb3_var__u5),
	.input_acl_hw_wg_id_1(bb_3_lvb_input_acl_hw_wg_id),
	.valid_out_0(bb_4_valid_out_0),
	.stall_in_0(bb_4_stall_out_0),
	.lvb_c0_exe1_0(bb_4_lvb_c0_exe1_0),
	.lvb_c0_exe2_0(bb_4_lvb_c0_exe2_0),
	.lvb_c0_exe3_0(bb_4_lvb_c0_exe3_0),
	.lvb_c0_exe4_0(bb_4_lvb_c0_exe4_0),
	.lvb_c0_exe6_0(bb_4_lvb_c0_exe6_0),
	.lvb_c0_exe7_0(bb_4_lvb_c0_exe7_0),
	.lvb_indvars_iv21_0(bb_4_lvb_indvars_iv21_0),
	.lvb_cmp4_0(bb_4_lvb_cmp4_0),
	.lvb_var__0(bb_4_lvb_var__0),
	.lvb_ld__0(bb_4_lvb_ld__0),
	.lvb_indvars_iv19_0(bb_4_lvb_indvars_iv19_0),
	.lvb_indvars_iv17_0(bb_4_lvb_indvars_iv17_0),
	.lvb_right_lower_0_ph7_0(bb_4_lvb_right_lower_0_ph7_0),
	.lvb_temp_index_0_ph8_0(bb_4_lvb_temp_index_0_ph8_0),
	.lvb_or_cond_0(bb_4_lvb_or_cond_0),
	.lvb_var__u7_0(bb_4_lvb_var__u7_0),
	.lvb_ld__pre_pre_0(bb_4_lvb_ld__pre_pre_0),
	.lvb_var__u8_0(bb_4_lvb_var__u8_0),
	.lvb_var__u9_0(bb_4_lvb_var__u9_0),
	.lvb_var__u10_0(bb_4_lvb_var__u10_0),
	.lvb_input_acl_hw_wg_id_0(bb_4_lvb_input_acl_hw_wg_id_0),
	.valid_out_1(bb_4_valid_out_1),
	.stall_in_1(bb_5_stall_out),
	.lvb_c0_exe1_1(bb_4_lvb_c0_exe1_1),
	.lvb_c0_exe2_1(bb_4_lvb_c0_exe2_1),
	.lvb_c0_exe3_1(bb_4_lvb_c0_exe3_1),
	.lvb_c0_exe4_1(bb_4_lvb_c0_exe4_1),
	.lvb_c0_exe6_1(bb_4_lvb_c0_exe6_1),
	.lvb_c0_exe7_1(bb_4_lvb_c0_exe7_1),
	.lvb_indvars_iv21_1(bb_4_lvb_indvars_iv21_1),
	.lvb_cmp4_1(bb_4_lvb_cmp4_1),
	.lvb_var__1(bb_4_lvb_var__1),
	.lvb_ld__1(bb_4_lvb_ld__1),
	.lvb_indvars_iv19_1(bb_4_lvb_indvars_iv19_1),
	.lvb_indvars_iv17_1(bb_4_lvb_indvars_iv17_1),
	.lvb_right_lower_0_ph7_1(bb_4_lvb_right_lower_0_ph7_1),
	.lvb_temp_index_0_ph8_1(bb_4_lvb_temp_index_0_ph8_1),
	.lvb_or_cond_1(bb_4_lvb_or_cond_1),
	.lvb_var__u7_1(bb_4_lvb_var__u7_1),
	.lvb_ld__pre_pre_1(bb_4_lvb_ld__pre_pre_1),
	.lvb_var__u8_1(bb_4_lvb_var__u8_1),
	.lvb_var__u9_1(bb_4_lvb_var__u9_1),
	.lvb_var__u10_1(bb_4_lvb_var__u10_1),
	.lvb_input_acl_hw_wg_id_1(bb_4_lvb_input_acl_hw_wg_id_1),
	.workgroup_size(workgroup_size),
	.start(start)
);


fpgasort_basic_block_5 fpgasort_basic_block_5 (
	.clock(clock),
	.resetn(resetn),
	.input_temp(input_temp),
	.valid_in(bb_4_valid_out_1),
	.stall_out(bb_5_stall_out),
	.input_c0_exe1(bb_4_lvb_c0_exe1_1),
	.input_c0_exe2(bb_4_lvb_c0_exe2_1),
	.input_c0_exe3(bb_4_lvb_c0_exe3_1),
	.input_c0_exe4(bb_4_lvb_c0_exe4_1),
	.input_c0_exe6(bb_4_lvb_c0_exe6_1),
	.input_c0_exe7(bb_4_lvb_c0_exe7_1),
	.input_indvars_iv21(bb_4_lvb_indvars_iv21_1),
	.input_cmp4(bb_4_lvb_cmp4_1),
	.input_var_(bb_4_lvb_var__1),
	.input_ld_(bb_4_lvb_ld__1),
	.input_indvars_iv19(bb_4_lvb_indvars_iv19_1),
	.input_indvars_iv17(bb_4_lvb_indvars_iv17_1),
	.input_right_lower_0_ph7(bb_4_lvb_right_lower_0_ph7_1),
	.input_temp_index_0_ph8(bb_4_lvb_temp_index_0_ph8_1),
	.input_or_cond(bb_4_lvb_or_cond_1),
	.input_var__u11(bb_4_lvb_var__u7_1),
	.input_ld__pre_pre(bb_4_lvb_ld__pre_pre_1),
	.input_var__u12(bb_4_lvb_var__u8_1),
	.input_var__u13(bb_4_lvb_var__u9_1),
	.input_acl_hw_wg_id(bb_4_lvb_input_acl_hw_wg_id_1),
	.valid_out_0(bb_5_valid_out_0),
	.stall_in_0(bb_3_stall_out_0),
	.lvb_c0_exe1_0(bb_5_lvb_c0_exe1_0),
	.lvb_c0_exe2_0(bb_5_lvb_c0_exe2_0),
	.lvb_c0_exe3_0(bb_5_lvb_c0_exe3_0),
	.lvb_c0_exe4_0(bb_5_lvb_c0_exe4_0),
	.lvb_c0_exe6_0(bb_5_lvb_c0_exe6_0),
	.lvb_c0_exe7_0(bb_5_lvb_c0_exe7_0),
	.lvb_indvars_iv21_0(bb_5_lvb_indvars_iv21_0),
	.lvb_cmp4_0(bb_5_lvb_cmp4_0),
	.lvb_var__0(bb_5_lvb_var__0),
	.lvb_ld__0(bb_5_lvb_ld__0),
	.lvb_right_lower_0_ph7_0(bb_5_lvb_right_lower_0_ph7_0),
	.lvb_temp_index_0_ph8_0(bb_5_lvb_temp_index_0_ph8_0),
	.lvb_var__u12_0(bb_5_lvb_var__u12_0),
	.lvb_var__u13_0(bb_5_lvb_var__u13_0),
	.lvb_bb5_indvars_iv_next18_0(bb_5_lvb_bb5_indvars_iv_next18_0),
	.lvb_bb5_inc_0(bb_5_lvb_bb5_inc_0),
	.lvb_bb5_indvars_iv_next20_0(bb_5_lvb_bb5_indvars_iv_next20_0),
	.lvb_bb5_inc17_0(bb_5_lvb_bb5_inc17_0),
	.lvb_input_acl_hw_wg_id_0(bb_5_lvb_input_acl_hw_wg_id_0),
	.valid_out_1(bb_5_valid_out_1),
	.stall_in_1(bb_8_stall_out),
	.lvb_c0_exe1_1(bb_5_lvb_c0_exe1_1),
	.lvb_c0_exe2_1(bb_5_lvb_c0_exe2_1),
	.lvb_c0_exe3_1(bb_5_lvb_c0_exe3_1),
	.lvb_c0_exe4_1(bb_5_lvb_c0_exe4_1),
	.lvb_c0_exe6_1(bb_5_lvb_c0_exe6_1),
	.lvb_c0_exe7_1(bb_5_lvb_c0_exe7_1),
	.lvb_indvars_iv21_1(bb_5_lvb_indvars_iv21_1),
	.lvb_cmp4_1(bb_5_lvb_cmp4_1),
	.lvb_var__1(bb_5_lvb_var__1),
	.lvb_ld__1(bb_5_lvb_ld__1),
	.lvb_right_lower_0_ph7_1(bb_5_lvb_right_lower_0_ph7_1),
	.lvb_temp_index_0_ph8_1(bb_5_lvb_temp_index_0_ph8_1),
	.lvb_var__u12_1(bb_5_lvb_var__u12_1),
	.lvb_var__u13_1(bb_5_lvb_var__u13_1),
	.lvb_bb5_indvars_iv_next18_1(bb_5_lvb_bb5_indvars_iv_next18_1),
	.lvb_bb5_inc_1(bb_5_lvb_bb5_inc_1),
	.lvb_bb5_indvars_iv_next20_1(bb_5_lvb_bb5_indvars_iv_next20_1),
	.lvb_bb5_inc17_1(bb_5_lvb_bb5_inc17_1),
	.lvb_input_acl_hw_wg_id_1(bb_5_lvb_input_acl_hw_wg_id_1),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb5_st__pre_pre_readdata(avm_local_bb5_st__pre_pre_readdata),
	.avm_local_bb5_st__pre_pre_readdatavalid(avm_local_bb5_st__pre_pre_readdatavalid),
	.avm_local_bb5_st__pre_pre_waitrequest(avm_local_bb5_st__pre_pre_waitrequest),
	.avm_local_bb5_st__pre_pre_address(avm_local_bb5_st__pre_pre_address),
	.avm_local_bb5_st__pre_pre_read(avm_local_bb5_st__pre_pre_read),
	.avm_local_bb5_st__pre_pre_write(avm_local_bb5_st__pre_pre_write),
	.avm_local_bb5_st__pre_pre_writeack(avm_local_bb5_st__pre_pre_writeack),
	.avm_local_bb5_st__pre_pre_writedata(avm_local_bb5_st__pre_pre_writedata),
	.avm_local_bb5_st__pre_pre_byteenable(avm_local_bb5_st__pre_pre_byteenable),
	.avm_local_bb5_st__pre_pre_burstcount(avm_local_bb5_st__pre_pre_burstcount),
	.local_bb5_st__pre_pre_active(bb_5_local_bb5_st__pre_pre_active),
	.clock2x(clock2x)
);


fpgasort_basic_block_6 fpgasort_basic_block_6 (
	.clock(clock),
	.resetn(resetn),
	.input_temp(input_temp),
	.input_data(input_data),
	.valid_in_0(bb_6_valid_out_1),
	.stall_out_0(bb_6_stall_out_0),
	.input_c0_exe3_0(bb_6_lvb_c0_exe3_1),
	.input_c0_exe7_0(bb_6_lvb_c0_exe7_1),
	.input_indvars_iv_0(bb_6_lvb_bb6_indvars_iv_next_1),
	.input_cmp424_0(bb_6_lvb_cmp424_1),
	.input_cmp_phi_decision80_xor_or_0(bb_6_lvb_cmp_phi_decision80_xor_or_1),
	.input_acl_hw_wg_id_0(bb_6_lvb_input_acl_hw_wg_id_1),
	.valid_in_1(loop_limiter_1_valid_out),
	.stall_out_1(bb_6_stall_out_1),
	.input_c0_exe3_1(bb_9_lvb_c0_exe3),
	.input_c0_exe7_1(bb_9_lvb_c0_exe7),
	.input_indvars_iv_1(bb_9_lvb_c0_exe6),
	.input_cmp424_1(bb_9_lvb_bb9_cmp424),
	.input_cmp_phi_decision80_xor_or_1(bb_9_lvb_bb9_cmp_phi_decision80_xor_or),
	.input_acl_hw_wg_id_1(bb_9_lvb_input_acl_hw_wg_id),
	.valid_out_0(bb_6_valid_out_0),
	.stall_in_0(bb_7_stall_out),
	.lvb_c0_exe3_0(bb_6_lvb_c0_exe3_0),
	.lvb_c0_exe7_0(bb_6_lvb_c0_exe7_0),
	.lvb_bb6_indvars_iv_next_0(bb_6_lvb_bb6_indvars_iv_next_0),
	.lvb_cmp424_0(bb_6_lvb_cmp424_0),
	.lvb_cmp_phi_decision80_xor_or_0(bb_6_lvb_cmp_phi_decision80_xor_or_0),
	.lvb_input_acl_hw_wg_id_0(bb_6_lvb_input_acl_hw_wg_id_0),
	.valid_out_1(bb_6_valid_out_1),
	.stall_in_1(bb_6_stall_out_0),
	.lvb_c0_exe3_1(bb_6_lvb_c0_exe3_1),
	.lvb_c0_exe7_1(bb_6_lvb_c0_exe7_1),
	.lvb_bb6_indvars_iv_next_1(bb_6_lvb_bb6_indvars_iv_next_1),
	.lvb_cmp424_1(bb_6_lvb_cmp424_1),
	.lvb_cmp_phi_decision80_xor_or_1(bb_6_lvb_cmp_phi_decision80_xor_or_1),
	.lvb_input_acl_hw_wg_id_1(bb_6_lvb_input_acl_hw_wg_id_1),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb6_ld__readdata(avm_local_bb6_ld__readdata),
	.avm_local_bb6_ld__readdatavalid(avm_local_bb6_ld__readdatavalid),
	.avm_local_bb6_ld__waitrequest(avm_local_bb6_ld__waitrequest),
	.avm_local_bb6_ld__address(avm_local_bb6_ld__address),
	.avm_local_bb6_ld__read(avm_local_bb6_ld__read),
	.avm_local_bb6_ld__write(avm_local_bb6_ld__write),
	.avm_local_bb6_ld__writeack(avm_local_bb6_ld__writeack),
	.avm_local_bb6_ld__writedata(avm_local_bb6_ld__writedata),
	.avm_local_bb6_ld__byteenable(avm_local_bb6_ld__byteenable),
	.avm_local_bb6_ld__burstcount(avm_local_bb6_ld__burstcount),
	.local_bb6_ld__active(bb_6_local_bb6_ld__active),
	.clock2x(clock2x),
	.avm_local_bb6_st__readdata(avm_local_bb6_st__readdata),
	.avm_local_bb6_st__readdatavalid(avm_local_bb6_st__readdatavalid),
	.avm_local_bb6_st__waitrequest(avm_local_bb6_st__waitrequest),
	.avm_local_bb6_st__address(avm_local_bb6_st__address),
	.avm_local_bb6_st__read(avm_local_bb6_st__read),
	.avm_local_bb6_st__write(avm_local_bb6_st__write),
	.avm_local_bb6_st__writeack(avm_local_bb6_st__writeack),
	.avm_local_bb6_st__writedata(avm_local_bb6_st__writedata),
	.avm_local_bb6_st__byteenable(avm_local_bb6_st__byteenable),
	.avm_local_bb6_st__burstcount(avm_local_bb6_st__burstcount),
	.local_bb6_st__active(bb_6_local_bb6_st__active)
);


fpgasort_basic_block_7 fpgasort_basic_block_7 (
	.clock(clock),
	.resetn(resetn),
	.valid_in(bb_6_valid_out_0),
	.stall_out(bb_7_stall_out),
	.input_acl_hw_wg_id(bb_6_lvb_input_acl_hw_wg_id_0),
	.valid_out(bb_7_valid_out),
	.stall_in(stall_in),
	.lvb_input_acl_hw_wg_id(bb_7_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size),
	.start(start)
);


fpgasort_basic_block_8 fpgasort_basic_block_8 (
	.clock(clock),
	.resetn(resetn),
	.input_temp(input_temp),
	.valid_in(bb_5_valid_out_1),
	.stall_out(bb_8_stall_out),
	.input_c0_exe1(bb_5_lvb_c0_exe1_1),
	.input_c0_exe2(bb_5_lvb_c0_exe2_1),
	.input_c0_exe3(bb_5_lvb_c0_exe3_1),
	.input_c0_exe4(bb_5_lvb_c0_exe4_1),
	.input_c0_exe6(bb_5_lvb_c0_exe6_1),
	.input_c0_exe7(bb_5_lvb_c0_exe7_1),
	.input_indvars_iv21(bb_5_lvb_indvars_iv21_1),
	.input_ld_(bb_5_lvb_ld__1),
	.input_right_lower_0_ph7(bb_5_lvb_right_lower_0_ph7_1),
	.input_temp_index_0_ph8(bb_5_lvb_temp_index_0_ph8_1),
	.input_var_(bb_5_lvb_var__u12_1),
	.input_var__u15(bb_5_lvb_var__u13_1),
	.input_inc17(bb_5_lvb_bb5_inc17_1),
	.input_acl_hw_wg_id(bb_5_lvb_input_acl_hw_wg_id_1),
	.valid_out_0(bb_8_valid_out_0),
	.stall_in_0(bb_2_stall_out_0),
	.lvb_c0_exe1_0(bb_8_lvb_c0_exe1_0),
	.lvb_c0_exe2_0(bb_8_lvb_c0_exe2_0),
	.lvb_c0_exe3_0(bb_8_lvb_c0_exe3_0),
	.lvb_c0_exe4_0(bb_8_lvb_c0_exe4_0),
	.lvb_c0_exe6_0(bb_8_lvb_c0_exe6_0),
	.lvb_c0_exe7_0(bb_8_lvb_c0_exe7_0),
	.lvb_right_lower_0_ph7_0(bb_8_lvb_right_lower_0_ph7_0),
	.lvb_inc17_0(bb_8_lvb_inc17_0),
	.lvb_bb8_indvars_iv_next22_0(bb_8_lvb_bb8_indvars_iv_next22_0),
	.lvb_bb8_var__0(bb_8_lvb_bb8_var__0),
	.lvb_input_acl_hw_wg_id_0(bb_8_lvb_input_acl_hw_wg_id_0),
	.valid_out_1(bb_8_valid_out_1),
	.stall_in_1(bb_9_stall_out),
	.lvb_c0_exe1_1(bb_8_lvb_c0_exe1_1),
	.lvb_c0_exe2_1(bb_8_lvb_c0_exe2_1),
	.lvb_c0_exe3_1(bb_8_lvb_c0_exe3_1),
	.lvb_c0_exe4_1(bb_8_lvb_c0_exe4_1),
	.lvb_c0_exe6_1(bb_8_lvb_c0_exe6_1),
	.lvb_c0_exe7_1(bb_8_lvb_c0_exe7_1),
	.lvb_right_lower_0_ph7_1(bb_8_lvb_right_lower_0_ph7_1),
	.lvb_inc17_1(bb_8_lvb_inc17_1),
	.lvb_bb8_indvars_iv_next22_1(bb_8_lvb_bb8_indvars_iv_next22_1),
	.lvb_bb8_var__1(bb_8_lvb_bb8_var__1),
	.lvb_input_acl_hw_wg_id_1(bb_8_lvb_input_acl_hw_wg_id_1),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb8_st__readdata(avm_local_bb8_st__readdata),
	.avm_local_bb8_st__readdatavalid(avm_local_bb8_st__readdatavalid),
	.avm_local_bb8_st__waitrequest(avm_local_bb8_st__waitrequest),
	.avm_local_bb8_st__address(avm_local_bb8_st__address),
	.avm_local_bb8_st__read(avm_local_bb8_st__read),
	.avm_local_bb8_st__write(avm_local_bb8_st__write),
	.avm_local_bb8_st__writeack(avm_local_bb8_st__writeack),
	.avm_local_bb8_st__writedata(avm_local_bb8_st__writedata),
	.avm_local_bb8_st__byteenable(avm_local_bb8_st__byteenable),
	.avm_local_bb8_st__burstcount(avm_local_bb8_st__burstcount),
	.local_bb8_st__active(bb_8_local_bb8_st__active),
	.clock2x(clock2x)
);


fpgasort_basic_block_9 fpgasort_basic_block_9 (
	.clock(clock),
	.resetn(resetn),
	.valid_in(bb_8_valid_out_1),
	.stall_out(bb_9_stall_out),
	.input_c0_exe1(bb_8_lvb_c0_exe1_1),
	.input_c0_exe3(bb_8_lvb_c0_exe3_1),
	.input_c0_exe6(bb_8_lvb_c0_exe6_1),
	.input_c0_exe7(bb_8_lvb_c0_exe7_1),
	.input_acl_hw_wg_id(bb_8_lvb_input_acl_hw_wg_id_1),
	.valid_out(bb_9_valid_out),
	.stall_in(loop_limiter_1_stall_out),
	.lvb_c0_exe3(bb_9_lvb_c0_exe3),
	.lvb_c0_exe6(bb_9_lvb_c0_exe6),
	.lvb_c0_exe7(bb_9_lvb_c0_exe7),
	.lvb_bb9_cmp424(bb_9_lvb_bb9_cmp424),
	.lvb_bb9_cmp_phi_decision80_xor_or(bb_9_lvb_bb9_cmp_phi_decision80_xor_or),
	.lvb_input_acl_hw_wg_id(bb_9_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size),
	.start(start)
);


acl_loop_limiter loop_limiter_0 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_1_valid_out),
	.i_stall(bb_2_stall_out_1),
	.i_valid_exit(bb_8_valid_out_1),
	.i_stall_exit(bb_9_stall_out),
	.o_valid(loop_limiter_0_valid_out),
	.o_stall(loop_limiter_0_stall_out)
);

defparam loop_limiter_0.ENTRY_WIDTH = 1;
defparam loop_limiter_0.EXIT_WIDTH = 1;
defparam loop_limiter_0.THRESHOLD = 655;

acl_loop_limiter loop_limiter_1 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_9_valid_out),
	.i_stall(bb_6_stall_out_1),
	.i_valid_exit(bb_6_valid_out_0),
	.i_stall_exit(bb_7_stall_out),
	.o_valid(loop_limiter_1_valid_out),
	.o_stall(loop_limiter_1_stall_out)
);

defparam loop_limiter_1.ENTRY_WIDTH = 1;
defparam loop_limiter_1.EXIT_WIDTH = 1;
defparam loop_limiter_1.THRESHOLD = 166;

acl_loop_limiter loop_limiter_2 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_2_valid_out),
	.i_stall(bb_3_stall_out_1),
	.i_valid_exit(bb_5_valid_out_1),
	.i_stall_exit(bb_8_stall_out),
	.o_valid(loop_limiter_2_valid_out),
	.o_stall(loop_limiter_2_stall_out)
);

defparam loop_limiter_2.ENTRY_WIDTH = 1;
defparam loop_limiter_2.EXIT_WIDTH = 1;
defparam loop_limiter_2.THRESHOLD = 330;

acl_loop_limiter loop_limiter_3 (
	.clock(clock),
	.resetn(resetn),
	.i_valid(bb_3_valid_out),
	.i_stall(bb_4_stall_out_1),
	.i_valid_exit(bb_4_valid_out_1),
	.i_stall_exit(bb_5_stall_out),
	.o_valid(loop_limiter_3_valid_out),
	.o_stall(loop_limiter_3_stall_out)
);

defparam loop_limiter_3.ENTRY_WIDTH = 1;
defparam loop_limiter_3.EXIT_WIDTH = 1;
defparam loop_limiter_3.THRESHOLD = 2;

fpgasort_sys_cycle_time system_cycle_time_module (
	.clock(clock),
	.resetn(resetn),
	.cur_cycle(cur_cycle)
);


assign valid_out = bb_7_valid_out;
assign output_0 = bb_7_lvb_input_acl_hw_wg_id;
assign stall_out = bb_0_stall_out;
assign writes_pending[0] = bb_5_local_bb5_st__pre_pre_active;
assign writes_pending[1] = bb_6_local_bb6_st__active;
assign writes_pending[2] = bb_8_local_bb8_st__active;
assign lsus_active[0] = bb_2_local_bb2_ld__active;
assign lsus_active[1] = bb_3_local_bb3_ld__pre_pre_active;
assign lsus_active[2] = bb_5_local_bb5_st__pre_pre_active;
assign lsus_active[3] = bb_6_local_bb6_ld__active;
assign lsus_active[4] = bb_6_local_bb6_st__active;
assign lsus_active[5] = bb_8_local_bb8_st__active;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		has_a_write_pending <= 1'b0;
		has_a_lsu_active <= 1'b0;
	end
	else
	begin
		has_a_write_pending <= (|writes_pending);
		has_a_lsu_active <= (|lsus_active);
	end
end

endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_function_wrapper
	(
		input 		clock,
		input 		resetn,
		input 		clock2x,
		input 		local_router_hang,
		input 		avs_cra_read,
		input 		avs_cra_write,
		input [3:0] 		avs_cra_address,
		input [63:0] 		avs_cra_writedata,
		input [7:0] 		avs_cra_byteenable,
		output 		avs_cra_waitrequest,
		output reg [63:0] 		avs_cra_readdata,
		output reg 		avs_cra_readdatavalid,
		output 		cra_irq,
		input [255:0] 		avm_local_bb2_ld__inst0_readdata,
		input 		avm_local_bb2_ld__inst0_readdatavalid,
		input 		avm_local_bb2_ld__inst0_waitrequest,
		output [29:0] 		avm_local_bb2_ld__inst0_address,
		output 		avm_local_bb2_ld__inst0_read,
		output 		avm_local_bb2_ld__inst0_write,
		input 		avm_local_bb2_ld__inst0_writeack,
		output [255:0] 		avm_local_bb2_ld__inst0_writedata,
		output [31:0] 		avm_local_bb2_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb2_ld__inst0_burstcount,
		input [255:0] 		avm_local_bb3_ld__pre_pre_inst0_readdata,
		input 		avm_local_bb3_ld__pre_pre_inst0_readdatavalid,
		input 		avm_local_bb3_ld__pre_pre_inst0_waitrequest,
		output [29:0] 		avm_local_bb3_ld__pre_pre_inst0_address,
		output 		avm_local_bb3_ld__pre_pre_inst0_read,
		output 		avm_local_bb3_ld__pre_pre_inst0_write,
		input 		avm_local_bb3_ld__pre_pre_inst0_writeack,
		output [255:0] 		avm_local_bb3_ld__pre_pre_inst0_writedata,
		output [31:0] 		avm_local_bb3_ld__pre_pre_inst0_byteenable,
		output [4:0] 		avm_local_bb3_ld__pre_pre_inst0_burstcount,
		input [255:0] 		avm_local_bb5_st__pre_pre_inst0_readdata,
		input 		avm_local_bb5_st__pre_pre_inst0_readdatavalid,
		input 		avm_local_bb5_st__pre_pre_inst0_waitrequest,
		output [29:0] 		avm_local_bb5_st__pre_pre_inst0_address,
		output 		avm_local_bb5_st__pre_pre_inst0_read,
		output 		avm_local_bb5_st__pre_pre_inst0_write,
		input 		avm_local_bb5_st__pre_pre_inst0_writeack,
		output [255:0] 		avm_local_bb5_st__pre_pre_inst0_writedata,
		output [31:0] 		avm_local_bb5_st__pre_pre_inst0_byteenable,
		output [4:0] 		avm_local_bb5_st__pre_pre_inst0_burstcount,
		input [255:0] 		avm_local_bb6_ld__inst0_readdata,
		input 		avm_local_bb6_ld__inst0_readdatavalid,
		input 		avm_local_bb6_ld__inst0_waitrequest,
		output [29:0] 		avm_local_bb6_ld__inst0_address,
		output 		avm_local_bb6_ld__inst0_read,
		output 		avm_local_bb6_ld__inst0_write,
		input 		avm_local_bb6_ld__inst0_writeack,
		output [255:0] 		avm_local_bb6_ld__inst0_writedata,
		output [31:0] 		avm_local_bb6_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb6_ld__inst0_burstcount,
		input [255:0] 		avm_local_bb6_st__inst0_readdata,
		input 		avm_local_bb6_st__inst0_readdatavalid,
		input 		avm_local_bb6_st__inst0_waitrequest,
		output [29:0] 		avm_local_bb6_st__inst0_address,
		output 		avm_local_bb6_st__inst0_read,
		output 		avm_local_bb6_st__inst0_write,
		input 		avm_local_bb6_st__inst0_writeack,
		output [255:0] 		avm_local_bb6_st__inst0_writedata,
		output [31:0] 		avm_local_bb6_st__inst0_byteenable,
		output [4:0] 		avm_local_bb6_st__inst0_burstcount,
		input [255:0] 		avm_local_bb8_st__inst0_readdata,
		input 		avm_local_bb8_st__inst0_readdatavalid,
		input 		avm_local_bb8_st__inst0_waitrequest,
		output [29:0] 		avm_local_bb8_st__inst0_address,
		output 		avm_local_bb8_st__inst0_read,
		output 		avm_local_bb8_st__inst0_write,
		input 		avm_local_bb8_st__inst0_writeack,
		output [255:0] 		avm_local_bb8_st__inst0_writedata,
		output [31:0] 		avm_local_bb8_st__inst0_byteenable,
		output [4:0] 		avm_local_bb8_st__inst0_burstcount
	);

// Responsible for interfacing a kernel with the outside world. It comprises a
// slave interface to specify the kernel arguments and retain kernel status. 

// This section of the wrapper implements the slave interface.
// twoXclock_consumer uses clock2x, even if nobody inside the kernel does. Keeps interface to acl_iface consistent for all kernels.
 reg start_NO_SHIFT_REG;
 reg started_NO_SHIFT_REG;
wire finish;
 reg [31:0] status_NO_SHIFT_REG;
wire has_a_write_pending;
wire has_a_lsu_active;
 reg [191:0] kernel_arguments_NO_SHIFT_REG;
 reg twoXclock_consumer_NO_SHIFT_REG /* synthesis  preserve  noprune  */;
 reg [31:0] workgroup_size_NO_SHIFT_REG;
 reg [31:0] global_size_NO_SHIFT_REG[2:0];
 reg [31:0] num_groups_NO_SHIFT_REG[2:0];
 reg [31:0] local_size_NO_SHIFT_REG[2:0];
 reg [31:0] work_dim_NO_SHIFT_REG;
 reg [31:0] global_offset_NO_SHIFT_REG[2:0];
 reg [63:0] profile_data_NO_SHIFT_REG;
 reg [31:0] profile_ctrl_NO_SHIFT_REG;
 reg [63:0] profile_start_cycle_NO_SHIFT_REG;
 reg [63:0] profile_stop_cycle_NO_SHIFT_REG;
wire dispatched_all_groups;
wire [31:0] group_id_tmp[2:0];
wire [31:0] global_id_base_out[2:0];
wire start_out;
wire [31:0] local_id[0:0][2:0];
wire [31:0] global_id[0:0][2:0];
wire [31:0] group_id[0:0][2:0];
wire iter_valid_in;
wire iter_stall_out;
wire stall_in;
wire stall_out;
wire valid_in;
wire valid_out;

always @(posedge clock2x or negedge resetn)
begin
	if (~(resetn))
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		twoXclock_consumer_NO_SHIFT_REG <= 1'b1;
	end
end



// Work group dispatcher is responsible for issuing work-groups to id iterator(s)
acl_work_group_dispatcher group_dispatcher (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.num_groups(num_groups_NO_SHIFT_REG),
	.local_size(local_size_NO_SHIFT_REG),
	.stall_in(iter_stall_out),
	.valid_out(iter_valid_in),
	.group_id_out(group_id_tmp),
	.global_id_base_out(global_id_base_out),
	.start_out(start_out),
	.dispatched_all_groups(dispatched_all_groups)
);

defparam group_dispatcher.NUM_COPIES = 1;
defparam group_dispatcher.RUN_FOREVER = 0;


// This section of the wrapper implements an Avalon Slave Interface used to configure a kernel invocation.
// The few words words contain the status and the workgroup size registers.
// The remaining addressable space is reserved for kernel arguments.
wire [63:0] bitenable;

assign bitenable[7:0] = (avs_cra_byteenable[0] ? 8'hFF : 8'h0);
assign bitenable[15:8] = (avs_cra_byteenable[1] ? 8'hFF : 8'h0);
assign bitenable[23:16] = (avs_cra_byteenable[2] ? 8'hFF : 8'h0);
assign bitenable[31:24] = (avs_cra_byteenable[3] ? 8'hFF : 8'h0);
assign bitenable[39:32] = (avs_cra_byteenable[4] ? 8'hFF : 8'h0);
assign bitenable[47:40] = (avs_cra_byteenable[5] ? 8'hFF : 8'h0);
assign bitenable[55:48] = (avs_cra_byteenable[6] ? 8'hFF : 8'h0);
assign bitenable[63:56] = (avs_cra_byteenable[7] ? 8'hFF : 8'h0);
assign avs_cra_waitrequest = 1'b0;
assign cra_irq = (status_NO_SHIFT_REG[1] | status_NO_SHIFT_REG[3]);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		start_NO_SHIFT_REG <= 1'b0;
		started_NO_SHIFT_REG <= 1'b0;
		kernel_arguments_NO_SHIFT_REG <= 192'h0;
		status_NO_SHIFT_REG <= 32'h30000;
		profile_ctrl_NO_SHIFT_REG <= 32'h4;
		profile_start_cycle_NO_SHIFT_REG <= 64'h0;
		profile_stop_cycle_NO_SHIFT_REG <= 64'hFFFFFFFFFFFFFFFF;
		work_dim_NO_SHIFT_REG <= 32'h0;
		workgroup_size_NO_SHIFT_REG <= 32'h0;
		global_size_NO_SHIFT_REG[0] <= 32'h0;
		global_size_NO_SHIFT_REG[1] <= 32'h0;
		global_size_NO_SHIFT_REG[2] <= 32'h0;
		num_groups_NO_SHIFT_REG[0] <= 32'h0;
		num_groups_NO_SHIFT_REG[1] <= 32'h0;
		num_groups_NO_SHIFT_REG[2] <= 32'h0;
		local_size_NO_SHIFT_REG[0] <= 32'h0;
		local_size_NO_SHIFT_REG[1] <= 32'h0;
		local_size_NO_SHIFT_REG[2] <= 32'h0;
		global_offset_NO_SHIFT_REG[0] <= 32'h0;
		global_offset_NO_SHIFT_REG[1] <= 32'h0;
		global_offset_NO_SHIFT_REG[2] <= 32'h0;
	end
	else
	begin
		if (avs_cra_write)
		begin
			case (avs_cra_address)
				4'h0:
				begin
					status_NO_SHIFT_REG[31:16] <= 16'h3;
					status_NO_SHIFT_REG[15:0] <= ((status_NO_SHIFT_REG[15:0] & ~(bitenable[15:0])) | (avs_cra_writedata[15:0] & bitenable[15:0]));
				end

				4'h1:
				begin
					profile_ctrl_NO_SHIFT_REG <= ((profile_ctrl_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h3:
				begin
					profile_start_cycle_NO_SHIFT_REG[31:0] <= ((profile_start_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_start_cycle_NO_SHIFT_REG[63:32] <= ((profile_start_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h4:
				begin
					profile_stop_cycle_NO_SHIFT_REG[31:0] <= ((profile_stop_cycle_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					profile_stop_cycle_NO_SHIFT_REG[63:32] <= ((profile_stop_cycle_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h5:
				begin
					work_dim_NO_SHIFT_REG <= ((work_dim_NO_SHIFT_REG & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					workgroup_size_NO_SHIFT_REG <= ((workgroup_size_NO_SHIFT_REG & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h6:
				begin
					global_size_NO_SHIFT_REG[0] <= ((global_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_size_NO_SHIFT_REG[1] <= ((global_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h7:
				begin
					global_size_NO_SHIFT_REG[2] <= ((global_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[0] <= ((num_groups_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h8:
				begin
					num_groups_NO_SHIFT_REG[1] <= ((num_groups_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					num_groups_NO_SHIFT_REG[2] <= ((num_groups_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'h9:
				begin
					local_size_NO_SHIFT_REG[0] <= ((local_size_NO_SHIFT_REG[0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					local_size_NO_SHIFT_REG[1] <= ((local_size_NO_SHIFT_REG[1] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hA:
				begin
					local_size_NO_SHIFT_REG[2] <= ((local_size_NO_SHIFT_REG[2] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[0] <= ((global_offset_NO_SHIFT_REG[0] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hB:
				begin
					global_offset_NO_SHIFT_REG[1] <= ((global_offset_NO_SHIFT_REG[1] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					global_offset_NO_SHIFT_REG[2] <= ((global_offset_NO_SHIFT_REG[2] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hC:
				begin
					kernel_arguments_NO_SHIFT_REG[31:0] <= ((kernel_arguments_NO_SHIFT_REG[31:0] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[63:32] <= ((kernel_arguments_NO_SHIFT_REG[63:32] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hD:
				begin
					kernel_arguments_NO_SHIFT_REG[95:64] <= ((kernel_arguments_NO_SHIFT_REG[95:64] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[127:96] <= ((kernel_arguments_NO_SHIFT_REG[127:96] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				4'hE:
				begin
					kernel_arguments_NO_SHIFT_REG[159:128] <= ((kernel_arguments_NO_SHIFT_REG[159:128] & ~(bitenable[31:0])) | (avs_cra_writedata[31:0] & bitenable[31:0]));
					kernel_arguments_NO_SHIFT_REG[191:160] <= ((kernel_arguments_NO_SHIFT_REG[191:160] & ~(bitenable[63:32])) | (avs_cra_writedata[63:32] & bitenable[63:32]));
				end

				default:
				begin
				end

			endcase
		end
		else
		begin
			if (status_NO_SHIFT_REG[0])
			begin
				start_NO_SHIFT_REG <= 1'b1;
			end
			if (start_NO_SHIFT_REG)
			begin
				status_NO_SHIFT_REG[0] <= 1'b0;
				started_NO_SHIFT_REG <= 1'b1;
			end
			if (started_NO_SHIFT_REG)
			begin
				start_NO_SHIFT_REG <= 1'b0;
			end
			if (finish)
			begin
				status_NO_SHIFT_REG[1] <= 1'b1;
				started_NO_SHIFT_REG <= 1'b0;
			end
		end
		status_NO_SHIFT_REG[11] <= local_router_hang;
		status_NO_SHIFT_REG[12] <= (|has_a_lsu_active);
		status_NO_SHIFT_REG[13] <= (|has_a_write_pending);
		status_NO_SHIFT_REG[14] <= (|valid_in);
		status_NO_SHIFT_REG[15] <= started_NO_SHIFT_REG;
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdata <= 64'h0;
	end
	else
	begin
		case (avs_cra_address)
			4'h0:
			begin
				avs_cra_readdata[31:0] <= status_NO_SHIFT_REG;
				avs_cra_readdata[63:32] <= 32'h0;
			end

			4'h1:
			begin
				avs_cra_readdata[31:0] <= 'x;
				avs_cra_readdata[63:32] <= 32'h0;
			end

			4'h2:
			begin
				avs_cra_readdata[63:0] <= 64'h0;
			end

			4'h3:
			begin
				avs_cra_readdata[63:0] <= 64'h0;
			end

			4'h4:
			begin
				avs_cra_readdata[63:0] <= 64'h0;
			end

			4'h5:
			begin
				avs_cra_readdata[31:0] <= work_dim_NO_SHIFT_REG;
				avs_cra_readdata[63:32] <= workgroup_size_NO_SHIFT_REG;
			end

			4'h6:
			begin
				avs_cra_readdata[31:0] <= global_size_NO_SHIFT_REG[0];
				avs_cra_readdata[63:32] <= global_size_NO_SHIFT_REG[1];
			end

			4'h7:
			begin
				avs_cra_readdata[31:0] <= global_size_NO_SHIFT_REG[2];
				avs_cra_readdata[63:32] <= num_groups_NO_SHIFT_REG[0];
			end

			4'h8:
			begin
				avs_cra_readdata[31:0] <= num_groups_NO_SHIFT_REG[1];
				avs_cra_readdata[63:32] <= num_groups_NO_SHIFT_REG[2];
			end

			4'h9:
			begin
				avs_cra_readdata[31:0] <= local_size_NO_SHIFT_REG[0];
				avs_cra_readdata[63:32] <= local_size_NO_SHIFT_REG[1];
			end

			4'hA:
			begin
				avs_cra_readdata[31:0] <= local_size_NO_SHIFT_REG[2];
				avs_cra_readdata[63:32] <= global_offset_NO_SHIFT_REG[0];
			end

			4'hB:
			begin
				avs_cra_readdata[31:0] <= global_offset_NO_SHIFT_REG[1];
				avs_cra_readdata[63:32] <= global_offset_NO_SHIFT_REG[2];
			end

			4'hC:
			begin
				avs_cra_readdata[31:0] <= kernel_arguments_NO_SHIFT_REG[31:0];
				avs_cra_readdata[63:32] <= kernel_arguments_NO_SHIFT_REG[63:32];
			end

			4'hD:
			begin
				avs_cra_readdata[31:0] <= kernel_arguments_NO_SHIFT_REG[95:64];
				avs_cra_readdata[63:32] <= kernel_arguments_NO_SHIFT_REG[127:96];
			end

			4'hE:
			begin
				avs_cra_readdata[31:0] <= kernel_arguments_NO_SHIFT_REG[159:128];
				avs_cra_readdata[63:32] <= kernel_arguments_NO_SHIFT_REG[191:160];
			end

			default:
			begin
				avs_cra_readdata <= status_NO_SHIFT_REG;
			end

		endcase
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		avs_cra_readdatavalid <= 1'b0;
	end
	else
	begin
		avs_cra_readdatavalid <= (avs_cra_read & ~(avs_cra_waitrequest));
	end
end


// Handshaking signals used to control data through the pipeline

// Determine when the kernel is finished.
acl_kernel_finish_detector kernel_finish_detector (
	.clock(clock),
	.resetn(resetn),
	.start(start_NO_SHIFT_REG),
	.wg_size(workgroup_size_NO_SHIFT_REG),
	.wg_dispatch_valid_out(iter_valid_in),
	.wg_dispatch_stall_in(iter_stall_out),
	.dispatched_all_groups(dispatched_all_groups),
	.kernel_copy_valid_out(valid_out),
	.kernel_copy_stall_in(stall_in),
	.pending_writes(has_a_write_pending),
	.finish(finish)
);

defparam kernel_finish_detector.NUM_COPIES = 1;
defparam kernel_finish_detector.WG_SIZE_W = 32;

assign stall_in = 1'b0;

// Creating ID iterator and kernel instance for every requested kernel copy

// ID iterator is responsible for iterating over all local ids for given work-groups
acl_id_iterator id_iter_inst0 (
	.clock(clock),
	.resetn(resetn),
	.start(start_out),
	.valid_in(iter_valid_in),
	.stall_out(iter_stall_out),
	.stall_in(stall_out),
	.valid_out(valid_in),
	.group_id_in(group_id_tmp),
	.global_id_base_in(global_id_base_out),
	.local_size(local_size_NO_SHIFT_REG),
	.global_size(global_size_NO_SHIFT_REG),
	.local_id(local_id[0]),
	.global_id(global_id[0]),
	.group_id(group_id[0])
);



// This section instantiates a kernel function block
fpgasort_function fpgasort_function_inst0 (
	.clock(clock),
	.resetn(resetn),
	.input_global_id_0(global_id[0][0]),
	.input_acl_hw_wg_id(),
	.stall_out(stall_out),
	.valid_in(valid_in),
	.output_0(),
	.valid_out(valid_out),
	.stall_in(stall_in),
	.workgroup_size(workgroup_size_NO_SHIFT_REG),
	.avm_local_bb2_ld__readdata(avm_local_bb2_ld__inst0_readdata),
	.avm_local_bb2_ld__readdatavalid(avm_local_bb2_ld__inst0_readdatavalid),
	.avm_local_bb2_ld__waitrequest(avm_local_bb2_ld__inst0_waitrequest),
	.avm_local_bb2_ld__address(avm_local_bb2_ld__inst0_address),
	.avm_local_bb2_ld__read(avm_local_bb2_ld__inst0_read),
	.avm_local_bb2_ld__write(avm_local_bb2_ld__inst0_write),
	.avm_local_bb2_ld__writeack(avm_local_bb2_ld__inst0_writeack),
	.avm_local_bb2_ld__writedata(avm_local_bb2_ld__inst0_writedata),
	.avm_local_bb2_ld__byteenable(avm_local_bb2_ld__inst0_byteenable),
	.avm_local_bb2_ld__burstcount(avm_local_bb2_ld__inst0_burstcount),
	.avm_local_bb3_ld__pre_pre_readdata(avm_local_bb3_ld__pre_pre_inst0_readdata),
	.avm_local_bb3_ld__pre_pre_readdatavalid(avm_local_bb3_ld__pre_pre_inst0_readdatavalid),
	.avm_local_bb3_ld__pre_pre_waitrequest(avm_local_bb3_ld__pre_pre_inst0_waitrequest),
	.avm_local_bb3_ld__pre_pre_address(avm_local_bb3_ld__pre_pre_inst0_address),
	.avm_local_bb3_ld__pre_pre_read(avm_local_bb3_ld__pre_pre_inst0_read),
	.avm_local_bb3_ld__pre_pre_write(avm_local_bb3_ld__pre_pre_inst0_write),
	.avm_local_bb3_ld__pre_pre_writeack(avm_local_bb3_ld__pre_pre_inst0_writeack),
	.avm_local_bb3_ld__pre_pre_writedata(avm_local_bb3_ld__pre_pre_inst0_writedata),
	.avm_local_bb3_ld__pre_pre_byteenable(avm_local_bb3_ld__pre_pre_inst0_byteenable),
	.avm_local_bb3_ld__pre_pre_burstcount(avm_local_bb3_ld__pre_pre_inst0_burstcount),
	.avm_local_bb5_st__pre_pre_readdata(avm_local_bb5_st__pre_pre_inst0_readdata),
	.avm_local_bb5_st__pre_pre_readdatavalid(avm_local_bb5_st__pre_pre_inst0_readdatavalid),
	.avm_local_bb5_st__pre_pre_waitrequest(avm_local_bb5_st__pre_pre_inst0_waitrequest),
	.avm_local_bb5_st__pre_pre_address(avm_local_bb5_st__pre_pre_inst0_address),
	.avm_local_bb5_st__pre_pre_read(avm_local_bb5_st__pre_pre_inst0_read),
	.avm_local_bb5_st__pre_pre_write(avm_local_bb5_st__pre_pre_inst0_write),
	.avm_local_bb5_st__pre_pre_writeack(avm_local_bb5_st__pre_pre_inst0_writeack),
	.avm_local_bb5_st__pre_pre_writedata(avm_local_bb5_st__pre_pre_inst0_writedata),
	.avm_local_bb5_st__pre_pre_byteenable(avm_local_bb5_st__pre_pre_inst0_byteenable),
	.avm_local_bb5_st__pre_pre_burstcount(avm_local_bb5_st__pre_pre_inst0_burstcount),
	.avm_local_bb6_ld__readdata(avm_local_bb6_ld__inst0_readdata),
	.avm_local_bb6_ld__readdatavalid(avm_local_bb6_ld__inst0_readdatavalid),
	.avm_local_bb6_ld__waitrequest(avm_local_bb6_ld__inst0_waitrequest),
	.avm_local_bb6_ld__address(avm_local_bb6_ld__inst0_address),
	.avm_local_bb6_ld__read(avm_local_bb6_ld__inst0_read),
	.avm_local_bb6_ld__write(avm_local_bb6_ld__inst0_write),
	.avm_local_bb6_ld__writeack(avm_local_bb6_ld__inst0_writeack),
	.avm_local_bb6_ld__writedata(avm_local_bb6_ld__inst0_writedata),
	.avm_local_bb6_ld__byteenable(avm_local_bb6_ld__inst0_byteenable),
	.avm_local_bb6_ld__burstcount(avm_local_bb6_ld__inst0_burstcount),
	.avm_local_bb6_st__readdata(avm_local_bb6_st__inst0_readdata),
	.avm_local_bb6_st__readdatavalid(avm_local_bb6_st__inst0_readdatavalid),
	.avm_local_bb6_st__waitrequest(avm_local_bb6_st__inst0_waitrequest),
	.avm_local_bb6_st__address(avm_local_bb6_st__inst0_address),
	.avm_local_bb6_st__read(avm_local_bb6_st__inst0_read),
	.avm_local_bb6_st__write(avm_local_bb6_st__inst0_write),
	.avm_local_bb6_st__writeack(avm_local_bb6_st__inst0_writeack),
	.avm_local_bb6_st__writedata(avm_local_bb6_st__inst0_writedata),
	.avm_local_bb6_st__byteenable(avm_local_bb6_st__inst0_byteenable),
	.avm_local_bb6_st__burstcount(avm_local_bb6_st__inst0_burstcount),
	.avm_local_bb8_st__readdata(avm_local_bb8_st__inst0_readdata),
	.avm_local_bb8_st__readdatavalid(avm_local_bb8_st__inst0_readdatavalid),
	.avm_local_bb8_st__waitrequest(avm_local_bb8_st__inst0_waitrequest),
	.avm_local_bb8_st__address(avm_local_bb8_st__inst0_address),
	.avm_local_bb8_st__read(avm_local_bb8_st__inst0_read),
	.avm_local_bb8_st__write(avm_local_bb8_st__inst0_write),
	.avm_local_bb8_st__writeack(avm_local_bb8_st__inst0_writeack),
	.avm_local_bb8_st__writedata(avm_local_bb8_st__inst0_writedata),
	.avm_local_bb8_st__byteenable(avm_local_bb8_st__inst0_byteenable),
	.avm_local_bb8_st__burstcount(avm_local_bb8_st__inst0_burstcount),
	.start(start_out),
	.input_subarr_size(kernel_arguments_NO_SHIFT_REG[191:160]),
	.input_num_of_elements(kernel_arguments_NO_SHIFT_REG[159:128]),
	.clock2x(clock2x),
	.input_data(kernel_arguments_NO_SHIFT_REG[63:0]),
	.input_temp(kernel_arguments_NO_SHIFT_REG[127:64]),
	.has_a_write_pending(has_a_write_pending),
	.has_a_lsu_active(has_a_lsu_active)
);



endmodule

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

module fpgasort_sys_cycle_time
	(
		input 		clock,
		input 		resetn,
		output [31:0] 		cur_cycle
	);


 reg [31:0] cur_count_NO_SHIFT_REG;

assign cur_cycle = cur_count_NO_SHIFT_REG;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		cur_count_NO_SHIFT_REG <= 32'h0;
	end
	else
	begin
		cur_count_NO_SHIFT_REG <= (cur_count_NO_SHIFT_REG + 32'h1);
	end
end

endmodule

