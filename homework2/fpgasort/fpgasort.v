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
		input [31:0] 		input_num_of_elements,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out,
		input 		stall_in,
		output [63:0] 		lvb_bb0_conv,
		output [63:0] 		lvb_bb0_conv1,
		output [63:0] 		lvb_bb0_add,
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
wire merge_node_stall_in_2;
 reg merge_node_valid_out_2_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_global_id_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_global_id_0_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG));
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
		merge_node_valid_out_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (~(merge_stalled_by_successors))
		begin
			merge_node_valid_out_0_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_1_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_2_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
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
wire local_bb0_conv_inputs_ready;
 reg local_bb0_conv_wii_reg_NO_SHIFT_REG;
 reg local_bb0_conv_valid_out_0_NO_SHIFT_REG;
wire local_bb0_conv_stall_in_0;
 reg local_bb0_conv_valid_out_1_NO_SHIFT_REG;
wire local_bb0_conv_stall_in_1;
wire local_bb0_conv_output_regs_ready;
 reg [63:0] local_bb0_conv_NO_SHIFT_REG;
wire local_bb0_conv_causedstall;

assign local_bb0_conv_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb0_conv_output_regs_ready = (~(local_bb0_conv_wii_reg_NO_SHIFT_REG) & ((~(local_bb0_conv_valid_out_0_NO_SHIFT_REG) | ~(local_bb0_conv_stall_in_0)) & (~(local_bb0_conv_valid_out_1_NO_SHIFT_REG) | ~(local_bb0_conv_stall_in_1))));
assign merge_node_stall_in_0 = (~(local_bb0_conv_wii_reg_NO_SHIFT_REG) & (~(local_bb0_conv_output_regs_ready) | ~(local_bb0_conv_inputs_ready)));
assign local_bb0_conv_causedstall = (local_bb0_conv_inputs_ready && (~(local_bb0_conv_output_regs_ready) && !(~(local_bb0_conv_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_conv_NO_SHIFT_REG <= 'x;
		local_bb0_conv_valid_out_0_NO_SHIFT_REG <= 1'b0;
		local_bb0_conv_valid_out_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_conv_NO_SHIFT_REG <= 'x;
			local_bb0_conv_valid_out_0_NO_SHIFT_REG <= 1'b0;
			local_bb0_conv_valid_out_1_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_conv_output_regs_ready)
			begin
				local_bb0_conv_NO_SHIFT_REG <= $signed(input_subarr_size);
				local_bb0_conv_valid_out_0_NO_SHIFT_REG <= local_bb0_conv_inputs_ready;
				local_bb0_conv_valid_out_1_NO_SHIFT_REG <= local_bb0_conv_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_conv_stall_in_0))
				begin
					local_bb0_conv_valid_out_0_NO_SHIFT_REG <= local_bb0_conv_wii_reg_NO_SHIFT_REG;
				end
				if (~(local_bb0_conv_stall_in_1))
				begin
					local_bb0_conv_valid_out_1_NO_SHIFT_REG <= local_bb0_conv_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_conv_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_conv_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_conv_inputs_ready)
			begin
				local_bb0_conv_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb0_conv1_inputs_ready;
 reg local_bb0_conv1_wii_reg_NO_SHIFT_REG;
 reg local_bb0_conv1_valid_out_NO_SHIFT_REG;
wire local_bb0_conv1_stall_in;
wire local_bb0_conv1_output_regs_ready;
 reg [63:0] local_bb0_conv1_NO_SHIFT_REG;
wire local_bb0_conv1_causedstall;

assign local_bb0_conv1_inputs_ready = merge_node_valid_out_1_NO_SHIFT_REG;
assign local_bb0_conv1_output_regs_ready = (~(local_bb0_conv1_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_conv1_valid_out_NO_SHIFT_REG) | ~(local_bb0_conv1_stall_in))));
assign merge_node_stall_in_1 = (~(local_bb0_conv1_wii_reg_NO_SHIFT_REG) & (~(local_bb0_conv1_output_regs_ready) | ~(local_bb0_conv1_inputs_ready)));
assign local_bb0_conv1_causedstall = (local_bb0_conv1_inputs_ready && (~(local_bb0_conv1_output_regs_ready) && !(~(local_bb0_conv1_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_conv1_NO_SHIFT_REG <= 'x;
		local_bb0_conv1_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_conv1_NO_SHIFT_REG <= 'x;
			local_bb0_conv1_valid_out_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_conv1_output_regs_ready)
			begin
				local_bb0_conv1_NO_SHIFT_REG <= $signed(input_num_of_elements);
				local_bb0_conv1_valid_out_NO_SHIFT_REG <= local_bb0_conv1_inputs_ready;
			end
			else
			begin
				if (~(local_bb0_conv1_stall_in))
				begin
					local_bb0_conv1_valid_out_NO_SHIFT_REG <= local_bb0_conv1_wii_reg_NO_SHIFT_REG;
				end
			end
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb0_conv1_wii_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (start)
		begin
			local_bb0_conv1_wii_reg_NO_SHIFT_REG <= 1'b0;
		end
		else
		begin
			if (local_bb0_conv1_inputs_ready)
			begin
				local_bb0_conv1_wii_reg_NO_SHIFT_REG <= 1'b1;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb0_add_inputs_ready;
 reg local_bb0_add_wii_reg_NO_SHIFT_REG;
 reg local_bb0_add_valid_out_NO_SHIFT_REG;
wire local_bb0_add_stall_in;
wire local_bb0_add_output_regs_ready;
 reg [63:0] local_bb0_add_NO_SHIFT_REG;
wire local_bb0_add_causedstall;

assign local_bb0_add_inputs_ready = local_bb0_conv_valid_out_0_NO_SHIFT_REG;
assign local_bb0_add_output_regs_ready = (~(local_bb0_add_wii_reg_NO_SHIFT_REG) & (&(~(local_bb0_add_valid_out_NO_SHIFT_REG) | ~(local_bb0_add_stall_in))));
assign local_bb0_conv_stall_in_0 = (~(local_bb0_add_wii_reg_NO_SHIFT_REG) & (~(local_bb0_add_output_regs_ready) | ~(local_bb0_add_inputs_ready)));
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
				local_bb0_add_NO_SHIFT_REG <= (local_bb0_conv_NO_SHIFT_REG + 64'hFFFFFFFFFFFFFFFF);
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
 reg [63:0] lvb_bb0_conv_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb0_conv1_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb0_add_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_global_id_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb0_add_valid_out_NO_SHIFT_REG & local_bb0_conv1_valid_out_NO_SHIFT_REG & merge_node_valid_out_2_NO_SHIFT_REG & local_bb0_conv_valid_out_1_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb0_add_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb0_conv1_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign merge_node_stall_in_2 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb0_conv_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb0_conv = lvb_bb0_conv_reg_NO_SHIFT_REG;
assign lvb_bb0_conv1 = lvb_bb0_conv1_reg_NO_SHIFT_REG;
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
		lvb_bb0_conv_reg_NO_SHIFT_REG <= 'x;
		lvb_bb0_conv1_reg_NO_SHIFT_REG <= 'x;
		lvb_bb0_add_reg_NO_SHIFT_REG <= 'x;
		lvb_input_global_id_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb0_conv_reg_NO_SHIFT_REG <= local_bb0_conv_NO_SHIFT_REG;
			lvb_bb0_conv1_reg_NO_SHIFT_REG <= local_bb0_conv1_NO_SHIFT_REG;
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
		input [63:0] 		input_wii_conv,
		input [63:0] 		input_wii_conv1,
		input [63:0] 		input_wii_add,
		input 		valid_in,
		output 		stall_out,
		input [31:0] 		input_global_id_0,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out,
		input 		stall_in,
		output [63:0] 		lvb_bb1_mul,
		output 		lvb_bb1_cmp,
		output [63:0] 		lvb_bb1_sub,
		output [63:0] 		lvb_bb1_div,
		output [63:0] 		lvb_bb1_add5,
		output 		lvb_bb1_var_,
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
wire local_bb1_result_i_valid_out;
wire local_bb1_result_i_stall_in;
wire local_bb1_result_i_inputs_ready;
wire local_bb1_result_i_stall_local;
wire [63:0] local_bb1_result_i;

assign local_bb1_result_i_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb1_result_i[63:32] = 32'h0;
assign local_bb1_result_i[31:0] = local_lvm_input_global_id_0_NO_SHIFT_REG;
assign local_bb1_result_i_valid_out = local_bb1_result_i_inputs_ready;
assign local_bb1_result_i_stall_local = local_bb1_result_i_stall_in;
assign merge_node_stall_in_0 = (|local_bb1_result_i_stall_local);

// Register node:
//  * latency = 5
//  * capacity = 5
 logic rnode_1to6_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to6_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to6_input_acl_hw_wg_id_0_reg_6_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_1to6_input_acl_hw_wg_id_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to6_input_acl_hw_wg_id_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to6_input_acl_hw_wg_id_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_1to6_input_acl_hw_wg_id_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_1to6_input_acl_hw_wg_id_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to6_input_acl_hw_wg_id_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo.DEPTH = 6;
defparam rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo.DATA_WIDTH = 32;
defparam rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to6_input_acl_hw_wg_id_0_reg_6_fifo.IMPL = "ll_reg";

assign rnode_1to6_input_acl_hw_wg_id_0_reg_6_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign merge_node_stall_in_1 = rnode_1to6_input_acl_hw_wg_id_0_stall_out_reg_6_NO_SHIFT_REG;
assign rnode_1to6_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to6_input_acl_hw_wg_id_0_reg_6_NO_SHIFT_REG;
assign rnode_1to6_input_acl_hw_wg_id_0_stall_in_reg_6_NO_SHIFT_REG = rnode_1to6_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to6_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to6_input_acl_hw_wg_id_0_valid_out_reg_6_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb1_mul_inputs_ready;
 reg local_bb1_mul_valid_out_0_NO_SHIFT_REG;
wire local_bb1_mul_stall_in_0;
 reg local_bb1_mul_valid_out_1_NO_SHIFT_REG;
wire local_bb1_mul_stall_in_1;
wire local_bb1_mul_output_regs_ready;
wire [63:0] local_bb1_mul;
 reg local_bb1_mul_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb1_mul_valid_pipe_1_NO_SHIFT_REG;
wire local_bb1_mul_causedstall;

acl_int_mult64s_s5 int_module_local_bb1_mul (
	.clock(clock),
	.dataa(local_bb1_result_i),
	.datab(input_wii_conv),
	.enable(local_bb1_mul_output_regs_ready),
	.result(local_bb1_mul)
);

defparam int_module_local_bb1_mul.INPUT1_WIDTH = 32;
defparam int_module_local_bb1_mul.INPUT2_WIDTH = 64;

assign local_bb1_mul_inputs_ready = local_bb1_result_i_valid_out;
assign local_bb1_mul_output_regs_ready = ((~(local_bb1_mul_valid_out_0_NO_SHIFT_REG) | ~(local_bb1_mul_stall_in_0)) & (~(local_bb1_mul_valid_out_1_NO_SHIFT_REG) | ~(local_bb1_mul_stall_in_1)));
assign local_bb1_result_i_stall_in = (~(local_bb1_mul_output_regs_ready) | ~(local_bb1_mul_inputs_ready));
assign local_bb1_mul_causedstall = (local_bb1_mul_inputs_ready && (~(local_bb1_mul_output_regs_ready) && !(~(local_bb1_mul_output_regs_ready))));

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
			local_bb1_mul_valid_pipe_0_NO_SHIFT_REG <= local_bb1_mul_inputs_ready;
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
			local_bb1_mul_valid_out_0_NO_SHIFT_REG <= local_bb1_mul_valid_pipe_1_NO_SHIFT_REG;
			local_bb1_mul_valid_out_1_NO_SHIFT_REG <= local_bb1_mul_valid_pipe_1_NO_SHIFT_REG;
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
wire [63:0] local_bb1_sub;

assign local_bb1_sub_inputs_ready = local_bb1_mul_valid_out_0_NO_SHIFT_REG;
assign local_bb1_sub = (input_wii_add + local_bb1_mul);
assign local_bb1_sub_valid_out = local_bb1_sub_inputs_ready;
assign local_bb1_sub_stall_local = local_bb1_sub_stall_in;
assign local_bb1_mul_stall_in_0 = (|local_bb1_sub_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb1_mul_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_mul_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_mul_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_mul_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_4to5_bb1_mul_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_mul_1_NO_SHIFT_REG;
 logic rnode_4to5_bb1_mul_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_4to5_bb1_mul_0_stall_in_2_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_mul_2_NO_SHIFT_REG;
 logic rnode_4to5_bb1_mul_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_mul_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_mul_0_valid_out_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_mul_0_stall_in_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_mul_0_stall_out_reg_5_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_mul_0_reg_5_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_4to5_bb1_mul_0_reg_5_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_4to5_bb1_mul_0_reg_5_NO_SHIFT_REG),
	.valid_in(rnode_4to5_bb1_mul_0_valid_out_0_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_mul_0_stall_in_0_reg_5_NO_SHIFT_REG),
	.data_out(rnode_4to5_bb1_mul_0_reg_5_NO_SHIFT_REG_fa),
	.valid_out({rnode_4to5_bb1_mul_0_valid_out_0_NO_SHIFT_REG, rnode_4to5_bb1_mul_0_valid_out_1_NO_SHIFT_REG, rnode_4to5_bb1_mul_0_valid_out_2_NO_SHIFT_REG}),
	.stall_in({rnode_4to5_bb1_mul_0_stall_in_0_NO_SHIFT_REG, rnode_4to5_bb1_mul_0_stall_in_1_NO_SHIFT_REG, rnode_4to5_bb1_mul_0_stall_in_2_NO_SHIFT_REG})
);

defparam rnode_4to5_bb1_mul_0_reg_5_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_4to5_bb1_mul_0_reg_5_fanout_adaptor.NUM_FANOUTS = 3;

acl_data_fifo rnode_4to5_bb1_mul_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb1_mul_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb1_mul_0_stall_in_0_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb1_mul_0_valid_out_0_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_mul_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_mul),
	.data_out(rnode_4to5_bb1_mul_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb1_mul_0_reg_5_fifo.DEPTH = 2;
defparam rnode_4to5_bb1_mul_0_reg_5_fifo.DATA_WIDTH = 64;
defparam rnode_4to5_bb1_mul_0_reg_5_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_4to5_bb1_mul_0_reg_5_fifo.IMPL = "ll_reg";

assign rnode_4to5_bb1_mul_0_reg_5_inputs_ready_NO_SHIFT_REG = local_bb1_mul_valid_out_1_NO_SHIFT_REG;
assign local_bb1_mul_stall_in_1 = rnode_4to5_bb1_mul_0_stall_out_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_mul_0_NO_SHIFT_REG = rnode_4to5_bb1_mul_0_reg_5_NO_SHIFT_REG_fa;
assign rnode_4to5_bb1_mul_1_NO_SHIFT_REG = rnode_4to5_bb1_mul_0_reg_5_NO_SHIFT_REG_fa;
assign rnode_4to5_bb1_mul_2_NO_SHIFT_REG = rnode_4to5_bb1_mul_0_reg_5_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_4to5_bb1_sub_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_sub_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_sub_0_NO_SHIFT_REG;
 logic rnode_4to5_bb1_sub_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_4to5_bb1_sub_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_sub_1_NO_SHIFT_REG;
 logic rnode_4to5_bb1_sub_0_reg_5_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_sub_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_sub_0_valid_out_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_sub_0_stall_in_0_reg_5_NO_SHIFT_REG;
 logic rnode_4to5_bb1_sub_0_stall_out_reg_5_NO_SHIFT_REG;
 logic [63:0] rnode_4to5_bb1_sub_0_reg_5_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_4to5_bb1_sub_0_reg_5_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_4to5_bb1_sub_0_reg_5_NO_SHIFT_REG),
	.valid_in(rnode_4to5_bb1_sub_0_valid_out_0_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_sub_0_stall_in_0_reg_5_NO_SHIFT_REG),
	.data_out(rnode_4to5_bb1_sub_0_reg_5_NO_SHIFT_REG_fa),
	.valid_out({rnode_4to5_bb1_sub_0_valid_out_0_NO_SHIFT_REG, rnode_4to5_bb1_sub_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_4to5_bb1_sub_0_stall_in_0_NO_SHIFT_REG, rnode_4to5_bb1_sub_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_4to5_bb1_sub_0_reg_5_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_4to5_bb1_sub_0_reg_5_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_4to5_bb1_sub_0_reg_5_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_4to5_bb1_sub_0_reg_5_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_4to5_bb1_sub_0_stall_in_0_reg_5_NO_SHIFT_REG),
	.valid_out(rnode_4to5_bb1_sub_0_valid_out_0_reg_5_NO_SHIFT_REG),
	.stall_out(rnode_4to5_bb1_sub_0_stall_out_reg_5_NO_SHIFT_REG),
	.data_in(local_bb1_sub),
	.data_out(rnode_4to5_bb1_sub_0_reg_5_NO_SHIFT_REG)
);

defparam rnode_4to5_bb1_sub_0_reg_5_fifo.DEPTH = 2;
defparam rnode_4to5_bb1_sub_0_reg_5_fifo.DATA_WIDTH = 64;
defparam rnode_4to5_bb1_sub_0_reg_5_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_4to5_bb1_sub_0_reg_5_fifo.IMPL = "ll_reg";

assign rnode_4to5_bb1_sub_0_reg_5_inputs_ready_NO_SHIFT_REG = local_bb1_sub_valid_out;
assign local_bb1_sub_stall_in = rnode_4to5_bb1_sub_0_stall_out_reg_5_NO_SHIFT_REG;
assign rnode_4to5_bb1_sub_0_NO_SHIFT_REG = rnode_4to5_bb1_sub_0_reg_5_NO_SHIFT_REG_fa;
assign rnode_4to5_bb1_sub_1_NO_SHIFT_REG = rnode_4to5_bb1_sub_0_reg_5_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb1_cmp_valid_out;
wire local_bb1_cmp_stall_in;
wire local_bb1_cmp_inputs_ready;
wire local_bb1_cmp_stall_local;
wire local_bb1_cmp;

assign local_bb1_cmp_inputs_ready = rnode_4to5_bb1_mul_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_cmp = (rnode_4to5_bb1_mul_0_NO_SHIFT_REG < input_wii_conv1);
assign local_bb1_cmp_valid_out = local_bb1_cmp_inputs_ready;
assign local_bb1_cmp_stall_local = local_bb1_cmp_stall_in;
assign rnode_4to5_bb1_mul_0_stall_in_0_NO_SHIFT_REG = (|local_bb1_cmp_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb1_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_mul_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_mul_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_mul_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb1_mul_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb1_mul_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb1_mul_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb1_mul_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb1_mul_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_4to5_bb1_mul_2_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb1_mul_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb1_mul_0_reg_6_fifo.DEPTH = 2;
defparam rnode_5to6_bb1_mul_0_reg_6_fifo.DATA_WIDTH = 64;
defparam rnode_5to6_bb1_mul_0_reg_6_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_5to6_bb1_mul_0_reg_6_fifo.IMPL = "ll_reg";

assign rnode_5to6_bb1_mul_0_reg_6_inputs_ready_NO_SHIFT_REG = rnode_4to5_bb1_mul_0_valid_out_2_NO_SHIFT_REG;
assign rnode_4to5_bb1_mul_0_stall_in_2_NO_SHIFT_REG = rnode_5to6_bb1_mul_0_stall_out_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_mul_0_NO_SHIFT_REG = rnode_5to6_bb1_mul_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_mul_0_stall_in_reg_6_NO_SHIFT_REG = rnode_5to6_bb1_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_5to6_bb1_mul_0_valid_out_NO_SHIFT_REG = rnode_5to6_bb1_mul_0_valid_out_reg_6_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb1_add4_stall_local;
wire [63:0] local_bb1_add4;

assign local_bb1_add4 = (rnode_4to5_bb1_sub_0_NO_SHIFT_REG + rnode_4to5_bb1_mul_1_NO_SHIFT_REG);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb1_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_sub_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_sub_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_valid_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_stall_in_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_sub_0_stall_out_reg_6_NO_SHIFT_REG;

acl_data_fifo rnode_5to6_bb1_sub_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb1_sub_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb1_sub_0_stall_in_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb1_sub_0_valid_out_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb1_sub_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(rnode_4to5_bb1_sub_1_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb1_sub_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb1_sub_0_reg_6_fifo.DEPTH = 2;
defparam rnode_5to6_bb1_sub_0_reg_6_fifo.DATA_WIDTH = 64;
defparam rnode_5to6_bb1_sub_0_reg_6_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_5to6_bb1_sub_0_reg_6_fifo.IMPL = "ll_reg";

assign rnode_5to6_bb1_sub_0_reg_6_inputs_ready_NO_SHIFT_REG = rnode_4to5_bb1_sub_0_valid_out_1_NO_SHIFT_REG;
assign rnode_4to5_bb1_sub_0_stall_in_1_NO_SHIFT_REG = rnode_5to6_bb1_sub_0_stall_out_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_sub_0_NO_SHIFT_REG = rnode_5to6_bb1_sub_0_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_sub_0_stall_in_reg_6_NO_SHIFT_REG = rnode_5to6_bb1_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_5to6_bb1_sub_0_valid_out_NO_SHIFT_REG = rnode_5to6_bb1_sub_0_valid_out_reg_6_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb1_cmp_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_1_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_valid_out_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_stall_in_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_stall_out_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_cmp_0_reg_6_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_5to6_bb1_cmp_0_reg_6_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_5to6_bb1_cmp_0_reg_6_NO_SHIFT_REG),
	.valid_in(rnode_5to6_bb1_cmp_0_valid_out_0_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb1_cmp_0_stall_in_0_reg_6_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb1_cmp_0_reg_6_NO_SHIFT_REG_fa),
	.valid_out({rnode_5to6_bb1_cmp_0_valid_out_0_NO_SHIFT_REG, rnode_5to6_bb1_cmp_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_5to6_bb1_cmp_0_stall_in_0_NO_SHIFT_REG, rnode_5to6_bb1_cmp_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_5to6_bb1_cmp_0_reg_6_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_5to6_bb1_cmp_0_reg_6_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_5to6_bb1_cmp_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb1_cmp_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb1_cmp_0_stall_in_0_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb1_cmp_0_valid_out_0_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb1_cmp_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(local_bb1_cmp),
	.data_out(rnode_5to6_bb1_cmp_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb1_cmp_0_reg_6_fifo.DEPTH = 2;
defparam rnode_5to6_bb1_cmp_0_reg_6_fifo.DATA_WIDTH = 1;
defparam rnode_5to6_bb1_cmp_0_reg_6_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_5to6_bb1_cmp_0_reg_6_fifo.IMPL = "ll_reg";

assign rnode_5to6_bb1_cmp_0_reg_6_inputs_ready_NO_SHIFT_REG = local_bb1_cmp_valid_out;
assign local_bb1_cmp_stall_in = rnode_5to6_bb1_cmp_0_stall_out_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_cmp_0_NO_SHIFT_REG = rnode_5to6_bb1_cmp_0_reg_6_NO_SHIFT_REG_fa;
assign rnode_5to6_bb1_cmp_1_NO_SHIFT_REG = rnode_5to6_bb1_cmp_0_reg_6_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb1_div_valid_out;
wire local_bb1_div_stall_in;
wire local_bb1_div_inputs_ready;
wire local_bb1_div_stall_local;
wire [63:0] local_bb1_div;

assign local_bb1_div_inputs_ready = (rnode_4to5_bb1_mul_0_valid_out_1_NO_SHIFT_REG & rnode_4to5_bb1_sub_0_valid_out_0_NO_SHIFT_REG);
assign local_bb1_div = (local_bb1_add4 >> 64'h1);
assign local_bb1_div_valid_out = local_bb1_div_inputs_ready;
assign local_bb1_div_stall_local = local_bb1_div_stall_in;
assign rnode_4to5_bb1_mul_0_stall_in_1_NO_SHIFT_REG = (local_bb1_div_stall_local | ~(local_bb1_div_inputs_ready));
assign rnode_4to5_bb1_sub_0_stall_in_0_NO_SHIFT_REG = (local_bb1_div_stall_local | ~(local_bb1_div_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb1_var__valid_out;
wire local_bb1_var__stall_in;
wire local_bb1_var__inputs_ready;
wire local_bb1_var__stall_local;
wire local_bb1_var_;

assign local_bb1_var__inputs_ready = rnode_5to6_bb1_cmp_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_var_ = (rnode_5to6_bb1_cmp_0_NO_SHIFT_REG ^ 1'b1);
assign local_bb1_var__valid_out = local_bb1_var__inputs_ready;
assign local_bb1_var__stall_local = local_bb1_var__stall_in;
assign rnode_5to6_bb1_cmp_0_stall_in_0_NO_SHIFT_REG = (|local_bb1_var__stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_5to6_bb1_div_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_div_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_div_0_NO_SHIFT_REG;
 logic rnode_5to6_bb1_div_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_5to6_bb1_div_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_div_1_NO_SHIFT_REG;
 logic rnode_5to6_bb1_div_0_reg_6_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_div_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_div_0_valid_out_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_div_0_stall_in_0_reg_6_NO_SHIFT_REG;
 logic rnode_5to6_bb1_div_0_stall_out_reg_6_NO_SHIFT_REG;
 logic [63:0] rnode_5to6_bb1_div_0_reg_6_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_5to6_bb1_div_0_reg_6_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_5to6_bb1_div_0_reg_6_NO_SHIFT_REG),
	.valid_in(rnode_5to6_bb1_div_0_valid_out_0_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb1_div_0_stall_in_0_reg_6_NO_SHIFT_REG),
	.data_out(rnode_5to6_bb1_div_0_reg_6_NO_SHIFT_REG_fa),
	.valid_out({rnode_5to6_bb1_div_0_valid_out_0_NO_SHIFT_REG, rnode_5to6_bb1_div_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_5to6_bb1_div_0_stall_in_0_NO_SHIFT_REG, rnode_5to6_bb1_div_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_5to6_bb1_div_0_reg_6_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_5to6_bb1_div_0_reg_6_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_5to6_bb1_div_0_reg_6_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_5to6_bb1_div_0_reg_6_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_5to6_bb1_div_0_stall_in_0_reg_6_NO_SHIFT_REG),
	.valid_out(rnode_5to6_bb1_div_0_valid_out_0_reg_6_NO_SHIFT_REG),
	.stall_out(rnode_5to6_bb1_div_0_stall_out_reg_6_NO_SHIFT_REG),
	.data_in(local_bb1_div),
	.data_out(rnode_5to6_bb1_div_0_reg_6_NO_SHIFT_REG)
);

defparam rnode_5to6_bb1_div_0_reg_6_fifo.DEPTH = 2;
defparam rnode_5to6_bb1_div_0_reg_6_fifo.DATA_WIDTH = 64;
defparam rnode_5to6_bb1_div_0_reg_6_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_5to6_bb1_div_0_reg_6_fifo.IMPL = "ll_reg";

assign rnode_5to6_bb1_div_0_reg_6_inputs_ready_NO_SHIFT_REG = local_bb1_div_valid_out;
assign local_bb1_div_stall_in = rnode_5to6_bb1_div_0_stall_out_reg_6_NO_SHIFT_REG;
assign rnode_5to6_bb1_div_0_NO_SHIFT_REG = rnode_5to6_bb1_div_0_reg_6_NO_SHIFT_REG_fa;
assign rnode_5to6_bb1_div_1_NO_SHIFT_REG = rnode_5to6_bb1_div_0_reg_6_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb1_add5_valid_out;
wire local_bb1_add5_stall_in;
wire local_bb1_add5_inputs_ready;
wire local_bb1_add5_stall_local;
wire [63:0] local_bb1_add5;

assign local_bb1_add5_inputs_ready = rnode_5to6_bb1_div_0_valid_out_0_NO_SHIFT_REG;
assign local_bb1_add5 = (rnode_5to6_bb1_div_0_NO_SHIFT_REG + 64'h1);
assign local_bb1_add5_valid_out = local_bb1_add5_inputs_ready;
assign local_bb1_add5_stall_local = local_bb1_add5_stall_in;
assign rnode_5to6_bb1_div_0_stall_in_0_NO_SHIFT_REG = (|local_bb1_add5_stall_local);

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [63:0] lvb_bb1_mul_reg_NO_SHIFT_REG;
 reg lvb_bb1_cmp_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb1_sub_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb1_div_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb1_add5_reg_NO_SHIFT_REG;
 reg lvb_bb1_var__reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb1_var__valid_out & local_bb1_add5_valid_out & rnode_5to6_bb1_cmp_0_valid_out_1_NO_SHIFT_REG & rnode_5to6_bb1_div_0_valid_out_1_NO_SHIFT_REG & rnode_1to6_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rnode_5to6_bb1_mul_0_valid_out_NO_SHIFT_REG & rnode_5to6_bb1_sub_0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb1_var__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb1_add5_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_5to6_bb1_cmp_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_5to6_bb1_div_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to6_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_5to6_bb1_mul_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_5to6_bb1_sub_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_bb1_mul = lvb_bb1_mul_reg_NO_SHIFT_REG;
assign lvb_bb1_cmp = lvb_bb1_cmp_reg_NO_SHIFT_REG;
assign lvb_bb1_sub = lvb_bb1_sub_reg_NO_SHIFT_REG;
assign lvb_bb1_div = lvb_bb1_div_reg_NO_SHIFT_REG;
assign lvb_bb1_add5 = lvb_bb1_add5_reg_NO_SHIFT_REG;
assign lvb_bb1_var_ = lvb_bb1_var__reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_bb1_mul_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_cmp_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_sub_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_div_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_add5_reg_NO_SHIFT_REG <= 'x;
		lvb_bb1_var__reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_bb1_mul_reg_NO_SHIFT_REG <= rnode_5to6_bb1_mul_0_NO_SHIFT_REG;
			lvb_bb1_cmp_reg_NO_SHIFT_REG <= rnode_5to6_bb1_cmp_1_NO_SHIFT_REG;
			lvb_bb1_sub_reg_NO_SHIFT_REG <= rnode_5to6_bb1_sub_0_NO_SHIFT_REG;
			lvb_bb1_div_reg_NO_SHIFT_REG <= rnode_5to6_bb1_div_1_NO_SHIFT_REG;
			lvb_bb1_add5_reg_NO_SHIFT_REG <= local_bb1_add5;
			lvb_bb1_var__reg_NO_SHIFT_REG <= local_bb1_var_;
			lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= rnode_1to6_input_acl_hw_wg_id_0_NO_SHIFT_REG;
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
		input [63:0] 		input_mul_0,
		input 		input_cmp_0,
		input [63:0] 		input_sub_0,
		input [63:0] 		input_div_0,
		input 		input_var__0,
		input [63:0] 		input_left_lower_0_ph_0,
		input [63:0] 		input_right_lower_0_ph_0,
		input [63:0] 		input_temp_index_0_ph_0,
		input [31:0] 		input_acl_hw_wg_id_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [63:0] 		input_mul_1,
		input 		input_cmp_1,
		input [63:0] 		input_sub_1,
		input [63:0] 		input_div_1,
		input 		input_var__1,
		input [63:0] 		input_left_lower_0_ph_1,
		input [63:0] 		input_right_lower_0_ph_1,
		input [63:0] 		input_temp_index_0_ph_1,
		input [31:0] 		input_acl_hw_wg_id_1,
		output 		valid_out,
		input 		stall_in,
		output [63:0] 		lvb_mul,
		output 		lvb_cmp,
		output [63:0] 		lvb_sub,
		output [63:0] 		lvb_div,
		output 		lvb_var_,
		output [63:0] 		lvb_left_lower_0_ph,
		output [63:0] 		lvb_right_lower_0_ph,
		output [63:0] 		lvb_temp_index_0_ph,
		output 		lvb_bb2_cmp6,
		output [63:0] 		lvb_bb2_arrayidx24,
		output 		lvb_bb2_not_cmp6,
		output 		lvb_bb2_var_,
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
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_mul_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_div_0_staging_reg_NO_SHIFT_REG;
 reg input_var__0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_right_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_temp_index_0_ph_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] local_lvm_mul_NO_SHIFT_REG;
 reg local_lvm_cmp_NO_SHIFT_REG;
 reg [63:0] local_lvm_sub_NO_SHIFT_REG;
 reg [63:0] local_lvm_div_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg [63:0] local_lvm_left_lower_0_ph_NO_SHIFT_REG;
 reg [63:0] local_lvm_right_lower_0_ph_NO_SHIFT_REG;
 reg [63:0] local_lvm_temp_index_0_ph_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_mul_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_div_1_staging_reg_NO_SHIFT_REG;
 reg input_var__1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_right_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_temp_index_0_ph_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG) | (merge_node_stall_in_9 & merge_node_valid_out_9_NO_SHIFT_REG) | (merge_node_stall_in_10 & merge_node_valid_out_10_NO_SHIFT_REG));
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
		input_mul_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_sub_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_div_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_mul_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_sub_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_div_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_mul_0_staging_reg_NO_SHIFT_REG <= input_mul_0;
				input_cmp_0_staging_reg_NO_SHIFT_REG <= input_cmp_0;
				input_sub_0_staging_reg_NO_SHIFT_REG <= input_sub_0;
				input_div_0_staging_reg_NO_SHIFT_REG <= input_div_0;
				input_var__0_staging_reg_NO_SHIFT_REG <= input_var__0;
				input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= input_left_lower_0_ph_0;
				input_right_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph_0;
				input_temp_index_0_ph_0_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph_0;
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
				input_mul_1_staging_reg_NO_SHIFT_REG <= input_mul_1;
				input_cmp_1_staging_reg_NO_SHIFT_REG <= input_cmp_1;
				input_sub_1_staging_reg_NO_SHIFT_REG <= input_sub_1;
				input_div_1_staging_reg_NO_SHIFT_REG <= input_div_1;
				input_var__1_staging_reg_NO_SHIFT_REG <= input_var__1;
				input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= input_left_lower_0_ph_1;
				input_right_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph_1;
				input_temp_index_0_ph_1_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph_1;
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
					local_lvm_mul_NO_SHIFT_REG <= input_mul_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_0_staging_reg_NO_SHIFT_REG;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_0_staging_reg_NO_SHIFT_REG;
					local_lvm_div_NO_SHIFT_REG <= input_div_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__0_staging_reg_NO_SHIFT_REG;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph_NO_SHIFT_REG <= input_right_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph_NO_SHIFT_REG <= input_temp_index_0_ph_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul_0;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_0;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_0;
					local_lvm_div_NO_SHIFT_REG <= input_div_0;
					local_lvm_var__NO_SHIFT_REG <= input_var__0;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_0;
					local_lvm_right_lower_0_ph_NO_SHIFT_REG <= input_right_lower_0_ph_0;
					local_lvm_temp_index_0_ph_NO_SHIFT_REG <= input_temp_index_0_ph_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_1_staging_reg_NO_SHIFT_REG;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_1_staging_reg_NO_SHIFT_REG;
					local_lvm_div_NO_SHIFT_REG <= input_div_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__1_staging_reg_NO_SHIFT_REG;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph_NO_SHIFT_REG <= input_right_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph_NO_SHIFT_REG <= input_temp_index_0_ph_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul_1;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_1;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_1;
					local_lvm_div_NO_SHIFT_REG <= input_div_1;
					local_lvm_var__NO_SHIFT_REG <= input_var__1;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_1;
					local_lvm_right_lower_0_ph_NO_SHIFT_REG <= input_right_lower_0_ph_1;
					local_lvm_temp_index_0_ph_NO_SHIFT_REG <= input_temp_index_0_ph_1;
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
wire local_bb2_cmp6_valid_out;
wire local_bb2_cmp6_stall_in;
wire local_bb2_cmp6_inputs_ready;
wire local_bb2_cmp6_stall_local;
wire local_bb2_cmp6;

assign local_bb2_cmp6_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb2_cmp6 = (local_lvm_left_lower_0_ph_NO_SHIFT_REG > local_lvm_div_NO_SHIFT_REG);
assign local_bb2_cmp6_valid_out = local_bb2_cmp6_inputs_ready;
assign local_bb2_cmp6_stall_local = local_bb2_cmp6_stall_in;
assign merge_node_stall_in_0 = (|local_bb2_cmp6_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb2_arrayidx24_valid_out;
wire local_bb2_arrayidx24_stall_in;
wire local_bb2_arrayidx24_inputs_ready;
wire local_bb2_arrayidx24_stall_local;
wire [63:0] local_bb2_arrayidx24;

assign local_bb2_arrayidx24_inputs_ready = merge_node_valid_out_1_NO_SHIFT_REG;
assign local_bb2_arrayidx24 = (input_data + (local_lvm_left_lower_0_ph_NO_SHIFT_REG << 6'h2));
assign local_bb2_arrayidx24_valid_out = local_bb2_arrayidx24_inputs_ready;
assign local_bb2_arrayidx24_stall_local = local_bb2_arrayidx24_stall_in;
assign merge_node_stall_in_1 = (|local_bb2_arrayidx24_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_var__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_var__0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_var__0_NO_SHIFT_REG;
 logic rnode_1to2_var__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_var__0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_var__1_NO_SHIFT_REG;
 logic rnode_1to2_var__0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_var__0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_var__0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_var__0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_var__0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_var__0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_var__0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_var__0_valid_out_0_NO_SHIFT_REG, rnode_1to2_var__0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_var__0_stall_in_0_NO_SHIFT_REG, rnode_1to2_var__0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_var__0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_var__0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_var__0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_var__0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_var__0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_var__0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_var__0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_var__NO_SHIFT_REG),
	.data_out(rnode_1to2_var__0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_var__0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_var__0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_var__0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_var__0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_var__0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to2_var__0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_var__0_NO_SHIFT_REG = rnode_1to2_var__0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_var__1_NO_SHIFT_REG = rnode_1to2_var__0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_mul_0_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_mul_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_mul_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_mul_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_mul_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_mul_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_mul_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_mul_NO_SHIFT_REG),
	.data_out(rnode_1to2_mul_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_mul_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_mul_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_mul_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_mul_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_mul_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to2_mul_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_mul_0_NO_SHIFT_REG = rnode_1to2_mul_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_mul_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_mul_0_valid_out_NO_SHIFT_REG = rnode_1to2_mul_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_cmp_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_cmp_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to2_cmp_0_NO_SHIFT_REG;
 logic rnode_1to2_cmp_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_cmp_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_cmp_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_cmp_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_cmp_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_cmp_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_cmp_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_cmp_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_cmp_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_cmp_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_cmp_NO_SHIFT_REG),
	.data_out(rnode_1to2_cmp_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_cmp_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_cmp_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_cmp_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_cmp_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_cmp_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to2_cmp_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_cmp_0_NO_SHIFT_REG = rnode_1to2_cmp_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_cmp_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_cmp_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_cmp_0_valid_out_NO_SHIFT_REG = rnode_1to2_cmp_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_sub_0_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_sub_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_sub_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_sub_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_sub_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_sub_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_sub_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_sub_NO_SHIFT_REG),
	.data_out(rnode_1to2_sub_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_sub_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_sub_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_sub_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_sub_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_sub_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to2_sub_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_sub_0_NO_SHIFT_REG = rnode_1to2_sub_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_sub_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_sub_0_valid_out_NO_SHIFT_REG = rnode_1to2_sub_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_div_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_div_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_div_0_NO_SHIFT_REG;
 logic rnode_1to2_div_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_div_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_div_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_div_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_div_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_div_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_div_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_div_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_div_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_div_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_div_NO_SHIFT_REG),
	.data_out(rnode_1to2_div_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_div_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_div_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_div_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_div_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_div_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to2_div_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_div_0_NO_SHIFT_REG = rnode_1to2_div_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_div_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_div_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_div_0_valid_out_NO_SHIFT_REG = rnode_1to2_div_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_left_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_1to2_left_lower_0_ph_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_left_lower_0_ph_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_left_lower_0_ph_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_left_lower_0_ph_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_left_lower_0_ph_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_left_lower_0_ph_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_left_lower_0_ph_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_left_lower_0_ph_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_left_lower_0_ph_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_left_lower_0_ph_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_left_lower_0_ph_NO_SHIFT_REG),
	.data_out(rnode_1to2_left_lower_0_ph_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_left_lower_0_ph_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_left_lower_0_ph_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_left_lower_0_ph_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_left_lower_0_ph_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_left_lower_0_ph_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to2_left_lower_0_ph_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_left_lower_0_ph_0_NO_SHIFT_REG = rnode_1to2_left_lower_0_ph_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_left_lower_0_ph_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_left_lower_0_ph_0_valid_out_NO_SHIFT_REG = rnode_1to2_left_lower_0_ph_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_right_lower_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_right_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_right_lower_0_ph_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_right_lower_0_ph_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_right_lower_0_ph_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_right_lower_0_ph_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_right_lower_0_ph_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_right_lower_0_ph_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_right_lower_0_ph_NO_SHIFT_REG),
	.data_out(rnode_1to2_right_lower_0_ph_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_right_lower_0_ph_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_right_lower_0_ph_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_right_lower_0_ph_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_right_lower_0_ph_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_right_lower_0_ph_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to2_right_lower_0_ph_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_right_lower_0_ph_0_NO_SHIFT_REG = rnode_1to2_right_lower_0_ph_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_right_lower_0_ph_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_right_lower_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_right_lower_0_ph_0_valid_out_NO_SHIFT_REG = rnode_1to2_right_lower_0_ph_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_temp_index_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_temp_index_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_temp_index_0_ph_0_NO_SHIFT_REG;
 logic rnode_1to2_temp_index_0_ph_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_temp_index_0_ph_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_temp_index_0_ph_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_temp_index_0_ph_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_temp_index_0_ph_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_temp_index_0_ph_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_temp_index_0_ph_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_temp_index_0_ph_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_temp_index_0_ph_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_temp_index_0_ph_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_temp_index_0_ph_NO_SHIFT_REG),
	.data_out(rnode_1to2_temp_index_0_ph_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_temp_index_0_ph_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_temp_index_0_ph_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_temp_index_0_ph_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_temp_index_0_ph_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_temp_index_0_ph_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_9_NO_SHIFT_REG;
assign merge_node_stall_in_9 = rnode_1to2_temp_index_0_ph_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_temp_index_0_ph_0_NO_SHIFT_REG = rnode_1to2_temp_index_0_ph_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_temp_index_0_ph_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_temp_index_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_temp_index_0_ph_0_valid_out_NO_SHIFT_REG = rnode_1to2_temp_index_0_ph_0_valid_out_reg_2_NO_SHIFT_REG;

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

assign rnode_1to2_input_acl_hw_wg_id_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_10_NO_SHIFT_REG;
assign merge_node_stall_in_10 = rnode_1to2_input_acl_hw_wg_id_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to2_input_acl_hw_wg_id_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_input_acl_hw_wg_id_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to2_input_acl_hw_wg_id_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_cmp6_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_1_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_cmp6_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_bb2_cmp6_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_bb2_cmp6_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_bb2_cmp6_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_cmp6_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_bb2_cmp6_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_bb2_cmp6_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_bb2_cmp6_0_valid_out_1_NO_SHIFT_REG, rnode_1to2_bb2_cmp6_0_valid_out_2_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_bb2_cmp6_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_bb2_cmp6_0_stall_in_1_NO_SHIFT_REG, rnode_1to2_bb2_cmp6_0_stall_in_2_NO_SHIFT_REG})
);

defparam rnode_1to2_bb2_cmp6_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_bb2_cmp6_0_reg_2_fanout_adaptor.NUM_FANOUTS = 3;

acl_data_fifo rnode_1to2_bb2_cmp6_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_cmp6_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_cmp6_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_cmp6_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_cmp6_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_cmp6),
	.data_out(rnode_1to2_bb2_cmp6_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_cmp6_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb2_cmp6_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb2_cmp6_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb2_cmp6_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb2_cmp6_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb2_cmp6_valid_out;
assign local_bb2_cmp6_stall_in = rnode_1to2_bb2_cmp6_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_cmp6_0_NO_SHIFT_REG = rnode_1to2_bb2_cmp6_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_bb2_cmp6_1_NO_SHIFT_REG = rnode_1to2_bb2_cmp6_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_bb2_cmp6_2_NO_SHIFT_REG = rnode_1to2_bb2_cmp6_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb2_arrayidx24_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb2_arrayidx24_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_bb2_arrayidx24_0_NO_SHIFT_REG;
 logic rnode_1to2_bb2_arrayidx24_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_bb2_arrayidx24_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_arrayidx24_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_arrayidx24_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb2_arrayidx24_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb2_arrayidx24_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb2_arrayidx24_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb2_arrayidx24_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb2_arrayidx24_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb2_arrayidx24_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb2_arrayidx24),
	.data_out(rnode_1to2_bb2_arrayidx24_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb2_arrayidx24_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb2_arrayidx24_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_bb2_arrayidx24_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb2_arrayidx24_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb2_arrayidx24_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb2_arrayidx24_valid_out;
assign local_bb2_arrayidx24_stall_in = rnode_1to2_bb2_arrayidx24_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_arrayidx24_0_NO_SHIFT_REG = rnode_1to2_bb2_arrayidx24_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb2_arrayidx24_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_bb2_arrayidx24_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_bb2_arrayidx24_0_valid_out_NO_SHIFT_REG = rnode_1to2_bb2_arrayidx24_0_valid_out_reg_2_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb2_not_cmp6_stall_local;
wire local_bb2_not_cmp6;

assign local_bb2_not_cmp6 = (rnode_1to2_bb2_cmp6_0_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb2_var__valid_out;
wire local_bb2_var__stall_in;
 reg local_bb2_var__consumed_0_NO_SHIFT_REG;
wire local_bb2_not_cmp6_valid_out;
wire local_bb2_not_cmp6_stall_in;
 reg local_bb2_not_cmp6_consumed_0_NO_SHIFT_REG;
wire local_bb2_var__inputs_ready;
wire local_bb2_var__stall_local;
wire local_bb2_var_;

assign local_bb2_var__inputs_ready = (rnode_1to2_bb2_cmp6_0_valid_out_1_NO_SHIFT_REG & rnode_1to2_var__0_valid_out_0_NO_SHIFT_REG & rnode_1to2_bb2_cmp6_0_valid_out_0_NO_SHIFT_REG);
assign local_bb2_var_ = (rnode_1to2_bb2_cmp6_1_NO_SHIFT_REG | rnode_1to2_var__0_NO_SHIFT_REG);
assign local_bb2_var__stall_local = ((local_bb2_var__stall_in & ~(local_bb2_var__consumed_0_NO_SHIFT_REG)) | (local_bb2_not_cmp6_stall_in & ~(local_bb2_not_cmp6_consumed_0_NO_SHIFT_REG)));
assign local_bb2_var__valid_out = (local_bb2_var__inputs_ready & ~(local_bb2_var__consumed_0_NO_SHIFT_REG));
assign local_bb2_not_cmp6_valid_out = (local_bb2_var__inputs_ready & ~(local_bb2_not_cmp6_consumed_0_NO_SHIFT_REG));
assign rnode_1to2_bb2_cmp6_0_stall_in_1_NO_SHIFT_REG = (local_bb2_var__stall_local | ~(local_bb2_var__inputs_ready));
assign rnode_1to2_var__0_stall_in_0_NO_SHIFT_REG = (local_bb2_var__stall_local | ~(local_bb2_var__inputs_ready));
assign rnode_1to2_bb2_cmp6_0_stall_in_0_NO_SHIFT_REG = (local_bb2_var__stall_local | ~(local_bb2_var__inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb2_var__consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb2_not_cmp6_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb2_var__consumed_0_NO_SHIFT_REG <= (local_bb2_var__inputs_ready & (local_bb2_var__consumed_0_NO_SHIFT_REG | ~(local_bb2_var__stall_in)) & local_bb2_var__stall_local);
		local_bb2_not_cmp6_consumed_0_NO_SHIFT_REG <= (local_bb2_var__inputs_ready & (local_bb2_not_cmp6_consumed_0_NO_SHIFT_REG | ~(local_bb2_not_cmp6_stall_in)) & local_bb2_var__stall_local);
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [63:0] lvb_mul_reg_NO_SHIFT_REG;
 reg lvb_cmp_reg_NO_SHIFT_REG;
 reg [63:0] lvb_sub_reg_NO_SHIFT_REG;
 reg [63:0] lvb_div_reg_NO_SHIFT_REG;
 reg lvb_var__reg_NO_SHIFT_REG;
 reg [63:0] lvb_left_lower_0_ph_reg_NO_SHIFT_REG;
 reg [63:0] lvb_right_lower_0_ph_reg_NO_SHIFT_REG;
 reg [63:0] lvb_temp_index_0_ph_reg_NO_SHIFT_REG;
 reg lvb_bb2_cmp6_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb2_arrayidx24_reg_NO_SHIFT_REG;
 reg lvb_bb2_not_cmp6_reg_NO_SHIFT_REG;
 reg lvb_bb2_var__reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb2_var__valid_out & local_bb2_not_cmp6_valid_out & rnode_1to2_mul_0_valid_out_NO_SHIFT_REG & rnode_1to2_cmp_0_valid_out_NO_SHIFT_REG & rnode_1to2_sub_0_valid_out_NO_SHIFT_REG & rnode_1to2_div_0_valid_out_NO_SHIFT_REG & rnode_1to2_var__0_valid_out_1_NO_SHIFT_REG & rnode_1to2_left_lower_0_ph_0_valid_out_NO_SHIFT_REG & rnode_1to2_right_lower_0_ph_0_valid_out_NO_SHIFT_REG & rnode_1to2_temp_index_0_ph_0_valid_out_NO_SHIFT_REG & rnode_1to2_bb2_cmp6_0_valid_out_2_NO_SHIFT_REG & rnode_1to2_bb2_arrayidx24_0_valid_out_NO_SHIFT_REG & rnode_1to2_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb2_var__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb2_not_cmp6_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_mul_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_cmp_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_sub_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_div_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_var__0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_left_lower_0_ph_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_right_lower_0_ph_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_temp_index_0_ph_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_bb2_cmp6_0_stall_in_2_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_bb2_arrayidx24_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_mul = lvb_mul_reg_NO_SHIFT_REG;
assign lvb_cmp = lvb_cmp_reg_NO_SHIFT_REG;
assign lvb_sub = lvb_sub_reg_NO_SHIFT_REG;
assign lvb_div = lvb_div_reg_NO_SHIFT_REG;
assign lvb_var_ = lvb_var__reg_NO_SHIFT_REG;
assign lvb_left_lower_0_ph = lvb_left_lower_0_ph_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph = lvb_right_lower_0_ph_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph = lvb_temp_index_0_ph_reg_NO_SHIFT_REG;
assign lvb_bb2_cmp6 = lvb_bb2_cmp6_reg_NO_SHIFT_REG;
assign lvb_bb2_arrayidx24 = lvb_bb2_arrayidx24_reg_NO_SHIFT_REG;
assign lvb_bb2_not_cmp6 = lvb_bb2_not_cmp6_reg_NO_SHIFT_REG;
assign lvb_bb2_var_ = lvb_bb2_var__reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_mul_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp_reg_NO_SHIFT_REG <= 'x;
		lvb_sub_reg_NO_SHIFT_REG <= 'x;
		lvb_div_reg_NO_SHIFT_REG <= 'x;
		lvb_var__reg_NO_SHIFT_REG <= 'x;
		lvb_left_lower_0_ph_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph_reg_NO_SHIFT_REG <= 'x;
		lvb_temp_index_0_ph_reg_NO_SHIFT_REG <= 'x;
		lvb_bb2_cmp6_reg_NO_SHIFT_REG <= 'x;
		lvb_bb2_arrayidx24_reg_NO_SHIFT_REG <= 'x;
		lvb_bb2_not_cmp6_reg_NO_SHIFT_REG <= 'x;
		lvb_bb2_var__reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_mul_reg_NO_SHIFT_REG <= rnode_1to2_mul_0_NO_SHIFT_REG;
			lvb_cmp_reg_NO_SHIFT_REG <= rnode_1to2_cmp_0_NO_SHIFT_REG;
			lvb_sub_reg_NO_SHIFT_REG <= rnode_1to2_sub_0_NO_SHIFT_REG;
			lvb_div_reg_NO_SHIFT_REG <= rnode_1to2_div_0_NO_SHIFT_REG;
			lvb_var__reg_NO_SHIFT_REG <= rnode_1to2_var__1_NO_SHIFT_REG;
			lvb_left_lower_0_ph_reg_NO_SHIFT_REG <= rnode_1to2_left_lower_0_ph_0_NO_SHIFT_REG;
			lvb_right_lower_0_ph_reg_NO_SHIFT_REG <= rnode_1to2_right_lower_0_ph_0_NO_SHIFT_REG;
			lvb_temp_index_0_ph_reg_NO_SHIFT_REG <= rnode_1to2_temp_index_0_ph_0_NO_SHIFT_REG;
			lvb_bb2_cmp6_reg_NO_SHIFT_REG <= rnode_1to2_bb2_cmp6_2_NO_SHIFT_REG;
			lvb_bb2_arrayidx24_reg_NO_SHIFT_REG <= rnode_1to2_bb2_arrayidx24_0_NO_SHIFT_REG;
			lvb_bb2_not_cmp6_reg_NO_SHIFT_REG <= local_bb2_not_cmp6;
			lvb_bb2_var__reg_NO_SHIFT_REG <= local_bb2_var_;
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

module fpgasort_basic_block_3
	(
		input 		clock,
		input 		resetn,
		input [63:0] 		input_data,
		input 		valid_in_0,
		output 		stall_out_0,
		input [63:0] 		input_mul_0,
		input 		input_cmp_0,
		input [63:0] 		input_sub_0,
		input [63:0] 		input_div_0,
		input 		input_var__0,
		input [63:0] 		input_left_lower_0_ph_0,
		input 		input_cmp6_0,
		input [63:0] 		input_arrayidx24_0,
		input 		input_not_cmp6_0,
		input 		input_var__u0_0,
		input [63:0] 		input_right_lower_0_ph6_0,
		input [63:0] 		input_temp_index_0_ph7_0,
		input [31:0] 		input_acl_hw_wg_id_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [63:0] 		input_mul_1,
		input 		input_cmp_1,
		input [63:0] 		input_sub_1,
		input [63:0] 		input_div_1,
		input 		input_var__1,
		input [63:0] 		input_left_lower_0_ph_1,
		input 		input_cmp6_1,
		input [63:0] 		input_arrayidx24_1,
		input 		input_not_cmp6_1,
		input 		input_var__u0_1,
		input [63:0] 		input_right_lower_0_ph6_1,
		input [63:0] 		input_temp_index_0_ph7_1,
		input [31:0] 		input_acl_hw_wg_id_1,
		output 		valid_out,
		input 		stall_in,
		output [63:0] 		lvb_mul,
		output 		lvb_cmp,
		output [63:0] 		lvb_sub,
		output [63:0] 		lvb_div,
		output 		lvb_var_,
		output [63:0] 		lvb_left_lower_0_ph,
		output 		lvb_cmp6,
		output [63:0] 		lvb_arrayidx24,
		output 		lvb_not_cmp6,
		output 		lvb_var__u0,
		output [63:0] 		lvb_right_lower_0_ph6,
		output [63:0] 		lvb_temp_index_0_ph7,
		output 		lvb_bb3_cmp8,
		output 		lvb_bb3_or_cond,
		output [63:0] 		lvb_bb3_arrayidx23,
		output 		lvb_bb3_var_,
		output 		lvb_bb3_var__u1,
		output [31:0] 		lvb_bb3_ld_,
		output [31:0] 		lvb_bb3_ld__u2,
		output 		lvb_bb3_cmp25,
		output 		lvb_bb3_var__u3,
		output 		lvb_bb3_var__u4,
		output [31:0] 		lvb_input_acl_hw_wg_id,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb3_ld__u2_readdata,
		input 		avm_local_bb3_ld__u2_readdatavalid,
		input 		avm_local_bb3_ld__u2_waitrequest,
		output [29:0] 		avm_local_bb3_ld__u2_address,
		output 		avm_local_bb3_ld__u2_read,
		output 		avm_local_bb3_ld__u2_write,
		input 		avm_local_bb3_ld__u2_writeack,
		output [255:0] 		avm_local_bb3_ld__u2_writedata,
		output [31:0] 		avm_local_bb3_ld__u2_byteenable,
		output [4:0] 		avm_local_bb3_ld__u2_burstcount,
		output 		local_bb3_ld__u2_active,
		input 		clock2x,
		input [255:0] 		avm_local_bb3_ld__readdata,
		input 		avm_local_bb3_ld__readdatavalid,
		input 		avm_local_bb3_ld__waitrequest,
		output [29:0] 		avm_local_bb3_ld__address,
		output 		avm_local_bb3_ld__read,
		output 		avm_local_bb3_ld__write,
		input 		avm_local_bb3_ld__writeack,
		output [255:0] 		avm_local_bb3_ld__writedata,
		output [31:0] 		avm_local_bb3_ld__byteenable,
		output [4:0] 		avm_local_bb3_ld__burstcount,
		output 		local_bb3_ld__active
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
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_mul_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_div_0_staging_reg_NO_SHIFT_REG;
 reg input_var__0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp6_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx24_0_staging_reg_NO_SHIFT_REG;
 reg input_not_cmp6_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u0_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_right_lower_0_ph6_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_temp_index_0_ph7_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] local_lvm_mul_NO_SHIFT_REG;
 reg local_lvm_cmp_NO_SHIFT_REG;
 reg [63:0] local_lvm_sub_NO_SHIFT_REG;
 reg [63:0] local_lvm_div_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg [63:0] local_lvm_left_lower_0_ph_NO_SHIFT_REG;
 reg local_lvm_cmp6_NO_SHIFT_REG;
 reg [63:0] local_lvm_arrayidx24_NO_SHIFT_REG;
 reg local_lvm_not_cmp6_NO_SHIFT_REG;
 reg local_lvm_var__u0_NO_SHIFT_REG;
 reg [63:0] local_lvm_right_lower_0_ph6_NO_SHIFT_REG;
 reg [63:0] local_lvm_temp_index_0_ph7_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_mul_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_div_1_staging_reg_NO_SHIFT_REG;
 reg input_var__1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp6_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx24_1_staging_reg_NO_SHIFT_REG;
 reg input_not_cmp6_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u0_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_right_lower_0_ph6_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_temp_index_0_ph7_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG) | (merge_node_stall_in_9 & merge_node_valid_out_9_NO_SHIFT_REG) | (merge_node_stall_in_10 & merge_node_valid_out_10_NO_SHIFT_REG) | (merge_node_stall_in_11 & merge_node_valid_out_11_NO_SHIFT_REG) | (merge_node_stall_in_12 & merge_node_valid_out_12_NO_SHIFT_REG) | (merge_node_stall_in_13 & merge_node_valid_out_13_NO_SHIFT_REG) | (merge_node_stall_in_14 & merge_node_valid_out_14_NO_SHIFT_REG));
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
		input_mul_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_sub_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_div_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx24_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_not_cmp6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u0_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_mul_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_sub_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_div_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx24_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_not_cmp6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u0_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_mul_0_staging_reg_NO_SHIFT_REG <= input_mul_0;
				input_cmp_0_staging_reg_NO_SHIFT_REG <= input_cmp_0;
				input_sub_0_staging_reg_NO_SHIFT_REG <= input_sub_0;
				input_div_0_staging_reg_NO_SHIFT_REG <= input_div_0;
				input_var__0_staging_reg_NO_SHIFT_REG <= input_var__0;
				input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= input_left_lower_0_ph_0;
				input_cmp6_0_staging_reg_NO_SHIFT_REG <= input_cmp6_0;
				input_arrayidx24_0_staging_reg_NO_SHIFT_REG <= input_arrayidx24_0;
				input_not_cmp6_0_staging_reg_NO_SHIFT_REG <= input_not_cmp6_0;
				input_var__u0_0_staging_reg_NO_SHIFT_REG <= input_var__u0_0;
				input_right_lower_0_ph6_0_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph6_0;
				input_temp_index_0_ph7_0_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph7_0;
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
				input_mul_1_staging_reg_NO_SHIFT_REG <= input_mul_1;
				input_cmp_1_staging_reg_NO_SHIFT_REG <= input_cmp_1;
				input_sub_1_staging_reg_NO_SHIFT_REG <= input_sub_1;
				input_div_1_staging_reg_NO_SHIFT_REG <= input_div_1;
				input_var__1_staging_reg_NO_SHIFT_REG <= input_var__1;
				input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= input_left_lower_0_ph_1;
				input_cmp6_1_staging_reg_NO_SHIFT_REG <= input_cmp6_1;
				input_arrayidx24_1_staging_reg_NO_SHIFT_REG <= input_arrayidx24_1;
				input_not_cmp6_1_staging_reg_NO_SHIFT_REG <= input_not_cmp6_1;
				input_var__u0_1_staging_reg_NO_SHIFT_REG <= input_var__u0_1;
				input_right_lower_0_ph6_1_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph6_1;
				input_temp_index_0_ph7_1_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph7_1;
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
					local_lvm_mul_NO_SHIFT_REG <= input_mul_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_0_staging_reg_NO_SHIFT_REG;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_0_staging_reg_NO_SHIFT_REG;
					local_lvm_div_NO_SHIFT_REG <= input_div_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__0_staging_reg_NO_SHIFT_REG;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_0_staging_reg_NO_SHIFT_REG;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u0_NO_SHIFT_REG <= input_var__u0_0_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul_0;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_0;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_0;
					local_lvm_div_NO_SHIFT_REG <= input_div_0;
					local_lvm_var__NO_SHIFT_REG <= input_var__0;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_0;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6_0;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_0;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6_0;
					local_lvm_var__u0_NO_SHIFT_REG <= input_var__u0_0;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_0;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_1_staging_reg_NO_SHIFT_REG;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_1_staging_reg_NO_SHIFT_REG;
					local_lvm_div_NO_SHIFT_REG <= input_div_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__1_staging_reg_NO_SHIFT_REG;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_1_staging_reg_NO_SHIFT_REG;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u0_NO_SHIFT_REG <= input_var__u0_1_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul_1;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_1;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_1;
					local_lvm_div_NO_SHIFT_REG <= input_div_1;
					local_lvm_var__NO_SHIFT_REG <= input_var__1;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_1;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6_1;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_1;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6_1;
					local_lvm_var__u0_NO_SHIFT_REG <= input_var__u0_1;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_1;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7_1;
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
wire local_bb3_cmp8_valid_out;
wire local_bb3_cmp8_stall_in;
wire local_bb3_cmp8_inputs_ready;
wire local_bb3_cmp8_stall_local;
wire local_bb3_cmp8;

assign local_bb3_cmp8_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb3_cmp8 = (local_lvm_right_lower_0_ph6_NO_SHIFT_REG > local_lvm_sub_NO_SHIFT_REG);
assign local_bb3_cmp8_valid_out = local_bb3_cmp8_inputs_ready;
assign local_bb3_cmp8_stall_local = local_bb3_cmp8_stall_in;
assign merge_node_stall_in_0 = (|local_bb3_cmp8_stall_local);

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_cmp6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_cmp6_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to164_cmp6_0_NO_SHIFT_REG;
 logic rnode_1to164_cmp6_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to164_cmp6_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp6_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp6_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp6_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_cmp6_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_cmp6_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_cmp6_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_cmp6_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_cmp6_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_cmp6_NO_SHIFT_REG),
	.data_out(rnode_1to164_cmp6_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_cmp6_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_cmp6_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_1to164_cmp6_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_cmp6_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_cmp6_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign merge_node_stall_in_1 = rnode_1to164_cmp6_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_cmp6_0_NO_SHIFT_REG = rnode_1to164_cmp6_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_cmp6_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_cmp6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_cmp6_0_valid_out_NO_SHIFT_REG = rnode_1to164_cmp6_0_valid_out_reg_164_NO_SHIFT_REG;

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

assign rnode_1to2_input_data_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to2_input_data_0_stall_out_reg_2_NO_SHIFT_REG;
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

assign rnode_1to164_var__0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to164_var__0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_var__0_NO_SHIFT_REG = rnode_1to164_var__0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_var__0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_var__0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_var__0_valid_out_NO_SHIFT_REG = rnode_1to164_var__0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_mul_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_mul_0_NO_SHIFT_REG;
 logic rnode_1to164_mul_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_mul_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_mul_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_mul_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_mul_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_mul_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_mul_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_mul_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_mul_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_mul_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_mul_NO_SHIFT_REG),
	.data_out(rnode_1to164_mul_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_mul_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_mul_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_1to164_mul_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_mul_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_mul_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to164_mul_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_mul_0_NO_SHIFT_REG = rnode_1to164_mul_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_mul_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_mul_0_valid_out_NO_SHIFT_REG = rnode_1to164_mul_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_cmp_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_cmp_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to164_cmp_0_NO_SHIFT_REG;
 logic rnode_1to164_cmp_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to164_cmp_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_cmp_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_cmp_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_cmp_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_cmp_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_cmp_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_cmp_NO_SHIFT_REG),
	.data_out(rnode_1to164_cmp_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_cmp_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_cmp_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_1to164_cmp_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_cmp_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_cmp_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to164_cmp_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_cmp_0_NO_SHIFT_REG = rnode_1to164_cmp_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_cmp_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_cmp_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_cmp_0_valid_out_NO_SHIFT_REG = rnode_1to164_cmp_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_sub_0_NO_SHIFT_REG;
 logic rnode_1to164_sub_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_sub_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_sub_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_sub_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_sub_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_sub_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_sub_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_sub_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_sub_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_sub_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_sub_NO_SHIFT_REG),
	.data_out(rnode_1to164_sub_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_sub_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_sub_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_1to164_sub_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_sub_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_sub_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to164_sub_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_sub_0_NO_SHIFT_REG = rnode_1to164_sub_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_sub_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_sub_0_valid_out_NO_SHIFT_REG = rnode_1to164_sub_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_div_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_div_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_div_0_NO_SHIFT_REG;
 logic rnode_1to164_div_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_div_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_div_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_div_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_div_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_div_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_div_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_div_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_div_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_div_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_div_NO_SHIFT_REG),
	.data_out(rnode_1to164_div_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_div_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_div_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_1to164_div_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_div_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_div_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to164_div_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_div_0_NO_SHIFT_REG = rnode_1to164_div_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_div_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_div_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_div_0_valid_out_NO_SHIFT_REG = rnode_1to164_div_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_left_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_1to164_left_lower_0_ph_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_left_lower_0_ph_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_left_lower_0_ph_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_left_lower_0_ph_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_left_lower_0_ph_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_left_lower_0_ph_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_left_lower_0_ph_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_left_lower_0_ph_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_left_lower_0_ph_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_left_lower_0_ph_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_left_lower_0_ph_NO_SHIFT_REG),
	.data_out(rnode_1to164_left_lower_0_ph_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_left_lower_0_ph_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_left_lower_0_ph_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_1to164_left_lower_0_ph_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_left_lower_0_ph_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_left_lower_0_ph_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to164_left_lower_0_ph_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_left_lower_0_ph_0_NO_SHIFT_REG = rnode_1to164_left_lower_0_ph_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_left_lower_0_ph_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_left_lower_0_ph_0_valid_out_NO_SHIFT_REG = rnode_1to164_left_lower_0_ph_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_not_cmp6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_not_cmp6_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to164_not_cmp6_0_NO_SHIFT_REG;
 logic rnode_1to164_not_cmp6_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to164_not_cmp6_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_not_cmp6_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_not_cmp6_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_not_cmp6_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_not_cmp6_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_not_cmp6_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_not_cmp6_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_not_cmp6_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_not_cmp6_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_not_cmp6_NO_SHIFT_REG),
	.data_out(rnode_1to164_not_cmp6_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_not_cmp6_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_not_cmp6_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_1to164_not_cmp6_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_not_cmp6_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_not_cmp6_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_9_NO_SHIFT_REG;
assign merge_node_stall_in_9 = rnode_1to164_not_cmp6_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_not_cmp6_0_NO_SHIFT_REG = rnode_1to164_not_cmp6_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_not_cmp6_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_not_cmp6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_not_cmp6_0_valid_out_NO_SHIFT_REG = rnode_1to164_not_cmp6_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 163
//  * capacity = 163
 logic rnode_1to164_temp_index_0_ph7_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph7_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_temp_index_0_ph7_0_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph7_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to164_temp_index_0_ph7_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph7_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph7_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_temp_index_0_ph7_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_temp_index_0_ph7_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_temp_index_0_ph7_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_temp_index_0_ph7_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_temp_index_0_ph7_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_temp_index_0_ph7_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_temp_index_0_ph7_NO_SHIFT_REG),
	.data_out(rnode_1to164_temp_index_0_ph7_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_temp_index_0_ph7_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_temp_index_0_ph7_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_1to164_temp_index_0_ph7_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_temp_index_0_ph7_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_temp_index_0_ph7_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_10_NO_SHIFT_REG;
assign merge_node_stall_in_10 = rnode_1to164_temp_index_0_ph7_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_temp_index_0_ph7_0_NO_SHIFT_REG = rnode_1to164_temp_index_0_ph7_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_temp_index_0_ph7_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_temp_index_0_ph7_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_temp_index_0_ph7_0_valid_out_NO_SHIFT_REG = rnode_1to164_temp_index_0_ph7_0_valid_out_reg_164_NO_SHIFT_REG;

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

assign rnode_1to164_input_acl_hw_wg_id_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_11_NO_SHIFT_REG;
assign merge_node_stall_in_11 = rnode_1to164_input_acl_hw_wg_id_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to164_input_acl_hw_wg_id_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_right_lower_0_ph6_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph6_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_right_lower_0_ph6_0_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph6_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph6_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_right_lower_0_ph6_1_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph6_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_right_lower_0_ph6_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph6_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph6_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_right_lower_0_ph6_0_stall_out_reg_2_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_right_lower_0_ph6_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_right_lower_0_ph6_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_right_lower_0_ph6_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_right_lower_0_ph6_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_right_lower_0_ph6_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_right_lower_0_ph6_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_right_lower_0_ph6_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_right_lower_0_ph6_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_right_lower_0_ph6_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_right_lower_0_ph6_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_right_lower_0_ph6_0_reg_2_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_1to2_right_lower_0_ph6_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_right_lower_0_ph6_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_right_lower_0_ph6_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_right_lower_0_ph6_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_right_lower_0_ph6_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_right_lower_0_ph6_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_right_lower_0_ph6_NO_SHIFT_REG),
	.data_out(rnode_1to2_right_lower_0_ph6_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_right_lower_0_ph6_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_right_lower_0_ph6_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_right_lower_0_ph6_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_right_lower_0_ph6_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_right_lower_0_ph6_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_12_NO_SHIFT_REG;
assign merge_node_stall_in_12 = rnode_1to2_right_lower_0_ph6_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_right_lower_0_ph6_0_NO_SHIFT_REG = rnode_1to2_right_lower_0_ph6_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_right_lower_0_ph6_1_NO_SHIFT_REG = rnode_1to2_right_lower_0_ph6_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_var__u0_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_1_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__u0_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_var__u0_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_var__u0_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_var__u0_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_var__u0_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_var__u0_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_var__u0_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_var__u0_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_var__u0_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_var__u0_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_var__u0_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_var__u0_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_var__u0_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_var__u0_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_var__u0_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_var__u0_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_var__u0_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_var__u0_NO_SHIFT_REG),
	.data_out(rnode_1to2_var__u0_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_var__u0_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_var__u0_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_var__u0_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_var__u0_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_var__u0_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_13_NO_SHIFT_REG;
assign merge_node_stall_in_13 = rnode_1to2_var__u0_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_var__u0_0_NO_SHIFT_REG = rnode_1to2_var__u0_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_var__u0_1_NO_SHIFT_REG = rnode_1to2_var__u0_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_arrayidx24_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_arrayidx24_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_arrayidx24_0_NO_SHIFT_REG;
 logic rnode_1to2_arrayidx24_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_arrayidx24_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_arrayidx24_1_NO_SHIFT_REG;
 logic rnode_1to2_arrayidx24_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_arrayidx24_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_arrayidx24_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_arrayidx24_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_arrayidx24_0_stall_out_reg_2_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_arrayidx24_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_arrayidx24_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_arrayidx24_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_arrayidx24_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_arrayidx24_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_arrayidx24_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_arrayidx24_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_arrayidx24_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_arrayidx24_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_arrayidx24_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_arrayidx24_0_reg_2_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_1to2_arrayidx24_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_arrayidx24_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_arrayidx24_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_arrayidx24_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_arrayidx24_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_arrayidx24_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_arrayidx24_NO_SHIFT_REG),
	.data_out(rnode_1to2_arrayidx24_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_arrayidx24_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_arrayidx24_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_arrayidx24_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_arrayidx24_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_arrayidx24_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_14_NO_SHIFT_REG;
assign merge_node_stall_in_14 = rnode_1to2_arrayidx24_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_arrayidx24_0_NO_SHIFT_REG = rnode_1to2_arrayidx24_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_arrayidx24_1_NO_SHIFT_REG = rnode_1to2_arrayidx24_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb3_cmp8_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_1_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb3_cmp8_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_bb3_cmp8_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_bb3_cmp8_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_bb3_cmp8_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb3_cmp8_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_bb3_cmp8_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_bb3_cmp8_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_bb3_cmp8_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_bb3_cmp8_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_bb3_cmp8_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_bb3_cmp8_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_bb3_cmp8_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_bb3_cmp8_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb3_cmp8_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb3_cmp8_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb3_cmp8_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb3_cmp8_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb3_cmp8),
	.data_out(rnode_1to2_bb3_cmp8_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb3_cmp8_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb3_cmp8_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb3_cmp8_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb3_cmp8_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb3_cmp8_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb3_cmp8_valid_out;
assign local_bb3_cmp8_stall_in = rnode_1to2_bb3_cmp8_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb3_cmp8_0_NO_SHIFT_REG = rnode_1to2_bb3_cmp8_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_bb3_cmp8_1_NO_SHIFT_REG = rnode_1to2_bb3_cmp8_0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_cmp6_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_1_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_stall_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp6_0_reg_165_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_164to165_cmp6_0_reg_165_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_164to165_cmp6_0_reg_165_NO_SHIFT_REG),
	.valid_in(rnode_164to165_cmp6_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_cmp6_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.data_out(rnode_164to165_cmp6_0_reg_165_NO_SHIFT_REG_fa),
	.valid_out({rnode_164to165_cmp6_0_valid_out_0_NO_SHIFT_REG, rnode_164to165_cmp6_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_164to165_cmp6_0_stall_in_0_NO_SHIFT_REG, rnode_164to165_cmp6_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_164to165_cmp6_0_reg_165_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_164to165_cmp6_0_reg_165_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_164to165_cmp6_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_cmp6_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_cmp6_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_cmp6_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_cmp6_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_cmp6_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_cmp6_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_cmp6_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_cmp6_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_cmp6_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_cmp6_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_cmp6_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_cmp6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_cmp6_0_stall_in_NO_SHIFT_REG = rnode_164to165_cmp6_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_cmp6_0_NO_SHIFT_REG = rnode_164to165_cmp6_0_reg_165_NO_SHIFT_REG_fa;
assign rnode_164to165_cmp6_1_NO_SHIFT_REG = rnode_164to165_cmp6_0_reg_165_NO_SHIFT_REG_fa;

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
 logic rnode_164to165_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_mul_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_mul_0_NO_SHIFT_REG;
 logic rnode_164to165_mul_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_mul_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_mul_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_mul_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_mul_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_mul_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_mul_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_mul_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_mul_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_mul_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_mul_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_mul_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_mul_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_mul_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_mul_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_mul_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_mul_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_mul_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_mul_0_stall_in_NO_SHIFT_REG = rnode_164to165_mul_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_mul_0_NO_SHIFT_REG = rnode_164to165_mul_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_mul_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_mul_0_valid_out_NO_SHIFT_REG = rnode_164to165_mul_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_cmp_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_cmp_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_cmp_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_cmp_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_cmp_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_cmp_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_cmp_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_cmp_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_cmp_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_cmp_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_cmp_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_cmp_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_cmp_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_cmp_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_cmp_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_cmp_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_cmp_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_cmp_0_stall_in_NO_SHIFT_REG = rnode_164to165_cmp_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_cmp_0_NO_SHIFT_REG = rnode_164to165_cmp_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_cmp_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_cmp_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_cmp_0_valid_out_NO_SHIFT_REG = rnode_164to165_cmp_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_sub_0_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_sub_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_sub_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_sub_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_sub_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_sub_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_sub_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_sub_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_sub_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_sub_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_sub_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_sub_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_sub_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_sub_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_sub_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_sub_0_stall_in_NO_SHIFT_REG = rnode_164to165_sub_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_sub_0_NO_SHIFT_REG = rnode_164to165_sub_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_sub_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_sub_0_valid_out_NO_SHIFT_REG = rnode_164to165_sub_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_div_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_div_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_div_0_NO_SHIFT_REG;
 logic rnode_164to165_div_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_div_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_div_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_div_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_div_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_div_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_div_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_div_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_div_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_div_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_div_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_div_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_div_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_div_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_div_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_div_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_div_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_div_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_div_0_stall_in_NO_SHIFT_REG = rnode_164to165_div_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_div_0_NO_SHIFT_REG = rnode_164to165_div_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_div_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_div_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_div_0_valid_out_NO_SHIFT_REG = rnode_164to165_div_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_left_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_164to165_left_lower_0_ph_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_left_lower_0_ph_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_left_lower_0_ph_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_left_lower_0_ph_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_left_lower_0_ph_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_left_lower_0_ph_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_left_lower_0_ph_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_left_lower_0_ph_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_left_lower_0_ph_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_left_lower_0_ph_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_left_lower_0_ph_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_left_lower_0_ph_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_left_lower_0_ph_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_left_lower_0_ph_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_left_lower_0_ph_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_left_lower_0_ph_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_left_lower_0_ph_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_left_lower_0_ph_0_stall_in_NO_SHIFT_REG = rnode_164to165_left_lower_0_ph_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_left_lower_0_ph_0_NO_SHIFT_REG = rnode_164to165_left_lower_0_ph_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_left_lower_0_ph_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_left_lower_0_ph_0_valid_out_NO_SHIFT_REG = rnode_164to165_left_lower_0_ph_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_not_cmp6_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_not_cmp6_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_not_cmp6_0_NO_SHIFT_REG;
 logic rnode_164to165_not_cmp6_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_not_cmp6_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_not_cmp6_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_not_cmp6_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_not_cmp6_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_not_cmp6_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_not_cmp6_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_not_cmp6_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_not_cmp6_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_not_cmp6_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_not_cmp6_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_not_cmp6_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_not_cmp6_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_not_cmp6_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_not_cmp6_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_not_cmp6_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_not_cmp6_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_not_cmp6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_not_cmp6_0_stall_in_NO_SHIFT_REG = rnode_164to165_not_cmp6_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_not_cmp6_0_NO_SHIFT_REG = rnode_164to165_not_cmp6_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_not_cmp6_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_not_cmp6_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_not_cmp6_0_valid_out_NO_SHIFT_REG = rnode_164to165_not_cmp6_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_temp_index_0_ph7_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph7_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_temp_index_0_ph7_0_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph7_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_temp_index_0_ph7_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph7_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph7_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_temp_index_0_ph7_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_temp_index_0_ph7_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_temp_index_0_ph7_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_temp_index_0_ph7_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_temp_index_0_ph7_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_temp_index_0_ph7_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_temp_index_0_ph7_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_temp_index_0_ph7_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_temp_index_0_ph7_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_temp_index_0_ph7_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_temp_index_0_ph7_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_temp_index_0_ph7_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_temp_index_0_ph7_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_temp_index_0_ph7_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_temp_index_0_ph7_0_stall_in_NO_SHIFT_REG = rnode_164to165_temp_index_0_ph7_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_temp_index_0_ph7_0_NO_SHIFT_REG = rnode_164to165_temp_index_0_ph7_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_temp_index_0_ph7_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_temp_index_0_ph7_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_temp_index_0_ph7_0_valid_out_NO_SHIFT_REG = rnode_164to165_temp_index_0_ph7_0_valid_out_reg_165_NO_SHIFT_REG;

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

// This section implements an unregistered operation.
// 
wire local_bb3_arrayidx23_valid_out;
wire local_bb3_arrayidx23_stall_in;
wire local_bb3_arrayidx23_inputs_ready;
wire local_bb3_arrayidx23_stall_local;
wire [63:0] local_bb3_arrayidx23;

assign local_bb3_arrayidx23_inputs_ready = (rnode_1to2_input_data_0_valid_out_NO_SHIFT_REG & rnode_1to2_right_lower_0_ph6_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3_arrayidx23 = (input_data + (rnode_1to2_right_lower_0_ph6_0_NO_SHIFT_REG << 6'h2));
assign local_bb3_arrayidx23_valid_out = local_bb3_arrayidx23_inputs_ready;
assign local_bb3_arrayidx23_stall_local = local_bb3_arrayidx23_stall_in;
assign rnode_1to2_input_data_0_stall_in_NO_SHIFT_REG = (local_bb3_arrayidx23_stall_local | ~(local_bb3_arrayidx23_inputs_ready));
assign rnode_1to2_right_lower_0_ph6_0_stall_in_0_NO_SHIFT_REG = (local_bb3_arrayidx23_stall_local | ~(local_bb3_arrayidx23_inputs_ready));

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_2to164_right_lower_0_ph6_0_NO_SHIFT_REG;
 logic rnode_2to164_right_lower_0_ph6_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_2to164_right_lower_0_ph6_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_right_lower_0_ph6_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_right_lower_0_ph6_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_right_lower_0_ph6_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_right_lower_0_ph6_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_right_lower_0_ph6_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_right_lower_0_ph6_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_right_lower_0_ph6_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_right_lower_0_ph6_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rnode_1to2_right_lower_0_ph6_1_NO_SHIFT_REG),
	.data_out(rnode_2to164_right_lower_0_ph6_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_right_lower_0_ph6_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_right_lower_0_ph6_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_2to164_right_lower_0_ph6_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_right_lower_0_ph6_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_right_lower_0_ph6_0_reg_164_inputs_ready_NO_SHIFT_REG = rnode_1to2_right_lower_0_ph6_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_right_lower_0_ph6_0_stall_in_1_NO_SHIFT_REG = rnode_2to164_right_lower_0_ph6_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_right_lower_0_ph6_0_NO_SHIFT_REG = rnode_2to164_right_lower_0_ph6_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_right_lower_0_ph6_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG = rnode_2to164_right_lower_0_ph6_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_var__u0_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_var__u0_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to164_var__u0_0_NO_SHIFT_REG;
 logic rnode_2to164_var__u0_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to164_var__u0_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_var__u0_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_var__u0_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_var__u0_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_var__u0_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_var__u0_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_var__u0_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_var__u0_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_var__u0_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rnode_1to2_var__u0_1_NO_SHIFT_REG),
	.data_out(rnode_2to164_var__u0_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_var__u0_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_var__u0_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_2to164_var__u0_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_var__u0_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_var__u0_0_reg_164_inputs_ready_NO_SHIFT_REG = rnode_1to2_var__u0_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_var__u0_0_stall_in_1_NO_SHIFT_REG = rnode_2to164_var__u0_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_var__u0_0_NO_SHIFT_REG = rnode_2to164_var__u0_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_var__u0_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_var__u0_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_var__u0_0_valid_out_NO_SHIFT_REG = rnode_2to164_var__u0_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_arrayidx24_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_arrayidx24_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_2to164_arrayidx24_0_NO_SHIFT_REG;
 logic rnode_2to164_arrayidx24_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_2to164_arrayidx24_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_arrayidx24_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_arrayidx24_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_arrayidx24_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_arrayidx24_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_arrayidx24_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_arrayidx24_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_arrayidx24_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_arrayidx24_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rnode_1to2_arrayidx24_1_NO_SHIFT_REG),
	.data_out(rnode_2to164_arrayidx24_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_arrayidx24_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_arrayidx24_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_2to164_arrayidx24_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_arrayidx24_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_arrayidx24_0_reg_164_inputs_ready_NO_SHIFT_REG = rnode_1to2_arrayidx24_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_arrayidx24_0_stall_in_1_NO_SHIFT_REG = rnode_2to164_arrayidx24_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_arrayidx24_0_NO_SHIFT_REG = rnode_2to164_arrayidx24_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_arrayidx24_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_arrayidx24_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_arrayidx24_0_valid_out_NO_SHIFT_REG = rnode_2to164_arrayidx24_0_valid_out_reg_164_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb3_var__u1_valid_out;
wire local_bb3_var__u1_stall_in;
wire local_bb3_var__u1_inputs_ready;
wire local_bb3_var__u1_stall_local;
wire local_bb3_var__u1;

assign local_bb3_var__u1_inputs_ready = (rnode_1to2_var__u0_0_valid_out_0_NO_SHIFT_REG & rnode_1to2_bb3_cmp8_0_valid_out_0_NO_SHIFT_REG);
assign local_bb3_var__u1 = (rnode_1to2_var__u0_0_NO_SHIFT_REG | rnode_1to2_bb3_cmp8_0_NO_SHIFT_REG);
assign local_bb3_var__u1_valid_out = local_bb3_var__u1_inputs_ready;
assign local_bb3_var__u1_stall_local = local_bb3_var__u1_stall_in;
assign rnode_1to2_var__u0_0_stall_in_0_NO_SHIFT_REG = (local_bb3_var__u1_stall_local | ~(local_bb3_var__u1_inputs_ready));
assign rnode_1to2_bb3_cmp8_0_stall_in_0_NO_SHIFT_REG = (local_bb3_var__u1_stall_local | ~(local_bb3_var__u1_inputs_ready));

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_bb3_cmp8_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_bb3_cmp8_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to164_bb3_cmp8_0_NO_SHIFT_REG;
 logic rnode_2to164_bb3_cmp8_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to164_bb3_cmp8_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_cmp8_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_cmp8_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_cmp8_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_bb3_cmp8_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_bb3_cmp8_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_bb3_cmp8_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_bb3_cmp8_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_bb3_cmp8_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rnode_1to2_bb3_cmp8_1_NO_SHIFT_REG),
	.data_out(rnode_2to164_bb3_cmp8_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_bb3_cmp8_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_bb3_cmp8_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_2to164_bb3_cmp8_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_bb3_cmp8_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_bb3_cmp8_0_reg_164_inputs_ready_NO_SHIFT_REG = rnode_1to2_bb3_cmp8_0_valid_out_1_NO_SHIFT_REG;
assign rnode_1to2_bb3_cmp8_0_stall_in_1_NO_SHIFT_REG = rnode_2to164_bb3_cmp8_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_cmp8_0_NO_SHIFT_REG = rnode_2to164_bb3_cmp8_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_cmp8_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_bb3_cmp8_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_bb3_cmp8_0_valid_out_NO_SHIFT_REG = rnode_2to164_bb3_cmp8_0_valid_out_reg_164_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_2to2_bb3_arrayidx23_valid_out_0;
wire rstag_2to2_bb3_arrayidx23_stall_in_0;
 reg rstag_2to2_bb3_arrayidx23_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb3_arrayidx23_valid_out_1;
wire rstag_2to2_bb3_arrayidx23_stall_in_1;
 reg rstag_2to2_bb3_arrayidx23_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb3_arrayidx23_inputs_ready;
wire rstag_2to2_bb3_arrayidx23_stall_local;
 reg rstag_2to2_bb3_arrayidx23_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb3_arrayidx23_combined_valid;
 reg [63:0] rstag_2to2_bb3_arrayidx23_staging_reg_NO_SHIFT_REG;
wire [63:0] rstag_2to2_bb3_arrayidx23;

assign rstag_2to2_bb3_arrayidx23_inputs_ready = local_bb3_arrayidx23_valid_out;
assign rstag_2to2_bb3_arrayidx23 = (rstag_2to2_bb3_arrayidx23_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb3_arrayidx23_staging_reg_NO_SHIFT_REG : local_bb3_arrayidx23);
assign rstag_2to2_bb3_arrayidx23_combined_valid = (rstag_2to2_bb3_arrayidx23_staging_valid_NO_SHIFT_REG | rstag_2to2_bb3_arrayidx23_inputs_ready);
assign rstag_2to2_bb3_arrayidx23_stall_local = ((rstag_2to2_bb3_arrayidx23_stall_in_0 & ~(rstag_2to2_bb3_arrayidx23_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb3_arrayidx23_stall_in_1 & ~(rstag_2to2_bb3_arrayidx23_consumed_1_NO_SHIFT_REG)));
assign rstag_2to2_bb3_arrayidx23_valid_out_0 = (rstag_2to2_bb3_arrayidx23_combined_valid & ~(rstag_2to2_bb3_arrayidx23_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb3_arrayidx23_valid_out_1 = (rstag_2to2_bb3_arrayidx23_combined_valid & ~(rstag_2to2_bb3_arrayidx23_consumed_1_NO_SHIFT_REG));
assign local_bb3_arrayidx23_stall_in = (|rstag_2to2_bb3_arrayidx23_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb3_arrayidx23_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb3_arrayidx23_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb3_arrayidx23_stall_local)
		begin
			if (~(rstag_2to2_bb3_arrayidx23_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb3_arrayidx23_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb3_arrayidx23_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb3_arrayidx23_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb3_arrayidx23_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb3_arrayidx23_staging_reg_NO_SHIFT_REG <= local_bb3_arrayidx23;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb3_arrayidx23_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb3_arrayidx23_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb3_arrayidx23_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb3_arrayidx23_combined_valid & (rstag_2to2_bb3_arrayidx23_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb3_arrayidx23_stall_in_0)) & rstag_2to2_bb3_arrayidx23_stall_local);
		rstag_2to2_bb3_arrayidx23_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb3_arrayidx23_combined_valid & (rstag_2to2_bb3_arrayidx23_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb3_arrayidx23_stall_in_1)) & rstag_2to2_bb3_arrayidx23_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_right_lower_0_ph6_0_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph6_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_right_lower_0_ph6_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph6_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph6_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_right_lower_0_ph6_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_right_lower_0_ph6_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_right_lower_0_ph6_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_right_lower_0_ph6_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_right_lower_0_ph6_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_right_lower_0_ph6_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_right_lower_0_ph6_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_right_lower_0_ph6_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_right_lower_0_ph6_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_right_lower_0_ph6_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_right_lower_0_ph6_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_right_lower_0_ph6_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_right_lower_0_ph6_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG = rnode_164to165_right_lower_0_ph6_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_right_lower_0_ph6_0_NO_SHIFT_REG = rnode_164to165_right_lower_0_ph6_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_right_lower_0_ph6_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG = rnode_164to165_right_lower_0_ph6_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_var__u0_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_var__u0_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_var__u0_0_NO_SHIFT_REG;
 logic rnode_164to165_var__u0_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_var__u0_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_var__u0_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_var__u0_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_var__u0_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_var__u0_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_var__u0_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_var__u0_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_var__u0_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_var__u0_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_var__u0_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_var__u0_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_var__u0_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_var__u0_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_var__u0_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_var__u0_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_var__u0_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_var__u0_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_var__u0_0_stall_in_NO_SHIFT_REG = rnode_164to165_var__u0_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_var__u0_0_NO_SHIFT_REG = rnode_164to165_var__u0_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_var__u0_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_var__u0_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_var__u0_0_valid_out_NO_SHIFT_REG = rnode_164to165_var__u0_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_arrayidx24_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_arrayidx24_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_arrayidx24_0_NO_SHIFT_REG;
 logic rnode_164to165_arrayidx24_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_arrayidx24_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_arrayidx24_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_arrayidx24_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_arrayidx24_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_arrayidx24_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_arrayidx24_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_arrayidx24_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_arrayidx24_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_arrayidx24_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_arrayidx24_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_arrayidx24_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_arrayidx24_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_arrayidx24_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_arrayidx24_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_arrayidx24_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_arrayidx24_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_arrayidx24_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_arrayidx24_0_stall_in_NO_SHIFT_REG = rnode_164to165_arrayidx24_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_arrayidx24_0_NO_SHIFT_REG = rnode_164to165_arrayidx24_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_arrayidx24_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_arrayidx24_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_arrayidx24_0_valid_out_NO_SHIFT_REG = rnode_164to165_arrayidx24_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_2to2_bb3_var__u1_valid_out_0;
wire rstag_2to2_bb3_var__u1_stall_in_0;
 reg rstag_2to2_bb3_var__u1_consumed_0_NO_SHIFT_REG;
wire rstag_2to2_bb3_var__u1_valid_out_1;
wire rstag_2to2_bb3_var__u1_stall_in_1;
 reg rstag_2to2_bb3_var__u1_consumed_1_NO_SHIFT_REG;
wire rstag_2to2_bb3_var__u1_valid_out_2;
wire rstag_2to2_bb3_var__u1_stall_in_2;
 reg rstag_2to2_bb3_var__u1_consumed_2_NO_SHIFT_REG;
wire rstag_2to2_bb3_var__u1_inputs_ready;
wire rstag_2to2_bb3_var__u1_stall_local;
 reg rstag_2to2_bb3_var__u1_staging_valid_NO_SHIFT_REG;
wire rstag_2to2_bb3_var__u1_combined_valid;
 reg rstag_2to2_bb3_var__u1_staging_reg_NO_SHIFT_REG;
wire rstag_2to2_bb3_var__u1;

assign rstag_2to2_bb3_var__u1_inputs_ready = local_bb3_var__u1_valid_out;
assign rstag_2to2_bb3_var__u1 = (rstag_2to2_bb3_var__u1_staging_valid_NO_SHIFT_REG ? rstag_2to2_bb3_var__u1_staging_reg_NO_SHIFT_REG : local_bb3_var__u1);
assign rstag_2to2_bb3_var__u1_combined_valid = (rstag_2to2_bb3_var__u1_staging_valid_NO_SHIFT_REG | rstag_2to2_bb3_var__u1_inputs_ready);
assign rstag_2to2_bb3_var__u1_stall_local = ((rstag_2to2_bb3_var__u1_stall_in_0 & ~(rstag_2to2_bb3_var__u1_consumed_0_NO_SHIFT_REG)) | (rstag_2to2_bb3_var__u1_stall_in_1 & ~(rstag_2to2_bb3_var__u1_consumed_1_NO_SHIFT_REG)) | (rstag_2to2_bb3_var__u1_stall_in_2 & ~(rstag_2to2_bb3_var__u1_consumed_2_NO_SHIFT_REG)));
assign rstag_2to2_bb3_var__u1_valid_out_0 = (rstag_2to2_bb3_var__u1_combined_valid & ~(rstag_2to2_bb3_var__u1_consumed_0_NO_SHIFT_REG));
assign rstag_2to2_bb3_var__u1_valid_out_1 = (rstag_2to2_bb3_var__u1_combined_valid & ~(rstag_2to2_bb3_var__u1_consumed_1_NO_SHIFT_REG));
assign rstag_2to2_bb3_var__u1_valid_out_2 = (rstag_2to2_bb3_var__u1_combined_valid & ~(rstag_2to2_bb3_var__u1_consumed_2_NO_SHIFT_REG));
assign local_bb3_var__u1_stall_in = (|rstag_2to2_bb3_var__u1_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb3_var__u1_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb3_var__u1_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_2to2_bb3_var__u1_stall_local)
		begin
			if (~(rstag_2to2_bb3_var__u1_staging_valid_NO_SHIFT_REG))
			begin
				rstag_2to2_bb3_var__u1_staging_valid_NO_SHIFT_REG <= rstag_2to2_bb3_var__u1_inputs_ready;
			end
		end
		else
		begin
			rstag_2to2_bb3_var__u1_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_2to2_bb3_var__u1_staging_valid_NO_SHIFT_REG))
		begin
			rstag_2to2_bb3_var__u1_staging_reg_NO_SHIFT_REG <= local_bb3_var__u1;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_2to2_bb3_var__u1_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb3_var__u1_consumed_1_NO_SHIFT_REG <= 1'b0;
		rstag_2to2_bb3_var__u1_consumed_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_2to2_bb3_var__u1_consumed_0_NO_SHIFT_REG <= (rstag_2to2_bb3_var__u1_combined_valid & (rstag_2to2_bb3_var__u1_consumed_0_NO_SHIFT_REG | ~(rstag_2to2_bb3_var__u1_stall_in_0)) & rstag_2to2_bb3_var__u1_stall_local);
		rstag_2to2_bb3_var__u1_consumed_1_NO_SHIFT_REG <= (rstag_2to2_bb3_var__u1_combined_valid & (rstag_2to2_bb3_var__u1_consumed_1_NO_SHIFT_REG | ~(rstag_2to2_bb3_var__u1_stall_in_1)) & rstag_2to2_bb3_var__u1_stall_local);
		rstag_2to2_bb3_var__u1_consumed_2_NO_SHIFT_REG <= (rstag_2to2_bb3_var__u1_combined_valid & (rstag_2to2_bb3_var__u1_consumed_2_NO_SHIFT_REG | ~(rstag_2to2_bb3_var__u1_stall_in_2)) & rstag_2to2_bb3_var__u1_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb3_cmp8_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_1_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_stall_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_cmp8_0_reg_165_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_164to165_bb3_cmp8_0_reg_165_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_164to165_bb3_cmp8_0_reg_165_NO_SHIFT_REG),
	.valid_in(rnode_164to165_bb3_cmp8_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb3_cmp8_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb3_cmp8_0_reg_165_NO_SHIFT_REG_fa),
	.valid_out({rnode_164to165_bb3_cmp8_0_valid_out_0_NO_SHIFT_REG, rnode_164to165_bb3_cmp8_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_164to165_bb3_cmp8_0_stall_in_0_NO_SHIFT_REG, rnode_164to165_bb3_cmp8_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_164to165_bb3_cmp8_0_reg_165_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_164to165_bb3_cmp8_0_reg_165_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_164to165_bb3_cmp8_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb3_cmp8_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb3_cmp8_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb3_cmp8_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb3_cmp8_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_bb3_cmp8_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb3_cmp8_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb3_cmp8_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb3_cmp8_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb3_cmp8_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb3_cmp8_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb3_cmp8_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_bb3_cmp8_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_bb3_cmp8_0_stall_in_NO_SHIFT_REG = rnode_164to165_bb3_cmp8_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_cmp8_0_NO_SHIFT_REG = rnode_164to165_bb3_cmp8_0_reg_165_NO_SHIFT_REG_fa;
assign rnode_164to165_bb3_cmp8_1_NO_SHIFT_REG = rnode_164to165_bb3_cmp8_0_reg_165_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_bb3_arrayidx23_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_bb3_arrayidx23_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_2to164_bb3_arrayidx23_0_NO_SHIFT_REG;
 logic rnode_2to164_bb3_arrayidx23_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_2to164_bb3_arrayidx23_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_arrayidx23_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_arrayidx23_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_arrayidx23_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_bb3_arrayidx23_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_bb3_arrayidx23_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_bb3_arrayidx23_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_bb3_arrayidx23_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_bb3_arrayidx23_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rstag_2to2_bb3_arrayidx23),
	.data_out(rnode_2to164_bb3_arrayidx23_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_bb3_arrayidx23_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_bb3_arrayidx23_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_2to164_bb3_arrayidx23_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_bb3_arrayidx23_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_bb3_arrayidx23_0_reg_164_inputs_ready_NO_SHIFT_REG = rstag_2to2_bb3_arrayidx23_valid_out_0;
assign rstag_2to2_bb3_arrayidx23_stall_in_0 = rnode_2to164_bb3_arrayidx23_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_arrayidx23_0_NO_SHIFT_REG = rnode_2to164_bb3_arrayidx23_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_arrayidx23_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_bb3_arrayidx23_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_bb3_arrayidx23_0_valid_out_NO_SHIFT_REG = rnode_2to164_bb3_arrayidx23_0_valid_out_reg_164_NO_SHIFT_REG;

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_2to164_bb3_var__u1_0_valid_out_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__u1_0_stall_in_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__u1_0_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__u1_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__u1_0_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__u1_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__u1_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_2to164_bb3_var__u1_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_2to164_bb3_var__u1_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to164_bb3_var__u1_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to164_bb3_var__u1_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_2to164_bb3_var__u1_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_2to164_bb3_var__u1_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rstag_2to2_bb3_var__u1),
	.data_out(rnode_2to164_bb3_var__u1_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_2to164_bb3_var__u1_0_reg_164_fifo.DEPTH = 163;
defparam rnode_2to164_bb3_var__u1_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_2to164_bb3_var__u1_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to164_bb3_var__u1_0_reg_164_fifo.IMPL = "ram";

assign rnode_2to164_bb3_var__u1_0_reg_164_inputs_ready_NO_SHIFT_REG = rstag_2to2_bb3_var__u1_valid_out_0;
assign rstag_2to2_bb3_var__u1_stall_in_0 = rnode_2to164_bb3_var__u1_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_var__u1_0_NO_SHIFT_REG = rnode_2to164_bb3_var__u1_0_reg_164_NO_SHIFT_REG;
assign rnode_2to164_bb3_var__u1_0_stall_in_reg_164_NO_SHIFT_REG = rnode_2to164_bb3_var__u1_0_stall_in_NO_SHIFT_REG;
assign rnode_2to164_bb3_var__u1_0_valid_out_NO_SHIFT_REG = rnode_2to164_bb3_var__u1_0_valid_out_reg_164_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb3_ld__u2_inputs_ready;
 reg local_bb3_ld__u2_valid_out_NO_SHIFT_REG;
wire local_bb3_ld__u2_stall_in;
wire local_bb3_ld__u2_output_regs_ready;
wire local_bb3_ld__u2_fu_stall_out;
wire local_bb3_ld__u2_fu_valid_out;
wire [31:0] local_bb3_ld__u2_lsu_dataout;
 reg [31:0] local_bb3_ld__u2_NO_SHIFT_REG;
wire local_bb3_ld__u2_causedstall;

lsu_top lsu_local_bb3_ld__u2 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb3_ld__u2_fu_stall_out),
	.i_valid(local_bb3_ld__u2_inputs_ready),
	.i_address(rnode_1to2_arrayidx24_0_NO_SHIFT_REG),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_2to2_bb3_var__u1),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb3_ld__u2_output_regs_ready)),
	.o_valid(local_bb3_ld__u2_fu_valid_out),
	.o_readdata(local_bb3_ld__u2_lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb3_ld__u2_active),
	.avm_address(avm_local_bb3_ld__u2_address),
	.avm_read(avm_local_bb3_ld__u2_read),
	.avm_readdata(avm_local_bb3_ld__u2_readdata),
	.avm_write(avm_local_bb3_ld__u2_write),
	.avm_writeack(avm_local_bb3_ld__u2_writeack),
	.avm_burstcount(avm_local_bb3_ld__u2_burstcount),
	.avm_writedata(avm_local_bb3_ld__u2_writedata),
	.avm_byteenable(avm_local_bb3_ld__u2_byteenable),
	.avm_waitrequest(avm_local_bb3_ld__u2_waitrequest),
	.avm_readdatavalid(avm_local_bb3_ld__u2_readdatavalid),
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

defparam lsu_local_bb3_ld__u2.AWIDTH = 30;
defparam lsu_local_bb3_ld__u2.WIDTH_BYTES = 4;
defparam lsu_local_bb3_ld__u2.MWIDTH_BYTES = 32;
defparam lsu_local_bb3_ld__u2.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb3_ld__u2.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb3_ld__u2.READ = 1;
defparam lsu_local_bb3_ld__u2.ATOMIC = 0;
defparam lsu_local_bb3_ld__u2.WIDTH = 32;
defparam lsu_local_bb3_ld__u2.MWIDTH = 256;
defparam lsu_local_bb3_ld__u2.ATOMIC_WIDTH = 3;
defparam lsu_local_bb3_ld__u2.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb3_ld__u2.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb3_ld__u2.MEMORY_SIDE_MEM_LATENCY = 58;
defparam lsu_local_bb3_ld__u2.USE_WRITE_ACK = 0;
defparam lsu_local_bb3_ld__u2.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb3_ld__u2.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb3_ld__u2.NUMBER_BANKS = 1;
defparam lsu_local_bb3_ld__u2.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb3_ld__u2.USEINPUTFIFO = 0;
defparam lsu_local_bb3_ld__u2.USECACHING = 0;
defparam lsu_local_bb3_ld__u2.USEOUTPUTFIFO = 1;
defparam lsu_local_bb3_ld__u2.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb3_ld__u2.HIGH_FMAX = 1;
defparam lsu_local_bb3_ld__u2.ADDRSPACE = 1;
defparam lsu_local_bb3_ld__u2.STYLE = "BURST-COALESCED";

assign local_bb3_ld__u2_inputs_ready = (rnode_1to2_arrayidx24_0_valid_out_0_NO_SHIFT_REG & rstag_2to2_bb3_var__u1_valid_out_1);
assign local_bb3_ld__u2_output_regs_ready = (&(~(local_bb3_ld__u2_valid_out_NO_SHIFT_REG) | ~(local_bb3_ld__u2_stall_in)));
assign rnode_1to2_arrayidx24_0_stall_in_0_NO_SHIFT_REG = (local_bb3_ld__u2_fu_stall_out | ~(local_bb3_ld__u2_inputs_ready));
assign rstag_2to2_bb3_var__u1_stall_in_1 = (local_bb3_ld__u2_fu_stall_out | ~(local_bb3_ld__u2_inputs_ready));
assign local_bb3_ld__u2_causedstall = (local_bb3_ld__u2_inputs_ready && (local_bb3_ld__u2_fu_stall_out && !(~(local_bb3_ld__u2_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_ld__u2_NO_SHIFT_REG <= 'x;
		local_bb3_ld__u2_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_ld__u2_output_regs_ready)
		begin
			local_bb3_ld__u2_NO_SHIFT_REG <= local_bb3_ld__u2_lsu_dataout;
			local_bb3_ld__u2_valid_out_NO_SHIFT_REG <= local_bb3_ld__u2_fu_valid_out;
		end
		else
		begin
			if (~(local_bb3_ld__u2_stall_in))
			begin
				local_bb3_ld__u2_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb3_ld__inputs_ready;
 reg local_bb3_ld__valid_out_NO_SHIFT_REG;
wire local_bb3_ld__stall_in;
wire local_bb3_ld__output_regs_ready;
wire local_bb3_ld__fu_stall_out;
wire local_bb3_ld__fu_valid_out;
wire [31:0] local_bb3_ld__lsu_dataout;
 reg [31:0] local_bb3_ld__NO_SHIFT_REG;
wire local_bb3_ld__causedstall;

lsu_top lsu_local_bb3_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb3_ld__fu_stall_out),
	.i_valid(local_bb3_ld__inputs_ready),
	.i_address(rstag_2to2_bb3_arrayidx23),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_2to2_bb3_var__u1),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb3_ld__output_regs_ready)),
	.o_valid(local_bb3_ld__fu_valid_out),
	.o_readdata(local_bb3_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb3_ld__active),
	.avm_address(avm_local_bb3_ld__address),
	.avm_read(avm_local_bb3_ld__read),
	.avm_readdata(avm_local_bb3_ld__readdata),
	.avm_write(avm_local_bb3_ld__write),
	.avm_writeack(avm_local_bb3_ld__writeack),
	.avm_burstcount(avm_local_bb3_ld__burstcount),
	.avm_writedata(avm_local_bb3_ld__writedata),
	.avm_byteenable(avm_local_bb3_ld__byteenable),
	.avm_waitrequest(avm_local_bb3_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb3_ld__readdatavalid),
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

defparam lsu_local_bb3_ld_.AWIDTH = 30;
defparam lsu_local_bb3_ld_.WIDTH_BYTES = 4;
defparam lsu_local_bb3_ld_.MWIDTH_BYTES = 32;
defparam lsu_local_bb3_ld_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb3_ld_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb3_ld_.READ = 1;
defparam lsu_local_bb3_ld_.ATOMIC = 0;
defparam lsu_local_bb3_ld_.WIDTH = 32;
defparam lsu_local_bb3_ld_.MWIDTH = 256;
defparam lsu_local_bb3_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb3_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb3_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb3_ld_.MEMORY_SIDE_MEM_LATENCY = 58;
defparam lsu_local_bb3_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb3_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb3_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb3_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb3_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb3_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb3_ld_.USECACHING = 0;
defparam lsu_local_bb3_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb3_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb3_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb3_ld_.ADDRSPACE = 1;
defparam lsu_local_bb3_ld_.STYLE = "BURST-COALESCED";

assign local_bb3_ld__inputs_ready = (rstag_2to2_bb3_var__u1_valid_out_2 & rstag_2to2_bb3_arrayidx23_valid_out_1);
assign local_bb3_ld__output_regs_ready = (&(~(local_bb3_ld__valid_out_NO_SHIFT_REG) | ~(local_bb3_ld__stall_in)));
assign rstag_2to2_bb3_var__u1_stall_in_2 = (local_bb3_ld__fu_stall_out | ~(local_bb3_ld__inputs_ready));
assign rstag_2to2_bb3_arrayidx23_stall_in_1 = (local_bb3_ld__fu_stall_out | ~(local_bb3_ld__inputs_ready));
assign local_bb3_ld__causedstall = (local_bb3_ld__inputs_ready && (local_bb3_ld__fu_stall_out && !(~(local_bb3_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_ld__NO_SHIFT_REG <= 'x;
		local_bb3_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_ld__output_regs_ready)
		begin
			local_bb3_ld__NO_SHIFT_REG <= local_bb3_ld__lsu_dataout;
			local_bb3_ld__valid_out_NO_SHIFT_REG <= local_bb3_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb3_ld__stall_in))
			begin
				local_bb3_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb3_or_cond_stall_local;
wire local_bb3_or_cond;

assign local_bb3_or_cond = (rnode_164to165_cmp6_0_NO_SHIFT_REG & rnode_164to165_bb3_cmp8_0_NO_SHIFT_REG);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb3_arrayidx23_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb3_arrayidx23_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_bb3_arrayidx23_0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_arrayidx23_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_bb3_arrayidx23_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_arrayidx23_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_arrayidx23_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_arrayidx23_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb3_arrayidx23_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb3_arrayidx23_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb3_arrayidx23_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb3_arrayidx23_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb3_arrayidx23_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_bb3_arrayidx23_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb3_arrayidx23_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb3_arrayidx23_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb3_arrayidx23_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_bb3_arrayidx23_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb3_arrayidx23_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb3_arrayidx23_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_bb3_arrayidx23_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_bb3_arrayidx23_0_stall_in_NO_SHIFT_REG = rnode_164to165_bb3_arrayidx23_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_arrayidx23_0_NO_SHIFT_REG = rnode_164to165_bb3_arrayidx23_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_arrayidx23_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_bb3_arrayidx23_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_bb3_arrayidx23_0_valid_out_NO_SHIFT_REG = rnode_164to165_bb3_arrayidx23_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb3_var__u1_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_1_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_stall_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb3_var__u1_0_reg_165_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_164to165_bb3_var__u1_0_reg_165_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_164to165_bb3_var__u1_0_reg_165_NO_SHIFT_REG),
	.valid_in(rnode_164to165_bb3_var__u1_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb3_var__u1_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb3_var__u1_0_reg_165_NO_SHIFT_REG_fa),
	.valid_out({rnode_164to165_bb3_var__u1_0_valid_out_0_NO_SHIFT_REG, rnode_164to165_bb3_var__u1_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_164to165_bb3_var__u1_0_stall_in_0_NO_SHIFT_REG, rnode_164to165_bb3_var__u1_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_164to165_bb3_var__u1_0_reg_165_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_164to165_bb3_var__u1_0_reg_165_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_164to165_bb3_var__u1_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb3_var__u1_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb3_var__u1_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb3_var__u1_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb3_var__u1_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_2to164_bb3_var__u1_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb3_var__u1_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb3_var__u1_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb3_var__u1_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb3_var__u1_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb3_var__u1_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb3_var__u1_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_2to164_bb3_var__u1_0_valid_out_NO_SHIFT_REG;
assign rnode_2to164_bb3_var__u1_0_stall_in_NO_SHIFT_REG = rnode_164to165_bb3_var__u1_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb3_var__u1_0_NO_SHIFT_REG = rnode_164to165_bb3_var__u1_0_reg_165_NO_SHIFT_REG_fa;
assign rnode_164to165_bb3_var__u1_1_NO_SHIFT_REG = rnode_164to165_bb3_var__u1_0_reg_165_NO_SHIFT_REG_fa;

// This section implements a staging register.
// 
wire rstag_162to162_bb3_ld__u2_valid_out_0;
wire rstag_162to162_bb3_ld__u2_stall_in_0;
 reg rstag_162to162_bb3_ld__u2_consumed_0_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__u2_valid_out_1;
wire rstag_162to162_bb3_ld__u2_stall_in_1;
 reg rstag_162to162_bb3_ld__u2_consumed_1_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__u2_valid_out_2;
wire rstag_162to162_bb3_ld__u2_stall_in_2;
 reg rstag_162to162_bb3_ld__u2_consumed_2_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__u2_inputs_ready;
wire rstag_162to162_bb3_ld__u2_stall_local;
 reg rstag_162to162_bb3_ld__u2_staging_valid_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__u2_combined_valid;
 reg [31:0] rstag_162to162_bb3_ld__u2_staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_162to162_bb3_ld__u2;

assign rstag_162to162_bb3_ld__u2_inputs_ready = local_bb3_ld__u2_valid_out_NO_SHIFT_REG;
assign rstag_162to162_bb3_ld__u2 = (rstag_162to162_bb3_ld__u2_staging_valid_NO_SHIFT_REG ? rstag_162to162_bb3_ld__u2_staging_reg_NO_SHIFT_REG : local_bb3_ld__u2_NO_SHIFT_REG);
assign rstag_162to162_bb3_ld__u2_combined_valid = (rstag_162to162_bb3_ld__u2_staging_valid_NO_SHIFT_REG | rstag_162to162_bb3_ld__u2_inputs_ready);
assign rstag_162to162_bb3_ld__u2_stall_local = ((rstag_162to162_bb3_ld__u2_stall_in_0 & ~(rstag_162to162_bb3_ld__u2_consumed_0_NO_SHIFT_REG)) | (rstag_162to162_bb3_ld__u2_stall_in_1 & ~(rstag_162to162_bb3_ld__u2_consumed_1_NO_SHIFT_REG)) | (rstag_162to162_bb3_ld__u2_stall_in_2 & ~(rstag_162to162_bb3_ld__u2_consumed_2_NO_SHIFT_REG)));
assign rstag_162to162_bb3_ld__u2_valid_out_0 = (rstag_162to162_bb3_ld__u2_combined_valid & ~(rstag_162to162_bb3_ld__u2_consumed_0_NO_SHIFT_REG));
assign rstag_162to162_bb3_ld__u2_valid_out_1 = (rstag_162to162_bb3_ld__u2_combined_valid & ~(rstag_162to162_bb3_ld__u2_consumed_1_NO_SHIFT_REG));
assign rstag_162to162_bb3_ld__u2_valid_out_2 = (rstag_162to162_bb3_ld__u2_combined_valid & ~(rstag_162to162_bb3_ld__u2_consumed_2_NO_SHIFT_REG));
assign local_bb3_ld__u2_stall_in = (|rstag_162to162_bb3_ld__u2_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb3_ld__u2_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb3_ld__u2_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_162to162_bb3_ld__u2_stall_local)
		begin
			if (~(rstag_162to162_bb3_ld__u2_staging_valid_NO_SHIFT_REG))
			begin
				rstag_162to162_bb3_ld__u2_staging_valid_NO_SHIFT_REG <= rstag_162to162_bb3_ld__u2_inputs_ready;
			end
		end
		else
		begin
			rstag_162to162_bb3_ld__u2_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_162to162_bb3_ld__u2_staging_valid_NO_SHIFT_REG))
		begin
			rstag_162to162_bb3_ld__u2_staging_reg_NO_SHIFT_REG <= local_bb3_ld__u2_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb3_ld__u2_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb3_ld__u2_consumed_1_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb3_ld__u2_consumed_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_162to162_bb3_ld__u2_consumed_0_NO_SHIFT_REG <= (rstag_162to162_bb3_ld__u2_combined_valid & (rstag_162to162_bb3_ld__u2_consumed_0_NO_SHIFT_REG | ~(rstag_162to162_bb3_ld__u2_stall_in_0)) & rstag_162to162_bb3_ld__u2_stall_local);
		rstag_162to162_bb3_ld__u2_consumed_1_NO_SHIFT_REG <= (rstag_162to162_bb3_ld__u2_combined_valid & (rstag_162to162_bb3_ld__u2_consumed_1_NO_SHIFT_REG | ~(rstag_162to162_bb3_ld__u2_stall_in_1)) & rstag_162to162_bb3_ld__u2_stall_local);
		rstag_162to162_bb3_ld__u2_consumed_2_NO_SHIFT_REG <= (rstag_162to162_bb3_ld__u2_combined_valid & (rstag_162to162_bb3_ld__u2_consumed_2_NO_SHIFT_REG | ~(rstag_162to162_bb3_ld__u2_stall_in_2)) & rstag_162to162_bb3_ld__u2_stall_local);
	end
end


// This section implements a staging register.
// 
wire rstag_162to162_bb3_ld__valid_out_0;
wire rstag_162to162_bb3_ld__stall_in_0;
 reg rstag_162to162_bb3_ld__consumed_0_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__valid_out_1;
wire rstag_162to162_bb3_ld__stall_in_1;
 reg rstag_162to162_bb3_ld__consumed_1_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__valid_out_2;
wire rstag_162to162_bb3_ld__stall_in_2;
 reg rstag_162to162_bb3_ld__consumed_2_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__inputs_ready;
wire rstag_162to162_bb3_ld__stall_local;
 reg rstag_162to162_bb3_ld__staging_valid_NO_SHIFT_REG;
wire rstag_162to162_bb3_ld__combined_valid;
 reg [31:0] rstag_162to162_bb3_ld__staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_162to162_bb3_ld_;

assign rstag_162to162_bb3_ld__inputs_ready = local_bb3_ld__valid_out_NO_SHIFT_REG;
assign rstag_162to162_bb3_ld_ = (rstag_162to162_bb3_ld__staging_valid_NO_SHIFT_REG ? rstag_162to162_bb3_ld__staging_reg_NO_SHIFT_REG : local_bb3_ld__NO_SHIFT_REG);
assign rstag_162to162_bb3_ld__combined_valid = (rstag_162to162_bb3_ld__staging_valid_NO_SHIFT_REG | rstag_162to162_bb3_ld__inputs_ready);
assign rstag_162to162_bb3_ld__stall_local = ((rstag_162to162_bb3_ld__stall_in_0 & ~(rstag_162to162_bb3_ld__consumed_0_NO_SHIFT_REG)) | (rstag_162to162_bb3_ld__stall_in_1 & ~(rstag_162to162_bb3_ld__consumed_1_NO_SHIFT_REG)) | (rstag_162to162_bb3_ld__stall_in_2 & ~(rstag_162to162_bb3_ld__consumed_2_NO_SHIFT_REG)));
assign rstag_162to162_bb3_ld__valid_out_0 = (rstag_162to162_bb3_ld__combined_valid & ~(rstag_162to162_bb3_ld__consumed_0_NO_SHIFT_REG));
assign rstag_162to162_bb3_ld__valid_out_1 = (rstag_162to162_bb3_ld__combined_valid & ~(rstag_162to162_bb3_ld__consumed_1_NO_SHIFT_REG));
assign rstag_162to162_bb3_ld__valid_out_2 = (rstag_162to162_bb3_ld__combined_valid & ~(rstag_162to162_bb3_ld__consumed_2_NO_SHIFT_REG));
assign local_bb3_ld__stall_in = (|rstag_162to162_bb3_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb3_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb3_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_162to162_bb3_ld__stall_local)
		begin
			if (~(rstag_162to162_bb3_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_162to162_bb3_ld__staging_valid_NO_SHIFT_REG <= rstag_162to162_bb3_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_162to162_bb3_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_162to162_bb3_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_162to162_bb3_ld__staging_reg_NO_SHIFT_REG <= local_bb3_ld__NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_162to162_bb3_ld__consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb3_ld__consumed_1_NO_SHIFT_REG <= 1'b0;
		rstag_162to162_bb3_ld__consumed_2_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_162to162_bb3_ld__consumed_0_NO_SHIFT_REG <= (rstag_162to162_bb3_ld__combined_valid & (rstag_162to162_bb3_ld__consumed_0_NO_SHIFT_REG | ~(rstag_162to162_bb3_ld__stall_in_0)) & rstag_162to162_bb3_ld__stall_local);
		rstag_162to162_bb3_ld__consumed_1_NO_SHIFT_REG <= (rstag_162to162_bb3_ld__combined_valid & (rstag_162to162_bb3_ld__consumed_1_NO_SHIFT_REG | ~(rstag_162to162_bb3_ld__stall_in_1)) & rstag_162to162_bb3_ld__stall_local);
		rstag_162to162_bb3_ld__consumed_2_NO_SHIFT_REG <= (rstag_162to162_bb3_ld__combined_valid & (rstag_162to162_bb3_ld__consumed_2_NO_SHIFT_REG | ~(rstag_162to162_bb3_ld__stall_in_2)) & rstag_162to162_bb3_ld__stall_local);
	end
end


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

assign local_bb3_var__inputs_ready = (rnode_164to165_cmp6_0_valid_out_0_NO_SHIFT_REG & rnode_164to165_bb3_cmp8_0_valid_out_0_NO_SHIFT_REG & rnode_164to165_var__0_valid_out_0_NO_SHIFT_REG);
assign local_bb3_var_ = (local_bb3_or_cond | rnode_164to165_var__0_NO_SHIFT_REG);
assign local_bb3_var__stall_local = ((local_bb3_or_cond_stall_in_1 & ~(local_bb3_or_cond_consumed_1_NO_SHIFT_REG)) | (local_bb3_var__stall_in & ~(local_bb3_var__consumed_0_NO_SHIFT_REG)));
assign local_bb3_or_cond_valid_out_1 = (local_bb3_var__inputs_ready & ~(local_bb3_or_cond_consumed_1_NO_SHIFT_REG));
assign local_bb3_var__valid_out = (local_bb3_var__inputs_ready & ~(local_bb3_var__consumed_0_NO_SHIFT_REG));
assign rnode_164to165_cmp6_0_stall_in_0_NO_SHIFT_REG = (local_bb3_var__stall_local | ~(local_bb3_var__inputs_ready));
assign rnode_164to165_bb3_cmp8_0_stall_in_0_NO_SHIFT_REG = (local_bb3_var__stall_local | ~(local_bb3_var__inputs_ready));
assign rnode_164to165_var__0_stall_in_0_NO_SHIFT_REG = (local_bb3_var__stall_local | ~(local_bb3_var__inputs_ready));

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
//  * latency = 3
//  * capacity = 3
 logic rnode_162to165_bb3_ld__u2_0_valid_out_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__u2_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_162to165_bb3_ld__u2_0_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__u2_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_162to165_bb3_ld__u2_0_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__u2_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__u2_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__u2_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_162to165_bb3_ld__u2_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_162to165_bb3_ld__u2_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_162to165_bb3_ld__u2_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_162to165_bb3_ld__u2_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_162to165_bb3_ld__u2_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rstag_162to162_bb3_ld__u2),
	.data_out(rnode_162to165_bb3_ld__u2_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_162to165_bb3_ld__u2_0_reg_165_fifo.DEPTH = 4;
defparam rnode_162to165_bb3_ld__u2_0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_162to165_bb3_ld__u2_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_162to165_bb3_ld__u2_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_162to165_bb3_ld__u2_0_reg_165_inputs_ready_NO_SHIFT_REG = rstag_162to162_bb3_ld__u2_valid_out_0;
assign rstag_162to162_bb3_ld__u2_stall_in_0 = rnode_162to165_bb3_ld__u2_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_162to165_bb3_ld__u2_0_NO_SHIFT_REG = rnode_162to165_bb3_ld__u2_0_reg_165_NO_SHIFT_REG;
assign rnode_162to165_bb3_ld__u2_0_stall_in_reg_165_NO_SHIFT_REG = rnode_162to165_bb3_ld__u2_0_stall_in_NO_SHIFT_REG;
assign rnode_162to165_bb3_ld__u2_0_valid_out_NO_SHIFT_REG = rnode_162to165_bb3_ld__u2_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 3
//  * capacity = 3
 logic rnode_162to165_bb3_ld__0_valid_out_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_162to165_bb3_ld__0_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_162to165_bb3_ld__0_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_162to165_bb3_ld__0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_162to165_bb3_ld__0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_162to165_bb3_ld__0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_162to165_bb3_ld__0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_162to165_bb3_ld__0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_162to165_bb3_ld__0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rstag_162to162_bb3_ld_),
	.data_out(rnode_162to165_bb3_ld__0_reg_165_NO_SHIFT_REG)
);

defparam rnode_162to165_bb3_ld__0_reg_165_fifo.DEPTH = 4;
defparam rnode_162to165_bb3_ld__0_reg_165_fifo.DATA_WIDTH = 32;
defparam rnode_162to165_bb3_ld__0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_162to165_bb3_ld__0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_162to165_bb3_ld__0_reg_165_inputs_ready_NO_SHIFT_REG = rstag_162to162_bb3_ld__valid_out_0;
assign rstag_162to162_bb3_ld__stall_in_0 = rnode_162to165_bb3_ld__0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_162to165_bb3_ld__0_NO_SHIFT_REG = rnode_162to165_bb3_ld__0_reg_165_NO_SHIFT_REG;
assign rnode_162to165_bb3_ld__0_stall_in_reg_165_NO_SHIFT_REG = rnode_162to165_bb3_ld__0_stall_in_NO_SHIFT_REG;
assign rnode_162to165_bb3_ld__0_valid_out_NO_SHIFT_REG = rnode_162to165_bb3_ld__0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb3_cmp35_inputs_ready;
 reg local_bb3_cmp35_valid_out_NO_SHIFT_REG;
wire local_bb3_cmp35_stall_in;
wire local_bb3_cmp35_output_regs_ready;
wire local_bb3_cmp35;
 reg local_bb3_cmp35_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb3_cmp35_valid_pipe_1_NO_SHIFT_REG;
wire local_bb3_cmp35_causedstall;

acl_fp_cmp fp_module_local_bb3_cmp35 (
	.clock(clock),
	.dataa(rstag_162to162_bb3_ld__u2),
	.datab(rstag_162to162_bb3_ld_),
	.enable(local_bb3_cmp35_output_regs_ready),
	.result(local_bb3_cmp35)
);

defparam fp_module_local_bb3_cmp35.UNORDERED_MODE = 1;
defparam fp_module_local_bb3_cmp35.COMPARISON_MODE = 3;

assign local_bb3_cmp35_inputs_ready = (rstag_162to162_bb3_ld__u2_valid_out_1 & rstag_162to162_bb3_ld__valid_out_1);
assign local_bb3_cmp35_output_regs_ready = (&(~(local_bb3_cmp35_valid_out_NO_SHIFT_REG) | ~(local_bb3_cmp35_stall_in)));
assign rstag_162to162_bb3_ld__u2_stall_in_1 = (~(local_bb3_cmp35_output_regs_ready) | ~(local_bb3_cmp35_inputs_ready));
assign rstag_162to162_bb3_ld__stall_in_1 = (~(local_bb3_cmp35_output_regs_ready) | ~(local_bb3_cmp35_inputs_ready));
assign local_bb3_cmp35_causedstall = (local_bb3_cmp35_inputs_ready && (~(local_bb3_cmp35_output_regs_ready) && !(~(local_bb3_cmp35_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp35_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb3_cmp35_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp35_output_regs_ready)
		begin
			local_bb3_cmp35_valid_pipe_0_NO_SHIFT_REG <= local_bb3_cmp35_inputs_ready;
			local_bb3_cmp35_valid_pipe_1_NO_SHIFT_REG <= local_bb3_cmp35_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp35_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp35_output_regs_ready)
		begin
			local_bb3_cmp35_valid_out_NO_SHIFT_REG <= local_bb3_cmp35_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb3_cmp35_stall_in))
			begin
				local_bb3_cmp35_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb3_cmp25_inputs_ready;
 reg local_bb3_cmp25_valid_out_NO_SHIFT_REG;
wire local_bb3_cmp25_stall_in;
wire local_bb3_cmp25_output_regs_ready;
wire local_bb3_cmp25;
 reg local_bb3_cmp25_valid_pipe_0_NO_SHIFT_REG;
 reg local_bb3_cmp25_valid_pipe_1_NO_SHIFT_REG;
wire local_bb3_cmp25_causedstall;

acl_fp_cmp fp_module_local_bb3_cmp25 (
	.clock(clock),
	.dataa(rstag_162to162_bb3_ld_),
	.datab(rstag_162to162_bb3_ld__u2),
	.enable(local_bb3_cmp25_output_regs_ready),
	.result(local_bb3_cmp25)
);

defparam fp_module_local_bb3_cmp25.COMPARISON_MODE = 5;

assign local_bb3_cmp25_inputs_ready = (rstag_162to162_bb3_ld__u2_valid_out_2 & rstag_162to162_bb3_ld__valid_out_2);
assign local_bb3_cmp25_output_regs_ready = (&(~(local_bb3_cmp25_valid_out_NO_SHIFT_REG) | ~(local_bb3_cmp25_stall_in)));
assign rstag_162to162_bb3_ld__u2_stall_in_2 = (~(local_bb3_cmp25_output_regs_ready) | ~(local_bb3_cmp25_inputs_ready));
assign rstag_162to162_bb3_ld__stall_in_2 = (~(local_bb3_cmp25_output_regs_ready) | ~(local_bb3_cmp25_inputs_ready));
assign local_bb3_cmp25_causedstall = (local_bb3_cmp25_inputs_ready && (~(local_bb3_cmp25_output_regs_ready) && !(~(local_bb3_cmp25_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp25_valid_pipe_0_NO_SHIFT_REG <= 1'b0;
		local_bb3_cmp25_valid_pipe_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp25_output_regs_ready)
		begin
			local_bb3_cmp25_valid_pipe_0_NO_SHIFT_REG <= local_bb3_cmp25_inputs_ready;
			local_bb3_cmp25_valid_pipe_1_NO_SHIFT_REG <= local_bb3_cmp25_valid_pipe_0_NO_SHIFT_REG;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_cmp25_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb3_cmp25_output_regs_ready)
		begin
			local_bb3_cmp25_valid_out_NO_SHIFT_REG <= local_bb3_cmp25_valid_pipe_1_NO_SHIFT_REG;
		end
		else
		begin
			if (~(local_bb3_cmp25_stall_in))
			begin
				local_bb3_cmp25_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_165to165_bb3_cmp35_0_valid_out_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp35_0_stall_in_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp35_0_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp35_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp35_0_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp35_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp35_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp35_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_165to165_bb3_cmp35_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to165_bb3_cmp35_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to165_bb3_cmp35_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_165to165_bb3_cmp35_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_165to165_bb3_cmp35_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb3_cmp35),
	.data_out(rnode_165to165_bb3_cmp35_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_165to165_bb3_cmp35_0_reg_165_fifo.DEPTH = 3;
defparam rnode_165to165_bb3_cmp35_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_165to165_bb3_cmp35_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to165_bb3_cmp35_0_reg_165_fifo.IMPL = "zl_reg";

assign rnode_165to165_bb3_cmp35_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb3_cmp35_valid_out_NO_SHIFT_REG;
assign local_bb3_cmp35_stall_in = rnode_165to165_bb3_cmp35_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp35_0_NO_SHIFT_REG = rnode_165to165_bb3_cmp35_0_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp35_0_stall_in_reg_165_NO_SHIFT_REG = rnode_165to165_bb3_cmp35_0_stall_in_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp35_0_valid_out_NO_SHIFT_REG = rnode_165to165_bb3_cmp35_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 0
//  * capacity = 2
 logic rnode_165to165_bb3_cmp25_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_1_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_stall_out_reg_165_NO_SHIFT_REG;
 logic rnode_165to165_bb3_cmp25_0_reg_165_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_165to165_bb3_cmp25_0_reg_165_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_165to165_bb3_cmp25_0_reg_165_NO_SHIFT_REG),
	.valid_in(rnode_165to165_bb3_cmp25_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_165to165_bb3_cmp25_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.data_out(rnode_165to165_bb3_cmp25_0_reg_165_NO_SHIFT_REG_fa),
	.valid_out({rnode_165to165_bb3_cmp25_0_valid_out_0_NO_SHIFT_REG, rnode_165to165_bb3_cmp25_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_165to165_bb3_cmp25_0_stall_in_0_NO_SHIFT_REG, rnode_165to165_bb3_cmp25_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_165to165_bb3_cmp25_0_reg_165_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_165to165_bb3_cmp25_0_reg_165_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_165to165_bb3_cmp25_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_165to165_bb3_cmp25_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_165to165_bb3_cmp25_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_165to165_bb3_cmp25_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_165to165_bb3_cmp25_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb3_cmp25),
	.data_out(rnode_165to165_bb3_cmp25_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_165to165_bb3_cmp25_0_reg_165_fifo.DEPTH = 3;
defparam rnode_165to165_bb3_cmp25_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_165to165_bb3_cmp25_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_165to165_bb3_cmp25_0_reg_165_fifo.IMPL = "zl_reg";

assign rnode_165to165_bb3_cmp25_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb3_cmp25_valid_out_NO_SHIFT_REG;
assign local_bb3_cmp25_stall_in = rnode_165to165_bb3_cmp25_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_165to165_bb3_cmp25_0_NO_SHIFT_REG = rnode_165to165_bb3_cmp25_0_reg_165_NO_SHIFT_REG_fa;
assign rnode_165to165_bb3_cmp25_1_NO_SHIFT_REG = rnode_165to165_bb3_cmp25_0_reg_165_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb3_var__u3_stall_local;
wire local_bb3_var__u3;

assign local_bb3_var__u3 = (rnode_164to165_bb3_var__u1_0_NO_SHIFT_REG | rnode_165to165_bb3_cmp25_1_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u5_stall_local;
wire local_bb3_var__u5;

assign local_bb3_var__u5 = (local_bb3_var__u3 ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb3_var__u3_valid_out_1;
wire local_bb3_var__u3_stall_in_1;
 reg local_bb3_var__u3_consumed_1_NO_SHIFT_REG;
wire local_bb3_var__u4_valid_out;
wire local_bb3_var__u4_stall_in;
 reg local_bb3_var__u4_consumed_0_NO_SHIFT_REG;
wire local_bb3_var__u4_inputs_ready;
wire local_bb3_var__u4_stall_local;
wire local_bb3_var__u4;

assign local_bb3_var__u4_inputs_ready = (rnode_164to165_bb3_var__u1_0_valid_out_0_NO_SHIFT_REG & rnode_165to165_bb3_cmp25_0_valid_out_1_NO_SHIFT_REG & rnode_165to165_bb3_cmp35_0_valid_out_NO_SHIFT_REG);
assign local_bb3_var__u4 = (rnode_165to165_bb3_cmp35_0_NO_SHIFT_REG & local_bb3_var__u5);
assign local_bb3_var__u4_stall_local = ((local_bb3_var__u3_stall_in_1 & ~(local_bb3_var__u3_consumed_1_NO_SHIFT_REG)) | (local_bb3_var__u4_stall_in & ~(local_bb3_var__u4_consumed_0_NO_SHIFT_REG)));
assign local_bb3_var__u3_valid_out_1 = (local_bb3_var__u4_inputs_ready & ~(local_bb3_var__u3_consumed_1_NO_SHIFT_REG));
assign local_bb3_var__u4_valid_out = (local_bb3_var__u4_inputs_ready & ~(local_bb3_var__u4_consumed_0_NO_SHIFT_REG));
assign rnode_164to165_bb3_var__u1_0_stall_in_0_NO_SHIFT_REG = (local_bb3_var__u4_stall_local | ~(local_bb3_var__u4_inputs_ready));
assign rnode_165to165_bb3_cmp25_0_stall_in_1_NO_SHIFT_REG = (local_bb3_var__u4_stall_local | ~(local_bb3_var__u4_inputs_ready));
assign rnode_165to165_bb3_cmp35_0_stall_in_NO_SHIFT_REG = (local_bb3_var__u4_stall_local | ~(local_bb3_var__u4_inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb3_var__u3_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb3_var__u4_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb3_var__u3_consumed_1_NO_SHIFT_REG <= (local_bb3_var__u4_inputs_ready & (local_bb3_var__u3_consumed_1_NO_SHIFT_REG | ~(local_bb3_var__u3_stall_in_1)) & local_bb3_var__u4_stall_local);
		local_bb3_var__u4_consumed_0_NO_SHIFT_REG <= (local_bb3_var__u4_inputs_ready & (local_bb3_var__u4_consumed_0_NO_SHIFT_REG | ~(local_bb3_var__u4_stall_in)) & local_bb3_var__u4_stall_local);
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [63:0] lvb_mul_reg_NO_SHIFT_REG;
 reg lvb_cmp_reg_NO_SHIFT_REG;
 reg [63:0] lvb_sub_reg_NO_SHIFT_REG;
 reg [63:0] lvb_div_reg_NO_SHIFT_REG;
 reg lvb_var__reg_NO_SHIFT_REG;
 reg [63:0] lvb_left_lower_0_ph_reg_NO_SHIFT_REG;
 reg lvb_cmp6_reg_NO_SHIFT_REG;
 reg [63:0] lvb_arrayidx24_reg_NO_SHIFT_REG;
 reg lvb_not_cmp6_reg_NO_SHIFT_REG;
 reg lvb_var__u0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_right_lower_0_ph6_reg_NO_SHIFT_REG;
 reg [63:0] lvb_temp_index_0_ph7_reg_NO_SHIFT_REG;
 reg lvb_bb3_cmp8_reg_NO_SHIFT_REG;
 reg lvb_bb3_or_cond_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb3_arrayidx23_reg_NO_SHIFT_REG;
 reg lvb_bb3_var__reg_NO_SHIFT_REG;
 reg lvb_bb3_var__u1_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb3_ld__reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb3_ld__u2_reg_NO_SHIFT_REG;
 reg lvb_bb3_cmp25_reg_NO_SHIFT_REG;
 reg lvb_bb3_var__u3_reg_NO_SHIFT_REG;
 reg lvb_bb3_var__u4_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb3_var__u4_valid_out & local_bb3_var__valid_out & local_bb3_or_cond_valid_out_1 & local_bb3_var__u3_valid_out_1 & rnode_162to165_bb3_ld__0_valid_out_NO_SHIFT_REG & rnode_162to165_bb3_ld__u2_0_valid_out_NO_SHIFT_REG & rnode_164to165_cmp6_0_valid_out_1_NO_SHIFT_REG & rnode_164to165_var__0_valid_out_1_NO_SHIFT_REG & rnode_164to165_mul_0_valid_out_NO_SHIFT_REG & rnode_164to165_cmp_0_valid_out_NO_SHIFT_REG & rnode_164to165_sub_0_valid_out_NO_SHIFT_REG & rnode_164to165_div_0_valid_out_NO_SHIFT_REG & rnode_164to165_left_lower_0_ph_0_valid_out_NO_SHIFT_REG & rnode_164to165_not_cmp6_0_valid_out_NO_SHIFT_REG & rnode_164to165_temp_index_0_ph7_0_valid_out_NO_SHIFT_REG & rnode_164to165_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rnode_164to165_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG & rnode_164to165_var__u0_0_valid_out_NO_SHIFT_REG & rnode_164to165_arrayidx24_0_valid_out_NO_SHIFT_REG & rnode_164to165_bb3_cmp8_0_valid_out_1_NO_SHIFT_REG & rnode_164to165_bb3_arrayidx23_0_valid_out_NO_SHIFT_REG & rnode_164to165_bb3_var__u1_0_valid_out_1_NO_SHIFT_REG & rnode_165to165_bb3_cmp25_0_valid_out_0_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb3_var__u4_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb3_var__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb3_or_cond_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign local_bb3_var__u3_stall_in_1 = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_162to165_bb3_ld__0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_162to165_bb3_ld__u2_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_cmp6_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_var__0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_mul_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_cmp_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_sub_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_div_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_left_lower_0_ph_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_not_cmp6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_temp_index_0_ph7_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_var__u0_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_arrayidx24_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_bb3_cmp8_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_bb3_arrayidx23_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_bb3_var__u1_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_165to165_bb3_cmp25_0_stall_in_0_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_mul = lvb_mul_reg_NO_SHIFT_REG;
assign lvb_cmp = lvb_cmp_reg_NO_SHIFT_REG;
assign lvb_sub = lvb_sub_reg_NO_SHIFT_REG;
assign lvb_div = lvb_div_reg_NO_SHIFT_REG;
assign lvb_var_ = lvb_var__reg_NO_SHIFT_REG;
assign lvb_left_lower_0_ph = lvb_left_lower_0_ph_reg_NO_SHIFT_REG;
assign lvb_cmp6 = lvb_cmp6_reg_NO_SHIFT_REG;
assign lvb_arrayidx24 = lvb_arrayidx24_reg_NO_SHIFT_REG;
assign lvb_not_cmp6 = lvb_not_cmp6_reg_NO_SHIFT_REG;
assign lvb_var__u0 = lvb_var__u0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph6 = lvb_right_lower_0_ph6_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph7 = lvb_temp_index_0_ph7_reg_NO_SHIFT_REG;
assign lvb_bb3_cmp8 = lvb_bb3_cmp8_reg_NO_SHIFT_REG;
assign lvb_bb3_or_cond = lvb_bb3_or_cond_reg_NO_SHIFT_REG;
assign lvb_bb3_arrayidx23 = lvb_bb3_arrayidx23_reg_NO_SHIFT_REG;
assign lvb_bb3_var_ = lvb_bb3_var__reg_NO_SHIFT_REG;
assign lvb_bb3_var__u1 = lvb_bb3_var__u1_reg_NO_SHIFT_REG;
assign lvb_bb3_ld_ = lvb_bb3_ld__reg_NO_SHIFT_REG;
assign lvb_bb3_ld__u2 = lvb_bb3_ld__u2_reg_NO_SHIFT_REG;
assign lvb_bb3_cmp25 = lvb_bb3_cmp25_reg_NO_SHIFT_REG;
assign lvb_bb3_var__u3 = lvb_bb3_var__u3_reg_NO_SHIFT_REG;
assign lvb_bb3_var__u4 = lvb_bb3_var__u4_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_mul_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp_reg_NO_SHIFT_REG <= 'x;
		lvb_sub_reg_NO_SHIFT_REG <= 'x;
		lvb_div_reg_NO_SHIFT_REG <= 'x;
		lvb_var__reg_NO_SHIFT_REG <= 'x;
		lvb_left_lower_0_ph_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp6_reg_NO_SHIFT_REG <= 'x;
		lvb_arrayidx24_reg_NO_SHIFT_REG <= 'x;
		lvb_not_cmp6_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u0_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph6_reg_NO_SHIFT_REG <= 'x;
		lvb_temp_index_0_ph7_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_cmp8_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_or_cond_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_arrayidx23_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_var__reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_var__u1_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_ld__reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_ld__u2_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_cmp25_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_var__u3_reg_NO_SHIFT_REG <= 'x;
		lvb_bb3_var__u4_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_mul_reg_NO_SHIFT_REG <= rnode_164to165_mul_0_NO_SHIFT_REG;
			lvb_cmp_reg_NO_SHIFT_REG <= rnode_164to165_cmp_0_NO_SHIFT_REG;
			lvb_sub_reg_NO_SHIFT_REG <= rnode_164to165_sub_0_NO_SHIFT_REG;
			lvb_div_reg_NO_SHIFT_REG <= rnode_164to165_div_0_NO_SHIFT_REG;
			lvb_var__reg_NO_SHIFT_REG <= rnode_164to165_var__1_NO_SHIFT_REG;
			lvb_left_lower_0_ph_reg_NO_SHIFT_REG <= rnode_164to165_left_lower_0_ph_0_NO_SHIFT_REG;
			lvb_cmp6_reg_NO_SHIFT_REG <= rnode_164to165_cmp6_1_NO_SHIFT_REG;
			lvb_arrayidx24_reg_NO_SHIFT_REG <= rnode_164to165_arrayidx24_0_NO_SHIFT_REG;
			lvb_not_cmp6_reg_NO_SHIFT_REG <= rnode_164to165_not_cmp6_0_NO_SHIFT_REG;
			lvb_var__u0_reg_NO_SHIFT_REG <= rnode_164to165_var__u0_0_NO_SHIFT_REG;
			lvb_right_lower_0_ph6_reg_NO_SHIFT_REG <= rnode_164to165_right_lower_0_ph6_0_NO_SHIFT_REG;
			lvb_temp_index_0_ph7_reg_NO_SHIFT_REG <= rnode_164to165_temp_index_0_ph7_0_NO_SHIFT_REG;
			lvb_bb3_cmp8_reg_NO_SHIFT_REG <= rnode_164to165_bb3_cmp8_1_NO_SHIFT_REG;
			lvb_bb3_or_cond_reg_NO_SHIFT_REG <= local_bb3_or_cond;
			lvb_bb3_arrayidx23_reg_NO_SHIFT_REG <= rnode_164to165_bb3_arrayidx23_0_NO_SHIFT_REG;
			lvb_bb3_var__reg_NO_SHIFT_REG <= local_bb3_var_;
			lvb_bb3_var__u1_reg_NO_SHIFT_REG <= rnode_164to165_bb3_var__u1_1_NO_SHIFT_REG;
			lvb_bb3_ld__reg_NO_SHIFT_REG <= rnode_162to165_bb3_ld__0_NO_SHIFT_REG;
			lvb_bb3_ld__u2_reg_NO_SHIFT_REG <= rnode_162to165_bb3_ld__u2_0_NO_SHIFT_REG;
			lvb_bb3_cmp25_reg_NO_SHIFT_REG <= rnode_165to165_bb3_cmp25_0_NO_SHIFT_REG;
			lvb_bb3_var__u3_reg_NO_SHIFT_REG <= local_bb3_var__u3;
			lvb_bb3_var__u4_reg_NO_SHIFT_REG <= local_bb3_var__u4;
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
		input [63:0] 		input_mul_0,
		input 		input_cmp_0,
		input [63:0] 		input_sub_0,
		input [63:0] 		input_div_0,
		input 		input_var__0,
		input [63:0] 		input_left_lower_0_ph_0,
		input 		input_cmp6_0,
		input [63:0] 		input_arrayidx24_0,
		input 		input_not_cmp6_0,
		input 		input_var__u6_0,
		input [63:0] 		input_right_lower_0_ph6_0,
		input [63:0] 		input_temp_index_0_ph7_0,
		input 		input_cmp8_0,
		input 		input_or_cond_0,
		input [63:0] 		input_arrayidx23_0,
		input 		input_var__u7_0,
		input 		input_var__u8_0,
		input [31:0] 		input_ld__0,
		input [31:0] 		input_ld__u9_0,
		input 		input_cmp25_0,
		input 		input_var__u10_0,
		input 		input_var__u11_0,
		input [31:0] 		input_acl_hw_wg_id_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [63:0] 		input_mul_1,
		input 		input_cmp_1,
		input [63:0] 		input_sub_1,
		input [63:0] 		input_div_1,
		input 		input_var__1,
		input [63:0] 		input_left_lower_0_ph_1,
		input 		input_cmp6_1,
		input [63:0] 		input_arrayidx24_1,
		input 		input_not_cmp6_1,
		input 		input_var__u6_1,
		input [63:0] 		input_right_lower_0_ph6_1,
		input [63:0] 		input_temp_index_0_ph7_1,
		input 		input_cmp8_1,
		input 		input_or_cond_1,
		input [63:0] 		input_arrayidx23_1,
		input 		input_var__u7_1,
		input 		input_var__u8_1,
		input [31:0] 		input_ld__1,
		input [31:0] 		input_ld__u9_1,
		input 		input_cmp25_1,
		input 		input_var__u10_1,
		input 		input_var__u11_1,
		input [31:0] 		input_acl_hw_wg_id_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output [63:0] 		lvb_mul_0,
		output 		lvb_cmp_0,
		output [63:0] 		lvb_sub_0,
		output [63:0] 		lvb_div_0,
		output 		lvb_var__0,
		output [63:0] 		lvb_left_lower_0_ph_0,
		output 		lvb_cmp6_0,
		output [63:0] 		lvb_arrayidx24_0,
		output 		lvb_not_cmp6_0,
		output 		lvb_var__u6_0,
		output [63:0] 		lvb_right_lower_0_ph6_0,
		output [63:0] 		lvb_temp_index_0_ph7_0,
		output 		lvb_cmp8_0,
		output 		lvb_or_cond_0,
		output [63:0] 		lvb_arrayidx23_0,
		output 		lvb_var__u7_0,
		output 		lvb_var__u8_0,
		output [31:0] 		lvb_ld__0,
		output [31:0] 		lvb_ld__u9_0,
		output 		lvb_cmp25_0,
		output 		lvb_var__u10_0,
		output 		lvb_var__u11_0,
		output [31:0] 		lvb_input_acl_hw_wg_id_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [63:0] 		lvb_mul_1,
		output 		lvb_cmp_1,
		output [63:0] 		lvb_sub_1,
		output [63:0] 		lvb_div_1,
		output 		lvb_var__1,
		output [63:0] 		lvb_left_lower_0_ph_1,
		output 		lvb_cmp6_1,
		output [63:0] 		lvb_arrayidx24_1,
		output 		lvb_not_cmp6_1,
		output 		lvb_var__u6_1,
		output [63:0] 		lvb_right_lower_0_ph6_1,
		output [63:0] 		lvb_temp_index_0_ph7_1,
		output 		lvb_cmp8_1,
		output 		lvb_or_cond_1,
		output [63:0] 		lvb_arrayidx23_1,
		output 		lvb_var__u7_1,
		output 		lvb_var__u8_1,
		output [31:0] 		lvb_ld__1,
		output [31:0] 		lvb_ld__u9_1,
		output 		lvb_cmp25_1,
		output 		lvb_var__u10_1,
		output 		lvb_var__u11_1,
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
 reg [63:0] input_mul_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_div_0_staging_reg_NO_SHIFT_REG;
 reg input_var__0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp6_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx24_0_staging_reg_NO_SHIFT_REG;
 reg input_not_cmp6_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u6_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_right_lower_0_ph6_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_temp_index_0_ph7_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp8_0_staging_reg_NO_SHIFT_REG;
 reg input_or_cond_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx23_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u7_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u8_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__u9_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp25_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u10_0_staging_reg_NO_SHIFT_REG;
 reg input_var__u11_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] local_lvm_mul_NO_SHIFT_REG;
 reg local_lvm_cmp_NO_SHIFT_REG;
 reg [63:0] local_lvm_sub_NO_SHIFT_REG;
 reg [63:0] local_lvm_div_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg [63:0] local_lvm_left_lower_0_ph_NO_SHIFT_REG;
 reg local_lvm_cmp6_NO_SHIFT_REG;
 reg [63:0] local_lvm_arrayidx24_NO_SHIFT_REG;
 reg local_lvm_not_cmp6_NO_SHIFT_REG;
 reg local_lvm_var__u6_NO_SHIFT_REG;
 reg [63:0] local_lvm_right_lower_0_ph6_NO_SHIFT_REG;
 reg [63:0] local_lvm_temp_index_0_ph7_NO_SHIFT_REG;
 reg local_lvm_cmp8_NO_SHIFT_REG;
 reg local_lvm_or_cond_NO_SHIFT_REG;
 reg [63:0] local_lvm_arrayidx23_NO_SHIFT_REG;
 reg local_lvm_var__u7_NO_SHIFT_REG;
 reg local_lvm_var__u8_NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__u9_NO_SHIFT_REG;
 reg local_lvm_cmp25_NO_SHIFT_REG;
 reg local_lvm_var__u10_NO_SHIFT_REG;
 reg local_lvm_var__u11_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_mul_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_div_1_staging_reg_NO_SHIFT_REG;
 reg input_var__1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp6_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx24_1_staging_reg_NO_SHIFT_REG;
 reg input_not_cmp6_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u6_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_right_lower_0_ph6_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_temp_index_0_ph7_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp8_1_staging_reg_NO_SHIFT_REG;
 reg input_or_cond_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx23_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u7_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u8_1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__1_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__u9_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp25_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u10_1_staging_reg_NO_SHIFT_REG;
 reg input_var__u11_1_staging_reg_NO_SHIFT_REG;
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
		input_mul_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_sub_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_div_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx24_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_not_cmp6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph6_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp8_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_or_cond_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx23_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u7_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u8_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__u9_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp25_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u10_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u11_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_mul_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_sub_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_div_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx24_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_not_cmp6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph6_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp8_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_or_cond_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx23_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u7_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u8_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__u9_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp25_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u10_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u11_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_mul_0_staging_reg_NO_SHIFT_REG <= input_mul_0;
				input_cmp_0_staging_reg_NO_SHIFT_REG <= input_cmp_0;
				input_sub_0_staging_reg_NO_SHIFT_REG <= input_sub_0;
				input_div_0_staging_reg_NO_SHIFT_REG <= input_div_0;
				input_var__0_staging_reg_NO_SHIFT_REG <= input_var__0;
				input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG <= input_left_lower_0_ph_0;
				input_cmp6_0_staging_reg_NO_SHIFT_REG <= input_cmp6_0;
				input_arrayidx24_0_staging_reg_NO_SHIFT_REG <= input_arrayidx24_0;
				input_not_cmp6_0_staging_reg_NO_SHIFT_REG <= input_not_cmp6_0;
				input_var__u6_0_staging_reg_NO_SHIFT_REG <= input_var__u6_0;
				input_right_lower_0_ph6_0_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph6_0;
				input_temp_index_0_ph7_0_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph7_0;
				input_cmp8_0_staging_reg_NO_SHIFT_REG <= input_cmp8_0;
				input_or_cond_0_staging_reg_NO_SHIFT_REG <= input_or_cond_0;
				input_arrayidx23_0_staging_reg_NO_SHIFT_REG <= input_arrayidx23_0;
				input_var__u7_0_staging_reg_NO_SHIFT_REG <= input_var__u7_0;
				input_var__u8_0_staging_reg_NO_SHIFT_REG <= input_var__u8_0;
				input_ld__0_staging_reg_NO_SHIFT_REG <= input_ld__0;
				input_ld__u9_0_staging_reg_NO_SHIFT_REG <= input_ld__u9_0;
				input_cmp25_0_staging_reg_NO_SHIFT_REG <= input_cmp25_0;
				input_var__u10_0_staging_reg_NO_SHIFT_REG <= input_var__u10_0;
				input_var__u11_0_staging_reg_NO_SHIFT_REG <= input_var__u11_0;
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
				input_mul_1_staging_reg_NO_SHIFT_REG <= input_mul_1;
				input_cmp_1_staging_reg_NO_SHIFT_REG <= input_cmp_1;
				input_sub_1_staging_reg_NO_SHIFT_REG <= input_sub_1;
				input_div_1_staging_reg_NO_SHIFT_REG <= input_div_1;
				input_var__1_staging_reg_NO_SHIFT_REG <= input_var__1;
				input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG <= input_left_lower_0_ph_1;
				input_cmp6_1_staging_reg_NO_SHIFT_REG <= input_cmp6_1;
				input_arrayidx24_1_staging_reg_NO_SHIFT_REG <= input_arrayidx24_1;
				input_not_cmp6_1_staging_reg_NO_SHIFT_REG <= input_not_cmp6_1;
				input_var__u6_1_staging_reg_NO_SHIFT_REG <= input_var__u6_1;
				input_right_lower_0_ph6_1_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph6_1;
				input_temp_index_0_ph7_1_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph7_1;
				input_cmp8_1_staging_reg_NO_SHIFT_REG <= input_cmp8_1;
				input_or_cond_1_staging_reg_NO_SHIFT_REG <= input_or_cond_1;
				input_arrayidx23_1_staging_reg_NO_SHIFT_REG <= input_arrayidx23_1;
				input_var__u7_1_staging_reg_NO_SHIFT_REG <= input_var__u7_1;
				input_var__u8_1_staging_reg_NO_SHIFT_REG <= input_var__u8_1;
				input_ld__1_staging_reg_NO_SHIFT_REG <= input_ld__1;
				input_ld__u9_1_staging_reg_NO_SHIFT_REG <= input_ld__u9_1;
				input_cmp25_1_staging_reg_NO_SHIFT_REG <= input_cmp25_1;
				input_var__u10_1_staging_reg_NO_SHIFT_REG <= input_var__u10_1;
				input_var__u11_1_staging_reg_NO_SHIFT_REG <= input_var__u11_1;
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
					local_lvm_mul_NO_SHIFT_REG <= input_mul_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_0_staging_reg_NO_SHIFT_REG;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_0_staging_reg_NO_SHIFT_REG;
					local_lvm_div_NO_SHIFT_REG <= input_div_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__0_staging_reg_NO_SHIFT_REG;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_0_staging_reg_NO_SHIFT_REG;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u6_NO_SHIFT_REG <= input_var__u6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_0_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp8_NO_SHIFT_REG <= input_cmp8_0_staging_reg_NO_SHIFT_REG;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_0_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx23_NO_SHIFT_REG <= input_arrayidx23_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u7_NO_SHIFT_REG <= input_var__u7_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u8_NO_SHIFT_REG <= input_var__u8_0_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__u9_NO_SHIFT_REG <= input_ld__u9_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp25_NO_SHIFT_REG <= input_cmp25_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u10_NO_SHIFT_REG <= input_var__u10_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u11_NO_SHIFT_REG <= input_var__u11_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul_0;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_0;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_0;
					local_lvm_div_NO_SHIFT_REG <= input_div_0;
					local_lvm_var__NO_SHIFT_REG <= input_var__0;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_0;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6_0;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_0;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6_0;
					local_lvm_var__u6_NO_SHIFT_REG <= input_var__u6_0;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_0;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7_0;
					local_lvm_cmp8_NO_SHIFT_REG <= input_cmp8_0;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_0;
					local_lvm_arrayidx23_NO_SHIFT_REG <= input_arrayidx23_0;
					local_lvm_var__u7_NO_SHIFT_REG <= input_var__u7_0;
					local_lvm_var__u8_NO_SHIFT_REG <= input_var__u8_0;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__0;
					local_lvm_ld__u9_NO_SHIFT_REG <= input_ld__u9_0;
					local_lvm_cmp25_NO_SHIFT_REG <= input_cmp25_0;
					local_lvm_var__u10_NO_SHIFT_REG <= input_var__u10_0;
					local_lvm_var__u11_NO_SHIFT_REG <= input_var__u11_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_1_staging_reg_NO_SHIFT_REG;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_1_staging_reg_NO_SHIFT_REG;
					local_lvm_div_NO_SHIFT_REG <= input_div_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__1_staging_reg_NO_SHIFT_REG;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_1_staging_reg_NO_SHIFT_REG;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u6_NO_SHIFT_REG <= input_var__u6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_1_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp8_NO_SHIFT_REG <= input_cmp8_1_staging_reg_NO_SHIFT_REG;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_1_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx23_NO_SHIFT_REG <= input_arrayidx23_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u7_NO_SHIFT_REG <= input_var__u7_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u8_NO_SHIFT_REG <= input_var__u8_1_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__u9_NO_SHIFT_REG <= input_ld__u9_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp25_NO_SHIFT_REG <= input_cmp25_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u10_NO_SHIFT_REG <= input_var__u10_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u11_NO_SHIFT_REG <= input_var__u11_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul_1;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_1;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_1;
					local_lvm_div_NO_SHIFT_REG <= input_div_1;
					local_lvm_var__NO_SHIFT_REG <= input_var__1;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_1;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6_1;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_1;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6_1;
					local_lvm_var__u6_NO_SHIFT_REG <= input_var__u6_1;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_1;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7_1;
					local_lvm_cmp8_NO_SHIFT_REG <= input_cmp8_1;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_1;
					local_lvm_arrayidx23_NO_SHIFT_REG <= input_arrayidx23_1;
					local_lvm_var__u7_NO_SHIFT_REG <= input_var__u7_1;
					local_lvm_var__u8_NO_SHIFT_REG <= input_var__u8_1;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__1;
					local_lvm_ld__u9_NO_SHIFT_REG <= input_ld__u9_1;
					local_lvm_cmp25_NO_SHIFT_REG <= input_cmp25_1;
					local_lvm_var__u10_NO_SHIFT_REG <= input_var__u10_1;
					local_lvm_var__u11_NO_SHIFT_REG <= input_var__u11_1;
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
 reg [63:0] lvb_mul_0_reg_NO_SHIFT_REG;
 reg lvb_cmp_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_sub_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_div_0_reg_NO_SHIFT_REG;
 reg lvb_var__0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG;
 reg lvb_cmp6_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_arrayidx24_0_reg_NO_SHIFT_REG;
 reg lvb_not_cmp6_0_reg_NO_SHIFT_REG;
 reg lvb_var__u6_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_temp_index_0_ph7_0_reg_NO_SHIFT_REG;
 reg lvb_cmp8_0_reg_NO_SHIFT_REG;
 reg lvb_or_cond_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_arrayidx23_0_reg_NO_SHIFT_REG;
 reg lvb_var__u7_0_reg_NO_SHIFT_REG;
 reg lvb_var__u8_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__u9_0_reg_NO_SHIFT_REG;
 reg lvb_cmp25_0_reg_NO_SHIFT_REG;
 reg lvb_var__u10_0_reg_NO_SHIFT_REG;
 reg lvb_var__u11_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = merge_node_valid_out_NO_SHIFT_REG;
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign merge_node_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_mul_0 = lvb_mul_0_reg_NO_SHIFT_REG;
assign lvb_mul_1 = lvb_mul_0_reg_NO_SHIFT_REG;
assign lvb_cmp_0 = lvb_cmp_0_reg_NO_SHIFT_REG;
assign lvb_cmp_1 = lvb_cmp_0_reg_NO_SHIFT_REG;
assign lvb_sub_0 = lvb_sub_0_reg_NO_SHIFT_REG;
assign lvb_sub_1 = lvb_sub_0_reg_NO_SHIFT_REG;
assign lvb_div_0 = lvb_div_0_reg_NO_SHIFT_REG;
assign lvb_div_1 = lvb_div_0_reg_NO_SHIFT_REG;
assign lvb_var__0 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_var__1 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_left_lower_0_ph_0 = lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG;
assign lvb_left_lower_0_ph_1 = lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG;
assign lvb_cmp6_0 = lvb_cmp6_0_reg_NO_SHIFT_REG;
assign lvb_cmp6_1 = lvb_cmp6_0_reg_NO_SHIFT_REG;
assign lvb_arrayidx24_0 = lvb_arrayidx24_0_reg_NO_SHIFT_REG;
assign lvb_arrayidx24_1 = lvb_arrayidx24_0_reg_NO_SHIFT_REG;
assign lvb_not_cmp6_0 = lvb_not_cmp6_0_reg_NO_SHIFT_REG;
assign lvb_not_cmp6_1 = lvb_not_cmp6_0_reg_NO_SHIFT_REG;
assign lvb_var__u6_0 = lvb_var__u6_0_reg_NO_SHIFT_REG;
assign lvb_var__u6_1 = lvb_var__u6_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph6_0 = lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph6_1 = lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph7_0 = lvb_temp_index_0_ph7_0_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph7_1 = lvb_temp_index_0_ph7_0_reg_NO_SHIFT_REG;
assign lvb_cmp8_0 = lvb_cmp8_0_reg_NO_SHIFT_REG;
assign lvb_cmp8_1 = lvb_cmp8_0_reg_NO_SHIFT_REG;
assign lvb_or_cond_0 = lvb_or_cond_0_reg_NO_SHIFT_REG;
assign lvb_or_cond_1 = lvb_or_cond_0_reg_NO_SHIFT_REG;
assign lvb_arrayidx23_0 = lvb_arrayidx23_0_reg_NO_SHIFT_REG;
assign lvb_arrayidx23_1 = lvb_arrayidx23_0_reg_NO_SHIFT_REG;
assign lvb_var__u7_0 = lvb_var__u7_0_reg_NO_SHIFT_REG;
assign lvb_var__u7_1 = lvb_var__u7_0_reg_NO_SHIFT_REG;
assign lvb_var__u8_0 = lvb_var__u8_0_reg_NO_SHIFT_REG;
assign lvb_var__u8_1 = lvb_var__u8_0_reg_NO_SHIFT_REG;
assign lvb_ld__0 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_ld__1 = lvb_ld__0_reg_NO_SHIFT_REG;
assign lvb_ld__u9_0 = lvb_ld__u9_0_reg_NO_SHIFT_REG;
assign lvb_ld__u9_1 = lvb_ld__u9_0_reg_NO_SHIFT_REG;
assign lvb_cmp25_0 = lvb_cmp25_0_reg_NO_SHIFT_REG;
assign lvb_cmp25_1 = lvb_cmp25_0_reg_NO_SHIFT_REG;
assign lvb_var__u10_0 = lvb_var__u10_0_reg_NO_SHIFT_REG;
assign lvb_var__u10_1 = lvb_var__u10_0_reg_NO_SHIFT_REG;
assign lvb_var__u11_0 = lvb_var__u11_0_reg_NO_SHIFT_REG;
assign lvb_var__u11_1 = lvb_var__u11_0_reg_NO_SHIFT_REG;
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
		lvb_mul_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp_0_reg_NO_SHIFT_REG <= 'x;
		lvb_sub_0_reg_NO_SHIFT_REG <= 'x;
		lvb_div_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__0_reg_NO_SHIFT_REG <= 'x;
		lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_arrayidx24_0_reg_NO_SHIFT_REG <= 'x;
		lvb_not_cmp6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_temp_index_0_ph7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp8_0_reg_NO_SHIFT_REG <= 'x;
		lvb_or_cond_0_reg_NO_SHIFT_REG <= 'x;
		lvb_arrayidx23_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u7_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u8_0_reg_NO_SHIFT_REG <= 'x;
		lvb_ld__0_reg_NO_SHIFT_REG <= 'x;
		lvb_ld__u9_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp25_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u10_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u11_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_mul_0_reg_NO_SHIFT_REG <= local_lvm_mul_NO_SHIFT_REG;
			lvb_cmp_0_reg_NO_SHIFT_REG <= local_lvm_cmp_NO_SHIFT_REG;
			lvb_sub_0_reg_NO_SHIFT_REG <= local_lvm_sub_NO_SHIFT_REG;
			lvb_div_0_reg_NO_SHIFT_REG <= local_lvm_div_NO_SHIFT_REG;
			lvb_var__0_reg_NO_SHIFT_REG <= local_lvm_var__NO_SHIFT_REG;
			lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG <= local_lvm_left_lower_0_ph_NO_SHIFT_REG;
			lvb_cmp6_0_reg_NO_SHIFT_REG <= local_lvm_cmp6_NO_SHIFT_REG;
			lvb_arrayidx24_0_reg_NO_SHIFT_REG <= local_lvm_arrayidx24_NO_SHIFT_REG;
			lvb_not_cmp6_0_reg_NO_SHIFT_REG <= local_lvm_not_cmp6_NO_SHIFT_REG;
			lvb_var__u6_0_reg_NO_SHIFT_REG <= local_lvm_var__u6_NO_SHIFT_REG;
			lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG <= local_lvm_right_lower_0_ph6_NO_SHIFT_REG;
			lvb_temp_index_0_ph7_0_reg_NO_SHIFT_REG <= local_lvm_temp_index_0_ph7_NO_SHIFT_REG;
			lvb_cmp8_0_reg_NO_SHIFT_REG <= local_lvm_cmp8_NO_SHIFT_REG;
			lvb_or_cond_0_reg_NO_SHIFT_REG <= local_lvm_or_cond_NO_SHIFT_REG;
			lvb_arrayidx23_0_reg_NO_SHIFT_REG <= local_lvm_arrayidx23_NO_SHIFT_REG;
			lvb_var__u7_0_reg_NO_SHIFT_REG <= local_lvm_var__u7_NO_SHIFT_REG;
			lvb_var__u8_0_reg_NO_SHIFT_REG <= local_lvm_var__u8_NO_SHIFT_REG;
			lvb_ld__0_reg_NO_SHIFT_REG <= local_lvm_ld__NO_SHIFT_REG;
			lvb_ld__u9_0_reg_NO_SHIFT_REG <= local_lvm_ld__u9_NO_SHIFT_REG;
			lvb_cmp25_0_reg_NO_SHIFT_REG <= local_lvm_cmp25_NO_SHIFT_REG;
			lvb_var__u10_0_reg_NO_SHIFT_REG <= local_lvm_var__u10_NO_SHIFT_REG;
			lvb_var__u11_0_reg_NO_SHIFT_REG <= local_lvm_var__u11_NO_SHIFT_REG;
			lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= local_lvm_var__u11_NO_SHIFT_REG;
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
		input [63:0] 		input_mul,
		input 		input_cmp,
		input [63:0] 		input_sub,
		input [63:0] 		input_div,
		input 		input_var_,
		input [63:0] 		input_left_lower_0_ph,
		input 		input_cmp6,
		input [63:0] 		input_arrayidx24,
		input 		input_not_cmp6,
		input 		input_var__u12,
		input [63:0] 		input_right_lower_0_ph6,
		input [63:0] 		input_temp_index_0_ph7,
		input 		input_cmp8,
		input 		input_or_cond,
		input [63:0] 		input_arrayidx23,
		input 		input_var__u13,
		input 		input_var__u14,
		input [31:0] 		input_ld_,
		input [31:0] 		input_ld__u15,
		input 		input_cmp25,
		input 		input_var__u16,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out_0,
		input 		stall_in_0,
		output [63:0] 		lvb_mul_0,
		output 		lvb_cmp_0,
		output [63:0] 		lvb_sub_0,
		output [63:0] 		lvb_div_0,
		output 		lvb_var__0,
		output [63:0] 		lvb_left_lower_0_ph_0,
		output 		lvb_cmp6_0,
		output [63:0] 		lvb_arrayidx24_0,
		output 		lvb_not_cmp6_0,
		output 		lvb_var__u12_0,
		output [63:0] 		lvb_right_lower_0_ph6_0,
		output [31:0] 		lvb_ld__u15_0,
		output [31:0] 		lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0,
		output [63:0] 		lvb_bb5_arrayidx31_0,
		output [63:0] 		lvb_bb5_temp_index_0_ph7_be_0,
		output [63:0] 		lvb_bb5_right_lower_0_ph6_be_0,
		output [31:0] 		lvb_input_acl_hw_wg_id_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [63:0] 		lvb_mul_1,
		output 		lvb_cmp_1,
		output [63:0] 		lvb_sub_1,
		output [63:0] 		lvb_div_1,
		output 		lvb_var__1,
		output [63:0] 		lvb_left_lower_0_ph_1,
		output 		lvb_cmp6_1,
		output [63:0] 		lvb_arrayidx24_1,
		output 		lvb_not_cmp6_1,
		output 		lvb_var__u12_1,
		output [63:0] 		lvb_right_lower_0_ph6_1,
		output [31:0] 		lvb_ld__u15_1,
		output [31:0] 		lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_1,
		output [63:0] 		lvb_bb5_arrayidx31_1,
		output [63:0] 		lvb_bb5_temp_index_0_ph7_be_1,
		output [63:0] 		lvb_bb5_right_lower_0_ph6_be_1,
		output [31:0] 		lvb_input_acl_hw_wg_id_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb5_ld__readdata,
		input 		avm_local_bb5_ld__readdatavalid,
		input 		avm_local_bb5_ld__waitrequest,
		output [29:0] 		avm_local_bb5_ld__address,
		output 		avm_local_bb5_ld__read,
		output 		avm_local_bb5_ld__write,
		input 		avm_local_bb5_ld__writeack,
		output [255:0] 		avm_local_bb5_ld__writedata,
		output [31:0] 		avm_local_bb5_ld__byteenable,
		output [4:0] 		avm_local_bb5_ld__burstcount,
		output 		local_bb5_ld__active,
		input 		clock2x,
		input [255:0] 		avm_local_bb5_st__109_readdata,
		input 		avm_local_bb5_st__109_readdatavalid,
		input 		avm_local_bb5_st__109_waitrequest,
		output [29:0] 		avm_local_bb5_st__109_address,
		output 		avm_local_bb5_st__109_read,
		output 		avm_local_bb5_st__109_write,
		input 		avm_local_bb5_st__109_writeack,
		output [255:0] 		avm_local_bb5_st__109_writedata,
		output [31:0] 		avm_local_bb5_st__109_byteenable,
		output [4:0] 		avm_local_bb5_st__109_burstcount,
		output 		local_bb5_st__109_active
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
wire merge_node_stall_in_21;
 reg merge_node_valid_out_21_NO_SHIFT_REG;
wire merge_node_stall_in_22;
 reg merge_node_valid_out_22_NO_SHIFT_REG;
wire merge_node_stall_in_23;
 reg merge_node_valid_out_23_NO_SHIFT_REG;
wire merge_node_stall_in_24;
 reg merge_node_valid_out_24_NO_SHIFT_REG;
wire merge_node_stall_in_25;
 reg merge_node_valid_out_25_NO_SHIFT_REG;
wire merge_node_stall_in_26;
 reg merge_node_valid_out_26_NO_SHIFT_REG;
wire merge_node_stall_in_27;
 reg merge_node_valid_out_27_NO_SHIFT_REG;
wire merge_node_stall_in_28;
 reg merge_node_valid_out_28_NO_SHIFT_REG;
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_mul_staging_reg_NO_SHIFT_REG;
 reg input_cmp_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_div_staging_reg_NO_SHIFT_REG;
 reg input_var__staging_reg_NO_SHIFT_REG;
 reg [63:0] input_left_lower_0_ph_staging_reg_NO_SHIFT_REG;
 reg input_cmp6_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx24_staging_reg_NO_SHIFT_REG;
 reg input_not_cmp6_staging_reg_NO_SHIFT_REG;
 reg input_var__u12_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_right_lower_0_ph6_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_temp_index_0_ph7_staging_reg_NO_SHIFT_REG;
 reg input_cmp8_staging_reg_NO_SHIFT_REG;
 reg input_or_cond_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx23_staging_reg_NO_SHIFT_REG;
 reg input_var__u13_staging_reg_NO_SHIFT_REG;
 reg input_var__u14_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__u15_staging_reg_NO_SHIFT_REG;
 reg input_cmp25_staging_reg_NO_SHIFT_REG;
 reg input_var__u16_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [63:0] local_lvm_mul_NO_SHIFT_REG;
 reg local_lvm_cmp_NO_SHIFT_REG;
 reg [63:0] local_lvm_sub_NO_SHIFT_REG;
 reg [63:0] local_lvm_div_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg [63:0] local_lvm_left_lower_0_ph_NO_SHIFT_REG;
 reg local_lvm_cmp6_NO_SHIFT_REG;
 reg [63:0] local_lvm_arrayidx24_NO_SHIFT_REG;
 reg local_lvm_not_cmp6_NO_SHIFT_REG;
 reg local_lvm_var__u12_NO_SHIFT_REG;
 reg [63:0] local_lvm_right_lower_0_ph6_NO_SHIFT_REG;
 reg [63:0] local_lvm_temp_index_0_ph7_NO_SHIFT_REG;
 reg local_lvm_cmp8_NO_SHIFT_REG;
 reg local_lvm_or_cond_NO_SHIFT_REG;
 reg [63:0] local_lvm_arrayidx23_NO_SHIFT_REG;
 reg local_lvm_var__u13_NO_SHIFT_REG;
 reg local_lvm_var__u14_NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__u15_NO_SHIFT_REG;
 reg local_lvm_cmp25_NO_SHIFT_REG;
 reg local_lvm_var__u16_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG) | (merge_node_stall_in_9 & merge_node_valid_out_9_NO_SHIFT_REG) | (merge_node_stall_in_10 & merge_node_valid_out_10_NO_SHIFT_REG) | (merge_node_stall_in_11 & merge_node_valid_out_11_NO_SHIFT_REG) | (merge_node_stall_in_12 & merge_node_valid_out_12_NO_SHIFT_REG) | (merge_node_stall_in_13 & merge_node_valid_out_13_NO_SHIFT_REG) | (merge_node_stall_in_14 & merge_node_valid_out_14_NO_SHIFT_REG) | (merge_node_stall_in_15 & merge_node_valid_out_15_NO_SHIFT_REG) | (merge_node_stall_in_16 & merge_node_valid_out_16_NO_SHIFT_REG) | (merge_node_stall_in_17 & merge_node_valid_out_17_NO_SHIFT_REG) | (merge_node_stall_in_18 & merge_node_valid_out_18_NO_SHIFT_REG) | (merge_node_stall_in_19 & merge_node_valid_out_19_NO_SHIFT_REG) | (merge_node_stall_in_20 & merge_node_valid_out_20_NO_SHIFT_REG) | (merge_node_stall_in_21 & merge_node_valid_out_21_NO_SHIFT_REG) | (merge_node_stall_in_22 & merge_node_valid_out_22_NO_SHIFT_REG) | (merge_node_stall_in_23 & merge_node_valid_out_23_NO_SHIFT_REG) | (merge_node_stall_in_24 & merge_node_valid_out_24_NO_SHIFT_REG) | (merge_node_stall_in_25 & merge_node_valid_out_25_NO_SHIFT_REG) | (merge_node_stall_in_26 & merge_node_valid_out_26_NO_SHIFT_REG) | (merge_node_stall_in_27 & merge_node_valid_out_27_NO_SHIFT_REG) | (merge_node_stall_in_28 & merge_node_valid_out_28_NO_SHIFT_REG));
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
		input_mul_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_staging_reg_NO_SHIFT_REG <= 'x;
		input_sub_staging_reg_NO_SHIFT_REG <= 'x;
		input_div_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__staging_reg_NO_SHIFT_REG <= 'x;
		input_left_lower_0_ph_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp6_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx24_staging_reg_NO_SHIFT_REG <= 'x;
		input_not_cmp6_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u12_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph6_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph7_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp8_staging_reg_NO_SHIFT_REG <= 'x;
		input_or_cond_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx23_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u13_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u14_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__u15_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp25_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__u16_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_mul_staging_reg_NO_SHIFT_REG <= input_mul;
				input_cmp_staging_reg_NO_SHIFT_REG <= input_cmp;
				input_sub_staging_reg_NO_SHIFT_REG <= input_sub;
				input_div_staging_reg_NO_SHIFT_REG <= input_div;
				input_var__staging_reg_NO_SHIFT_REG <= input_var_;
				input_left_lower_0_ph_staging_reg_NO_SHIFT_REG <= input_left_lower_0_ph;
				input_cmp6_staging_reg_NO_SHIFT_REG <= input_cmp6;
				input_arrayidx24_staging_reg_NO_SHIFT_REG <= input_arrayidx24;
				input_not_cmp6_staging_reg_NO_SHIFT_REG <= input_not_cmp6;
				input_var__u12_staging_reg_NO_SHIFT_REG <= input_var__u12;
				input_right_lower_0_ph6_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph6;
				input_temp_index_0_ph7_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph7;
				input_cmp8_staging_reg_NO_SHIFT_REG <= input_cmp8;
				input_or_cond_staging_reg_NO_SHIFT_REG <= input_or_cond;
				input_arrayidx23_staging_reg_NO_SHIFT_REG <= input_arrayidx23;
				input_var__u13_staging_reg_NO_SHIFT_REG <= input_var__u13;
				input_var__u14_staging_reg_NO_SHIFT_REG <= input_var__u14;
				input_ld__staging_reg_NO_SHIFT_REG <= input_ld_;
				input_ld__u15_staging_reg_NO_SHIFT_REG <= input_ld__u15;
				input_cmp25_staging_reg_NO_SHIFT_REG <= input_cmp25;
				input_var__u16_staging_reg_NO_SHIFT_REG <= input_var__u16;
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
					local_lvm_mul_NO_SHIFT_REG <= input_mul_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_staging_reg_NO_SHIFT_REG;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_staging_reg_NO_SHIFT_REG;
					local_lvm_div_NO_SHIFT_REG <= input_div_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__staging_reg_NO_SHIFT_REG;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_staging_reg_NO_SHIFT_REG;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u12_NO_SHIFT_REG <= input_var__u12_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp8_NO_SHIFT_REG <= input_cmp8_staging_reg_NO_SHIFT_REG;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx23_NO_SHIFT_REG <= input_arrayidx23_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u13_NO_SHIFT_REG <= input_var__u13_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u14_NO_SHIFT_REG <= input_var__u14_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__staging_reg_NO_SHIFT_REG;
					local_lvm_ld__u15_NO_SHIFT_REG <= input_ld__u15_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp25_NO_SHIFT_REG <= input_cmp25_staging_reg_NO_SHIFT_REG;
					local_lvm_var__u16_NO_SHIFT_REG <= input_var__u16_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp;
					local_lvm_sub_NO_SHIFT_REG <= input_sub;
					local_lvm_div_NO_SHIFT_REG <= input_div;
					local_lvm_var__NO_SHIFT_REG <= input_var_;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph;
					local_lvm_cmp6_NO_SHIFT_REG <= input_cmp6;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24;
					local_lvm_not_cmp6_NO_SHIFT_REG <= input_not_cmp6;
					local_lvm_var__u12_NO_SHIFT_REG <= input_var__u12;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6;
					local_lvm_temp_index_0_ph7_NO_SHIFT_REG <= input_temp_index_0_ph7;
					local_lvm_cmp8_NO_SHIFT_REG <= input_cmp8;
					local_lvm_or_cond_NO_SHIFT_REG <= input_or_cond;
					local_lvm_arrayidx23_NO_SHIFT_REG <= input_arrayidx23;
					local_lvm_var__u13_NO_SHIFT_REG <= input_var__u13;
					local_lvm_var__u14_NO_SHIFT_REG <= input_var__u14;
					local_lvm_ld__NO_SHIFT_REG <= input_ld_;
					local_lvm_ld__u15_NO_SHIFT_REG <= input_ld__u15;
					local_lvm_cmp25_NO_SHIFT_REG <= input_cmp25;
					local_lvm_var__u16_NO_SHIFT_REG <= input_var__u16;
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
		merge_node_valid_out_21_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_22_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_23_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_24_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_25_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_26_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_27_NO_SHIFT_REG <= 1'b0;
		merge_node_valid_out_28_NO_SHIFT_REG <= 1'b0;
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
			merge_node_valid_out_21_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_22_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_23_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_24_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_25_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_26_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_27_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
			merge_node_valid_out_28_NO_SHIFT_REG <= is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
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
			if (~(merge_node_stall_in_21))
			begin
				merge_node_valid_out_21_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_22))
			begin
				merge_node_valid_out_22_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_23))
			begin
				merge_node_valid_out_23_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_24))
			begin
				merge_node_valid_out_24_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_25))
			begin
				merge_node_valid_out_25_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_26))
			begin
				merge_node_valid_out_26_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_27))
			begin
				merge_node_valid_out_27_NO_SHIFT_REG <= 1'b0;
			end
			if (~(merge_node_stall_in_28))
			begin
				merge_node_valid_out_28_NO_SHIFT_REG <= 1'b0;
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
wire local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select158_stall_local;
wire [31:0] local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select158;

assign local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select158 = (local_lvm_var__u16_NO_SHIFT_REG ? 32'h0 : 32'h3);

// This section implements an unregistered operation.
// 
wire local_bb5_var__stall_local;
wire local_bb5_var_;

assign local_bb5_var_ = (local_lvm_var__u14_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb5_do_directly_if_then12_select_stall_local;
wire local_bb5_do_directly_if_then12_select;

assign local_bb5_do_directly_if_then12_select = (local_lvm_var__u13_NO_SHIFT_REG ^ local_lvm_var__u12_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb5_or_cond_not_stall_local;
wire local_bb5_or_cond_not;

assign local_bb5_or_cond_not = (local_lvm_or_cond_NO_SHIFT_REG ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb5_not_cmp8_stall_local;
wire local_bb5_not_cmp8;

assign local_bb5_not_cmp8 = (local_lvm_cmp8_NO_SHIFT_REG ^ 1'b1);

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_input_temp_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_input_temp_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_input_temp_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_input_temp_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_temp_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_input_temp_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_input_temp_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_input_temp_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_input_temp_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_input_temp_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_input_temp_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_1to160_input_temp_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_input_temp_0_reg_160_fifo.DATA_WIDTH = 0;
defparam rnode_1to160_input_temp_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_input_temp_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_input_temp_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_13_NO_SHIFT_REG;
assign merge_node_stall_in_13 = rnode_1to160_input_temp_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_input_temp_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_input_temp_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_input_temp_0_valid_out_NO_SHIFT_REG = rnode_1to160_input_temp_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_temp_index_0_ph7_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph7_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_temp_index_0_ph7_0_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph7_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_temp_index_0_ph7_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph7_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph7_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_temp_index_0_ph7_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_temp_index_0_ph7_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_temp_index_0_ph7_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_temp_index_0_ph7_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_temp_index_0_ph7_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_temp_index_0_ph7_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_temp_index_0_ph7_NO_SHIFT_REG),
	.data_out(rnode_1to160_temp_index_0_ph7_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_temp_index_0_ph7_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_temp_index_0_ph7_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_temp_index_0_ph7_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_temp_index_0_ph7_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_temp_index_0_ph7_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_14_NO_SHIFT_REG;
assign merge_node_stall_in_14 = rnode_1to160_temp_index_0_ph7_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_temp_index_0_ph7_0_NO_SHIFT_REG = rnode_1to160_temp_index_0_ph7_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_temp_index_0_ph7_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_temp_index_0_ph7_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_temp_index_0_ph7_0_valid_out_NO_SHIFT_REG = rnode_1to160_temp_index_0_ph7_0_valid_out_reg_160_NO_SHIFT_REG;

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

assign rnode_1to160_ld__0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_15_NO_SHIFT_REG;
assign merge_node_stall_in_15 = rnode_1to160_ld__0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_ld__0_NO_SHIFT_REG = rnode_1to160_ld__0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_ld__0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_ld__0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_ld__0_valid_out_NO_SHIFT_REG = rnode_1to160_ld__0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_right_lower_0_ph6_0_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_right_lower_0_ph6_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_right_lower_0_ph6_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_right_lower_0_ph6_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_right_lower_0_ph6_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_right_lower_0_ph6_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_right_lower_0_ph6_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_right_lower_0_ph6_NO_SHIFT_REG),
	.data_out(rnode_1to300_right_lower_0_ph6_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_right_lower_0_ph6_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_right_lower_0_ph6_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_right_lower_0_ph6_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_right_lower_0_ph6_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_right_lower_0_ph6_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_16_NO_SHIFT_REG;
assign merge_node_stall_in_16 = rnode_1to300_right_lower_0_ph6_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_right_lower_0_ph6_0_NO_SHIFT_REG = rnode_1to300_right_lower_0_ph6_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_right_lower_0_ph6_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG = rnode_1to300_right_lower_0_ph6_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_mul_0_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_mul_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_mul_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_mul_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_mul_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_mul_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_mul_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_mul_NO_SHIFT_REG),
	.data_out(rnode_1to300_mul_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_mul_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_mul_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_mul_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_mul_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_mul_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_17_NO_SHIFT_REG;
assign merge_node_stall_in_17 = rnode_1to300_mul_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_mul_0_NO_SHIFT_REG = rnode_1to300_mul_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_mul_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_mul_0_valid_out_NO_SHIFT_REG = rnode_1to300_mul_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_sub_0_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_sub_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_sub_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_sub_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_sub_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_sub_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_sub_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_sub_NO_SHIFT_REG),
	.data_out(rnode_1to300_sub_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_sub_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_sub_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_sub_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_sub_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_sub_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_18_NO_SHIFT_REG;
assign merge_node_stall_in_18 = rnode_1to300_sub_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_sub_0_NO_SHIFT_REG = rnode_1to300_sub_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_sub_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_sub_0_valid_out_NO_SHIFT_REG = rnode_1to300_sub_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_div_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_div_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_div_0_NO_SHIFT_REG;
 logic rnode_1to300_div_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_div_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_div_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_div_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_div_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_div_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_div_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_div_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_div_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_div_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_div_NO_SHIFT_REG),
	.data_out(rnode_1to300_div_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_div_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_div_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_div_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_div_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_div_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_19_NO_SHIFT_REG;
assign merge_node_stall_in_19 = rnode_1to300_div_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_div_0_NO_SHIFT_REG = rnode_1to300_div_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_div_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_div_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_div_0_valid_out_NO_SHIFT_REG = rnode_1to300_div_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_1to300_var__0_NO_SHIFT_REG;
 logic rnode_1to300_var__0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to300_var__0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_var__0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_var__0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_var__0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_var__0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_var__0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_var__0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_var__0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_var__0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_var__NO_SHIFT_REG),
	.data_out(rnode_1to300_var__0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_var__0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_var__0_reg_300_fifo.DATA_WIDTH = 1;
defparam rnode_1to300_var__0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_var__0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_var__0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_20_NO_SHIFT_REG;
assign merge_node_stall_in_20 = rnode_1to300_var__0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_var__0_NO_SHIFT_REG = rnode_1to300_var__0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_var__0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_var__0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_var__0_valid_out_NO_SHIFT_REG = rnode_1to300_var__0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_left_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_left_lower_0_ph_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_left_lower_0_ph_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_left_lower_0_ph_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_left_lower_0_ph_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_left_lower_0_ph_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_left_lower_0_ph_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_left_lower_0_ph_NO_SHIFT_REG),
	.data_out(rnode_1to300_left_lower_0_ph_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_left_lower_0_ph_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_left_lower_0_ph_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_left_lower_0_ph_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_left_lower_0_ph_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_left_lower_0_ph_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_21_NO_SHIFT_REG;
assign merge_node_stall_in_21 = rnode_1to300_left_lower_0_ph_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_left_lower_0_ph_0_NO_SHIFT_REG = rnode_1to300_left_lower_0_ph_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_left_lower_0_ph_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_left_lower_0_ph_0_valid_out_NO_SHIFT_REG = rnode_1to300_left_lower_0_ph_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_cmp6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_cmp6_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to300_cmp6_0_NO_SHIFT_REG;
 logic rnode_1to300_cmp6_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to300_cmp6_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_cmp6_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_cmp6_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_cmp6_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_cmp6_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_cmp6_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_cmp6_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_cmp6_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_cmp6_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_cmp6_NO_SHIFT_REG),
	.data_out(rnode_1to300_cmp6_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_cmp6_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_cmp6_0_reg_300_fifo.DATA_WIDTH = 1;
defparam rnode_1to300_cmp6_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_cmp6_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_cmp6_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_22_NO_SHIFT_REG;
assign merge_node_stall_in_22 = rnode_1to300_cmp6_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_cmp6_0_NO_SHIFT_REG = rnode_1to300_cmp6_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_cmp6_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_cmp6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_cmp6_0_valid_out_NO_SHIFT_REG = rnode_1to300_cmp6_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_arrayidx24_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_arrayidx24_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_arrayidx24_0_NO_SHIFT_REG;
 logic rnode_1to300_arrayidx24_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_arrayidx24_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_arrayidx24_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_arrayidx24_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_arrayidx24_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_arrayidx24_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_arrayidx24_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_arrayidx24_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_arrayidx24_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_arrayidx24_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_arrayidx24_NO_SHIFT_REG),
	.data_out(rnode_1to300_arrayidx24_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_arrayidx24_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_arrayidx24_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_arrayidx24_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_arrayidx24_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_arrayidx24_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_23_NO_SHIFT_REG;
assign merge_node_stall_in_23 = rnode_1to300_arrayidx24_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_arrayidx24_0_NO_SHIFT_REG = rnode_1to300_arrayidx24_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_arrayidx24_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_arrayidx24_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_arrayidx24_0_valid_out_NO_SHIFT_REG = rnode_1to300_arrayidx24_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_var__u12_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_var__u12_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to300_var__u12_0_NO_SHIFT_REG;
 logic rnode_1to300_var__u12_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to300_var__u12_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_var__u12_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_var__u12_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_var__u12_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_var__u12_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_var__u12_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_var__u12_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_var__u12_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_var__u12_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_var__u12_NO_SHIFT_REG),
	.data_out(rnode_1to300_var__u12_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_var__u12_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_var__u12_0_reg_300_fifo.DATA_WIDTH = 1;
defparam rnode_1to300_var__u12_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_var__u12_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_var__u12_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_24_NO_SHIFT_REG;
assign merge_node_stall_in_24 = rnode_1to300_var__u12_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_var__u12_0_NO_SHIFT_REG = rnode_1to300_var__u12_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_var__u12_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_var__u12_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_var__u12_0_valid_out_NO_SHIFT_REG = rnode_1to300_var__u12_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_ld__u15_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_ld__u15_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to300_ld__u15_0_NO_SHIFT_REG;
 logic rnode_1to300_ld__u15_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to300_ld__u15_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_ld__u15_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_ld__u15_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_ld__u15_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_ld__u15_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_ld__u15_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_ld__u15_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_ld__u15_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_ld__u15_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_ld__u15_NO_SHIFT_REG),
	.data_out(rnode_1to300_ld__u15_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_ld__u15_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_ld__u15_0_reg_300_fifo.DATA_WIDTH = 32;
defparam rnode_1to300_ld__u15_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_ld__u15_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_ld__u15_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_25_NO_SHIFT_REG;
assign merge_node_stall_in_25 = rnode_1to300_ld__u15_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_ld__u15_0_NO_SHIFT_REG = rnode_1to300_ld__u15_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_ld__u15_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_ld__u15_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_ld__u15_0_valid_out_NO_SHIFT_REG = rnode_1to300_ld__u15_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to300_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to300_input_acl_hw_wg_id_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_input_acl_hw_wg_id_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_input_acl_hw_wg_id_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_input_acl_hw_wg_id_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_input_acl_hw_wg_id_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to300_input_acl_hw_wg_id_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo.DATA_WIDTH = 32;
defparam rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_input_acl_hw_wg_id_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_26_NO_SHIFT_REG;
assign merge_node_stall_in_26 = rnode_1to300_input_acl_hw_wg_id_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to300_input_acl_hw_wg_id_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_input_acl_hw_wg_id_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to300_input_acl_hw_wg_id_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_not_cmp6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_not_cmp6_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_not_cmp6_0_NO_SHIFT_REG;
 logic rnode_1to160_not_cmp6_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_not_cmp6_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_not_cmp6_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_not_cmp6_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_not_cmp6_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_not_cmp6_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_not_cmp6_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_not_cmp6_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_not_cmp6_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_not_cmp6_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_not_cmp6_NO_SHIFT_REG),
	.data_out(rnode_1to160_not_cmp6_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_not_cmp6_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_not_cmp6_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_not_cmp6_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_not_cmp6_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_not_cmp6_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_27_NO_SHIFT_REG;
assign merge_node_stall_in_27 = rnode_1to160_not_cmp6_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_not_cmp6_0_NO_SHIFT_REG = rnode_1to160_not_cmp6_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_not_cmp6_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_not_cmp6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_not_cmp6_0_valid_out_NO_SHIFT_REG = rnode_1to160_not_cmp6_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_cmp_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_cmp_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_cmp_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_cmp_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_cmp_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_cmp_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_cmp_NO_SHIFT_REG),
	.data_out(rnode_1to160_cmp_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_cmp_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_cmp_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_cmp_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_cmp_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_cmp_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_28_NO_SHIFT_REG;
assign merge_node_stall_in_28 = rnode_1to160_cmp_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp_0_NO_SHIFT_REG = rnode_1to160_cmp_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_cmp_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_cmp_0_valid_out_NO_SHIFT_REG = rnode_1to160_cmp_0_valid_out_reg_160_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select141_stall_local;
wire [31:0] local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select141;

assign local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select141 = (local_lvm_var__u14_NO_SHIFT_REG ? 32'h2 : local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select158);

// This section implements an unregistered operation.
// 
wire local_bb5_do_directly_if_then27_ph_select_stall_local;
wire local_bb5_do_directly_if_then27_ph_select;

assign local_bb5_do_directly_if_then27_ph_select = (local_lvm_cmp25_NO_SHIFT_REG & local_bb5_var_);

// This section implements an unregistered operation.
// 
wire local_bb5_cmp_phi_decision115_xor_or_demorgan_stall_local;
wire local_bb5_cmp_phi_decision115_xor_or_demorgan;

assign local_bb5_cmp_phi_decision115_xor_or_demorgan = (local_bb5_do_directly_if_then12_select & local_lvm_cmp_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb5_not__stall_local;
wire local_bb5_not_;

assign local_bb5_not_ = (local_lvm_cmp_NO_SHIFT_REG & local_bb5_or_cond_not);

// This section implements an unregistered operation.
// 
wire local_bb5__105_valid_out;
wire local_bb5__105_stall_in;
wire local_bb5__105_inputs_ready;
wire local_bb5__105_stall_local;
wire local_bb5__105;

assign local_bb5__105_inputs_ready = (merge_node_valid_out_9_NO_SHIFT_REG & merge_node_valid_out_10_NO_SHIFT_REG);
assign local_bb5__105 = (local_lvm_cmp25_NO_SHIFT_REG & local_bb5_not_cmp8);
assign local_bb5__105_valid_out = local_bb5__105_inputs_ready;
assign local_bb5__105_stall_local = local_bb5__105_stall_in;
assign merge_node_stall_in_9 = (local_bb5__105_stall_local | ~(local_bb5__105_inputs_ready));
assign merge_node_stall_in_10 = (local_bb5__105_stall_local | ~(local_bb5__105_inputs_ready));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_input_temp_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_input_temp_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_input_temp_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_input_temp_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_temp_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_input_temp_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_input_temp_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_input_temp_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_input_temp_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_input_temp_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_input_temp_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(),
	.data_out()
);

defparam rnode_160to161_input_temp_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_input_temp_0_reg_161_fifo.DATA_WIDTH = 0;
defparam rnode_160to161_input_temp_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_input_temp_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_input_temp_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_input_temp_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_input_temp_0_stall_in_NO_SHIFT_REG = rnode_160to161_input_temp_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_input_temp_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_input_temp_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_input_temp_0_valid_out_NO_SHIFT_REG = rnode_160to161_input_temp_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_temp_index_0_ph7_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph7_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_temp_index_0_ph7_0_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph7_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph7_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_temp_index_0_ph7_1_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph7_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_temp_index_0_ph7_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph7_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph7_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_temp_index_0_ph7_0_stall_out_reg_161_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_temp_index_0_ph7_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_temp_index_0_ph7_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_temp_index_0_ph7_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_temp_index_0_ph7_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_temp_index_0_ph7_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_temp_index_0_ph7_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_temp_index_0_ph7_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_temp_index_0_ph7_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_temp_index_0_ph7_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_temp_index_0_ph7_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_temp_index_0_ph7_0_reg_161_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_160to161_temp_index_0_ph7_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_temp_index_0_ph7_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_temp_index_0_ph7_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_temp_index_0_ph7_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_temp_index_0_ph7_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_temp_index_0_ph7_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_temp_index_0_ph7_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_temp_index_0_ph7_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_temp_index_0_ph7_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_temp_index_0_ph7_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_temp_index_0_ph7_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_temp_index_0_ph7_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_temp_index_0_ph7_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_temp_index_0_ph7_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_temp_index_0_ph7_0_stall_in_NO_SHIFT_REG = rnode_160to161_temp_index_0_ph7_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_temp_index_0_ph7_0_NO_SHIFT_REG = rnode_160to161_temp_index_0_ph7_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_temp_index_0_ph7_1_NO_SHIFT_REG = rnode_160to161_temp_index_0_ph7_0_reg_161_NO_SHIFT_REG_fa;

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
 logic rnode_300to301_right_lower_0_ph6_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_right_lower_0_ph6_0_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_right_lower_0_ph6_1_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_valid_out_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_stall_in_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_stall_out_reg_301_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_300to301_right_lower_0_ph6_0_reg_301_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG),
	.valid_in(rnode_300to301_right_lower_0_ph6_0_valid_out_0_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_right_lower_0_ph6_0_stall_in_0_reg_301_NO_SHIFT_REG),
	.data_out(rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG_fa),
	.valid_out({rnode_300to301_right_lower_0_ph6_0_valid_out_0_NO_SHIFT_REG, rnode_300to301_right_lower_0_ph6_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_300to301_right_lower_0_ph6_0_stall_in_0_NO_SHIFT_REG, rnode_300to301_right_lower_0_ph6_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_300to301_right_lower_0_ph6_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_right_lower_0_ph6_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_right_lower_0_ph6_0_stall_in_0_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_right_lower_0_ph6_0_valid_out_0_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_right_lower_0_ph6_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_right_lower_0_ph6_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_right_lower_0_ph6_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG = rnode_300to301_right_lower_0_ph6_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_right_lower_0_ph6_0_NO_SHIFT_REG = rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG_fa;
assign rnode_300to301_right_lower_0_ph6_1_NO_SHIFT_REG = rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_mul_0_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_mul_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_mul_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_mul_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_mul_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_mul_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_mul_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_mul_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_mul_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_mul_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_mul_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_mul_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_mul_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_mul_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_mul_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_mul_0_stall_in_NO_SHIFT_REG = rnode_300to301_mul_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_mul_0_NO_SHIFT_REG = rnode_300to301_mul_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_mul_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_mul_0_valid_out_NO_SHIFT_REG = rnode_300to301_mul_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_sub_0_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_sub_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_sub_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_sub_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_sub_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_sub_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_sub_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_sub_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_sub_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_sub_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_sub_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_sub_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_sub_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_sub_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_sub_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_sub_0_stall_in_NO_SHIFT_REG = rnode_300to301_sub_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_sub_0_NO_SHIFT_REG = rnode_300to301_sub_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_sub_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_sub_0_valid_out_NO_SHIFT_REG = rnode_300to301_sub_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_div_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_div_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_div_0_NO_SHIFT_REG;
 logic rnode_300to301_div_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_div_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_div_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_div_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_div_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_div_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_div_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_div_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_div_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_div_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_div_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_div_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_div_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_div_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_div_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_div_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_div_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_div_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_div_0_stall_in_NO_SHIFT_REG = rnode_300to301_div_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_div_0_NO_SHIFT_REG = rnode_300to301_div_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_div_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_div_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_div_0_valid_out_NO_SHIFT_REG = rnode_300to301_div_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_300to301_var__0_NO_SHIFT_REG;
 logic rnode_300to301_var__0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic rnode_300to301_var__0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_var__0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_var__0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_var__0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_var__0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_var__0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_var__0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_var__0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_var__0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_var__0_NO_SHIFT_REG),
	.data_out(rnode_300to301_var__0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_var__0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_var__0_reg_301_fifo.DATA_WIDTH = 1;
defparam rnode_300to301_var__0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_var__0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_var__0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_var__0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_var__0_stall_in_NO_SHIFT_REG = rnode_300to301_var__0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_var__0_NO_SHIFT_REG = rnode_300to301_var__0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_var__0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_var__0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_var__0_valid_out_NO_SHIFT_REG = rnode_300to301_var__0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_left_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_left_lower_0_ph_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_left_lower_0_ph_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_left_lower_0_ph_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_left_lower_0_ph_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_left_lower_0_ph_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_left_lower_0_ph_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_left_lower_0_ph_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_left_lower_0_ph_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_left_lower_0_ph_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_left_lower_0_ph_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_left_lower_0_ph_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_left_lower_0_ph_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_left_lower_0_ph_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_left_lower_0_ph_0_stall_in_NO_SHIFT_REG = rnode_300to301_left_lower_0_ph_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_left_lower_0_ph_0_NO_SHIFT_REG = rnode_300to301_left_lower_0_ph_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_left_lower_0_ph_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_left_lower_0_ph_0_valid_out_NO_SHIFT_REG = rnode_300to301_left_lower_0_ph_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_cmp6_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_cmp6_0_stall_in_NO_SHIFT_REG;
 logic rnode_300to301_cmp6_0_NO_SHIFT_REG;
 logic rnode_300to301_cmp6_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic rnode_300to301_cmp6_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp6_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp6_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp6_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_cmp6_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_cmp6_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_cmp6_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_cmp6_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_cmp6_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_cmp6_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_cmp6_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_cmp6_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_cmp6_0_reg_301_fifo.DATA_WIDTH = 1;
defparam rnode_300to301_cmp6_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_cmp6_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_cmp6_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_cmp6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_cmp6_0_stall_in_NO_SHIFT_REG = rnode_300to301_cmp6_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_cmp6_0_NO_SHIFT_REG = rnode_300to301_cmp6_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_cmp6_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_cmp6_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_cmp6_0_valid_out_NO_SHIFT_REG = rnode_300to301_cmp6_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_arrayidx24_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_arrayidx24_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_arrayidx24_0_NO_SHIFT_REG;
 logic rnode_300to301_arrayidx24_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_arrayidx24_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_arrayidx24_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_arrayidx24_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_arrayidx24_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_arrayidx24_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_arrayidx24_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_arrayidx24_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_arrayidx24_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_arrayidx24_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_arrayidx24_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_arrayidx24_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_arrayidx24_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_arrayidx24_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_arrayidx24_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_arrayidx24_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_arrayidx24_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_arrayidx24_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_arrayidx24_0_stall_in_NO_SHIFT_REG = rnode_300to301_arrayidx24_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_arrayidx24_0_NO_SHIFT_REG = rnode_300to301_arrayidx24_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_arrayidx24_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_arrayidx24_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_arrayidx24_0_valid_out_NO_SHIFT_REG = rnode_300to301_arrayidx24_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_var__u12_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_var__u12_0_stall_in_NO_SHIFT_REG;
 logic rnode_300to301_var__u12_0_NO_SHIFT_REG;
 logic rnode_300to301_var__u12_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic rnode_300to301_var__u12_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_var__u12_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_var__u12_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_var__u12_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_var__u12_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_var__u12_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_var__u12_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_var__u12_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_var__u12_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_var__u12_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_var__u12_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_var__u12_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_var__u12_0_reg_301_fifo.DATA_WIDTH = 1;
defparam rnode_300to301_var__u12_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_var__u12_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_var__u12_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_var__u12_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_var__u12_0_stall_in_NO_SHIFT_REG = rnode_300to301_var__u12_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_var__u12_0_NO_SHIFT_REG = rnode_300to301_var__u12_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_var__u12_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_var__u12_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_var__u12_0_valid_out_NO_SHIFT_REG = rnode_300to301_var__u12_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_ld__u15_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_ld__u15_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_ld__u15_0_NO_SHIFT_REG;
 logic rnode_300to301_ld__u15_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_ld__u15_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_ld__u15_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_ld__u15_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_ld__u15_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_ld__u15_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_ld__u15_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_ld__u15_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_ld__u15_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_ld__u15_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_ld__u15_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_ld__u15_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_ld__u15_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_ld__u15_0_reg_301_fifo.DATA_WIDTH = 32;
defparam rnode_300to301_ld__u15_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_ld__u15_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_ld__u15_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_ld__u15_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_ld__u15_0_stall_in_NO_SHIFT_REG = rnode_300to301_ld__u15_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_ld__u15_0_NO_SHIFT_REG = rnode_300to301_ld__u15_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_ld__u15_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_ld__u15_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_ld__u15_0_valid_out_NO_SHIFT_REG = rnode_300to301_ld__u15_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_input_acl_hw_wg_id_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_input_acl_hw_wg_id_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_input_acl_hw_wg_id_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_input_acl_hw_wg_id_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_input_acl_hw_wg_id_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_input_acl_hw_wg_id_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_input_acl_hw_wg_id_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo.DATA_WIDTH = 32;
defparam rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_input_acl_hw_wg_id_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = rnode_300to301_input_acl_hw_wg_id_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_300to301_input_acl_hw_wg_id_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_input_acl_hw_wg_id_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_300to301_input_acl_hw_wg_id_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_not_cmp6_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_1_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_stall_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_not_cmp6_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_not_cmp6_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_not_cmp6_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_not_cmp6_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_not_cmp6_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_not_cmp6_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_not_cmp6_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_not_cmp6_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_not_cmp6_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_not_cmp6_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_not_cmp6_0_reg_161_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_160to161_not_cmp6_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_not_cmp6_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_not_cmp6_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_not_cmp6_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_not_cmp6_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_not_cmp6_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_not_cmp6_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_not_cmp6_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_not_cmp6_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_not_cmp6_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_not_cmp6_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_not_cmp6_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_not_cmp6_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_not_cmp6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_not_cmp6_0_stall_in_NO_SHIFT_REG = rnode_160to161_not_cmp6_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_not_cmp6_0_NO_SHIFT_REG = rnode_160to161_not_cmp6_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_not_cmp6_1_NO_SHIFT_REG = rnode_160to161_not_cmp6_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_cmp_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_stall_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_cmp_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_cmp_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_cmp_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_cmp_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_cmp_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_cmp_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_cmp_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_cmp_0_reg_161_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_160to161_cmp_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_cmp_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_cmp_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_cmp_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_cmp_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_cmp_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_cmp_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_cmp_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_cmp_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_cmp_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_cmp_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_cmp_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_cmp_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_cmp_0_stall_in_NO_SHIFT_REG = rnode_160to161_cmp_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_cmp_0_NO_SHIFT_REG = rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_cmp_1_NO_SHIFT_REG = rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select_stall_local;
wire [31:0] local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select;

assign local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select = (local_lvm_var__u12_NO_SHIFT_REG ? 32'h0 : local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select141);

// This section implements an unregistered operation.
// 
wire local_bb5_cmp_phi_decision115_xor_or_stall_local;
wire local_bb5_cmp_phi_decision115_xor_or;

assign local_bb5_cmp_phi_decision115_xor_or = (local_bb5_cmp_phi_decision115_xor_or_demorgan ^ 1'b1);

// This section implements an unregistered operation.
// 
wire local_bb5_do_directly_if_then27_select_stall_local;
wire local_bb5_do_directly_if_then27_select;

assign local_bb5_do_directly_if_then27_select = (local_bb5_do_directly_if_then27_ph_select & local_bb5_not_);

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_bb5__105_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_bb5__105_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_bb5__105_0_NO_SHIFT_REG;
 logic rnode_1to160_bb5__105_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_bb5__105_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_bb5__105_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_bb5__105_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_bb5__105_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_bb5__105_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_bb5__105_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_bb5__105_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_bb5__105_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_bb5__105_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_bb5__105),
	.data_out(rnode_1to160_bb5__105_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_bb5__105_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_bb5__105_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_bb5__105_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_bb5__105_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_bb5__105_0_reg_160_inputs_ready_NO_SHIFT_REG = local_bb5__105_valid_out;
assign local_bb5__105_stall_in = rnode_1to160_bb5__105_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_bb5__105_0_NO_SHIFT_REG = rnode_1to160_bb5__105_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_bb5__105_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_bb5__105_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_bb5__105_0_valid_out_NO_SHIFT_REG = rnode_1to160_bb5__105_0_valid_out_reg_160_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb5_arrayidx31_valid_out;
wire local_bb5_arrayidx31_stall_in;
wire local_bb5_arrayidx31_inputs_ready;
wire local_bb5_arrayidx31_stall_local;
wire [63:0] local_bb5_arrayidx31;

assign local_bb5_arrayidx31_inputs_ready = (rnode_160to161_input_temp_0_valid_out_NO_SHIFT_REG & rnode_160to161_temp_index_0_ph7_0_valid_out_0_NO_SHIFT_REG);
assign local_bb5_arrayidx31 = (input_temp + (rnode_160to161_temp_index_0_ph7_0_NO_SHIFT_REG << 6'h2));
assign local_bb5_arrayidx31_valid_out = local_bb5_arrayidx31_inputs_ready;
assign local_bb5_arrayidx31_stall_local = local_bb5_arrayidx31_stall_in;
assign rnode_160to161_input_temp_0_stall_in_NO_SHIFT_REG = (local_bb5_arrayidx31_stall_local | ~(local_bb5_arrayidx31_inputs_ready));
assign rnode_160to161_temp_index_0_ph7_0_stall_in_0_NO_SHIFT_REG = (local_bb5_arrayidx31_stall_local | ~(local_bb5_arrayidx31_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb5_temp_index_0_ph7_be_valid_out;
wire local_bb5_temp_index_0_ph7_be_stall_in;
wire local_bb5_temp_index_0_ph7_be_inputs_ready;
wire local_bb5_temp_index_0_ph7_be_stall_local;
wire [63:0] local_bb5_temp_index_0_ph7_be;

assign local_bb5_temp_index_0_ph7_be_inputs_ready = rnode_160to161_temp_index_0_ph7_0_valid_out_1_NO_SHIFT_REG;
assign local_bb5_temp_index_0_ph7_be = (rnode_160to161_temp_index_0_ph7_1_NO_SHIFT_REG + 64'h1);
assign local_bb5_temp_index_0_ph7_be_valid_out = local_bb5_temp_index_0_ph7_be_inputs_ready;
assign local_bb5_temp_index_0_ph7_be_stall_local = local_bb5_temp_index_0_ph7_be_stall_in;
assign rnode_160to161_temp_index_0_ph7_0_stall_in_1_NO_SHIFT_REG = (|local_bb5_temp_index_0_ph7_be_stall_local);

// This section implements an unregistered operation.
// 
wire local_bb5_right_lower_0_ph6_be_valid_out;
wire local_bb5_right_lower_0_ph6_be_stall_in;
wire local_bb5_right_lower_0_ph6_be_inputs_ready;
wire local_bb5_right_lower_0_ph6_be_stall_local;
wire [63:0] local_bb5_right_lower_0_ph6_be;

assign local_bb5_right_lower_0_ph6_be_inputs_ready = rnode_300to301_right_lower_0_ph6_0_valid_out_0_NO_SHIFT_REG;
assign local_bb5_right_lower_0_ph6_be = (rnode_300to301_right_lower_0_ph6_0_NO_SHIFT_REG + 64'h1);
assign local_bb5_right_lower_0_ph6_be_valid_out = local_bb5_right_lower_0_ph6_be_inputs_ready;
assign local_bb5_right_lower_0_ph6_be_stall_local = local_bb5_right_lower_0_ph6_be_stall_in;
assign rnode_300to301_right_lower_0_ph6_0_stall_in_0_NO_SHIFT_REG = (|local_bb5_right_lower_0_ph6_be_stall_local);

// Register node:
//  * latency = 139
//  * capacity = 139
 logic rnode_161to300_not_cmp6_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to300_not_cmp6_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to300_not_cmp6_0_NO_SHIFT_REG;
 logic rnode_161to300_not_cmp6_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to300_not_cmp6_0_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_not_cmp6_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_not_cmp6_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_not_cmp6_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_161to300_not_cmp6_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to300_not_cmp6_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to300_not_cmp6_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_161to300_not_cmp6_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_161to300_not_cmp6_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(rnode_160to161_not_cmp6_1_NO_SHIFT_REG),
	.data_out(rnode_161to300_not_cmp6_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_161to300_not_cmp6_0_reg_300_fifo.DEPTH = 140;
defparam rnode_161to300_not_cmp6_0_reg_300_fifo.DATA_WIDTH = 1;
defparam rnode_161to300_not_cmp6_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to300_not_cmp6_0_reg_300_fifo.IMPL = "ram";

assign rnode_161to300_not_cmp6_0_reg_300_inputs_ready_NO_SHIFT_REG = rnode_160to161_not_cmp6_0_valid_out_1_NO_SHIFT_REG;
assign rnode_160to161_not_cmp6_0_stall_in_1_NO_SHIFT_REG = rnode_161to300_not_cmp6_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_161to300_not_cmp6_0_NO_SHIFT_REG = rnode_161to300_not_cmp6_0_reg_300_NO_SHIFT_REG;
assign rnode_161to300_not_cmp6_0_stall_in_reg_300_NO_SHIFT_REG = rnode_161to300_not_cmp6_0_stall_in_NO_SHIFT_REG;
assign rnode_161to300_not_cmp6_0_valid_out_NO_SHIFT_REG = rnode_161to300_not_cmp6_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 139
//  * capacity = 139
 logic rnode_161to300_cmp_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_161to300_cmp_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to300_cmp_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to300_cmp_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_161to300_cmp_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_161to300_cmp_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(rnode_160to161_cmp_1_NO_SHIFT_REG),
	.data_out(rnode_161to300_cmp_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_161to300_cmp_0_reg_300_fifo.DEPTH = 140;
defparam rnode_161to300_cmp_0_reg_300_fifo.DATA_WIDTH = 1;
defparam rnode_161to300_cmp_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to300_cmp_0_reg_300_fifo.IMPL = "ram";

assign rnode_161to300_cmp_0_reg_300_inputs_ready_NO_SHIFT_REG = rnode_160to161_cmp_0_valid_out_1_NO_SHIFT_REG;
assign rnode_160to161_cmp_0_stall_in_1_NO_SHIFT_REG = rnode_161to300_cmp_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_161to300_cmp_0_NO_SHIFT_REG = rnode_161to300_cmp_0_reg_300_NO_SHIFT_REG;
assign rnode_161to300_cmp_0_stall_in_reg_300_NO_SHIFT_REG = rnode_161to300_cmp_0_stall_in_NO_SHIFT_REG;
assign rnode_161to300_cmp_0_valid_out_NO_SHIFT_REG = rnode_161to300_cmp_0_valid_out_reg_300_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_valid_out;
wire local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_stall_in;
wire local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_inputs_ready;
wire local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_stall_local;
wire [31:0] local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select;

assign local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_inputs_ready = (merge_node_valid_out_0_NO_SHIFT_REG & merge_node_valid_out_2_NO_SHIFT_REG & merge_node_valid_out_3_NO_SHIFT_REG & merge_node_valid_out_5_NO_SHIFT_REG);
assign local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select = (local_lvm_var__u13_NO_SHIFT_REG ? 32'h1 : local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_ph_select);
assign local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_valid_out = local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_inputs_ready;
assign local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_stall_local = local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_stall_in;
assign merge_node_stall_in_0 = (local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_stall_local | ~(local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_inputs_ready));
assign merge_node_stall_in_2 = (local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_stall_local | ~(local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_inputs_ready));
assign merge_node_stall_in_3 = (local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_stall_local | ~(local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_inputs_ready));
assign merge_node_stall_in_5 = (local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_stall_local | ~(local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb5_or_valid_out;
wire local_bb5_or_stall_in;
 reg local_bb5_or_consumed_0_NO_SHIFT_REG;
wire local_bb5_cmp_phi_decision115_xor_or_valid_out;
wire local_bb5_cmp_phi_decision115_xor_or_stall_in;
 reg local_bb5_cmp_phi_decision115_xor_or_consumed_0_NO_SHIFT_REG;
wire local_bb5_or_inputs_ready;
wire local_bb5_or_stall_local;
wire local_bb5_or;

assign local_bb5_or_inputs_ready = (merge_node_valid_out_1_NO_SHIFT_REG & merge_node_valid_out_4_NO_SHIFT_REG & merge_node_valid_out_7_NO_SHIFT_REG & merge_node_valid_out_8_NO_SHIFT_REG & merge_node_valid_out_6_NO_SHIFT_REG & merge_node_valid_out_11_NO_SHIFT_REG);
assign local_bb5_or = (local_bb5_do_directly_if_then12_select | local_bb5_do_directly_if_then27_select);
assign local_bb5_or_stall_local = ((local_bb5_or_stall_in & ~(local_bb5_or_consumed_0_NO_SHIFT_REG)) | (local_bb5_cmp_phi_decision115_xor_or_stall_in & ~(local_bb5_cmp_phi_decision115_xor_or_consumed_0_NO_SHIFT_REG)));
assign local_bb5_or_valid_out = (local_bb5_or_inputs_ready & ~(local_bb5_or_consumed_0_NO_SHIFT_REG));
assign local_bb5_cmp_phi_decision115_xor_or_valid_out = (local_bb5_or_inputs_ready & ~(local_bb5_cmp_phi_decision115_xor_or_consumed_0_NO_SHIFT_REG));
assign merge_node_stall_in_1 = (local_bb5_or_stall_local | ~(local_bb5_or_inputs_ready));
assign merge_node_stall_in_4 = (local_bb5_or_stall_local | ~(local_bb5_or_inputs_ready));
assign merge_node_stall_in_7 = (local_bb5_or_stall_local | ~(local_bb5_or_inputs_ready));
assign merge_node_stall_in_8 = (local_bb5_or_stall_local | ~(local_bb5_or_inputs_ready));
assign merge_node_stall_in_6 = (local_bb5_or_stall_local | ~(local_bb5_or_inputs_ready));
assign merge_node_stall_in_11 = (local_bb5_or_stall_local | ~(local_bb5_or_inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_or_consumed_0_NO_SHIFT_REG <= 1'b0;
		local_bb5_cmp_phi_decision115_xor_or_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb5_or_consumed_0_NO_SHIFT_REG <= (local_bb5_or_inputs_ready & (local_bb5_or_consumed_0_NO_SHIFT_REG | ~(local_bb5_or_stall_in)) & local_bb5_or_stall_local);
		local_bb5_cmp_phi_decision115_xor_or_consumed_0_NO_SHIFT_REG <= (local_bb5_or_inputs_ready & (local_bb5_cmp_phi_decision115_xor_or_consumed_0_NO_SHIFT_REG | ~(local_bb5_cmp_phi_decision115_xor_or_stall_in)) & local_bb5_or_stall_local);
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_bb5__105_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_bb5__105_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_bb5__105_0_NO_SHIFT_REG;
 logic rnode_160to161_bb5__105_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_bb5__105_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb5__105_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb5__105_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb5__105_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_bb5__105_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_bb5__105_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_bb5__105_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_bb5__105_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_bb5__105_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_bb5__105_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_bb5__105_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_bb5__105_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_bb5__105_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_bb5__105_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_bb5__105_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_bb5__105_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_bb5__105_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_bb5__105_0_stall_in_NO_SHIFT_REG = rnode_160to161_bb5__105_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_bb5__105_0_NO_SHIFT_REG = rnode_160to161_bb5__105_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_bb5__105_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_bb5__105_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_bb5__105_0_valid_out_NO_SHIFT_REG = rnode_160to161_bb5__105_0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_161to161_bb5_arrayidx31_valid_out_0;
wire rstag_161to161_bb5_arrayidx31_stall_in_0;
 reg rstag_161to161_bb5_arrayidx31_consumed_0_NO_SHIFT_REG;
wire rstag_161to161_bb5_arrayidx31_valid_out_1;
wire rstag_161to161_bb5_arrayidx31_stall_in_1;
 reg rstag_161to161_bb5_arrayidx31_consumed_1_NO_SHIFT_REG;
wire rstag_161to161_bb5_arrayidx31_inputs_ready;
wire rstag_161to161_bb5_arrayidx31_stall_local;
 reg rstag_161to161_bb5_arrayidx31_staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb5_arrayidx31_combined_valid;
 reg [63:0] rstag_161to161_bb5_arrayidx31_staging_reg_NO_SHIFT_REG;
wire [63:0] rstag_161to161_bb5_arrayidx31;

assign rstag_161to161_bb5_arrayidx31_inputs_ready = local_bb5_arrayidx31_valid_out;
assign rstag_161to161_bb5_arrayidx31 = (rstag_161to161_bb5_arrayidx31_staging_valid_NO_SHIFT_REG ? rstag_161to161_bb5_arrayidx31_staging_reg_NO_SHIFT_REG : local_bb5_arrayidx31);
assign rstag_161to161_bb5_arrayidx31_combined_valid = (rstag_161to161_bb5_arrayidx31_staging_valid_NO_SHIFT_REG | rstag_161to161_bb5_arrayidx31_inputs_ready);
assign rstag_161to161_bb5_arrayidx31_stall_local = ((rstag_161to161_bb5_arrayidx31_stall_in_0 & ~(rstag_161to161_bb5_arrayidx31_consumed_0_NO_SHIFT_REG)) | (rstag_161to161_bb5_arrayidx31_stall_in_1 & ~(rstag_161to161_bb5_arrayidx31_consumed_1_NO_SHIFT_REG)));
assign rstag_161to161_bb5_arrayidx31_valid_out_0 = (rstag_161to161_bb5_arrayidx31_combined_valid & ~(rstag_161to161_bb5_arrayidx31_consumed_0_NO_SHIFT_REG));
assign rstag_161to161_bb5_arrayidx31_valid_out_1 = (rstag_161to161_bb5_arrayidx31_combined_valid & ~(rstag_161to161_bb5_arrayidx31_consumed_1_NO_SHIFT_REG));
assign local_bb5_arrayidx31_stall_in = (|rstag_161to161_bb5_arrayidx31_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb5_arrayidx31_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb5_arrayidx31_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb5_arrayidx31_stall_local)
		begin
			if (~(rstag_161to161_bb5_arrayidx31_staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb5_arrayidx31_staging_valid_NO_SHIFT_REG <= rstag_161to161_bb5_arrayidx31_inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb5_arrayidx31_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb5_arrayidx31_staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb5_arrayidx31_staging_reg_NO_SHIFT_REG <= local_bb5_arrayidx31;
		end
	end
end

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb5_arrayidx31_consumed_0_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb5_arrayidx31_consumed_1_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		rstag_161to161_bb5_arrayidx31_consumed_0_NO_SHIFT_REG <= (rstag_161to161_bb5_arrayidx31_combined_valid & (rstag_161to161_bb5_arrayidx31_consumed_0_NO_SHIFT_REG | ~(rstag_161to161_bb5_arrayidx31_stall_in_0)) & rstag_161to161_bb5_arrayidx31_stall_local);
		rstag_161to161_bb5_arrayidx31_consumed_1_NO_SHIFT_REG <= (rstag_161to161_bb5_arrayidx31_combined_valid & (rstag_161to161_bb5_arrayidx31_consumed_1_NO_SHIFT_REG | ~(rstag_161to161_bb5_arrayidx31_stall_in_1)) & rstag_161to161_bb5_arrayidx31_stall_local);
	end
end


// Register node:
//  * latency = 139
//  * capacity = 139
 logic rnode_161to300_bb5_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to300_bb5_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_161to300_bb5_temp_index_0_ph7_be_0_NO_SHIFT_REG;
 logic rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_bb5_temp_index_0_ph7_be_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_bb5_temp_index_0_ph7_be_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_bb5_temp_index_0_ph7_be_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to300_bb5_temp_index_0_ph7_be_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_161to300_bb5_temp_index_0_ph7_be_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_161to300_bb5_temp_index_0_ph7_be_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_bb5_temp_index_0_ph7_be),
	.data_out(rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_fifo.DEPTH = 140;
defparam rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_fifo.IMPL = "ram";

assign rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_inputs_ready_NO_SHIFT_REG = local_bb5_temp_index_0_ph7_be_valid_out;
assign local_bb5_temp_index_0_ph7_be_stall_in = rnode_161to300_bb5_temp_index_0_ph7_be_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_161to300_bb5_temp_index_0_ph7_be_0_NO_SHIFT_REG = rnode_161to300_bb5_temp_index_0_ph7_be_0_reg_300_NO_SHIFT_REG;
assign rnode_161to300_bb5_temp_index_0_ph7_be_0_stall_in_reg_300_NO_SHIFT_REG = rnode_161to300_bb5_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG;
assign rnode_161to300_bb5_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG = rnode_161to300_bb5_temp_index_0_ph7_be_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_not_cmp6_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_not_cmp6_0_stall_in_NO_SHIFT_REG;
 logic rnode_300to301_not_cmp6_0_NO_SHIFT_REG;
 logic rnode_300to301_not_cmp6_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic rnode_300to301_not_cmp6_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_not_cmp6_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_not_cmp6_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_not_cmp6_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_not_cmp6_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_not_cmp6_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_not_cmp6_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_not_cmp6_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_not_cmp6_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_161to300_not_cmp6_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_not_cmp6_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_not_cmp6_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_not_cmp6_0_reg_301_fifo.DATA_WIDTH = 1;
defparam rnode_300to301_not_cmp6_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_not_cmp6_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_not_cmp6_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_161to300_not_cmp6_0_valid_out_NO_SHIFT_REG;
assign rnode_161to300_not_cmp6_0_stall_in_NO_SHIFT_REG = rnode_300to301_not_cmp6_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_not_cmp6_0_NO_SHIFT_REG = rnode_300to301_not_cmp6_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_not_cmp6_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_not_cmp6_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_not_cmp6_0_valid_out_NO_SHIFT_REG = rnode_300to301_not_cmp6_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_cmp_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_300to301_cmp_1_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_valid_out_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_stall_in_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_stall_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_300to301_cmp_0_reg_301_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG),
	.valid_in(rnode_300to301_cmp_0_valid_out_0_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_cmp_0_stall_in_0_reg_301_NO_SHIFT_REG),
	.data_out(rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG_fa),
	.valid_out({rnode_300to301_cmp_0_valid_out_0_NO_SHIFT_REG, rnode_300to301_cmp_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_300to301_cmp_0_stall_in_0_NO_SHIFT_REG, rnode_300to301_cmp_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_300to301_cmp_0_reg_301_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_300to301_cmp_0_reg_301_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_300to301_cmp_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_cmp_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_cmp_0_stall_in_0_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_cmp_0_valid_out_0_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_cmp_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_161to300_cmp_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_cmp_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_cmp_0_reg_301_fifo.DATA_WIDTH = 1;
defparam rnode_300to301_cmp_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_cmp_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_cmp_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_161to300_cmp_0_valid_out_NO_SHIFT_REG;
assign rnode_161to300_cmp_0_stall_in_NO_SHIFT_REG = rnode_300to301_cmp_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_cmp_0_NO_SHIFT_REG = rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG_fa;
assign rnode_300to301_cmp_1_NO_SHIFT_REG = rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_NO_SHIFT_REG;
 logic rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select),
	.data_out(rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_fifo.DATA_WIDTH = 32;
defparam rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_inputs_ready_NO_SHIFT_REG = local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_valid_out;
assign local_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_stall_in = rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_NO_SHIFT_REG = rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_NO_SHIFT_REG = rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_bb5_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_bb5_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_bb5_or_0_NO_SHIFT_REG;
 logic rnode_1to160_bb5_or_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_bb5_or_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_bb5_or_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_bb5_or_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_bb5_or_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_bb5_or_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_bb5_or_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_bb5_or_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_bb5_or_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_bb5_or_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_bb5_or),
	.data_out(rnode_1to160_bb5_or_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_bb5_or_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_bb5_or_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_bb5_or_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_bb5_or_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_bb5_or_0_reg_160_inputs_ready_NO_SHIFT_REG = local_bb5_or_valid_out;
assign local_bb5_or_stall_in = rnode_1to160_bb5_or_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_bb5_or_0_NO_SHIFT_REG = rnode_1to160_bb5_or_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_bb5_or_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_bb5_or_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_bb5_or_0_valid_out_NO_SHIFT_REG = rnode_1to160_bb5_or_0_valid_out_reg_160_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_1to1_bb5_cmp_phi_decision115_xor_or_valid_out;
wire rstag_1to1_bb5_cmp_phi_decision115_xor_or_stall_in;
wire rstag_1to1_bb5_cmp_phi_decision115_xor_or_inputs_ready;
wire rstag_1to1_bb5_cmp_phi_decision115_xor_or_stall_local;
 reg rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_valid_NO_SHIFT_REG;
wire rstag_1to1_bb5_cmp_phi_decision115_xor_or_combined_valid;
 reg rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_reg_NO_SHIFT_REG;
wire rstag_1to1_bb5_cmp_phi_decision115_xor_or;

assign rstag_1to1_bb5_cmp_phi_decision115_xor_or_inputs_ready = local_bb5_cmp_phi_decision115_xor_or_valid_out;
assign rstag_1to1_bb5_cmp_phi_decision115_xor_or = (rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_valid_NO_SHIFT_REG ? rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_reg_NO_SHIFT_REG : local_bb5_cmp_phi_decision115_xor_or);
assign rstag_1to1_bb5_cmp_phi_decision115_xor_or_combined_valid = (rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_valid_NO_SHIFT_REG | rstag_1to1_bb5_cmp_phi_decision115_xor_or_inputs_ready);
assign rstag_1to1_bb5_cmp_phi_decision115_xor_or_valid_out = rstag_1to1_bb5_cmp_phi_decision115_xor_or_combined_valid;
assign rstag_1to1_bb5_cmp_phi_decision115_xor_or_stall_local = rstag_1to1_bb5_cmp_phi_decision115_xor_or_stall_in;
assign local_bb5_cmp_phi_decision115_xor_or_stall_in = (|rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_1to1_bb5_cmp_phi_decision115_xor_or_stall_local)
		begin
			if (~(rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_valid_NO_SHIFT_REG))
			begin
				rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_valid_NO_SHIFT_REG <= rstag_1to1_bb5_cmp_phi_decision115_xor_or_inputs_ready;
			end
		end
		else
		begin
			rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_valid_NO_SHIFT_REG))
		begin
			rstag_1to1_bb5_cmp_phi_decision115_xor_or_staging_reg_NO_SHIFT_REG <= local_bb5_cmp_phi_decision115_xor_or;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb5__107_stall_local;
wire local_bb5__107;

assign local_bb5__107 = (rnode_160to161_bb5__105_0_NO_SHIFT_REG & rnode_160to161_not_cmp6_0_NO_SHIFT_REG);

// Register node:
//  * latency = 139
//  * capacity = 139
 logic rnode_161to300_bb5_arrayidx31_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to300_bb5_arrayidx31_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_161to300_bb5_arrayidx31_0_NO_SHIFT_REG;
 logic rnode_161to300_bb5_arrayidx31_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_161to300_bb5_arrayidx31_0_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_bb5_arrayidx31_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_bb5_arrayidx31_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_bb5_arrayidx31_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_161to300_bb5_arrayidx31_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to300_bb5_arrayidx31_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to300_bb5_arrayidx31_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_161to300_bb5_arrayidx31_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_161to300_bb5_arrayidx31_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(rstag_161to161_bb5_arrayidx31),
	.data_out(rnode_161to300_bb5_arrayidx31_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_161to300_bb5_arrayidx31_0_reg_300_fifo.DEPTH = 140;
defparam rnode_161to300_bb5_arrayidx31_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_161to300_bb5_arrayidx31_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to300_bb5_arrayidx31_0_reg_300_fifo.IMPL = "ram";

assign rnode_161to300_bb5_arrayidx31_0_reg_300_inputs_ready_NO_SHIFT_REG = rstag_161to161_bb5_arrayidx31_valid_out_0;
assign rstag_161to161_bb5_arrayidx31_stall_in_0 = rnode_161to300_bb5_arrayidx31_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_161to300_bb5_arrayidx31_0_NO_SHIFT_REG = rnode_161to300_bb5_arrayidx31_0_reg_300_NO_SHIFT_REG;
assign rnode_161to300_bb5_arrayidx31_0_stall_in_reg_300_NO_SHIFT_REG = rnode_161to300_bb5_arrayidx31_0_stall_in_NO_SHIFT_REG;
assign rnode_161to300_bb5_arrayidx31_0_valid_out_NO_SHIFT_REG = rnode_161to300_bb5_arrayidx31_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_bb5_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_bb5_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_bb5_temp_index_0_ph7_be_0_NO_SHIFT_REG;
 logic rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb5_temp_index_0_ph7_be_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb5_temp_index_0_ph7_be_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb5_temp_index_0_ph7_be_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_bb5_temp_index_0_ph7_be_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_bb5_temp_index_0_ph7_be_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_bb5_temp_index_0_ph7_be_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_161to300_bb5_temp_index_0_ph7_be_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_161to300_bb5_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG;
assign rnode_161to300_bb5_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG = rnode_300to301_bb5_temp_index_0_ph7_be_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_bb5_temp_index_0_ph7_be_0_NO_SHIFT_REG = rnode_300to301_bb5_temp_index_0_ph7_be_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_bb5_temp_index_0_ph7_be_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_bb5_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_bb5_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG = rnode_300to301_bb5_temp_index_0_ph7_be_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_0_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_NO_SHIFT_REG;
 logic rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_1_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_1_NO_SHIFT_REG;
 logic rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_out_reg_301_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_NO_SHIFT_REG),
	.valid_in(rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_0_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_0_reg_301_NO_SHIFT_REG),
	.data_out(rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_NO_SHIFT_REG_fa),
	.valid_out({rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_0_NO_SHIFT_REG, rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_0_NO_SHIFT_REG, rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_fanout_adaptor.DATA_WIDTH = 32;
defparam rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_0_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_0_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_fifo.DATA_WIDTH = 32;
defparam rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_NO_SHIFT_REG = rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_NO_SHIFT_REG = rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_NO_SHIFT_REG_fa;
assign rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_1_NO_SHIFT_REG = rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_301_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_bb5_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_bb5_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_bb5_or_0_NO_SHIFT_REG;
 logic rnode_160to161_bb5_or_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_bb5_or_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb5_or_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb5_or_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb5_or_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_bb5_or_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_bb5_or_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_bb5_or_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_bb5_or_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_bb5_or_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_bb5_or_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_bb5_or_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_bb5_or_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_bb5_or_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_bb5_or_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_bb5_or_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_bb5_or_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_bb5_or_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_bb5_or_0_stall_in_NO_SHIFT_REG = rnode_160to161_bb5_or_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_bb5_or_0_NO_SHIFT_REG = rnode_160to161_bb5_or_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_bb5_or_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_bb5_or_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_bb5_or_0_valid_out_NO_SHIFT_REG = rnode_160to161_bb5_or_0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb5_ld__inputs_ready;
 reg local_bb5_ld__valid_out_NO_SHIFT_REG;
wire local_bb5_ld__stall_in;
wire local_bb5_ld__output_regs_ready;
wire local_bb5_ld__fu_stall_out;
wire local_bb5_ld__fu_valid_out;
wire [31:0] local_bb5_ld__lsu_dataout;
 reg [31:0] local_bb5_ld__NO_SHIFT_REG;
wire local_bb5_ld__causedstall;

lsu_top lsu_local_bb5_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb5_ld__fu_stall_out),
	.i_valid(local_bb5_ld__inputs_ready),
	.i_address(local_lvm_arrayidx23_NO_SHIFT_REG),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_1to1_bb5_cmp_phi_decision115_xor_or),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb5_ld__output_regs_ready)),
	.o_valid(local_bb5_ld__fu_valid_out),
	.o_readdata(local_bb5_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb5_ld__active),
	.avm_address(avm_local_bb5_ld__address),
	.avm_read(avm_local_bb5_ld__read),
	.avm_readdata(avm_local_bb5_ld__readdata),
	.avm_write(avm_local_bb5_ld__write),
	.avm_writeack(avm_local_bb5_ld__writeack),
	.avm_burstcount(avm_local_bb5_ld__burstcount),
	.avm_writedata(avm_local_bb5_ld__writedata),
	.avm_byteenable(avm_local_bb5_ld__byteenable),
	.avm_waitrequest(avm_local_bb5_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb5_ld__readdatavalid),
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

defparam lsu_local_bb5_ld_.AWIDTH = 30;
defparam lsu_local_bb5_ld_.WIDTH_BYTES = 4;
defparam lsu_local_bb5_ld_.MWIDTH_BYTES = 32;
defparam lsu_local_bb5_ld_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb5_ld_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb5_ld_.READ = 1;
defparam lsu_local_bb5_ld_.ATOMIC = 0;
defparam lsu_local_bb5_ld_.WIDTH = 32;
defparam lsu_local_bb5_ld_.MWIDTH = 256;
defparam lsu_local_bb5_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb5_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb5_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb5_ld_.MEMORY_SIDE_MEM_LATENCY = 58;
defparam lsu_local_bb5_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb5_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb5_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb5_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb5_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb5_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb5_ld_.USECACHING = 0;
defparam lsu_local_bb5_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb5_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb5_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb5_ld_.ADDRSPACE = 1;
defparam lsu_local_bb5_ld_.STYLE = "BURST-COALESCED";

assign local_bb5_ld__inputs_ready = (merge_node_valid_out_12_NO_SHIFT_REG & rstag_1to1_bb5_cmp_phi_decision115_xor_or_valid_out);
assign local_bb5_ld__output_regs_ready = (&(~(local_bb5_ld__valid_out_NO_SHIFT_REG) | ~(local_bb5_ld__stall_in)));
assign merge_node_stall_in_12 = (local_bb5_ld__fu_stall_out | ~(local_bb5_ld__inputs_ready));
assign rstag_1to1_bb5_cmp_phi_decision115_xor_or_stall_in = (local_bb5_ld__fu_stall_out | ~(local_bb5_ld__inputs_ready));
assign local_bb5_ld__causedstall = (local_bb5_ld__inputs_ready && (local_bb5_ld__fu_stall_out && !(~(local_bb5_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_ld__NO_SHIFT_REG <= 'x;
		local_bb5_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_ld__output_regs_ready)
		begin
			local_bb5_ld__NO_SHIFT_REG <= local_bb5_ld__lsu_dataout;
			local_bb5_ld__valid_out_NO_SHIFT_REG <= local_bb5_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb5_ld__stall_in))
			begin
				local_bb5_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_bb5_arrayidx31_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_bb5_arrayidx31_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_bb5_arrayidx31_0_NO_SHIFT_REG;
 logic rnode_300to301_bb5_arrayidx31_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_bb5_arrayidx31_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb5_arrayidx31_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb5_arrayidx31_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb5_arrayidx31_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_bb5_arrayidx31_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_bb5_arrayidx31_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_bb5_arrayidx31_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_bb5_arrayidx31_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_bb5_arrayidx31_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_161to300_bb5_arrayidx31_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_bb5_arrayidx31_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_bb5_arrayidx31_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_bb5_arrayidx31_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_bb5_arrayidx31_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_bb5_arrayidx31_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_bb5_arrayidx31_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_161to300_bb5_arrayidx31_0_valid_out_NO_SHIFT_REG;
assign rnode_161to300_bb5_arrayidx31_0_stall_in_NO_SHIFT_REG = rnode_300to301_bb5_arrayidx31_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_bb5_arrayidx31_0_NO_SHIFT_REG = rnode_300to301_bb5_arrayidx31_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_bb5_arrayidx31_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_bb5_arrayidx31_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_bb5_arrayidx31_0_valid_out_NO_SHIFT_REG = rnode_300to301_bb5_arrayidx31_0_valid_out_reg_301_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb5_while_cond_outer5_branch_back_stall_local;
wire local_bb5_while_cond_outer5_branch_back;

assign local_bb5_while_cond_outer5_branch_back = (rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_NO_SHIFT_REG == 32'h0);

// This section implements an unregistered operation.
// 
wire local_bb5_cmp_phi_decision115_xor116_or_demorgan_stall_local;
wire local_bb5_cmp_phi_decision115_xor116_or_demorgan;

assign local_bb5_cmp_phi_decision115_xor116_or_demorgan = (rnode_160to161_bb5_or_0_NO_SHIFT_REG & rnode_160to161_cmp_0_NO_SHIFT_REG);

// This section implements a staging register.
// 
wire rstag_161to161_bb5_ld__valid_out;
wire rstag_161to161_bb5_ld__stall_in;
wire rstag_161to161_bb5_ld__inputs_ready;
wire rstag_161to161_bb5_ld__stall_local;
 reg rstag_161to161_bb5_ld__staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb5_ld__combined_valid;
 reg [31:0] rstag_161to161_bb5_ld__staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_161to161_bb5_ld_;

assign rstag_161to161_bb5_ld__inputs_ready = local_bb5_ld__valid_out_NO_SHIFT_REG;
assign rstag_161to161_bb5_ld_ = (rstag_161to161_bb5_ld__staging_valid_NO_SHIFT_REG ? rstag_161to161_bb5_ld__staging_reg_NO_SHIFT_REG : local_bb5_ld__NO_SHIFT_REG);
assign rstag_161to161_bb5_ld__combined_valid = (rstag_161to161_bb5_ld__staging_valid_NO_SHIFT_REG | rstag_161to161_bb5_ld__inputs_ready);
assign rstag_161to161_bb5_ld__valid_out = rstag_161to161_bb5_ld__combined_valid;
assign rstag_161to161_bb5_ld__stall_local = rstag_161to161_bb5_ld__stall_in;
assign local_bb5_ld__stall_in = (|rstag_161to161_bb5_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb5_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb5_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb5_ld__stall_local)
		begin
			if (~(rstag_161to161_bb5_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb5_ld__staging_valid_NO_SHIFT_REG <= rstag_161to161_bb5_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb5_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb5_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb5_ld__staging_reg_NO_SHIFT_REG <= local_bb5_ld__NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb5_var__u17_valid_out;
wire local_bb5_var__u17_stall_in;
wire local_bb5_var__u17_inputs_ready;
wire local_bb5_var__u17_stall_local;
wire local_bb5_var__u17;

assign local_bb5_var__u17_inputs_ready = (rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_0_NO_SHIFT_REG & rnode_300to301_cmp_0_valid_out_0_NO_SHIFT_REG);
assign local_bb5_var__u17 = (rnode_300to301_cmp_0_NO_SHIFT_REG & local_bb5_while_cond_outer5_branch_back);
assign local_bb5_var__u17_valid_out = local_bb5_var__u17_inputs_ready;
assign local_bb5_var__u17_stall_local = local_bb5_var__u17_stall_in;
assign rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_0_NO_SHIFT_REG = (local_bb5_var__u17_stall_local | ~(local_bb5_var__u17_inputs_ready));
assign rnode_300to301_cmp_0_stall_in_0_NO_SHIFT_REG = (local_bb5_var__u17_stall_local | ~(local_bb5_var__u17_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb5_cmp_phi_decision115_xor116_or_valid_out;
wire local_bb5_cmp_phi_decision115_xor116_or_stall_in;
wire local_bb5_cmp_phi_decision115_xor116_or_inputs_ready;
wire local_bb5_cmp_phi_decision115_xor116_or_stall_local;
wire local_bb5_cmp_phi_decision115_xor116_or;

assign local_bb5_cmp_phi_decision115_xor116_or_inputs_ready = (rnode_160to161_cmp_0_valid_out_0_NO_SHIFT_REG & rnode_160to161_bb5_or_0_valid_out_NO_SHIFT_REG);
assign local_bb5_cmp_phi_decision115_xor116_or = (local_bb5_cmp_phi_decision115_xor116_or_demorgan ^ 1'b1);
assign local_bb5_cmp_phi_decision115_xor116_or_valid_out = local_bb5_cmp_phi_decision115_xor116_or_inputs_ready;
assign local_bb5_cmp_phi_decision115_xor116_or_stall_local = local_bb5_cmp_phi_decision115_xor116_or_stall_in;
assign rnode_160to161_cmp_0_stall_in_0_NO_SHIFT_REG = (local_bb5_cmp_phi_decision115_xor116_or_stall_local | ~(local_bb5_cmp_phi_decision115_xor116_or_inputs_ready));
assign rnode_160to161_bb5_or_0_stall_in_NO_SHIFT_REG = (local_bb5_cmp_phi_decision115_xor116_or_stall_local | ~(local_bb5_cmp_phi_decision115_xor116_or_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb5__109_valid_out;
wire local_bb5__109_stall_in;
wire local_bb5__109_inputs_ready;
wire local_bb5__109_stall_local;
wire [31:0] local_bb5__109;

assign local_bb5__109_inputs_ready = (rnode_160to161_ld__0_valid_out_NO_SHIFT_REG & rstag_161to161_bb5_ld__valid_out & rnode_160to161_not_cmp6_0_valid_out_0_NO_SHIFT_REG & rnode_160to161_bb5__105_0_valid_out_NO_SHIFT_REG);
assign local_bb5__109 = (local_bb5__107 ? rnode_160to161_ld__0_NO_SHIFT_REG : rstag_161to161_bb5_ld_);
assign local_bb5__109_valid_out = local_bb5__109_inputs_ready;
assign local_bb5__109_stall_local = local_bb5__109_stall_in;
assign rnode_160to161_ld__0_stall_in_NO_SHIFT_REG = (local_bb5__109_stall_local | ~(local_bb5__109_inputs_ready));
assign rstag_161to161_bb5_ld__stall_in = (local_bb5__109_stall_local | ~(local_bb5__109_inputs_ready));
assign rnode_160to161_not_cmp6_0_stall_in_0_NO_SHIFT_REG = (local_bb5__109_stall_local | ~(local_bb5__109_inputs_ready));
assign rnode_160to161_bb5__105_0_stall_in_NO_SHIFT_REG = (local_bb5__109_stall_local | ~(local_bb5__109_inputs_ready));

// This section implements a staging register.
// 
wire rstag_301to301_bb5_var__u17_valid_out;
wire rstag_301to301_bb5_var__u17_stall_in;
wire rstag_301to301_bb5_var__u17_inputs_ready;
wire rstag_301to301_bb5_var__u17_stall_local;
 reg rstag_301to301_bb5_var__u17_staging_valid_NO_SHIFT_REG;
wire rstag_301to301_bb5_var__u17_combined_valid;
 reg rstag_301to301_bb5_var__u17_staging_reg_NO_SHIFT_REG;
wire rstag_301to301_bb5_var__u17;

assign rstag_301to301_bb5_var__u17_inputs_ready = local_bb5_var__u17_valid_out;
assign rstag_301to301_bb5_var__u17 = (rstag_301to301_bb5_var__u17_staging_valid_NO_SHIFT_REG ? rstag_301to301_bb5_var__u17_staging_reg_NO_SHIFT_REG : local_bb5_var__u17);
assign rstag_301to301_bb5_var__u17_combined_valid = (rstag_301to301_bb5_var__u17_staging_valid_NO_SHIFT_REG | rstag_301to301_bb5_var__u17_inputs_ready);
assign rstag_301to301_bb5_var__u17_valid_out = rstag_301to301_bb5_var__u17_combined_valid;
assign rstag_301to301_bb5_var__u17_stall_local = rstag_301to301_bb5_var__u17_stall_in;
assign local_bb5_var__u17_stall_in = (|rstag_301to301_bb5_var__u17_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_301to301_bb5_var__u17_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_301to301_bb5_var__u17_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_301to301_bb5_var__u17_stall_local)
		begin
			if (~(rstag_301to301_bb5_var__u17_staging_valid_NO_SHIFT_REG))
			begin
				rstag_301to301_bb5_var__u17_staging_valid_NO_SHIFT_REG <= rstag_301to301_bb5_var__u17_inputs_ready;
			end
		end
		else
		begin
			rstag_301to301_bb5_var__u17_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_301to301_bb5_var__u17_staging_valid_NO_SHIFT_REG))
		begin
			rstag_301to301_bb5_var__u17_staging_reg_NO_SHIFT_REG <= local_bb5_var__u17;
		end
	end
end


// This section implements a staging register.
// 
wire rstag_161to161_bb5_cmp_phi_decision115_xor116_or_valid_out;
wire rstag_161to161_bb5_cmp_phi_decision115_xor116_or_stall_in;
wire rstag_161to161_bb5_cmp_phi_decision115_xor116_or_inputs_ready;
wire rstag_161to161_bb5_cmp_phi_decision115_xor116_or_stall_local;
 reg rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb5_cmp_phi_decision115_xor116_or_combined_valid;
 reg rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_reg_NO_SHIFT_REG;
wire rstag_161to161_bb5_cmp_phi_decision115_xor116_or;

assign rstag_161to161_bb5_cmp_phi_decision115_xor116_or_inputs_ready = local_bb5_cmp_phi_decision115_xor116_or_valid_out;
assign rstag_161to161_bb5_cmp_phi_decision115_xor116_or = (rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_valid_NO_SHIFT_REG ? rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_reg_NO_SHIFT_REG : local_bb5_cmp_phi_decision115_xor116_or);
assign rstag_161to161_bb5_cmp_phi_decision115_xor116_or_combined_valid = (rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_valid_NO_SHIFT_REG | rstag_161to161_bb5_cmp_phi_decision115_xor116_or_inputs_ready);
assign rstag_161to161_bb5_cmp_phi_decision115_xor116_or_valid_out = rstag_161to161_bb5_cmp_phi_decision115_xor116_or_combined_valid;
assign rstag_161to161_bb5_cmp_phi_decision115_xor116_or_stall_local = rstag_161to161_bb5_cmp_phi_decision115_xor116_or_stall_in;
assign local_bb5_cmp_phi_decision115_xor116_or_stall_in = (|rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb5_cmp_phi_decision115_xor116_or_stall_local)
		begin
			if (~(rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_valid_NO_SHIFT_REG <= rstag_161to161_bb5_cmp_phi_decision115_xor116_or_inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb5_cmp_phi_decision115_xor116_or_staging_reg_NO_SHIFT_REG <= local_bb5_cmp_phi_decision115_xor116_or;
		end
	end
end


// This section implements a staging register.
// 
wire rstag_161to161_bb5__109_valid_out;
wire rstag_161to161_bb5__109_stall_in;
wire rstag_161to161_bb5__109_inputs_ready;
wire rstag_161to161_bb5__109_stall_local;
 reg rstag_161to161_bb5__109_staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb5__109_combined_valid;
 reg [31:0] rstag_161to161_bb5__109_staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_161to161_bb5__109;

assign rstag_161to161_bb5__109_inputs_ready = local_bb5__109_valid_out;
assign rstag_161to161_bb5__109 = (rstag_161to161_bb5__109_staging_valid_NO_SHIFT_REG ? rstag_161to161_bb5__109_staging_reg_NO_SHIFT_REG : local_bb5__109);
assign rstag_161to161_bb5__109_combined_valid = (rstag_161to161_bb5__109_staging_valid_NO_SHIFT_REG | rstag_161to161_bb5__109_inputs_ready);
assign rstag_161to161_bb5__109_valid_out = rstag_161to161_bb5__109_combined_valid;
assign rstag_161to161_bb5__109_stall_local = rstag_161to161_bb5__109_stall_in;
assign local_bb5__109_stall_in = (|rstag_161to161_bb5__109_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb5__109_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb5__109_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb5__109_stall_local)
		begin
			if (~(rstag_161to161_bb5__109_staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb5__109_staging_valid_NO_SHIFT_REG <= rstag_161to161_bb5__109_inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb5__109_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb5__109_staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb5__109_staging_reg_NO_SHIFT_REG <= local_bb5__109;
		end
	end
end


// This section implements a registered operation.
// 
wire local_bb5_st__109_inputs_ready;
 reg local_bb5_st__109_valid_out_NO_SHIFT_REG;
wire local_bb5_st__109_stall_in;
wire local_bb5_st__109_output_regs_ready;
wire local_bb5_st__109_fu_stall_out;
wire local_bb5_st__109_fu_valid_out;
wire local_bb5_st__109_causedstall;

lsu_top lsu_local_bb5_st__109 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb5_st__109_fu_stall_out),
	.i_valid(local_bb5_st__109_inputs_ready),
	.i_address(rstag_161to161_bb5_arrayidx31),
	.i_writedata(rstag_161to161_bb5__109),
	.i_cmpdata(),
	.i_predicate(rstag_161to161_bb5_cmp_phi_decision115_xor116_or),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb5_st__109_output_regs_ready)),
	.o_valid(local_bb5_st__109_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb5_st__109_active),
	.avm_address(avm_local_bb5_st__109_address),
	.avm_read(avm_local_bb5_st__109_read),
	.avm_readdata(avm_local_bb5_st__109_readdata),
	.avm_write(avm_local_bb5_st__109_write),
	.avm_writeack(avm_local_bb5_st__109_writeack),
	.avm_burstcount(avm_local_bb5_st__109_burstcount),
	.avm_writedata(avm_local_bb5_st__109_writedata),
	.avm_byteenable(avm_local_bb5_st__109_byteenable),
	.avm_waitrequest(avm_local_bb5_st__109_waitrequest),
	.avm_readdatavalid(avm_local_bb5_st__109_readdatavalid),
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

defparam lsu_local_bb5_st__109.AWIDTH = 30;
defparam lsu_local_bb5_st__109.WIDTH_BYTES = 4;
defparam lsu_local_bb5_st__109.MWIDTH_BYTES = 32;
defparam lsu_local_bb5_st__109.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb5_st__109.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb5_st__109.READ = 0;
defparam lsu_local_bb5_st__109.ATOMIC = 0;
defparam lsu_local_bb5_st__109.WIDTH = 32;
defparam lsu_local_bb5_st__109.MWIDTH = 256;
defparam lsu_local_bb5_st__109.ATOMIC_WIDTH = 3;
defparam lsu_local_bb5_st__109.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb5_st__109.KERNEL_SIDE_MEM_LATENCY = 140;
defparam lsu_local_bb5_st__109.MEMORY_SIDE_MEM_LATENCY = 12;
defparam lsu_local_bb5_st__109.USE_WRITE_ACK = 1;
defparam lsu_local_bb5_st__109.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb5_st__109.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb5_st__109.NUMBER_BANKS = 1;
defparam lsu_local_bb5_st__109.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb5_st__109.USEINPUTFIFO = 0;
defparam lsu_local_bb5_st__109.USECACHING = 0;
defparam lsu_local_bb5_st__109.USEOUTPUTFIFO = 1;
defparam lsu_local_bb5_st__109.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb5_st__109.HIGH_FMAX = 1;
defparam lsu_local_bb5_st__109.ADDRSPACE = 1;
defparam lsu_local_bb5_st__109.STYLE = "BURST-COALESCED";
defparam lsu_local_bb5_st__109.USE_BYTE_EN = 0;

assign local_bb5_st__109_inputs_ready = (rstag_161to161_bb5_cmp_phi_decision115_xor116_or_valid_out & rstag_161to161_bb5__109_valid_out & rstag_161to161_bb5_arrayidx31_valid_out_1);
assign local_bb5_st__109_output_regs_ready = (&(~(local_bb5_st__109_valid_out_NO_SHIFT_REG) | ~(local_bb5_st__109_stall_in)));
assign rstag_161to161_bb5_cmp_phi_decision115_xor116_or_stall_in = (local_bb5_st__109_fu_stall_out | ~(local_bb5_st__109_inputs_ready));
assign rstag_161to161_bb5__109_stall_in = (local_bb5_st__109_fu_stall_out | ~(local_bb5_st__109_inputs_ready));
assign rstag_161to161_bb5_arrayidx31_stall_in_1 = (local_bb5_st__109_fu_stall_out | ~(local_bb5_st__109_inputs_ready));
assign local_bb5_st__109_causedstall = (local_bb5_st__109_inputs_ready && (local_bb5_st__109_fu_stall_out && !(~(local_bb5_st__109_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb5_st__109_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb5_st__109_output_regs_ready)
		begin
			local_bb5_st__109_valid_out_NO_SHIFT_REG <= local_bb5_st__109_fu_valid_out;
		end
		else
		begin
			if (~(local_bb5_st__109_stall_in))
			begin
				local_bb5_st__109_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_301to301_bb5_st__109_valid_out;
wire rstag_301to301_bb5_st__109_stall_in;
wire rstag_301to301_bb5_st__109_inputs_ready;
wire rstag_301to301_bb5_st__109_stall_local;
 reg rstag_301to301_bb5_st__109_staging_valid_NO_SHIFT_REG;
wire rstag_301to301_bb5_st__109_combined_valid;

assign rstag_301to301_bb5_st__109_inputs_ready = local_bb5_st__109_valid_out_NO_SHIFT_REG;
assign rstag_301to301_bb5_st__109_combined_valid = (rstag_301to301_bb5_st__109_staging_valid_NO_SHIFT_REG | rstag_301to301_bb5_st__109_inputs_ready);
assign rstag_301to301_bb5_st__109_valid_out = rstag_301to301_bb5_st__109_combined_valid;
assign rstag_301to301_bb5_st__109_stall_local = rstag_301to301_bb5_st__109_stall_in;
assign local_bb5_st__109_stall_in = (|rstag_301to301_bb5_st__109_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_301to301_bb5_st__109_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_301to301_bb5_st__109_stall_local)
		begin
			if (~(rstag_301to301_bb5_st__109_staging_valid_NO_SHIFT_REG))
			begin
				rstag_301to301_bb5_st__109_staging_valid_NO_SHIFT_REG <= rstag_301to301_bb5_st__109_inputs_ready;
			end
		end
		else
		begin
			rstag_301to301_bb5_st__109_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [63:0] lvb_mul_0_reg_NO_SHIFT_REG;
 reg lvb_cmp_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_sub_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_div_0_reg_NO_SHIFT_REG;
 reg lvb_var__0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG;
 reg lvb_cmp6_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_arrayidx24_0_reg_NO_SHIFT_REG;
 reg lvb_not_cmp6_0_reg_NO_SHIFT_REG;
 reg lvb_var__u12_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_ld__u15_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb5_arrayidx31_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb5_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb5_right_lower_0_ph6_be_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb5_right_lower_0_ph6_be_valid_out & rnode_300to301_right_lower_0_ph6_0_valid_out_1_NO_SHIFT_REG & rnode_300to301_mul_0_valid_out_NO_SHIFT_REG & rnode_300to301_sub_0_valid_out_NO_SHIFT_REG & rnode_300to301_div_0_valid_out_NO_SHIFT_REG & rnode_300to301_var__0_valid_out_NO_SHIFT_REG & rnode_300to301_left_lower_0_ph_0_valid_out_NO_SHIFT_REG & rnode_300to301_cmp6_0_valid_out_NO_SHIFT_REG & rnode_300to301_arrayidx24_0_valid_out_NO_SHIFT_REG & rnode_300to301_var__u12_0_valid_out_NO_SHIFT_REG & rnode_300to301_ld__u15_0_valid_out_NO_SHIFT_REG & rnode_300to301_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_valid_out_1_NO_SHIFT_REG & rnode_300to301_not_cmp6_0_valid_out_NO_SHIFT_REG & rnode_300to301_cmp_0_valid_out_1_NO_SHIFT_REG & rnode_300to301_bb5_arrayidx31_0_valid_out_NO_SHIFT_REG & rnode_300to301_bb5_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG & rstag_301to301_bb5_st__109_valid_out & rstag_301to301_bb5_var__u17_valid_out);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb5_right_lower_0_ph6_be_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_right_lower_0_ph6_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_mul_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_sub_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_div_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_var__0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_left_lower_0_ph_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_cmp6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_arrayidx24_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_var__u12_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_ld__u15_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_not_cmp6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_cmp_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_bb5_arrayidx31_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_bb5_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_301to301_bb5_st__109_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_301to301_bb5_var__u17_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_mul_0 = lvb_mul_0_reg_NO_SHIFT_REG;
assign lvb_mul_1 = lvb_mul_0_reg_NO_SHIFT_REG;
assign lvb_cmp_0 = lvb_cmp_0_reg_NO_SHIFT_REG;
assign lvb_cmp_1 = lvb_cmp_0_reg_NO_SHIFT_REG;
assign lvb_sub_0 = lvb_sub_0_reg_NO_SHIFT_REG;
assign lvb_sub_1 = lvb_sub_0_reg_NO_SHIFT_REG;
assign lvb_div_0 = lvb_div_0_reg_NO_SHIFT_REG;
assign lvb_div_1 = lvb_div_0_reg_NO_SHIFT_REG;
assign lvb_var__0 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_var__1 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_left_lower_0_ph_0 = lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG;
assign lvb_left_lower_0_ph_1 = lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG;
assign lvb_cmp6_0 = lvb_cmp6_0_reg_NO_SHIFT_REG;
assign lvb_cmp6_1 = lvb_cmp6_0_reg_NO_SHIFT_REG;
assign lvb_arrayidx24_0 = lvb_arrayidx24_0_reg_NO_SHIFT_REG;
assign lvb_arrayidx24_1 = lvb_arrayidx24_0_reg_NO_SHIFT_REG;
assign lvb_not_cmp6_0 = lvb_not_cmp6_0_reg_NO_SHIFT_REG;
assign lvb_not_cmp6_1 = lvb_not_cmp6_0_reg_NO_SHIFT_REG;
assign lvb_var__u12_0 = lvb_var__u12_0_reg_NO_SHIFT_REG;
assign lvb_var__u12_1 = lvb_var__u12_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph6_0 = lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph6_1 = lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG;
assign lvb_ld__u15_0 = lvb_ld__u15_0_reg_NO_SHIFT_REG;
assign lvb_ld__u15_1 = lvb_ld__u15_0_reg_NO_SHIFT_REG;
assign lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0 = lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_NO_SHIFT_REG;
assign lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_1 = lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_NO_SHIFT_REG;
assign lvb_bb5_arrayidx31_0 = lvb_bb5_arrayidx31_0_reg_NO_SHIFT_REG;
assign lvb_bb5_arrayidx31_1 = lvb_bb5_arrayidx31_0_reg_NO_SHIFT_REG;
assign lvb_bb5_temp_index_0_ph7_be_0 = lvb_bb5_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG;
assign lvb_bb5_temp_index_0_ph7_be_1 = lvb_bb5_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG;
assign lvb_bb5_right_lower_0_ph6_be_0 = lvb_bb5_right_lower_0_ph6_be_0_reg_NO_SHIFT_REG;
assign lvb_bb5_right_lower_0_ph6_be_1 = lvb_bb5_right_lower_0_ph6_be_0_reg_NO_SHIFT_REG;
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
		lvb_mul_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp_0_reg_NO_SHIFT_REG <= 'x;
		lvb_sub_0_reg_NO_SHIFT_REG <= 'x;
		lvb_div_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__0_reg_NO_SHIFT_REG <= 'x;
		lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_arrayidx24_0_reg_NO_SHIFT_REG <= 'x;
		lvb_not_cmp6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__u12_0_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_ld__u15_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb5_arrayidx31_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb5_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb5_right_lower_0_ph6_be_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_mul_0_reg_NO_SHIFT_REG <= rnode_300to301_mul_0_NO_SHIFT_REG;
			lvb_cmp_0_reg_NO_SHIFT_REG <= rnode_300to301_cmp_1_NO_SHIFT_REG;
			lvb_sub_0_reg_NO_SHIFT_REG <= rnode_300to301_sub_0_NO_SHIFT_REG;
			lvb_div_0_reg_NO_SHIFT_REG <= rnode_300to301_div_0_NO_SHIFT_REG;
			lvb_var__0_reg_NO_SHIFT_REG <= rnode_300to301_var__0_NO_SHIFT_REG;
			lvb_left_lower_0_ph_0_reg_NO_SHIFT_REG <= rnode_300to301_left_lower_0_ph_0_NO_SHIFT_REG;
			lvb_cmp6_0_reg_NO_SHIFT_REG <= rnode_300to301_cmp6_0_NO_SHIFT_REG;
			lvb_arrayidx24_0_reg_NO_SHIFT_REG <= rnode_300to301_arrayidx24_0_NO_SHIFT_REG;
			lvb_not_cmp6_0_reg_NO_SHIFT_REG <= rnode_300to301_not_cmp6_0_NO_SHIFT_REG;
			lvb_var__u12_0_reg_NO_SHIFT_REG <= rnode_300to301_var__u12_0_NO_SHIFT_REG;
			lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG <= rnode_300to301_right_lower_0_ph6_1_NO_SHIFT_REG;
			lvb_ld__u15_0_reg_NO_SHIFT_REG <= rnode_300to301_ld__u15_0_NO_SHIFT_REG;
			lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0_reg_NO_SHIFT_REG <= rnode_300to301_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_1_NO_SHIFT_REG;
			lvb_bb5_arrayidx31_0_reg_NO_SHIFT_REG <= rnode_300to301_bb5_arrayidx31_0_NO_SHIFT_REG;
			lvb_bb5_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG <= rnode_300to301_bb5_temp_index_0_ph7_be_0_NO_SHIFT_REG;
			lvb_bb5_right_lower_0_ph6_be_0_reg_NO_SHIFT_REG <= local_bb5_right_lower_0_ph6_be;
			lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= rnode_300to301_input_acl_hw_wg_id_0_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= rstag_301to301_bb5_var__u17;
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
		input [63:0] 		input_sub_0,
		input 		input_var__0,
		input [63:0] 		input_index_04_0,
		input 		input_cmp493_0,
		input 		input_cmp_phi_decision120_xor_or_0,
		input [31:0] 		input_acl_hw_wg_id_0,
		input 		valid_in_1,
		output 		stall_out_1,
		input [63:0] 		input_sub_1,
		input 		input_var__1,
		input [63:0] 		input_index_04_1,
		input 		input_cmp493_1,
		input 		input_cmp_phi_decision120_xor_or_1,
		input [31:0] 		input_acl_hw_wg_id_1,
		output 		valid_out_0,
		input 		stall_in_0,
		output [63:0] 		lvb_sub_0,
		output 		lvb_var__0,
		output [63:0] 		lvb_bb6_inc53_0,
		output 		lvb_cmp493_0,
		output 		lvb_cmp_phi_decision120_xor_or_0,
		output [31:0] 		lvb_input_acl_hw_wg_id_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [63:0] 		lvb_sub_1,
		output 		lvb_var__1,
		output [63:0] 		lvb_bb6_inc53_1,
		output 		lvb_cmp493_1,
		output 		lvb_cmp_phi_decision120_xor_or_1,
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
 reg [63:0] input_sub_0_staging_reg_NO_SHIFT_REG;
 reg input_var__0_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_index_04_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp493_0_staging_reg_NO_SHIFT_REG;
 reg input_cmp_phi_decision120_xor_or_0_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
 reg [63:0] local_lvm_sub_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg [63:0] local_lvm_index_04_NO_SHIFT_REG;
 reg local_lvm_cmp493_NO_SHIFT_REG;
 reg local_lvm_cmp_phi_decision120_xor_or_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg merge_node_valid_in_1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_1_staging_reg_NO_SHIFT_REG;
 reg input_var__1_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_index_04_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp493_1_staging_reg_NO_SHIFT_REG;
 reg input_cmp_phi_decision120_xor_or_1_staging_reg_NO_SHIFT_REG;
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
		input_sub_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__0_staging_reg_NO_SHIFT_REG <= 'x;
		input_index_04_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp493_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_phi_decision120_xor_or_0_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_0_staging_reg_NO_SHIFT_REG <= 1'b0;
		input_sub_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__1_staging_reg_NO_SHIFT_REG <= 'x;
		input_index_04_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp493_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_phi_decision120_xor_or_1_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_1_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_0_staging_reg_NO_SHIFT_REG))
			begin
				input_sub_0_staging_reg_NO_SHIFT_REG <= input_sub_0;
				input_var__0_staging_reg_NO_SHIFT_REG <= input_var__0;
				input_index_04_0_staging_reg_NO_SHIFT_REG <= input_index_04_0;
				input_cmp493_0_staging_reg_NO_SHIFT_REG <= input_cmp493_0;
				input_cmp_phi_decision120_xor_or_0_staging_reg_NO_SHIFT_REG <= input_cmp_phi_decision120_xor_or_0;
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
				input_sub_1_staging_reg_NO_SHIFT_REG <= input_sub_1;
				input_var__1_staging_reg_NO_SHIFT_REG <= input_var__1;
				input_index_04_1_staging_reg_NO_SHIFT_REG <= input_index_04_1;
				input_cmp493_1_staging_reg_NO_SHIFT_REG <= input_cmp493_1;
				input_cmp_phi_decision120_xor_or_1_staging_reg_NO_SHIFT_REG <= input_cmp_phi_decision120_xor_or_1;
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
					local_lvm_sub_NO_SHIFT_REG <= input_sub_0_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__0_staging_reg_NO_SHIFT_REG;
					local_lvm_index_04_NO_SHIFT_REG <= input_index_04_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp493_NO_SHIFT_REG <= input_cmp493_0_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_phi_decision120_xor_or_NO_SHIFT_REG <= input_cmp_phi_decision120_xor_or_0_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_sub_NO_SHIFT_REG <= input_sub_0;
					local_lvm_var__NO_SHIFT_REG <= input_var__0;
					local_lvm_index_04_NO_SHIFT_REG <= input_index_04_0;
					local_lvm_cmp493_NO_SHIFT_REG <= input_cmp493_0;
					local_lvm_cmp_phi_decision120_xor_or_NO_SHIFT_REG <= input_cmp_phi_decision120_xor_or_0;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_0;
				end
			end

			1'b1:
			begin
				if (merge_node_valid_in_1_staging_reg_NO_SHIFT_REG)
				begin
					local_lvm_sub_NO_SHIFT_REG <= input_sub_1_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__1_staging_reg_NO_SHIFT_REG;
					local_lvm_index_04_NO_SHIFT_REG <= input_index_04_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp493_NO_SHIFT_REG <= input_cmp493_1_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_phi_decision120_xor_or_NO_SHIFT_REG <= input_cmp_phi_decision120_xor_or_1_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_1_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_sub_NO_SHIFT_REG <= input_sub_1;
					local_lvm_var__NO_SHIFT_REG <= input_var__1;
					local_lvm_index_04_NO_SHIFT_REG <= input_index_04_1;
					local_lvm_cmp493_NO_SHIFT_REG <= input_cmp493_1;
					local_lvm_cmp_phi_decision120_xor_or_NO_SHIFT_REG <= input_cmp_phi_decision120_xor_or_1;
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
wire local_bb6_arrayidx51_valid_out;
wire local_bb6_arrayidx51_stall_in;
wire local_bb6_arrayidx51_inputs_ready;
wire local_bb6_arrayidx51_stall_local;
wire [63:0] local_bb6_arrayidx51;

assign local_bb6_arrayidx51_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb6_arrayidx51 = (input_temp + (local_lvm_index_04_NO_SHIFT_REG << 6'h2));
assign local_bb6_arrayidx51_valid_out = local_bb6_arrayidx51_inputs_ready;
assign local_bb6_arrayidx51_stall_local = local_bb6_arrayidx51_stall_in;
assign merge_node_stall_in_0 = (|local_bb6_arrayidx51_stall_local);

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
 logic rnode_1to164_cmp493_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to164_cmp493_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to164_cmp493_0_NO_SHIFT_REG;
 logic rnode_1to164_cmp493_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to164_cmp493_0_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp493_0_valid_out_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp493_0_stall_in_reg_164_NO_SHIFT_REG;
 logic rnode_1to164_cmp493_0_stall_out_reg_164_NO_SHIFT_REG;

acl_data_fifo rnode_1to164_cmp493_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to164_cmp493_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to164_cmp493_0_stall_in_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_1to164_cmp493_0_valid_out_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_1to164_cmp493_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_lvm_cmp493_NO_SHIFT_REG),
	.data_out(rnode_1to164_cmp493_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_1to164_cmp493_0_reg_164_fifo.DEPTH = 164;
defparam rnode_1to164_cmp493_0_reg_164_fifo.DATA_WIDTH = 1;
defparam rnode_1to164_cmp493_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to164_cmp493_0_reg_164_fifo.IMPL = "ram";

assign rnode_1to164_cmp493_0_reg_164_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to164_cmp493_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_1to164_cmp493_0_NO_SHIFT_REG = rnode_1to164_cmp493_0_reg_164_NO_SHIFT_REG;
assign rnode_1to164_cmp493_0_stall_in_reg_164_NO_SHIFT_REG = rnode_1to164_cmp493_0_stall_in_NO_SHIFT_REG;
assign rnode_1to164_cmp493_0_valid_out_NO_SHIFT_REG = rnode_1to164_cmp493_0_valid_out_reg_164_NO_SHIFT_REG;

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
 logic rnode_1to160_index_04_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_index_04_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_index_04_0_NO_SHIFT_REG;
 logic rnode_1to160_index_04_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_index_04_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_index_04_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_index_04_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_index_04_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_index_04_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_index_04_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_index_04_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_index_04_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_index_04_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_index_04_NO_SHIFT_REG),
	.data_out(rnode_1to160_index_04_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_index_04_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_index_04_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_index_04_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_index_04_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_index_04_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to160_index_04_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_index_04_0_NO_SHIFT_REG = rnode_1to160_index_04_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_index_04_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_index_04_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_index_04_0_valid_out_NO_SHIFT_REG = rnode_1to160_index_04_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_cmp_phi_decision120_xor_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision120_xor_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision120_xor_or_0_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision120_xor_or_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision120_xor_or_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_phi_decision120_xor_or_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_cmp_phi_decision120_xor_or_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_cmp_phi_decision120_xor_or_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_cmp_phi_decision120_xor_or_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_cmp_phi_decision120_xor_or_NO_SHIFT_REG),
	.data_out(rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to160_cmp_phi_decision120_xor_or_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp_phi_decision120_xor_or_0_NO_SHIFT_REG = rnode_1to160_cmp_phi_decision120_xor_or_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp_phi_decision120_xor_or_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_cmp_phi_decision120_xor_or_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_cmp_phi_decision120_xor_or_0_valid_out_NO_SHIFT_REG = rnode_1to160_cmp_phi_decision120_xor_or_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 162
//  * capacity = 162
 logic rnode_1to163_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to163_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to163_sub_0_NO_SHIFT_REG;
 logic rnode_1to163_sub_0_reg_163_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to163_sub_0_reg_163_NO_SHIFT_REG;
 logic rnode_1to163_sub_0_valid_out_reg_163_NO_SHIFT_REG;
 logic rnode_1to163_sub_0_stall_in_reg_163_NO_SHIFT_REG;
 logic rnode_1to163_sub_0_stall_out_reg_163_NO_SHIFT_REG;

acl_data_fifo rnode_1to163_sub_0_reg_163_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to163_sub_0_reg_163_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to163_sub_0_stall_in_reg_163_NO_SHIFT_REG),
	.valid_out(rnode_1to163_sub_0_valid_out_reg_163_NO_SHIFT_REG),
	.stall_out(rnode_1to163_sub_0_stall_out_reg_163_NO_SHIFT_REG),
	.data_in(local_lvm_sub_NO_SHIFT_REG),
	.data_out(rnode_1to163_sub_0_reg_163_NO_SHIFT_REG)
);

defparam rnode_1to163_sub_0_reg_163_fifo.DEPTH = 163;
defparam rnode_1to163_sub_0_reg_163_fifo.DATA_WIDTH = 64;
defparam rnode_1to163_sub_0_reg_163_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to163_sub_0_reg_163_fifo.IMPL = "ram";

assign rnode_1to163_sub_0_reg_163_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to163_sub_0_stall_out_reg_163_NO_SHIFT_REG;
assign rnode_1to163_sub_0_NO_SHIFT_REG = rnode_1to163_sub_0_reg_163_NO_SHIFT_REG;
assign rnode_1to163_sub_0_stall_in_reg_163_NO_SHIFT_REG = rnode_1to163_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_1to163_sub_0_valid_out_NO_SHIFT_REG = rnode_1to163_sub_0_valid_out_reg_163_NO_SHIFT_REG;

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
	.i_address(local_bb6_arrayidx51),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(local_lvm_cmp_phi_decision120_xor_or_NO_SHIFT_REG),
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
defparam lsu_local_bb6_ld_.MEMORY_SIDE_MEM_LATENCY = 58;
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

assign local_bb6_ld__inputs_ready = (local_bb6_arrayidx51_valid_out & merge_node_valid_out_1_NO_SHIFT_REG);
assign local_bb6_ld__output_regs_ready = (&(~(local_bb6_ld__valid_out_NO_SHIFT_REG) | ~(local_bb6_ld__stall_in)));
assign local_bb6_arrayidx51_stall_in = (local_bb6_ld__fu_stall_out | ~(local_bb6_ld__inputs_ready));
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
 logic rnode_164to165_cmp493_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_1_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_valid_out_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_stall_in_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_stall_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_cmp493_0_reg_165_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_164to165_cmp493_0_reg_165_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_164to165_cmp493_0_reg_165_NO_SHIFT_REG),
	.valid_in(rnode_164to165_cmp493_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_cmp493_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.data_out(rnode_164to165_cmp493_0_reg_165_NO_SHIFT_REG_fa),
	.valid_out({rnode_164to165_cmp493_0_valid_out_0_NO_SHIFT_REG, rnode_164to165_cmp493_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_164to165_cmp493_0_stall_in_0_NO_SHIFT_REG, rnode_164to165_cmp493_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_164to165_cmp493_0_reg_165_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_164to165_cmp493_0_reg_165_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_164to165_cmp493_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_cmp493_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_cmp493_0_stall_in_0_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_cmp493_0_valid_out_0_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_cmp493_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_1to164_cmp493_0_NO_SHIFT_REG),
	.data_out(rnode_164to165_cmp493_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_cmp493_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_cmp493_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_cmp493_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_cmp493_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_cmp493_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_1to164_cmp493_0_valid_out_NO_SHIFT_REG;
assign rnode_1to164_cmp493_0_stall_in_NO_SHIFT_REG = rnode_164to165_cmp493_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_cmp493_0_NO_SHIFT_REG = rnode_164to165_cmp493_0_reg_165_NO_SHIFT_REG_fa;
assign rnode_164to165_cmp493_1_NO_SHIFT_REG = rnode_164to165_cmp493_0_reg_165_NO_SHIFT_REG_fa;

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
 logic rnode_160to161_index_04_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_index_04_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_index_04_0_NO_SHIFT_REG;
 logic rnode_160to161_index_04_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_index_04_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_index_04_1_NO_SHIFT_REG;
 logic rnode_160to161_index_04_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_index_04_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_index_04_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_index_04_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_index_04_0_stall_out_reg_161_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_index_04_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_index_04_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_index_04_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_index_04_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_index_04_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_index_04_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_index_04_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_index_04_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_index_04_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_index_04_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_index_04_0_reg_161_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_160to161_index_04_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_index_04_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_index_04_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_index_04_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_index_04_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_index_04_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_index_04_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_index_04_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_index_04_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_index_04_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_index_04_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_index_04_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_index_04_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_index_04_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_index_04_0_stall_in_NO_SHIFT_REG = rnode_160to161_index_04_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_index_04_0_NO_SHIFT_REG = rnode_160to161_index_04_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_index_04_1_NO_SHIFT_REG = rnode_160to161_index_04_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_stall_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_cmp_phi_decision120_xor_or_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_cmp_phi_decision120_xor_or_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_cmp_phi_decision120_xor_or_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_cmp_phi_decision120_xor_or_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_cmp_phi_decision120_xor_or_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_cmp_phi_decision120_xor_or_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_cmp_phi_decision120_xor_or_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_cmp_phi_decision120_xor_or_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_cmp_phi_decision120_xor_or_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_cmp_phi_decision120_xor_or_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_cmp_phi_decision120_xor_or_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_cmp_phi_decision120_xor_or_0_stall_in_NO_SHIFT_REG = rnode_160to161_cmp_phi_decision120_xor_or_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_cmp_phi_decision120_xor_or_0_NO_SHIFT_REG = rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_cmp_phi_decision120_xor_or_1_NO_SHIFT_REG = rnode_160to161_cmp_phi_decision120_xor_or_0_reg_161_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_163to164_sub_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_163to164_sub_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_sub_0_NO_SHIFT_REG;
 logic rnode_163to164_sub_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_163to164_sub_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_sub_1_NO_SHIFT_REG;
 logic rnode_163to164_sub_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_sub_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_sub_0_valid_out_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_sub_0_stall_in_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_sub_0_stall_out_reg_164_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_sub_0_reg_164_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_163to164_sub_0_reg_164_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_163to164_sub_0_reg_164_NO_SHIFT_REG),
	.valid_in(rnode_163to164_sub_0_valid_out_0_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_sub_0_stall_in_0_reg_164_NO_SHIFT_REG),
	.data_out(rnode_163to164_sub_0_reg_164_NO_SHIFT_REG_fa),
	.valid_out({rnode_163to164_sub_0_valid_out_0_NO_SHIFT_REG, rnode_163to164_sub_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_163to164_sub_0_stall_in_0_NO_SHIFT_REG, rnode_163to164_sub_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_163to164_sub_0_reg_164_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_163to164_sub_0_reg_164_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_163to164_sub_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_sub_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_sub_0_stall_in_0_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_sub_0_valid_out_0_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_sub_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(rnode_1to163_sub_0_NO_SHIFT_REG),
	.data_out(rnode_163to164_sub_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_sub_0_reg_164_fifo.DEPTH = 2;
defparam rnode_163to164_sub_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_163to164_sub_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_163to164_sub_0_reg_164_fifo.IMPL = "ll_reg";

assign rnode_163to164_sub_0_reg_164_inputs_ready_NO_SHIFT_REG = rnode_1to163_sub_0_valid_out_NO_SHIFT_REG;
assign rnode_1to163_sub_0_stall_in_NO_SHIFT_REG = rnode_163to164_sub_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_163to164_sub_0_NO_SHIFT_REG = rnode_163to164_sub_0_reg_164_NO_SHIFT_REG_fa;
assign rnode_163to164_sub_1_NO_SHIFT_REG = rnode_163to164_sub_0_reg_164_NO_SHIFT_REG_fa;

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
wire local_bb6_arrayidx52_valid_out;
wire local_bb6_arrayidx52_stall_in;
wire local_bb6_arrayidx52_inputs_ready;
wire local_bb6_arrayidx52_stall_local;
wire [63:0] local_bb6_arrayidx52;

assign local_bb6_arrayidx52_inputs_ready = (rnode_160to161_input_data_0_valid_out_NO_SHIFT_REG & rnode_160to161_index_04_0_valid_out_0_NO_SHIFT_REG);
assign local_bb6_arrayidx52 = (input_data + (rnode_160to161_index_04_0_NO_SHIFT_REG << 6'h2));
assign local_bb6_arrayidx52_valid_out = local_bb6_arrayidx52_inputs_ready;
assign local_bb6_arrayidx52_stall_local = local_bb6_arrayidx52_stall_in;
assign rnode_160to161_input_data_0_stall_in_NO_SHIFT_REG = (local_bb6_arrayidx52_stall_local | ~(local_bb6_arrayidx52_inputs_ready));
assign rnode_160to161_index_04_0_stall_in_0_NO_SHIFT_REG = (local_bb6_arrayidx52_stall_local | ~(local_bb6_arrayidx52_inputs_ready));

// Register node:
//  * latency = 2
//  * capacity = 2
 logic rnode_161to163_index_04_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to163_index_04_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_161to163_index_04_0_NO_SHIFT_REG;
 logic rnode_161to163_index_04_0_reg_163_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_161to163_index_04_0_reg_163_NO_SHIFT_REG;
 logic rnode_161to163_index_04_0_valid_out_reg_163_NO_SHIFT_REG;
 logic rnode_161to163_index_04_0_stall_in_reg_163_NO_SHIFT_REG;
 logic rnode_161to163_index_04_0_stall_out_reg_163_NO_SHIFT_REG;

acl_data_fifo rnode_161to163_index_04_0_reg_163_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to163_index_04_0_reg_163_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to163_index_04_0_stall_in_reg_163_NO_SHIFT_REG),
	.valid_out(rnode_161to163_index_04_0_valid_out_reg_163_NO_SHIFT_REG),
	.stall_out(rnode_161to163_index_04_0_stall_out_reg_163_NO_SHIFT_REG),
	.data_in(rnode_160to161_index_04_1_NO_SHIFT_REG),
	.data_out(rnode_161to163_index_04_0_reg_163_NO_SHIFT_REG)
);

defparam rnode_161to163_index_04_0_reg_163_fifo.DEPTH = 3;
defparam rnode_161to163_index_04_0_reg_163_fifo.DATA_WIDTH = 64;
defparam rnode_161to163_index_04_0_reg_163_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to163_index_04_0_reg_163_fifo.IMPL = "ll_reg";

assign rnode_161to163_index_04_0_reg_163_inputs_ready_NO_SHIFT_REG = rnode_160to161_index_04_0_valid_out_1_NO_SHIFT_REG;
assign rnode_160to161_index_04_0_stall_in_1_NO_SHIFT_REG = rnode_161to163_index_04_0_stall_out_reg_163_NO_SHIFT_REG;
assign rnode_161to163_index_04_0_NO_SHIFT_REG = rnode_161to163_index_04_0_reg_163_NO_SHIFT_REG;
assign rnode_161to163_index_04_0_stall_in_reg_163_NO_SHIFT_REG = rnode_161to163_index_04_0_stall_in_NO_SHIFT_REG;
assign rnode_161to163_index_04_0_valid_out_NO_SHIFT_REG = rnode_161to163_index_04_0_valid_out_reg_163_NO_SHIFT_REG;

// Register node:
//  * latency = 4
//  * capacity = 4
 logic rnode_161to165_cmp_phi_decision120_xor_or_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision120_xor_or_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision120_xor_or_0_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision120_xor_or_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision120_xor_or_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_161to165_cmp_phi_decision120_xor_or_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to165_cmp_phi_decision120_xor_or_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_161to165_cmp_phi_decision120_xor_or_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_161to165_cmp_phi_decision120_xor_or_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_160to161_cmp_phi_decision120_xor_or_1_NO_SHIFT_REG),
	.data_out(rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_fifo.DEPTH = 5;
defparam rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_160to161_cmp_phi_decision120_xor_or_0_valid_out_1_NO_SHIFT_REG;
assign rnode_160to161_cmp_phi_decision120_xor_or_0_stall_in_1_NO_SHIFT_REG = rnode_161to165_cmp_phi_decision120_xor_or_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_161to165_cmp_phi_decision120_xor_or_0_NO_SHIFT_REG = rnode_161to165_cmp_phi_decision120_xor_or_0_reg_165_NO_SHIFT_REG;
assign rnode_161to165_cmp_phi_decision120_xor_or_0_stall_in_reg_165_NO_SHIFT_REG = rnode_161to165_cmp_phi_decision120_xor_or_0_stall_in_NO_SHIFT_REG;
assign rnode_161to165_cmp_phi_decision120_xor_or_0_valid_out_NO_SHIFT_REG = rnode_161to165_cmp_phi_decision120_xor_or_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_sub_0_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_sub_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_sub_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_sub_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_sub_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_sub_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_sub_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_sub_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_163to164_sub_1_NO_SHIFT_REG),
	.data_out(rnode_164to165_sub_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_sub_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_sub_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_sub_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_sub_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_sub_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_163to164_sub_0_valid_out_1_NO_SHIFT_REG;
assign rnode_163to164_sub_0_stall_in_1_NO_SHIFT_REG = rnode_164to165_sub_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_sub_0_NO_SHIFT_REG = rnode_164to165_sub_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_sub_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_sub_0_valid_out_NO_SHIFT_REG = rnode_164to165_sub_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_161to161_bb6_arrayidx52_valid_out;
wire rstag_161to161_bb6_arrayidx52_stall_in;
wire rstag_161to161_bb6_arrayidx52_inputs_ready;
wire rstag_161to161_bb6_arrayidx52_stall_local;
 reg rstag_161to161_bb6_arrayidx52_staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb6_arrayidx52_combined_valid;
 reg [63:0] rstag_161to161_bb6_arrayidx52_staging_reg_NO_SHIFT_REG;
wire [63:0] rstag_161to161_bb6_arrayidx52;

assign rstag_161to161_bb6_arrayidx52_inputs_ready = local_bb6_arrayidx52_valid_out;
assign rstag_161to161_bb6_arrayidx52 = (rstag_161to161_bb6_arrayidx52_staging_valid_NO_SHIFT_REG ? rstag_161to161_bb6_arrayidx52_staging_reg_NO_SHIFT_REG : local_bb6_arrayidx52);
assign rstag_161to161_bb6_arrayidx52_combined_valid = (rstag_161to161_bb6_arrayidx52_staging_valid_NO_SHIFT_REG | rstag_161to161_bb6_arrayidx52_inputs_ready);
assign rstag_161to161_bb6_arrayidx52_valid_out = rstag_161to161_bb6_arrayidx52_combined_valid;
assign rstag_161to161_bb6_arrayidx52_stall_local = rstag_161to161_bb6_arrayidx52_stall_in;
assign local_bb6_arrayidx52_stall_in = (|rstag_161to161_bb6_arrayidx52_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb6_arrayidx52_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb6_arrayidx52_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb6_arrayidx52_stall_local)
		begin
			if (~(rstag_161to161_bb6_arrayidx52_staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb6_arrayidx52_staging_valid_NO_SHIFT_REG <= rstag_161to161_bb6_arrayidx52_inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb6_arrayidx52_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb6_arrayidx52_staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb6_arrayidx52_staging_reg_NO_SHIFT_REG <= local_bb6_arrayidx52;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb6_inc53_valid_out;
wire local_bb6_inc53_stall_in;
wire local_bb6_inc53_inputs_ready;
wire local_bb6_inc53_stall_local;
wire [63:0] local_bb6_inc53;

assign local_bb6_inc53_inputs_ready = rnode_161to163_index_04_0_valid_out_NO_SHIFT_REG;
assign local_bb6_inc53 = (rnode_161to163_index_04_0_NO_SHIFT_REG + 64'h1);
assign local_bb6_inc53_valid_out = local_bb6_inc53_inputs_ready;
assign local_bb6_inc53_stall_local = local_bb6_inc53_stall_in;
assign rnode_161to163_index_04_0_stall_in_NO_SHIFT_REG = (|local_bb6_inc53_stall_local);

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
	.i_address(rstag_161to161_bb6_arrayidx52),
	.i_writedata(rstag_161to161_bb6_ld_),
	.i_cmpdata(),
	.i_predicate(rnode_160to161_cmp_phi_decision120_xor_or_0_NO_SHIFT_REG),
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

assign local_bb6_st__inputs_ready = (rnode_160to161_cmp_phi_decision120_xor_or_0_valid_out_0_NO_SHIFT_REG & rstag_161to161_bb6_arrayidx52_valid_out & rstag_161to161_bb6_ld__valid_out);
assign local_bb6_st__output_regs_ready = (&(~(local_bb6_st__valid_out_NO_SHIFT_REG) | ~(local_bb6_st__stall_in)));
assign rnode_160to161_cmp_phi_decision120_xor_or_0_stall_in_0_NO_SHIFT_REG = (local_bb6_st__fu_stall_out | ~(local_bb6_st__inputs_ready));
assign rstag_161to161_bb6_arrayidx52_stall_in = (local_bb6_st__fu_stall_out | ~(local_bb6_st__inputs_ready));
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
 logic rnode_163to164_bb6_inc53_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_163to164_bb6_inc53_0_stall_in_0_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_bb6_inc53_0_NO_SHIFT_REG;
 logic rnode_163to164_bb6_inc53_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_163to164_bb6_inc53_0_stall_in_1_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_bb6_inc53_1_NO_SHIFT_REG;
 logic rnode_163to164_bb6_inc53_0_reg_164_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_bb6_inc53_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb6_inc53_0_valid_out_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb6_inc53_0_stall_in_0_reg_164_NO_SHIFT_REG;
 logic rnode_163to164_bb6_inc53_0_stall_out_reg_164_NO_SHIFT_REG;
 logic [63:0] rnode_163to164_bb6_inc53_0_reg_164_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_163to164_bb6_inc53_0_reg_164_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_163to164_bb6_inc53_0_reg_164_NO_SHIFT_REG),
	.valid_in(rnode_163to164_bb6_inc53_0_valid_out_0_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb6_inc53_0_stall_in_0_reg_164_NO_SHIFT_REG),
	.data_out(rnode_163to164_bb6_inc53_0_reg_164_NO_SHIFT_REG_fa),
	.valid_out({rnode_163to164_bb6_inc53_0_valid_out_0_NO_SHIFT_REG, rnode_163to164_bb6_inc53_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_163to164_bb6_inc53_0_stall_in_0_NO_SHIFT_REG, rnode_163to164_bb6_inc53_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_163to164_bb6_inc53_0_reg_164_fanout_adaptor.DATA_WIDTH = 64;
defparam rnode_163to164_bb6_inc53_0_reg_164_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_163to164_bb6_inc53_0_reg_164_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_163to164_bb6_inc53_0_reg_164_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_163to164_bb6_inc53_0_stall_in_0_reg_164_NO_SHIFT_REG),
	.valid_out(rnode_163to164_bb6_inc53_0_valid_out_0_reg_164_NO_SHIFT_REG),
	.stall_out(rnode_163to164_bb6_inc53_0_stall_out_reg_164_NO_SHIFT_REG),
	.data_in(local_bb6_inc53),
	.data_out(rnode_163to164_bb6_inc53_0_reg_164_NO_SHIFT_REG)
);

defparam rnode_163to164_bb6_inc53_0_reg_164_fifo.DEPTH = 2;
defparam rnode_163to164_bb6_inc53_0_reg_164_fifo.DATA_WIDTH = 64;
defparam rnode_163to164_bb6_inc53_0_reg_164_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_163to164_bb6_inc53_0_reg_164_fifo.IMPL = "ll_reg";

assign rnode_163to164_bb6_inc53_0_reg_164_inputs_ready_NO_SHIFT_REG = local_bb6_inc53_valid_out;
assign local_bb6_inc53_stall_in = rnode_163to164_bb6_inc53_0_stall_out_reg_164_NO_SHIFT_REG;
assign rnode_163to164_bb6_inc53_0_NO_SHIFT_REG = rnode_163to164_bb6_inc53_0_reg_164_NO_SHIFT_REG_fa;
assign rnode_163to164_bb6_inc53_1_NO_SHIFT_REG = rnode_163to164_bb6_inc53_0_reg_164_NO_SHIFT_REG_fa;

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
wire local_bb6_cmp49_valid_out;
wire local_bb6_cmp49_stall_in;
wire local_bb6_cmp49_inputs_ready;
wire local_bb6_cmp49_stall_local;
wire local_bb6_cmp49;

assign local_bb6_cmp49_inputs_ready = (rnode_163to164_bb6_inc53_0_valid_out_0_NO_SHIFT_REG & rnode_163to164_sub_0_valid_out_0_NO_SHIFT_REG);
assign local_bb6_cmp49 = (rnode_163to164_bb6_inc53_0_NO_SHIFT_REG > rnode_163to164_sub_0_NO_SHIFT_REG);
assign local_bb6_cmp49_valid_out = local_bb6_cmp49_inputs_ready;
assign local_bb6_cmp49_stall_local = local_bb6_cmp49_stall_in;
assign rnode_163to164_bb6_inc53_0_stall_in_0_NO_SHIFT_REG = (local_bb6_cmp49_stall_local | ~(local_bb6_cmp49_inputs_ready));
assign rnode_163to164_sub_0_stall_in_0_NO_SHIFT_REG = (local_bb6_cmp49_stall_local | ~(local_bb6_cmp49_inputs_ready));

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb6_inc53_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb6_inc53_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_bb6_inc53_0_NO_SHIFT_REG;
 logic rnode_164to165_bb6_inc53_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_164to165_bb6_inc53_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_inc53_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_inc53_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_inc53_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb6_inc53_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb6_inc53_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb6_inc53_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb6_inc53_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb6_inc53_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(rnode_163to164_bb6_inc53_1_NO_SHIFT_REG),
	.data_out(rnode_164to165_bb6_inc53_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb6_inc53_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb6_inc53_0_reg_165_fifo.DATA_WIDTH = 64;
defparam rnode_164to165_bb6_inc53_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb6_inc53_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb6_inc53_0_reg_165_inputs_ready_NO_SHIFT_REG = rnode_163to164_bb6_inc53_0_valid_out_1_NO_SHIFT_REG;
assign rnode_163to164_bb6_inc53_0_stall_in_1_NO_SHIFT_REG = rnode_164to165_bb6_inc53_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb6_inc53_0_NO_SHIFT_REG = rnode_164to165_bb6_inc53_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb6_inc53_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_bb6_inc53_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_bb6_inc53_0_valid_out_NO_SHIFT_REG = rnode_164to165_bb6_inc53_0_valid_out_reg_165_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_164to165_bb6_cmp49_0_valid_out_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp49_0_stall_in_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp49_0_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp49_0_reg_165_inputs_ready_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp49_0_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp49_0_valid_out_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp49_0_stall_in_reg_165_NO_SHIFT_REG;
 logic rnode_164to165_bb6_cmp49_0_stall_out_reg_165_NO_SHIFT_REG;

acl_data_fifo rnode_164to165_bb6_cmp49_0_reg_165_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_164to165_bb6_cmp49_0_reg_165_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_164to165_bb6_cmp49_0_stall_in_reg_165_NO_SHIFT_REG),
	.valid_out(rnode_164to165_bb6_cmp49_0_valid_out_reg_165_NO_SHIFT_REG),
	.stall_out(rnode_164to165_bb6_cmp49_0_stall_out_reg_165_NO_SHIFT_REG),
	.data_in(local_bb6_cmp49),
	.data_out(rnode_164to165_bb6_cmp49_0_reg_165_NO_SHIFT_REG)
);

defparam rnode_164to165_bb6_cmp49_0_reg_165_fifo.DEPTH = 2;
defparam rnode_164to165_bb6_cmp49_0_reg_165_fifo.DATA_WIDTH = 1;
defparam rnode_164to165_bb6_cmp49_0_reg_165_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_164to165_bb6_cmp49_0_reg_165_fifo.IMPL = "ll_reg";

assign rnode_164to165_bb6_cmp49_0_reg_165_inputs_ready_NO_SHIFT_REG = local_bb6_cmp49_valid_out;
assign local_bb6_cmp49_stall_in = rnode_164to165_bb6_cmp49_0_stall_out_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb6_cmp49_0_NO_SHIFT_REG = rnode_164to165_bb6_cmp49_0_reg_165_NO_SHIFT_REG;
assign rnode_164to165_bb6_cmp49_0_stall_in_reg_165_NO_SHIFT_REG = rnode_164to165_bb6_cmp49_0_stall_in_NO_SHIFT_REG;
assign rnode_164to165_bb6_cmp49_0_valid_out_NO_SHIFT_REG = rnode_164to165_bb6_cmp49_0_valid_out_reg_165_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb6_cmp49_GUARD_stall_local;
wire local_bb6_cmp49_GUARD;

assign local_bb6_cmp49_GUARD = (rnode_164to165_bb6_cmp49_0_NO_SHIFT_REG | rnode_164to165_cmp493_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb6_var__valid_out;
wire local_bb6_var__stall_in;
wire local_bb6_var__inputs_ready;
wire local_bb6_var__stall_local;
wire local_bb6_var_;

assign local_bb6_var__inputs_ready = (rnode_164to165_bb6_cmp49_0_valid_out_NO_SHIFT_REG & rnode_164to165_cmp493_0_valid_out_0_NO_SHIFT_REG & rnode_164to165_var__0_valid_out_0_NO_SHIFT_REG);
assign local_bb6_var_ = (local_bb6_cmp49_GUARD | rnode_164to165_var__0_NO_SHIFT_REG);
assign local_bb6_var__valid_out = local_bb6_var__inputs_ready;
assign local_bb6_var__stall_local = local_bb6_var__stall_in;
assign rnode_164to165_bb6_cmp49_0_stall_in_NO_SHIFT_REG = (local_bb6_var__stall_local | ~(local_bb6_var__inputs_ready));
assign rnode_164to165_cmp493_0_stall_in_0_NO_SHIFT_REG = (local_bb6_var__stall_local | ~(local_bb6_var__inputs_ready));
assign rnode_164to165_var__0_stall_in_0_NO_SHIFT_REG = (local_bb6_var__stall_local | ~(local_bb6_var__inputs_ready));

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [63:0] lvb_sub_0_reg_NO_SHIFT_REG;
 reg lvb_var__0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb6_inc53_0_reg_NO_SHIFT_REG;
 reg lvb_cmp493_0_reg_NO_SHIFT_REG;
 reg lvb_cmp_phi_decision120_xor_or_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb6_var__valid_out & rnode_161to165_cmp_phi_decision120_xor_or_0_valid_out_NO_SHIFT_REG & rnode_164to165_sub_0_valid_out_NO_SHIFT_REG & rnode_164to165_bb6_inc53_0_valid_out_NO_SHIFT_REG & rnode_164to165_cmp493_0_valid_out_1_NO_SHIFT_REG & rnode_164to165_var__0_valid_out_1_NO_SHIFT_REG & rnode_164to165_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rstag_165to165_bb6_st__valid_out);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb6_var__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_161to165_cmp_phi_decision120_xor_or_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_sub_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_bb6_inc53_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_cmp493_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_var__0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_164to165_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_165to165_bb6_st__stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_sub_0 = lvb_sub_0_reg_NO_SHIFT_REG;
assign lvb_sub_1 = lvb_sub_0_reg_NO_SHIFT_REG;
assign lvb_var__0 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_var__1 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_bb6_inc53_0 = lvb_bb6_inc53_0_reg_NO_SHIFT_REG;
assign lvb_bb6_inc53_1 = lvb_bb6_inc53_0_reg_NO_SHIFT_REG;
assign lvb_cmp493_0 = lvb_cmp493_0_reg_NO_SHIFT_REG;
assign lvb_cmp493_1 = lvb_cmp493_0_reg_NO_SHIFT_REG;
assign lvb_cmp_phi_decision120_xor_or_0 = lvb_cmp_phi_decision120_xor_or_0_reg_NO_SHIFT_REG;
assign lvb_cmp_phi_decision120_xor_or_1 = lvb_cmp_phi_decision120_xor_or_0_reg_NO_SHIFT_REG;
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
		lvb_sub_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb6_inc53_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp493_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp_phi_decision120_xor_or_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_sub_0_reg_NO_SHIFT_REG <= rnode_164to165_sub_0_NO_SHIFT_REG;
			lvb_var__0_reg_NO_SHIFT_REG <= rnode_164to165_var__1_NO_SHIFT_REG;
			lvb_bb6_inc53_0_reg_NO_SHIFT_REG <= rnode_164to165_bb6_inc53_0_NO_SHIFT_REG;
			lvb_cmp493_0_reg_NO_SHIFT_REG <= rnode_164to165_cmp493_1_NO_SHIFT_REG;
			lvb_cmp_phi_decision120_xor_or_0_reg_NO_SHIFT_REG <= rnode_161to165_cmp_phi_decision120_xor_or_0_NO_SHIFT_REG;
			lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= rnode_164to165_input_acl_hw_wg_id_0_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= local_bb6_var_;
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
		input 		valid_in,
		output 		stall_out,
		input [63:0] 		input_mul,
		input 		input_cmp,
		input [63:0] 		input_sub,
		input [63:0] 		input_div,
		input 		input_var_,
		input [63:0] 		input_left_lower_0_ph,
		input [63:0] 		input_arrayidx24,
		input [63:0] 		input_right_lower_0_ph6,
		input [31:0] 		input_ld_,
		input [31:0] 		input_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select,
		input [63:0] 		input_arrayidx31,
		input [63:0] 		input_temp_index_0_ph7_be,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out_0,
		input 		stall_in_0,
		output [63:0] 		lvb_mul_0,
		output 		lvb_cmp_0,
		output [63:0] 		lvb_sub_0,
		output [63:0] 		lvb_div_0,
		output 		lvb_var__0,
		output [63:0] 		lvb_right_lower_0_ph6_0,
		output [63:0] 		lvb_temp_index_0_ph7_be_0,
		output [63:0] 		lvb_bb8_left_lower_0_ph_be_0,
		output [31:0] 		lvb_input_acl_hw_wg_id_0,
		output 		valid_out_1,
		input 		stall_in_1,
		output [63:0] 		lvb_mul_1,
		output 		lvb_cmp_1,
		output [63:0] 		lvb_sub_1,
		output [63:0] 		lvb_div_1,
		output 		lvb_var__1,
		output [63:0] 		lvb_right_lower_0_ph6_1,
		output [63:0] 		lvb_temp_index_0_ph7_be_1,
		output [63:0] 		lvb_bb8_left_lower_0_ph_be_1,
		output [31:0] 		lvb_input_acl_hw_wg_id_1,
		input [31:0] 		workgroup_size,
		input 		start,
		input [255:0] 		avm_local_bb8_ld__readdata,
		input 		avm_local_bb8_ld__readdatavalid,
		input 		avm_local_bb8_ld__waitrequest,
		output [29:0] 		avm_local_bb8_ld__address,
		output 		avm_local_bb8_ld__read,
		output 		avm_local_bb8_ld__write,
		input 		avm_local_bb8_ld__writeack,
		output [255:0] 		avm_local_bb8_ld__writedata,
		output [31:0] 		avm_local_bb8_ld__byteenable,
		output [4:0] 		avm_local_bb8_ld__burstcount,
		output 		local_bb8_ld__active,
		input 		clock2x,
		input [255:0] 		avm_local_bb8_st__52_readdata,
		input 		avm_local_bb8_st__52_readdatavalid,
		input 		avm_local_bb8_st__52_waitrequest,
		output [29:0] 		avm_local_bb8_st__52_address,
		output 		avm_local_bb8_st__52_read,
		output 		avm_local_bb8_st__52_write,
		input 		avm_local_bb8_st__52_writeack,
		output [255:0] 		avm_local_bb8_st__52_writedata,
		output [31:0] 		avm_local_bb8_st__52_byteenable,
		output [4:0] 		avm_local_bb8_st__52_burstcount,
		output 		local_bb8_st__52_active
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
wire merge_stalled_by_successors;
 reg merge_block_selector_NO_SHIFT_REG;
 reg merge_node_valid_in_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_mul_staging_reg_NO_SHIFT_REG;
 reg input_cmp_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_div_staging_reg_NO_SHIFT_REG;
 reg input_var__staging_reg_NO_SHIFT_REG;
 reg [63:0] input_left_lower_0_ph_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx24_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_right_lower_0_ph6_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_ld__staging_reg_NO_SHIFT_REG;
 reg [31:0] input_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_arrayidx31_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_temp_index_0_ph7_be_staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [63:0] local_lvm_mul_NO_SHIFT_REG;
 reg local_lvm_cmp_NO_SHIFT_REG;
 reg [63:0] local_lvm_sub_NO_SHIFT_REG;
 reg [63:0] local_lvm_div_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
 reg [63:0] local_lvm_left_lower_0_ph_NO_SHIFT_REG;
 reg [63:0] local_lvm_arrayidx24_NO_SHIFT_REG;
 reg [63:0] local_lvm_right_lower_0_ph6_NO_SHIFT_REG;
 reg [31:0] local_lvm_ld__NO_SHIFT_REG;
 reg [31:0] local_lvm_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_NO_SHIFT_REG;
 reg [63:0] local_lvm_arrayidx31_NO_SHIFT_REG;
 reg [63:0] local_lvm_temp_index_0_ph7_be_NO_SHIFT_REG;
 reg [31:0] local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG;
 reg is_merge_data_to_local_regs_valid_NO_SHIFT_REG;
 reg invariant_valid_NO_SHIFT_REG;

assign merge_stalled_by_successors = ((merge_node_stall_in_0 & merge_node_valid_out_0_NO_SHIFT_REG) | (merge_node_stall_in_1 & merge_node_valid_out_1_NO_SHIFT_REG) | (merge_node_stall_in_2 & merge_node_valid_out_2_NO_SHIFT_REG) | (merge_node_stall_in_3 & merge_node_valid_out_3_NO_SHIFT_REG) | (merge_node_stall_in_4 & merge_node_valid_out_4_NO_SHIFT_REG) | (merge_node_stall_in_5 & merge_node_valid_out_5_NO_SHIFT_REG) | (merge_node_stall_in_6 & merge_node_valid_out_6_NO_SHIFT_REG) | (merge_node_stall_in_7 & merge_node_valid_out_7_NO_SHIFT_REG) | (merge_node_stall_in_8 & merge_node_valid_out_8_NO_SHIFT_REG) | (merge_node_stall_in_9 & merge_node_valid_out_9_NO_SHIFT_REG) | (merge_node_stall_in_10 & merge_node_valid_out_10_NO_SHIFT_REG) | (merge_node_stall_in_11 & merge_node_valid_out_11_NO_SHIFT_REG) | (merge_node_stall_in_12 & merge_node_valid_out_12_NO_SHIFT_REG) | (merge_node_stall_in_13 & merge_node_valid_out_13_NO_SHIFT_REG) | (merge_node_stall_in_14 & merge_node_valid_out_14_NO_SHIFT_REG));
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
		input_mul_staging_reg_NO_SHIFT_REG <= 'x;
		input_cmp_staging_reg_NO_SHIFT_REG <= 'x;
		input_sub_staging_reg_NO_SHIFT_REG <= 'x;
		input_div_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__staging_reg_NO_SHIFT_REG <= 'x;
		input_left_lower_0_ph_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx24_staging_reg_NO_SHIFT_REG <= 'x;
		input_right_lower_0_ph6_staging_reg_NO_SHIFT_REG <= 'x;
		input_ld__staging_reg_NO_SHIFT_REG <= 'x;
		input_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_staging_reg_NO_SHIFT_REG <= 'x;
		input_arrayidx31_staging_reg_NO_SHIFT_REG <= 'x;
		input_temp_index_0_ph7_be_staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_mul_staging_reg_NO_SHIFT_REG <= input_mul;
				input_cmp_staging_reg_NO_SHIFT_REG <= input_cmp;
				input_sub_staging_reg_NO_SHIFT_REG <= input_sub;
				input_div_staging_reg_NO_SHIFT_REG <= input_div;
				input_var__staging_reg_NO_SHIFT_REG <= input_var_;
				input_left_lower_0_ph_staging_reg_NO_SHIFT_REG <= input_left_lower_0_ph;
				input_arrayidx24_staging_reg_NO_SHIFT_REG <= input_arrayidx24;
				input_right_lower_0_ph6_staging_reg_NO_SHIFT_REG <= input_right_lower_0_ph6;
				input_ld__staging_reg_NO_SHIFT_REG <= input_ld_;
				input_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_staging_reg_NO_SHIFT_REG <= input_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select;
				input_arrayidx31_staging_reg_NO_SHIFT_REG <= input_arrayidx31;
				input_temp_index_0_ph7_be_staging_reg_NO_SHIFT_REG <= input_temp_index_0_ph7_be;
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
					local_lvm_mul_NO_SHIFT_REG <= input_mul_staging_reg_NO_SHIFT_REG;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp_staging_reg_NO_SHIFT_REG;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_staging_reg_NO_SHIFT_REG;
					local_lvm_div_NO_SHIFT_REG <= input_div_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__staging_reg_NO_SHIFT_REG;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24_staging_reg_NO_SHIFT_REG;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6_staging_reg_NO_SHIFT_REG;
					local_lvm_ld__NO_SHIFT_REG <= input_ld__staging_reg_NO_SHIFT_REG;
					local_lvm_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_NO_SHIFT_REG <= input_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_staging_reg_NO_SHIFT_REG;
					local_lvm_arrayidx31_NO_SHIFT_REG <= input_arrayidx31_staging_reg_NO_SHIFT_REG;
					local_lvm_temp_index_0_ph7_be_NO_SHIFT_REG <= input_temp_index_0_ph7_be_staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul;
					local_lvm_cmp_NO_SHIFT_REG <= input_cmp;
					local_lvm_sub_NO_SHIFT_REG <= input_sub;
					local_lvm_div_NO_SHIFT_REG <= input_div;
					local_lvm_var__NO_SHIFT_REG <= input_var_;
					local_lvm_left_lower_0_ph_NO_SHIFT_REG <= input_left_lower_0_ph;
					local_lvm_arrayidx24_NO_SHIFT_REG <= input_arrayidx24;
					local_lvm_right_lower_0_ph6_NO_SHIFT_REG <= input_right_lower_0_ph6;
					local_lvm_ld__NO_SHIFT_REG <= input_ld_;
					local_lvm_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_NO_SHIFT_REG <= input_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select;
					local_lvm_arrayidx31_NO_SHIFT_REG <= input_arrayidx31;
					local_lvm_temp_index_0_ph7_be_NO_SHIFT_REG <= input_temp_index_0_ph7_be;
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
wire local_bb8_while_cond_outer5_branch_to_dummy_stall_local;
wire local_bb8_while_cond_outer5_branch_to_dummy;

assign local_bb8_while_cond_outer5_branch_to_dummy = (local_lvm_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_NO_SHIFT_REG == 32'h2);

// This section implements an unregistered operation.
// 
wire local_bb8_select55_off_valid_out;
wire local_bb8_select55_off_stall_in;
wire local_bb8_select55_off_inputs_ready;
wire local_bb8_select55_off_stall_local;
wire [31:0] local_bb8_select55_off;

assign local_bb8_select55_off_inputs_ready = merge_node_valid_out_3_NO_SHIFT_REG;
assign local_bb8_select55_off = (local_lvm_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_NO_SHIFT_REG + 32'hFFFFFFFE);
assign local_bb8_select55_off_valid_out = local_bb8_select55_off_inputs_ready;
assign local_bb8_select55_off_stall_local = local_bb8_select55_off_stall_in;
assign merge_node_stall_in_3 = (|local_bb8_select55_off_stall_local);

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

assign rnode_1to160_ld__0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_4_NO_SHIFT_REG;
assign merge_node_stall_in_4 = rnode_1to160_ld__0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_ld__0_NO_SHIFT_REG = rnode_1to160_ld__0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_ld__0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_ld__0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_ld__0_valid_out_NO_SHIFT_REG = rnode_1to160_ld__0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_arrayidx31_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_arrayidx31_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_arrayidx31_0_NO_SHIFT_REG;
 logic rnode_1to160_arrayidx31_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to160_arrayidx31_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_arrayidx31_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_arrayidx31_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_arrayidx31_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_arrayidx31_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_arrayidx31_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_arrayidx31_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_arrayidx31_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_arrayidx31_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_arrayidx31_NO_SHIFT_REG),
	.data_out(rnode_1to160_arrayidx31_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_arrayidx31_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_arrayidx31_0_reg_160_fifo.DATA_WIDTH = 64;
defparam rnode_1to160_arrayidx31_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_arrayidx31_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_arrayidx31_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_5_NO_SHIFT_REG;
assign merge_node_stall_in_5 = rnode_1to160_arrayidx31_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_arrayidx31_0_NO_SHIFT_REG = rnode_1to160_arrayidx31_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_arrayidx31_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_arrayidx31_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_arrayidx31_0_valid_out_NO_SHIFT_REG = rnode_1to160_arrayidx31_0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_left_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_left_lower_0_ph_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_left_lower_0_ph_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_left_lower_0_ph_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_left_lower_0_ph_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_left_lower_0_ph_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_left_lower_0_ph_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_left_lower_0_ph_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_left_lower_0_ph_NO_SHIFT_REG),
	.data_out(rnode_1to300_left_lower_0_ph_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_left_lower_0_ph_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_left_lower_0_ph_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_left_lower_0_ph_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_left_lower_0_ph_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_left_lower_0_ph_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_6_NO_SHIFT_REG;
assign merge_node_stall_in_6 = rnode_1to300_left_lower_0_ph_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_left_lower_0_ph_0_NO_SHIFT_REG = rnode_1to300_left_lower_0_ph_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_left_lower_0_ph_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_left_lower_0_ph_0_valid_out_NO_SHIFT_REG = rnode_1to300_left_lower_0_ph_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_mul_0_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_mul_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_mul_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_mul_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_mul_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_mul_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_mul_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_mul_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_mul_NO_SHIFT_REG),
	.data_out(rnode_1to300_mul_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_mul_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_mul_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_mul_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_mul_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_mul_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_7_NO_SHIFT_REG;
assign merge_node_stall_in_7 = rnode_1to300_mul_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_mul_0_NO_SHIFT_REG = rnode_1to300_mul_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_mul_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_mul_0_valid_out_NO_SHIFT_REG = rnode_1to300_mul_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_sub_0_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_sub_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_sub_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_sub_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_sub_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_sub_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_sub_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_sub_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_sub_NO_SHIFT_REG),
	.data_out(rnode_1to300_sub_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_sub_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_sub_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_sub_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_sub_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_sub_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_8_NO_SHIFT_REG;
assign merge_node_stall_in_8 = rnode_1to300_sub_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_sub_0_NO_SHIFT_REG = rnode_1to300_sub_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_sub_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_sub_0_valid_out_NO_SHIFT_REG = rnode_1to300_sub_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_div_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_div_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_div_0_NO_SHIFT_REG;
 logic rnode_1to300_div_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_div_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_div_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_div_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_div_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_div_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_div_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_div_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_div_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_div_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_div_NO_SHIFT_REG),
	.data_out(rnode_1to300_div_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_div_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_div_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_div_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_div_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_div_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_9_NO_SHIFT_REG;
assign merge_node_stall_in_9 = rnode_1to300_div_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_div_0_NO_SHIFT_REG = rnode_1to300_div_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_div_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_div_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_div_0_valid_out_NO_SHIFT_REG = rnode_1to300_div_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_1to300_var__0_NO_SHIFT_REG;
 logic rnode_1to300_var__0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to300_var__0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_var__0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_var__0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_var__0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_var__0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_var__0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_var__0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_var__0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_var__0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_var__NO_SHIFT_REG),
	.data_out(rnode_1to300_var__0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_var__0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_var__0_reg_300_fifo.DATA_WIDTH = 1;
defparam rnode_1to300_var__0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_var__0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_var__0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_10_NO_SHIFT_REG;
assign merge_node_stall_in_10 = rnode_1to300_var__0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_var__0_NO_SHIFT_REG = rnode_1to300_var__0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_var__0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_var__0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_var__0_valid_out_NO_SHIFT_REG = rnode_1to300_var__0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_right_lower_0_ph6_0_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_right_lower_0_ph6_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_right_lower_0_ph6_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_right_lower_0_ph6_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_right_lower_0_ph6_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_right_lower_0_ph6_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_right_lower_0_ph6_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_right_lower_0_ph6_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_right_lower_0_ph6_NO_SHIFT_REG),
	.data_out(rnode_1to300_right_lower_0_ph6_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_right_lower_0_ph6_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_right_lower_0_ph6_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_right_lower_0_ph6_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_right_lower_0_ph6_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_right_lower_0_ph6_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_11_NO_SHIFT_REG;
assign merge_node_stall_in_11 = rnode_1to300_right_lower_0_ph6_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_right_lower_0_ph6_0_NO_SHIFT_REG = rnode_1to300_right_lower_0_ph6_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_right_lower_0_ph6_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG = rnode_1to300_right_lower_0_ph6_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_temp_index_0_ph7_be_0_NO_SHIFT_REG;
 logic rnode_1to300_temp_index_0_ph7_be_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to300_temp_index_0_ph7_be_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_temp_index_0_ph7_be_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_temp_index_0_ph7_be_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_temp_index_0_ph7_be_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_temp_index_0_ph7_be_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_temp_index_0_ph7_be_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_temp_index_0_ph7_be_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_temp_index_0_ph7_be_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_temp_index_0_ph7_be_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_temp_index_0_ph7_be_NO_SHIFT_REG),
	.data_out(rnode_1to300_temp_index_0_ph7_be_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_temp_index_0_ph7_be_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_temp_index_0_ph7_be_0_reg_300_fifo.DATA_WIDTH = 64;
defparam rnode_1to300_temp_index_0_ph7_be_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_temp_index_0_ph7_be_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_temp_index_0_ph7_be_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_12_NO_SHIFT_REG;
assign merge_node_stall_in_12 = rnode_1to300_temp_index_0_ph7_be_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_temp_index_0_ph7_be_0_NO_SHIFT_REG = rnode_1to300_temp_index_0_ph7_be_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_temp_index_0_ph7_be_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG = rnode_1to300_temp_index_0_ph7_be_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 299
//  * capacity = 299
 logic rnode_1to300_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to300_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to300_input_acl_hw_wg_id_0_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_1to300_input_acl_hw_wg_id_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to300_input_acl_hw_wg_id_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to300_input_acl_hw_wg_id_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_1to300_input_acl_hw_wg_id_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_1to300_input_acl_hw_wg_id_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG),
	.data_out(rnode_1to300_input_acl_hw_wg_id_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo.DEPTH = 300;
defparam rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo.DATA_WIDTH = 32;
defparam rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to300_input_acl_hw_wg_id_0_reg_300_fifo.IMPL = "ram";

assign rnode_1to300_input_acl_hw_wg_id_0_reg_300_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_13_NO_SHIFT_REG;
assign merge_node_stall_in_13 = rnode_1to300_input_acl_hw_wg_id_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_1to300_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_1to300_input_acl_hw_wg_id_0_reg_300_NO_SHIFT_REG;
assign rnode_1to300_input_acl_hw_wg_id_0_stall_in_reg_300_NO_SHIFT_REG = rnode_1to300_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_1to300_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_1to300_input_acl_hw_wg_id_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_cmp_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_cmp_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_cmp_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_cmp_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_cmp_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_cmp_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_cmp_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_lvm_cmp_NO_SHIFT_REG),
	.data_out(rnode_1to160_cmp_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_cmp_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_cmp_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_cmp_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_cmp_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_cmp_0_reg_160_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_14_NO_SHIFT_REG;
assign merge_node_stall_in_14 = rnode_1to160_cmp_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp_0_NO_SHIFT_REG = rnode_1to160_cmp_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_cmp_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_cmp_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_cmp_0_valid_out_NO_SHIFT_REG = rnode_1to160_cmp_0_valid_out_reg_160_NO_SHIFT_REG;

// This section implements an unregistered operation.
// 
wire local_bb8_cmp_phi_decision117_xor_or_demorgan_stall_local;
wire local_bb8_cmp_phi_decision117_xor_or_demorgan;

assign local_bb8_cmp_phi_decision117_xor_or_demorgan = (local_bb8_while_cond_outer5_branch_to_dummy & local_lvm_cmp_NO_SHIFT_REG);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_bb8_select55_off_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_bb8_select55_off_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb8_select55_off_0_NO_SHIFT_REG;
 logic rnode_1to2_bb8_select55_off_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_1to2_bb8_select55_off_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb8_select55_off_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb8_select55_off_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb8_select55_off_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_bb8_select55_off_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb8_select55_off_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb8_select55_off_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb8_select55_off_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb8_select55_off_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb8_select55_off),
	.data_out(rnode_1to2_bb8_select55_off_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb8_select55_off_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb8_select55_off_0_reg_2_fifo.DATA_WIDTH = 32;
defparam rnode_1to2_bb8_select55_off_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb8_select55_off_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb8_select55_off_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb8_select55_off_valid_out;
assign local_bb8_select55_off_stall_in = rnode_1to2_bb8_select55_off_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb8_select55_off_0_NO_SHIFT_REG = rnode_1to2_bb8_select55_off_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb8_select55_off_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_bb8_select55_off_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_bb8_select55_off_0_valid_out_NO_SHIFT_REG = rnode_1to2_bb8_select55_off_0_valid_out_reg_2_NO_SHIFT_REG;

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
 logic rnode_160to161_arrayidx31_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_arrayidx31_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_arrayidx31_0_NO_SHIFT_REG;
 logic rnode_160to161_arrayidx31_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_160to161_arrayidx31_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_arrayidx31_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_arrayidx31_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_arrayidx31_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_arrayidx31_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_arrayidx31_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_arrayidx31_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_arrayidx31_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_arrayidx31_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_arrayidx31_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_arrayidx31_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_arrayidx31_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_arrayidx31_0_reg_161_fifo.DATA_WIDTH = 64;
defparam rnode_160to161_arrayidx31_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_arrayidx31_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_arrayidx31_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_arrayidx31_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_arrayidx31_0_stall_in_NO_SHIFT_REG = rnode_160to161_arrayidx31_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_arrayidx31_0_NO_SHIFT_REG = rnode_160to161_arrayidx31_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_arrayidx31_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_arrayidx31_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_arrayidx31_0_valid_out_NO_SHIFT_REG = rnode_160to161_arrayidx31_0_valid_out_reg_161_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_left_lower_0_ph_0_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_left_lower_0_ph_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_left_lower_0_ph_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_left_lower_0_ph_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_left_lower_0_ph_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_left_lower_0_ph_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_left_lower_0_ph_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_left_lower_0_ph_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_left_lower_0_ph_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_left_lower_0_ph_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_left_lower_0_ph_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_left_lower_0_ph_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_left_lower_0_ph_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_left_lower_0_ph_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_left_lower_0_ph_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_left_lower_0_ph_0_stall_in_NO_SHIFT_REG = rnode_300to301_left_lower_0_ph_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_left_lower_0_ph_0_NO_SHIFT_REG = rnode_300to301_left_lower_0_ph_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_left_lower_0_ph_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_left_lower_0_ph_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_left_lower_0_ph_0_valid_out_NO_SHIFT_REG = rnode_300to301_left_lower_0_ph_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_mul_0_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_mul_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_mul_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_mul_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_mul_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_mul_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_mul_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_mul_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_mul_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_mul_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_mul_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_mul_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_mul_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_mul_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_mul_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_mul_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_mul_0_stall_in_NO_SHIFT_REG = rnode_300to301_mul_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_mul_0_NO_SHIFT_REG = rnode_300to301_mul_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_mul_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_mul_0_valid_out_NO_SHIFT_REG = rnode_300to301_mul_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_sub_0_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_sub_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_sub_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_sub_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_sub_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_sub_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_sub_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_sub_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_sub_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_sub_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_sub_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_sub_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_sub_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_sub_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_sub_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_sub_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_sub_0_stall_in_NO_SHIFT_REG = rnode_300to301_sub_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_sub_0_NO_SHIFT_REG = rnode_300to301_sub_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_sub_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_sub_0_valid_out_NO_SHIFT_REG = rnode_300to301_sub_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_div_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_div_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_div_0_NO_SHIFT_REG;
 logic rnode_300to301_div_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_div_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_div_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_div_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_div_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_div_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_div_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_div_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_div_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_div_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_div_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_div_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_div_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_div_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_div_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_div_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_div_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_div_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_div_0_stall_in_NO_SHIFT_REG = rnode_300to301_div_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_div_0_NO_SHIFT_REG = rnode_300to301_div_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_div_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_div_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_div_0_valid_out_NO_SHIFT_REG = rnode_300to301_div_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_300to301_var__0_NO_SHIFT_REG;
 logic rnode_300to301_var__0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic rnode_300to301_var__0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_var__0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_var__0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_var__0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_var__0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_var__0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_var__0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_var__0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_var__0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_var__0_NO_SHIFT_REG),
	.data_out(rnode_300to301_var__0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_var__0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_var__0_reg_301_fifo.DATA_WIDTH = 1;
defparam rnode_300to301_var__0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_var__0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_var__0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_var__0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_var__0_stall_in_NO_SHIFT_REG = rnode_300to301_var__0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_var__0_NO_SHIFT_REG = rnode_300to301_var__0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_var__0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_var__0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_var__0_valid_out_NO_SHIFT_REG = rnode_300to301_var__0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_right_lower_0_ph6_0_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_right_lower_0_ph6_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_right_lower_0_ph6_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_right_lower_0_ph6_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_right_lower_0_ph6_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_right_lower_0_ph6_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_right_lower_0_ph6_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_right_lower_0_ph6_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_right_lower_0_ph6_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_right_lower_0_ph6_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG = rnode_300to301_right_lower_0_ph6_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_right_lower_0_ph6_0_NO_SHIFT_REG = rnode_300to301_right_lower_0_ph6_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_right_lower_0_ph6_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG = rnode_300to301_right_lower_0_ph6_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_temp_index_0_ph7_be_0_NO_SHIFT_REG;
 logic rnode_300to301_temp_index_0_ph7_be_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_300to301_temp_index_0_ph7_be_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_temp_index_0_ph7_be_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_temp_index_0_ph7_be_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_temp_index_0_ph7_be_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_temp_index_0_ph7_be_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_temp_index_0_ph7_be_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_temp_index_0_ph7_be_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_temp_index_0_ph7_be_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_temp_index_0_ph7_be_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_temp_index_0_ph7_be_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_temp_index_0_ph7_be_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_temp_index_0_ph7_be_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_temp_index_0_ph7_be_0_reg_301_fifo.DATA_WIDTH = 64;
defparam rnode_300to301_temp_index_0_ph7_be_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_temp_index_0_ph7_be_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_temp_index_0_ph7_be_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG = rnode_300to301_temp_index_0_ph7_be_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_temp_index_0_ph7_be_0_NO_SHIFT_REG = rnode_300to301_temp_index_0_ph7_be_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_temp_index_0_ph7_be_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG = rnode_300to301_temp_index_0_ph7_be_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_input_acl_hw_wg_id_0_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic [31:0] rnode_300to301_input_acl_hw_wg_id_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_input_acl_hw_wg_id_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_input_acl_hw_wg_id_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_input_acl_hw_wg_id_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_input_acl_hw_wg_id_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_input_acl_hw_wg_id_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_1to300_input_acl_hw_wg_id_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_input_acl_hw_wg_id_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo.DATA_WIDTH = 32;
defparam rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_input_acl_hw_wg_id_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_input_acl_hw_wg_id_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_1to300_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG;
assign rnode_1to300_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = rnode_300to301_input_acl_hw_wg_id_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_input_acl_hw_wg_id_0_NO_SHIFT_REG = rnode_300to301_input_acl_hw_wg_id_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_input_acl_hw_wg_id_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG = rnode_300to301_input_acl_hw_wg_id_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_cmp_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_1_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_valid_out_2_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_stall_in_2_NO_SHIFT_REG;
 logic rnode_160to161_cmp_2_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_stall_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_cmp_0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_cmp_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_cmp_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_cmp_0_valid_out_0_NO_SHIFT_REG, rnode_160to161_cmp_0_valid_out_1_NO_SHIFT_REG, rnode_160to161_cmp_0_valid_out_2_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_cmp_0_stall_in_0_NO_SHIFT_REG, rnode_160to161_cmp_0_stall_in_1_NO_SHIFT_REG, rnode_160to161_cmp_0_stall_in_2_NO_SHIFT_REG})
);

defparam rnode_160to161_cmp_0_reg_161_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_160to161_cmp_0_reg_161_fanout_adaptor.NUM_FANOUTS = 3;

acl_data_fifo rnode_160to161_cmp_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_cmp_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_cmp_0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_cmp_0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_cmp_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_cmp_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_cmp_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_cmp_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_cmp_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_cmp_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_cmp_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_cmp_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_cmp_0_stall_in_NO_SHIFT_REG = rnode_160to161_cmp_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_cmp_0_NO_SHIFT_REG = rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_cmp_1_NO_SHIFT_REG = rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_cmp_2_NO_SHIFT_REG = rnode_160to161_cmp_0_reg_161_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb8_while_cond_outer5_branch_to_dummy_valid_out_1;
wire local_bb8_while_cond_outer5_branch_to_dummy_stall_in_1;
 reg local_bb8_while_cond_outer5_branch_to_dummy_consumed_1_NO_SHIFT_REG;
wire local_bb8_cmp_phi_decision117_xor_or_valid_out;
wire local_bb8_cmp_phi_decision117_xor_or_stall_in;
 reg local_bb8_cmp_phi_decision117_xor_or_consumed_0_NO_SHIFT_REG;
wire local_bb8_cmp_phi_decision117_xor_or_inputs_ready;
wire local_bb8_cmp_phi_decision117_xor_or_stall_local;
wire local_bb8_cmp_phi_decision117_xor_or;

assign local_bb8_cmp_phi_decision117_xor_or_inputs_ready = (merge_node_valid_out_0_NO_SHIFT_REG & merge_node_valid_out_1_NO_SHIFT_REG);
assign local_bb8_cmp_phi_decision117_xor_or = (local_bb8_cmp_phi_decision117_xor_or_demorgan ^ 1'b1);
assign local_bb8_cmp_phi_decision117_xor_or_stall_local = ((local_bb8_while_cond_outer5_branch_to_dummy_stall_in_1 & ~(local_bb8_while_cond_outer5_branch_to_dummy_consumed_1_NO_SHIFT_REG)) | (local_bb8_cmp_phi_decision117_xor_or_stall_in & ~(local_bb8_cmp_phi_decision117_xor_or_consumed_0_NO_SHIFT_REG)));
assign local_bb8_while_cond_outer5_branch_to_dummy_valid_out_1 = (local_bb8_cmp_phi_decision117_xor_or_inputs_ready & ~(local_bb8_while_cond_outer5_branch_to_dummy_consumed_1_NO_SHIFT_REG));
assign local_bb8_cmp_phi_decision117_xor_or_valid_out = (local_bb8_cmp_phi_decision117_xor_or_inputs_ready & ~(local_bb8_cmp_phi_decision117_xor_or_consumed_0_NO_SHIFT_REG));
assign merge_node_stall_in_0 = (local_bb8_cmp_phi_decision117_xor_or_stall_local | ~(local_bb8_cmp_phi_decision117_xor_or_inputs_ready));
assign merge_node_stall_in_1 = (local_bb8_cmp_phi_decision117_xor_or_stall_local | ~(local_bb8_cmp_phi_decision117_xor_or_inputs_ready));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb8_while_cond_outer5_branch_to_dummy_consumed_1_NO_SHIFT_REG <= 1'b0;
		local_bb8_cmp_phi_decision117_xor_or_consumed_0_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		local_bb8_while_cond_outer5_branch_to_dummy_consumed_1_NO_SHIFT_REG <= (local_bb8_cmp_phi_decision117_xor_or_inputs_ready & (local_bb8_while_cond_outer5_branch_to_dummy_consumed_1_NO_SHIFT_REG | ~(local_bb8_while_cond_outer5_branch_to_dummy_stall_in_1)) & local_bb8_cmp_phi_decision117_xor_or_stall_local);
		local_bb8_cmp_phi_decision117_xor_or_consumed_0_NO_SHIFT_REG <= (local_bb8_cmp_phi_decision117_xor_or_inputs_ready & (local_bb8_cmp_phi_decision117_xor_or_consumed_0_NO_SHIFT_REG | ~(local_bb8_cmp_phi_decision117_xor_or_stall_in)) & local_bb8_cmp_phi_decision117_xor_or_stall_local);
	end
end


// This section implements an unregistered operation.
// 
wire local_bb8_var__valid_out;
wire local_bb8_var__stall_in;
wire local_bb8_var__inputs_ready;
wire local_bb8_var__stall_local;
wire local_bb8_var_;

assign local_bb8_var__inputs_ready = rnode_1to2_bb8_select55_off_0_valid_out_NO_SHIFT_REG;
assign local_bb8_var_ = (rnode_1to2_bb8_select55_off_0_NO_SHIFT_REG < 32'h2);
assign local_bb8_var__valid_out = local_bb8_var__inputs_ready;
assign local_bb8_var__stall_local = local_bb8_var__stall_in;
assign rnode_1to2_bb8_select55_off_0_stall_in_NO_SHIFT_REG = (|local_bb8_var__stall_local);

// This section implements an unregistered operation.
// 
wire local_bb8_left_lower_0_ph_be_valid_out;
wire local_bb8_left_lower_0_ph_be_stall_in;
wire local_bb8_left_lower_0_ph_be_inputs_ready;
wire local_bb8_left_lower_0_ph_be_stall_local;
wire [63:0] local_bb8_left_lower_0_ph_be;

assign local_bb8_left_lower_0_ph_be_inputs_ready = rnode_300to301_left_lower_0_ph_0_valid_out_NO_SHIFT_REG;
assign local_bb8_left_lower_0_ph_be = (rnode_300to301_left_lower_0_ph_0_NO_SHIFT_REG + 64'h1);
assign local_bb8_left_lower_0_ph_be_valid_out = local_bb8_left_lower_0_ph_be_inputs_ready;
assign local_bb8_left_lower_0_ph_be_stall_local = local_bb8_left_lower_0_ph_be_stall_in;
assign rnode_300to301_left_lower_0_ph_0_stall_in_NO_SHIFT_REG = (|local_bb8_left_lower_0_ph_be_stall_local);

// Register node:
//  * latency = 139
//  * capacity = 139
 logic rnode_161to300_cmp_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_cmp_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_161to300_cmp_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to300_cmp_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to300_cmp_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_161to300_cmp_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_161to300_cmp_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(rnode_160to161_cmp_2_NO_SHIFT_REG),
	.data_out(rnode_161to300_cmp_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_161to300_cmp_0_reg_300_fifo.DEPTH = 140;
defparam rnode_161to300_cmp_0_reg_300_fifo.DATA_WIDTH = 1;
defparam rnode_161to300_cmp_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to300_cmp_0_reg_300_fifo.IMPL = "ram";

assign rnode_161to300_cmp_0_reg_300_inputs_ready_NO_SHIFT_REG = rnode_160to161_cmp_0_valid_out_2_NO_SHIFT_REG;
assign rnode_160to161_cmp_0_stall_in_2_NO_SHIFT_REG = rnode_161to300_cmp_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_161to300_cmp_0_NO_SHIFT_REG = rnode_161to300_cmp_0_reg_300_NO_SHIFT_REG;
assign rnode_161to300_cmp_0_stall_in_reg_300_NO_SHIFT_REG = rnode_161to300_cmp_0_stall_in_NO_SHIFT_REG;
assign rnode_161to300_cmp_0_valid_out_NO_SHIFT_REG = rnode_161to300_cmp_0_valid_out_reg_300_NO_SHIFT_REG;

// Register node:
//  * latency = 159
//  * capacity = 159
 logic rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_NO_SHIFT_REG;
 logic rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_NO_SHIFT_REG;
 logic rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_bb8_while_cond_outer5_branch_to_dummy),
	.data_out(rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_NO_SHIFT_REG)
);

defparam rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_fifo.DEPTH = 160;
defparam rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_fifo.IMPL = "ram";

assign rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_inputs_ready_NO_SHIFT_REG = local_bb8_while_cond_outer5_branch_to_dummy_valid_out_1;
assign local_bb8_while_cond_outer5_branch_to_dummy_stall_in_1 = rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_NO_SHIFT_REG = rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_reg_160_NO_SHIFT_REG;
assign rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_reg_160_NO_SHIFT_REG = rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_NO_SHIFT_REG;
assign rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_NO_SHIFT_REG = rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_reg_160_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_1to1_bb8_cmp_phi_decision117_xor_or_valid_out;
wire rstag_1to1_bb8_cmp_phi_decision117_xor_or_stall_in;
wire rstag_1to1_bb8_cmp_phi_decision117_xor_or_inputs_ready;
wire rstag_1to1_bb8_cmp_phi_decision117_xor_or_stall_local;
 reg rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_valid_NO_SHIFT_REG;
wire rstag_1to1_bb8_cmp_phi_decision117_xor_or_combined_valid;
 reg rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_reg_NO_SHIFT_REG;
wire rstag_1to1_bb8_cmp_phi_decision117_xor_or;

assign rstag_1to1_bb8_cmp_phi_decision117_xor_or_inputs_ready = local_bb8_cmp_phi_decision117_xor_or_valid_out;
assign rstag_1to1_bb8_cmp_phi_decision117_xor_or = (rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_valid_NO_SHIFT_REG ? rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_reg_NO_SHIFT_REG : local_bb8_cmp_phi_decision117_xor_or);
assign rstag_1to1_bb8_cmp_phi_decision117_xor_or_combined_valid = (rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_valid_NO_SHIFT_REG | rstag_1to1_bb8_cmp_phi_decision117_xor_or_inputs_ready);
assign rstag_1to1_bb8_cmp_phi_decision117_xor_or_valid_out = rstag_1to1_bb8_cmp_phi_decision117_xor_or_combined_valid;
assign rstag_1to1_bb8_cmp_phi_decision117_xor_or_stall_local = rstag_1to1_bb8_cmp_phi_decision117_xor_or_stall_in;
assign local_bb8_cmp_phi_decision117_xor_or_stall_in = (|rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_1to1_bb8_cmp_phi_decision117_xor_or_stall_local)
		begin
			if (~(rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_valid_NO_SHIFT_REG))
			begin
				rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_valid_NO_SHIFT_REG <= rstag_1to1_bb8_cmp_phi_decision117_xor_or_inputs_ready;
			end
		end
		else
		begin
			rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_valid_NO_SHIFT_REG))
		begin
			rstag_1to1_bb8_cmp_phi_decision117_xor_or_staging_reg_NO_SHIFT_REG <= local_bb8_cmp_phi_decision117_xor_or;
		end
	end
end


// Register node:
//  * latency = 158
//  * capacity = 158
 logic rnode_2to160_bb8_var__0_valid_out_NO_SHIFT_REG;
 logic rnode_2to160_bb8_var__0_stall_in_NO_SHIFT_REG;
 logic rnode_2to160_bb8_var__0_NO_SHIFT_REG;
 logic rnode_2to160_bb8_var__0_reg_160_inputs_ready_NO_SHIFT_REG;
 logic rnode_2to160_bb8_var__0_reg_160_NO_SHIFT_REG;
 logic rnode_2to160_bb8_var__0_valid_out_reg_160_NO_SHIFT_REG;
 logic rnode_2to160_bb8_var__0_stall_in_reg_160_NO_SHIFT_REG;
 logic rnode_2to160_bb8_var__0_stall_out_reg_160_NO_SHIFT_REG;

acl_data_fifo rnode_2to160_bb8_var__0_reg_160_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_2to160_bb8_var__0_reg_160_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_2to160_bb8_var__0_stall_in_reg_160_NO_SHIFT_REG),
	.valid_out(rnode_2to160_bb8_var__0_valid_out_reg_160_NO_SHIFT_REG),
	.stall_out(rnode_2to160_bb8_var__0_stall_out_reg_160_NO_SHIFT_REG),
	.data_in(local_bb8_var_),
	.data_out(rnode_2to160_bb8_var__0_reg_160_NO_SHIFT_REG)
);

defparam rnode_2to160_bb8_var__0_reg_160_fifo.DEPTH = 159;
defparam rnode_2to160_bb8_var__0_reg_160_fifo.DATA_WIDTH = 1;
defparam rnode_2to160_bb8_var__0_reg_160_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_2to160_bb8_var__0_reg_160_fifo.IMPL = "ram";

assign rnode_2to160_bb8_var__0_reg_160_inputs_ready_NO_SHIFT_REG = local_bb8_var__valid_out;
assign local_bb8_var__stall_in = rnode_2to160_bb8_var__0_stall_out_reg_160_NO_SHIFT_REG;
assign rnode_2to160_bb8_var__0_NO_SHIFT_REG = rnode_2to160_bb8_var__0_reg_160_NO_SHIFT_REG;
assign rnode_2to160_bb8_var__0_stall_in_reg_160_NO_SHIFT_REG = rnode_2to160_bb8_var__0_stall_in_NO_SHIFT_REG;
assign rnode_2to160_bb8_var__0_valid_out_NO_SHIFT_REG = rnode_2to160_bb8_var__0_valid_out_reg_160_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_cmp_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_stall_in_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_cmp_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_cmp_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_cmp_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_cmp_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_cmp_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_cmp_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_161to300_cmp_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_cmp_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_cmp_0_reg_301_fifo.DATA_WIDTH = 1;
defparam rnode_300to301_cmp_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_cmp_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_cmp_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_161to300_cmp_0_valid_out_NO_SHIFT_REG;
assign rnode_161to300_cmp_0_stall_in_NO_SHIFT_REG = rnode_300to301_cmp_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_cmp_0_NO_SHIFT_REG = rnode_300to301_cmp_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_cmp_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_cmp_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_cmp_0_valid_out_NO_SHIFT_REG = rnode_300to301_cmp_0_valid_out_reg_301_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_NO_SHIFT_REG;
 logic rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_NO_SHIFT_REG;
 logic rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_NO_SHIFT_REG;
 logic rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_stall_out_reg_161_NO_SHIFT_REG;

acl_data_fifo rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_NO_SHIFT_REG),
	.data_out(rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_NO_SHIFT_REG;
assign rnode_1to160_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_NO_SHIFT_REG = rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_NO_SHIFT_REG = rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_reg_161_NO_SHIFT_REG;
assign rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_reg_161_NO_SHIFT_REG = rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_NO_SHIFT_REG;
assign rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_NO_SHIFT_REG = rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_reg_161_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb8_ld__inputs_ready;
 reg local_bb8_ld__valid_out_NO_SHIFT_REG;
wire local_bb8_ld__stall_in;
wire local_bb8_ld__output_regs_ready;
wire local_bb8_ld__fu_stall_out;
wire local_bb8_ld__fu_valid_out;
wire [31:0] local_bb8_ld__lsu_dataout;
 reg [31:0] local_bb8_ld__NO_SHIFT_REG;
wire local_bb8_ld__causedstall;

lsu_top lsu_local_bb8_ld_ (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb8_ld__fu_stall_out),
	.i_valid(local_bb8_ld__inputs_ready),
	.i_address(local_lvm_arrayidx24_NO_SHIFT_REG),
	.i_writedata(),
	.i_cmpdata(),
	.i_predicate(rstag_1to1_bb8_cmp_phi_decision117_xor_or),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb8_ld__output_regs_ready)),
	.o_valid(local_bb8_ld__fu_valid_out),
	.o_readdata(local_bb8_ld__lsu_dataout),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb8_ld__active),
	.avm_address(avm_local_bb8_ld__address),
	.avm_read(avm_local_bb8_ld__read),
	.avm_readdata(avm_local_bb8_ld__readdata),
	.avm_write(avm_local_bb8_ld__write),
	.avm_writeack(avm_local_bb8_ld__writeack),
	.avm_burstcount(avm_local_bb8_ld__burstcount),
	.avm_writedata(avm_local_bb8_ld__writedata),
	.avm_byteenable(avm_local_bb8_ld__byteenable),
	.avm_waitrequest(avm_local_bb8_ld__waitrequest),
	.avm_readdatavalid(avm_local_bb8_ld__readdatavalid),
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

defparam lsu_local_bb8_ld_.AWIDTH = 30;
defparam lsu_local_bb8_ld_.WIDTH_BYTES = 4;
defparam lsu_local_bb8_ld_.MWIDTH_BYTES = 32;
defparam lsu_local_bb8_ld_.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb8_ld_.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb8_ld_.READ = 1;
defparam lsu_local_bb8_ld_.ATOMIC = 0;
defparam lsu_local_bb8_ld_.WIDTH = 32;
defparam lsu_local_bb8_ld_.MWIDTH = 256;
defparam lsu_local_bb8_ld_.ATOMIC_WIDTH = 3;
defparam lsu_local_bb8_ld_.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb8_ld_.KERNEL_SIDE_MEM_LATENCY = 160;
defparam lsu_local_bb8_ld_.MEMORY_SIDE_MEM_LATENCY = 58;
defparam lsu_local_bb8_ld_.USE_WRITE_ACK = 0;
defparam lsu_local_bb8_ld_.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb8_ld_.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb8_ld_.NUMBER_BANKS = 1;
defparam lsu_local_bb8_ld_.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb8_ld_.USEINPUTFIFO = 0;
defparam lsu_local_bb8_ld_.USECACHING = 1;
defparam lsu_local_bb8_ld_.CACHESIZE = 256;
defparam lsu_local_bb8_ld_.USEOUTPUTFIFO = 1;
defparam lsu_local_bb8_ld_.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb8_ld_.HIGH_FMAX = 1;
defparam lsu_local_bb8_ld_.ADDRSPACE = 1;
defparam lsu_local_bb8_ld_.STYLE = "BURST-COALESCED";

assign local_bb8_ld__inputs_ready = (merge_node_valid_out_2_NO_SHIFT_REG & rstag_1to1_bb8_cmp_phi_decision117_xor_or_valid_out);
assign local_bb8_ld__output_regs_ready = (&(~(local_bb8_ld__valid_out_NO_SHIFT_REG) | ~(local_bb8_ld__stall_in)));
assign merge_node_stall_in_2 = (local_bb8_ld__fu_stall_out | ~(local_bb8_ld__inputs_ready));
assign rstag_1to1_bb8_cmp_phi_decision117_xor_or_stall_in = (local_bb8_ld__fu_stall_out | ~(local_bb8_ld__inputs_ready));
assign local_bb8_ld__causedstall = (local_bb8_ld__inputs_ready && (local_bb8_ld__fu_stall_out && !(~(local_bb8_ld__output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb8_ld__NO_SHIFT_REG <= 'x;
		local_bb8_ld__valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb8_ld__output_regs_ready)
		begin
			local_bb8_ld__NO_SHIFT_REG <= local_bb8_ld__lsu_dataout;
			local_bb8_ld__valid_out_NO_SHIFT_REG <= local_bb8_ld__fu_valid_out;
		end
		else
		begin
			if (~(local_bb8_ld__stall_in))
			begin
				local_bb8_ld__valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_160to161_bb8_var__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_stall_in_0_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_stall_in_1_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__1_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_reg_161_inputs_ready_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_valid_out_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_stall_in_0_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_stall_out_reg_161_NO_SHIFT_REG;
 logic rnode_160to161_bb8_var__0_reg_161_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_160to161_bb8_var__0_reg_161_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_160to161_bb8_var__0_reg_161_NO_SHIFT_REG),
	.valid_in(rnode_160to161_bb8_var__0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_bb8_var__0_stall_in_0_reg_161_NO_SHIFT_REG),
	.data_out(rnode_160to161_bb8_var__0_reg_161_NO_SHIFT_REG_fa),
	.valid_out({rnode_160to161_bb8_var__0_valid_out_0_NO_SHIFT_REG, rnode_160to161_bb8_var__0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_160to161_bb8_var__0_stall_in_0_NO_SHIFT_REG, rnode_160to161_bb8_var__0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_160to161_bb8_var__0_reg_161_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_160to161_bb8_var__0_reg_161_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_160to161_bb8_var__0_reg_161_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_160to161_bb8_var__0_reg_161_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_160to161_bb8_var__0_stall_in_0_reg_161_NO_SHIFT_REG),
	.valid_out(rnode_160to161_bb8_var__0_valid_out_0_reg_161_NO_SHIFT_REG),
	.stall_out(rnode_160to161_bb8_var__0_stall_out_reg_161_NO_SHIFT_REG),
	.data_in(rnode_2to160_bb8_var__0_NO_SHIFT_REG),
	.data_out(rnode_160to161_bb8_var__0_reg_161_NO_SHIFT_REG)
);

defparam rnode_160to161_bb8_var__0_reg_161_fifo.DEPTH = 2;
defparam rnode_160to161_bb8_var__0_reg_161_fifo.DATA_WIDTH = 1;
defparam rnode_160to161_bb8_var__0_reg_161_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_160to161_bb8_var__0_reg_161_fifo.IMPL = "ll_reg";

assign rnode_160to161_bb8_var__0_reg_161_inputs_ready_NO_SHIFT_REG = rnode_2to160_bb8_var__0_valid_out_NO_SHIFT_REG;
assign rnode_2to160_bb8_var__0_stall_in_NO_SHIFT_REG = rnode_160to161_bb8_var__0_stall_out_reg_161_NO_SHIFT_REG;
assign rnode_160to161_bb8_var__0_NO_SHIFT_REG = rnode_160to161_bb8_var__0_reg_161_NO_SHIFT_REG_fa;
assign rnode_160to161_bb8_var__1_NO_SHIFT_REG = rnode_160to161_bb8_var__0_reg_161_NO_SHIFT_REG_fa;

// This section implements a staging register.
// 
wire rstag_161to161_bb8_ld__valid_out;
wire rstag_161to161_bb8_ld__stall_in;
wire rstag_161to161_bb8_ld__inputs_ready;
wire rstag_161to161_bb8_ld__stall_local;
 reg rstag_161to161_bb8_ld__staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb8_ld__combined_valid;
 reg [31:0] rstag_161to161_bb8_ld__staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_161to161_bb8_ld_;

assign rstag_161to161_bb8_ld__inputs_ready = local_bb8_ld__valid_out_NO_SHIFT_REG;
assign rstag_161to161_bb8_ld_ = (rstag_161to161_bb8_ld__staging_valid_NO_SHIFT_REG ? rstag_161to161_bb8_ld__staging_reg_NO_SHIFT_REG : local_bb8_ld__NO_SHIFT_REG);
assign rstag_161to161_bb8_ld__combined_valid = (rstag_161to161_bb8_ld__staging_valid_NO_SHIFT_REG | rstag_161to161_bb8_ld__inputs_ready);
assign rstag_161to161_bb8_ld__valid_out = rstag_161to161_bb8_ld__combined_valid;
assign rstag_161to161_bb8_ld__stall_local = rstag_161to161_bb8_ld__stall_in;
assign local_bb8_ld__stall_in = (|rstag_161to161_bb8_ld__staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb8_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb8_ld__staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb8_ld__stall_local)
		begin
			if (~(rstag_161to161_bb8_ld__staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb8_ld__staging_valid_NO_SHIFT_REG <= rstag_161to161_bb8_ld__inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb8_ld__staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb8_ld__staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb8_ld__staging_reg_NO_SHIFT_REG <= local_bb8_ld__NO_SHIFT_REG;
		end
	end
end


// This section implements an unregistered operation.
// 
wire local_bb8_cmp_phi_decision117_xor118_or_demorgan_stall_local;
wire local_bb8_cmp_phi_decision117_xor118_or_demorgan;

assign local_bb8_cmp_phi_decision117_xor118_or_demorgan = (rnode_160to161_bb8_var__0_NO_SHIFT_REG & rnode_160to161_cmp_0_NO_SHIFT_REG);

// This section implements an unregistered operation.
// 
wire local_bb8_var__u18_valid_out;
wire local_bb8_var__u18_stall_in;
wire local_bb8_var__u18_inputs_ready;
wire local_bb8_var__u18_stall_local;
wire local_bb8_var__u18;

assign local_bb8_var__u18_inputs_ready = (rnode_160to161_cmp_0_valid_out_1_NO_SHIFT_REG & rnode_160to161_bb8_var__0_valid_out_1_NO_SHIFT_REG);
assign local_bb8_var__u18 = (rnode_160to161_cmp_1_NO_SHIFT_REG & rnode_160to161_bb8_var__1_NO_SHIFT_REG);
assign local_bb8_var__u18_valid_out = local_bb8_var__u18_inputs_ready;
assign local_bb8_var__u18_stall_local = local_bb8_var__u18_stall_in;
assign rnode_160to161_cmp_0_stall_in_1_NO_SHIFT_REG = (local_bb8_var__u18_stall_local | ~(local_bb8_var__u18_inputs_ready));
assign rnode_160to161_bb8_var__0_stall_in_1_NO_SHIFT_REG = (local_bb8_var__u18_stall_local | ~(local_bb8_var__u18_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb8__52_valid_out;
wire local_bb8__52_stall_in;
wire local_bb8__52_inputs_ready;
wire local_bb8__52_stall_local;
wire [31:0] local_bb8__52;

assign local_bb8__52_inputs_ready = (rnode_160to161_ld__0_valid_out_NO_SHIFT_REG & rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_valid_out_NO_SHIFT_REG & rstag_161to161_bb8_ld__valid_out);
assign local_bb8__52 = (rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_NO_SHIFT_REG ? rstag_161to161_bb8_ld_ : rnode_160to161_ld__0_NO_SHIFT_REG);
assign local_bb8__52_valid_out = local_bb8__52_inputs_ready;
assign local_bb8__52_stall_local = local_bb8__52_stall_in;
assign rnode_160to161_ld__0_stall_in_NO_SHIFT_REG = (local_bb8__52_stall_local | ~(local_bb8__52_inputs_ready));
assign rnode_160to161_bb8_while_cond_outer5_branch_to_dummy_0_stall_in_NO_SHIFT_REG = (local_bb8__52_stall_local | ~(local_bb8__52_inputs_ready));
assign rstag_161to161_bb8_ld__stall_in = (local_bb8__52_stall_local | ~(local_bb8__52_inputs_ready));

// This section implements an unregistered operation.
// 
wire local_bb8_cmp_phi_decision117_xor118_or_valid_out;
wire local_bb8_cmp_phi_decision117_xor118_or_stall_in;
wire local_bb8_cmp_phi_decision117_xor118_or_inputs_ready;
wire local_bb8_cmp_phi_decision117_xor118_or_stall_local;
wire local_bb8_cmp_phi_decision117_xor118_or;

assign local_bb8_cmp_phi_decision117_xor118_or_inputs_ready = (rnode_160to161_cmp_0_valid_out_0_NO_SHIFT_REG & rnode_160to161_bb8_var__0_valid_out_0_NO_SHIFT_REG);
assign local_bb8_cmp_phi_decision117_xor118_or = (local_bb8_cmp_phi_decision117_xor118_or_demorgan ^ 1'b1);
assign local_bb8_cmp_phi_decision117_xor118_or_valid_out = local_bb8_cmp_phi_decision117_xor118_or_inputs_ready;
assign local_bb8_cmp_phi_decision117_xor118_or_stall_local = local_bb8_cmp_phi_decision117_xor118_or_stall_in;
assign rnode_160to161_cmp_0_stall_in_0_NO_SHIFT_REG = (local_bb8_cmp_phi_decision117_xor118_or_stall_local | ~(local_bb8_cmp_phi_decision117_xor118_or_inputs_ready));
assign rnode_160to161_bb8_var__0_stall_in_0_NO_SHIFT_REG = (local_bb8_cmp_phi_decision117_xor118_or_stall_local | ~(local_bb8_cmp_phi_decision117_xor118_or_inputs_ready));

// Register node:
//  * latency = 139
//  * capacity = 139
 logic rnode_161to300_bb8_var__u18_0_valid_out_NO_SHIFT_REG;
 logic rnode_161to300_bb8_var__u18_0_stall_in_NO_SHIFT_REG;
 logic rnode_161to300_bb8_var__u18_0_NO_SHIFT_REG;
 logic rnode_161to300_bb8_var__u18_0_reg_300_inputs_ready_NO_SHIFT_REG;
 logic rnode_161to300_bb8_var__u18_0_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_bb8_var__u18_0_valid_out_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_bb8_var__u18_0_stall_in_reg_300_NO_SHIFT_REG;
 logic rnode_161to300_bb8_var__u18_0_stall_out_reg_300_NO_SHIFT_REG;

acl_data_fifo rnode_161to300_bb8_var__u18_0_reg_300_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_161to300_bb8_var__u18_0_reg_300_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_161to300_bb8_var__u18_0_stall_in_reg_300_NO_SHIFT_REG),
	.valid_out(rnode_161to300_bb8_var__u18_0_valid_out_reg_300_NO_SHIFT_REG),
	.stall_out(rnode_161to300_bb8_var__u18_0_stall_out_reg_300_NO_SHIFT_REG),
	.data_in(local_bb8_var__u18),
	.data_out(rnode_161to300_bb8_var__u18_0_reg_300_NO_SHIFT_REG)
);

defparam rnode_161to300_bb8_var__u18_0_reg_300_fifo.DEPTH = 140;
defparam rnode_161to300_bb8_var__u18_0_reg_300_fifo.DATA_WIDTH = 1;
defparam rnode_161to300_bb8_var__u18_0_reg_300_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_161to300_bb8_var__u18_0_reg_300_fifo.IMPL = "ram";

assign rnode_161to300_bb8_var__u18_0_reg_300_inputs_ready_NO_SHIFT_REG = local_bb8_var__u18_valid_out;
assign local_bb8_var__u18_stall_in = rnode_161to300_bb8_var__u18_0_stall_out_reg_300_NO_SHIFT_REG;
assign rnode_161to300_bb8_var__u18_0_NO_SHIFT_REG = rnode_161to300_bb8_var__u18_0_reg_300_NO_SHIFT_REG;
assign rnode_161to300_bb8_var__u18_0_stall_in_reg_300_NO_SHIFT_REG = rnode_161to300_bb8_var__u18_0_stall_in_NO_SHIFT_REG;
assign rnode_161to300_bb8_var__u18_0_valid_out_NO_SHIFT_REG = rnode_161to300_bb8_var__u18_0_valid_out_reg_300_NO_SHIFT_REG;

// This section implements a staging register.
// 
wire rstag_161to161_bb8__52_valid_out;
wire rstag_161to161_bb8__52_stall_in;
wire rstag_161to161_bb8__52_inputs_ready;
wire rstag_161to161_bb8__52_stall_local;
 reg rstag_161to161_bb8__52_staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb8__52_combined_valid;
 reg [31:0] rstag_161to161_bb8__52_staging_reg_NO_SHIFT_REG;
wire [31:0] rstag_161to161_bb8__52;

assign rstag_161to161_bb8__52_inputs_ready = local_bb8__52_valid_out;
assign rstag_161to161_bb8__52 = (rstag_161to161_bb8__52_staging_valid_NO_SHIFT_REG ? rstag_161to161_bb8__52_staging_reg_NO_SHIFT_REG : local_bb8__52);
assign rstag_161to161_bb8__52_combined_valid = (rstag_161to161_bb8__52_staging_valid_NO_SHIFT_REG | rstag_161to161_bb8__52_inputs_ready);
assign rstag_161to161_bb8__52_valid_out = rstag_161to161_bb8__52_combined_valid;
assign rstag_161to161_bb8__52_stall_local = rstag_161to161_bb8__52_stall_in;
assign local_bb8__52_stall_in = (|rstag_161to161_bb8__52_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb8__52_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb8__52_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb8__52_stall_local)
		begin
			if (~(rstag_161to161_bb8__52_staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb8__52_staging_valid_NO_SHIFT_REG <= rstag_161to161_bb8__52_inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb8__52_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb8__52_staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb8__52_staging_reg_NO_SHIFT_REG <= local_bb8__52;
		end
	end
end


// This section implements a staging register.
// 
wire rstag_161to161_bb8_cmp_phi_decision117_xor118_or_valid_out;
wire rstag_161to161_bb8_cmp_phi_decision117_xor118_or_stall_in;
wire rstag_161to161_bb8_cmp_phi_decision117_xor118_or_inputs_ready;
wire rstag_161to161_bb8_cmp_phi_decision117_xor118_or_stall_local;
 reg rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_valid_NO_SHIFT_REG;
wire rstag_161to161_bb8_cmp_phi_decision117_xor118_or_combined_valid;
 reg rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_reg_NO_SHIFT_REG;
wire rstag_161to161_bb8_cmp_phi_decision117_xor118_or;

assign rstag_161to161_bb8_cmp_phi_decision117_xor118_or_inputs_ready = local_bb8_cmp_phi_decision117_xor118_or_valid_out;
assign rstag_161to161_bb8_cmp_phi_decision117_xor118_or = (rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_valid_NO_SHIFT_REG ? rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_reg_NO_SHIFT_REG : local_bb8_cmp_phi_decision117_xor118_or);
assign rstag_161to161_bb8_cmp_phi_decision117_xor118_or_combined_valid = (rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_valid_NO_SHIFT_REG | rstag_161to161_bb8_cmp_phi_decision117_xor118_or_inputs_ready);
assign rstag_161to161_bb8_cmp_phi_decision117_xor118_or_valid_out = rstag_161to161_bb8_cmp_phi_decision117_xor118_or_combined_valid;
assign rstag_161to161_bb8_cmp_phi_decision117_xor118_or_stall_local = rstag_161to161_bb8_cmp_phi_decision117_xor118_or_stall_in;
assign local_bb8_cmp_phi_decision117_xor118_or_stall_in = (|rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (rstag_161to161_bb8_cmp_phi_decision117_xor118_or_stall_local)
		begin
			if (~(rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_valid_NO_SHIFT_REG))
			begin
				rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_valid_NO_SHIFT_REG <= rstag_161to161_bb8_cmp_phi_decision117_xor118_or_inputs_ready;
			end
		end
		else
		begin
			rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
		if (~(rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_valid_NO_SHIFT_REG))
		begin
			rstag_161to161_bb8_cmp_phi_decision117_xor118_or_staging_reg_NO_SHIFT_REG <= local_bb8_cmp_phi_decision117_xor118_or;
		end
	end
end


// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_300to301_bb8_var__u18_0_valid_out_NO_SHIFT_REG;
 logic rnode_300to301_bb8_var__u18_0_stall_in_NO_SHIFT_REG;
 logic rnode_300to301_bb8_var__u18_0_NO_SHIFT_REG;
 logic rnode_300to301_bb8_var__u18_0_reg_301_inputs_ready_NO_SHIFT_REG;
 logic rnode_300to301_bb8_var__u18_0_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb8_var__u18_0_valid_out_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb8_var__u18_0_stall_in_reg_301_NO_SHIFT_REG;
 logic rnode_300to301_bb8_var__u18_0_stall_out_reg_301_NO_SHIFT_REG;

acl_data_fifo rnode_300to301_bb8_var__u18_0_reg_301_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_300to301_bb8_var__u18_0_reg_301_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_300to301_bb8_var__u18_0_stall_in_reg_301_NO_SHIFT_REG),
	.valid_out(rnode_300to301_bb8_var__u18_0_valid_out_reg_301_NO_SHIFT_REG),
	.stall_out(rnode_300to301_bb8_var__u18_0_stall_out_reg_301_NO_SHIFT_REG),
	.data_in(rnode_161to300_bb8_var__u18_0_NO_SHIFT_REG),
	.data_out(rnode_300to301_bb8_var__u18_0_reg_301_NO_SHIFT_REG)
);

defparam rnode_300to301_bb8_var__u18_0_reg_301_fifo.DEPTH = 2;
defparam rnode_300to301_bb8_var__u18_0_reg_301_fifo.DATA_WIDTH = 1;
defparam rnode_300to301_bb8_var__u18_0_reg_301_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_300to301_bb8_var__u18_0_reg_301_fifo.IMPL = "ll_reg";

assign rnode_300to301_bb8_var__u18_0_reg_301_inputs_ready_NO_SHIFT_REG = rnode_161to300_bb8_var__u18_0_valid_out_NO_SHIFT_REG;
assign rnode_161to300_bb8_var__u18_0_stall_in_NO_SHIFT_REG = rnode_300to301_bb8_var__u18_0_stall_out_reg_301_NO_SHIFT_REG;
assign rnode_300to301_bb8_var__u18_0_NO_SHIFT_REG = rnode_300to301_bb8_var__u18_0_reg_301_NO_SHIFT_REG;
assign rnode_300to301_bb8_var__u18_0_stall_in_reg_301_NO_SHIFT_REG = rnode_300to301_bb8_var__u18_0_stall_in_NO_SHIFT_REG;
assign rnode_300to301_bb8_var__u18_0_valid_out_NO_SHIFT_REG = rnode_300to301_bb8_var__u18_0_valid_out_reg_301_NO_SHIFT_REG;

// This section implements a registered operation.
// 
wire local_bb8_st__52_inputs_ready;
 reg local_bb8_st__52_valid_out_NO_SHIFT_REG;
wire local_bb8_st__52_stall_in;
wire local_bb8_st__52_output_regs_ready;
wire local_bb8_st__52_fu_stall_out;
wire local_bb8_st__52_fu_valid_out;
wire local_bb8_st__52_causedstall;

lsu_top lsu_local_bb8_st__52 (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn),
	.flush(start),
	.stream_base_addr(),
	.stream_size(),
	.stream_reset(),
	.o_stall(local_bb8_st__52_fu_stall_out),
	.i_valid(local_bb8_st__52_inputs_ready),
	.i_address(rnode_160to161_arrayidx31_0_NO_SHIFT_REG),
	.i_writedata(rstag_161to161_bb8__52),
	.i_cmpdata(),
	.i_predicate(rstag_161to161_bb8_cmp_phi_decision117_xor118_or),
	.i_bitwiseor(64'h0),
	.i_byteenable(),
	.i_stall(~(local_bb8_st__52_output_regs_ready)),
	.o_valid(local_bb8_st__52_fu_valid_out),
	.o_readdata(),
	.o_input_fifo_depth(),
	.o_writeack(),
	.i_atomic_op(3'h0),
	.o_active(local_bb8_st__52_active),
	.avm_address(avm_local_bb8_st__52_address),
	.avm_read(avm_local_bb8_st__52_read),
	.avm_readdata(avm_local_bb8_st__52_readdata),
	.avm_write(avm_local_bb8_st__52_write),
	.avm_writeack(avm_local_bb8_st__52_writeack),
	.avm_burstcount(avm_local_bb8_st__52_burstcount),
	.avm_writedata(avm_local_bb8_st__52_writedata),
	.avm_byteenable(avm_local_bb8_st__52_byteenable),
	.avm_waitrequest(avm_local_bb8_st__52_waitrequest),
	.avm_readdatavalid(avm_local_bb8_st__52_readdatavalid),
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

defparam lsu_local_bb8_st__52.AWIDTH = 30;
defparam lsu_local_bb8_st__52.WIDTH_BYTES = 4;
defparam lsu_local_bb8_st__52.MWIDTH_BYTES = 32;
defparam lsu_local_bb8_st__52.WRITEDATAWIDTH_BYTES = 32;
defparam lsu_local_bb8_st__52.ALIGNMENT_BYTES = 4;
defparam lsu_local_bb8_st__52.READ = 0;
defparam lsu_local_bb8_st__52.ATOMIC = 0;
defparam lsu_local_bb8_st__52.WIDTH = 32;
defparam lsu_local_bb8_st__52.MWIDTH = 256;
defparam lsu_local_bb8_st__52.ATOMIC_WIDTH = 3;
defparam lsu_local_bb8_st__52.BURSTCOUNT_WIDTH = 5;
defparam lsu_local_bb8_st__52.KERNEL_SIDE_MEM_LATENCY = 140;
defparam lsu_local_bb8_st__52.MEMORY_SIDE_MEM_LATENCY = 12;
defparam lsu_local_bb8_st__52.USE_WRITE_ACK = 1;
defparam lsu_local_bb8_st__52.ENABLE_BANKED_MEMORY = 0;
defparam lsu_local_bb8_st__52.ABITS_PER_LMEM_BANK = 0;
defparam lsu_local_bb8_st__52.NUMBER_BANKS = 1;
defparam lsu_local_bb8_st__52.LMEM_ADDR_PERMUTATION_STYLE = 0;
defparam lsu_local_bb8_st__52.USEINPUTFIFO = 0;
defparam lsu_local_bb8_st__52.USECACHING = 0;
defparam lsu_local_bb8_st__52.USEOUTPUTFIFO = 1;
defparam lsu_local_bb8_st__52.FORCE_NOP_SUPPORT = 0;
defparam lsu_local_bb8_st__52.HIGH_FMAX = 1;
defparam lsu_local_bb8_st__52.ADDRSPACE = 1;
defparam lsu_local_bb8_st__52.STYLE = "BURST-COALESCED";
defparam lsu_local_bb8_st__52.USE_BYTE_EN = 0;

assign local_bb8_st__52_inputs_ready = (rnode_160to161_arrayidx31_0_valid_out_NO_SHIFT_REG & rstag_161to161_bb8_cmp_phi_decision117_xor118_or_valid_out & rstag_161to161_bb8__52_valid_out);
assign local_bb8_st__52_output_regs_ready = (&(~(local_bb8_st__52_valid_out_NO_SHIFT_REG) | ~(local_bb8_st__52_stall_in)));
assign rnode_160to161_arrayidx31_0_stall_in_NO_SHIFT_REG = (local_bb8_st__52_fu_stall_out | ~(local_bb8_st__52_inputs_ready));
assign rstag_161to161_bb8_cmp_phi_decision117_xor118_or_stall_in = (local_bb8_st__52_fu_stall_out | ~(local_bb8_st__52_inputs_ready));
assign rstag_161to161_bb8__52_stall_in = (local_bb8_st__52_fu_stall_out | ~(local_bb8_st__52_inputs_ready));
assign local_bb8_st__52_causedstall = (local_bb8_st__52_inputs_ready && (local_bb8_st__52_fu_stall_out && !(~(local_bb8_st__52_output_regs_ready))));

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		local_bb8_st__52_valid_out_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (local_bb8_st__52_output_regs_ready)
		begin
			local_bb8_st__52_valid_out_NO_SHIFT_REG <= local_bb8_st__52_fu_valid_out;
		end
		else
		begin
			if (~(local_bb8_st__52_stall_in))
			begin
				local_bb8_st__52_valid_out_NO_SHIFT_REG <= 1'b0;
			end
		end
	end
end


// This section implements a staging register.
// 
wire rstag_301to301_bb8_st__52_valid_out;
wire rstag_301to301_bb8_st__52_stall_in;
wire rstag_301to301_bb8_st__52_inputs_ready;
wire rstag_301to301_bb8_st__52_stall_local;
 reg rstag_301to301_bb8_st__52_staging_valid_NO_SHIFT_REG;
wire rstag_301to301_bb8_st__52_combined_valid;

assign rstag_301to301_bb8_st__52_inputs_ready = local_bb8_st__52_valid_out_NO_SHIFT_REG;
assign rstag_301to301_bb8_st__52_combined_valid = (rstag_301to301_bb8_st__52_staging_valid_NO_SHIFT_REG | rstag_301to301_bb8_st__52_inputs_ready);
assign rstag_301to301_bb8_st__52_valid_out = rstag_301to301_bb8_st__52_combined_valid;
assign rstag_301to301_bb8_st__52_stall_local = rstag_301to301_bb8_st__52_stall_in;
assign local_bb8_st__52_stall_in = (|rstag_301to301_bb8_st__52_staging_valid_NO_SHIFT_REG);

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		rstag_301to301_bb8_st__52_staging_valid_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (rstag_301to301_bb8_st__52_stall_local)
		begin
			if (~(rstag_301to301_bb8_st__52_staging_valid_NO_SHIFT_REG))
			begin
				rstag_301to301_bb8_st__52_staging_valid_NO_SHIFT_REG <= rstag_301to301_bb8_st__52_inputs_ready;
			end
		end
		else
		begin
			rstag_301to301_bb8_st__52_staging_valid_NO_SHIFT_REG <= 1'b0;
		end
	end
end


// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_0_NO_SHIFT_REG;
 reg branch_compare_result_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [63:0] lvb_mul_0_reg_NO_SHIFT_REG;
 reg lvb_cmp_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_sub_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_div_0_reg_NO_SHIFT_REG;
 reg lvb_var__0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG;
 reg [63:0] lvb_bb8_left_lower_0_ph_be_0_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb8_left_lower_0_ph_be_valid_out & rnode_300to301_mul_0_valid_out_NO_SHIFT_REG & rnode_300to301_sub_0_valid_out_NO_SHIFT_REG & rnode_300to301_div_0_valid_out_NO_SHIFT_REG & rnode_300to301_var__0_valid_out_NO_SHIFT_REG & rnode_300to301_right_lower_0_ph6_0_valid_out_NO_SHIFT_REG & rnode_300to301_temp_index_0_ph7_be_0_valid_out_NO_SHIFT_REG & rnode_300to301_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG & rnode_300to301_cmp_0_valid_out_NO_SHIFT_REG & rnode_300to301_bb8_var__u18_0_valid_out_NO_SHIFT_REG & rstag_301to301_bb8_st__52_valid_out);
assign branch_var__output_regs_ready = (~(branch_node_valid_out_0_NO_SHIFT_REG) | (((branch_compare_result_NO_SHIFT_REG != 1'b1) & ~(stall_in_1)) | (~((branch_compare_result_NO_SHIFT_REG != 1'b1)) & ~(stall_in_0))));
assign local_bb8_left_lower_0_ph_be_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_mul_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_sub_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_div_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_var__0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_right_lower_0_ph6_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_temp_index_0_ph7_be_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_cmp_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_300to301_bb8_var__u18_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rstag_301to301_bb8_st__52_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_mul_0 = lvb_mul_0_reg_NO_SHIFT_REG;
assign lvb_mul_1 = lvb_mul_0_reg_NO_SHIFT_REG;
assign lvb_cmp_0 = lvb_cmp_0_reg_NO_SHIFT_REG;
assign lvb_cmp_1 = lvb_cmp_0_reg_NO_SHIFT_REG;
assign lvb_sub_0 = lvb_sub_0_reg_NO_SHIFT_REG;
assign lvb_sub_1 = lvb_sub_0_reg_NO_SHIFT_REG;
assign lvb_div_0 = lvb_div_0_reg_NO_SHIFT_REG;
assign lvb_div_1 = lvb_div_0_reg_NO_SHIFT_REG;
assign lvb_var__0 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_var__1 = lvb_var__0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph6_0 = lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG;
assign lvb_right_lower_0_ph6_1 = lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph7_be_0 = lvb_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG;
assign lvb_temp_index_0_ph7_be_1 = lvb_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG;
assign lvb_bb8_left_lower_0_ph_be_0 = lvb_bb8_left_lower_0_ph_be_0_reg_NO_SHIFT_REG;
assign lvb_bb8_left_lower_0_ph_be_1 = lvb_bb8_left_lower_0_ph_be_0_reg_NO_SHIFT_REG;
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
		lvb_mul_0_reg_NO_SHIFT_REG <= 'x;
		lvb_cmp_0_reg_NO_SHIFT_REG <= 'x;
		lvb_sub_0_reg_NO_SHIFT_REG <= 'x;
		lvb_div_0_reg_NO_SHIFT_REG <= 'x;
		lvb_var__0_reg_NO_SHIFT_REG <= 'x;
		lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG <= 'x;
		lvb_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG <= 'x;
		lvb_bb8_left_lower_0_ph_be_0_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= 'x;
		branch_compare_result_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_0_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_mul_0_reg_NO_SHIFT_REG <= rnode_300to301_mul_0_NO_SHIFT_REG;
			lvb_cmp_0_reg_NO_SHIFT_REG <= rnode_300to301_cmp_0_NO_SHIFT_REG;
			lvb_sub_0_reg_NO_SHIFT_REG <= rnode_300to301_sub_0_NO_SHIFT_REG;
			lvb_div_0_reg_NO_SHIFT_REG <= rnode_300to301_div_0_NO_SHIFT_REG;
			lvb_var__0_reg_NO_SHIFT_REG <= rnode_300to301_var__0_NO_SHIFT_REG;
			lvb_right_lower_0_ph6_0_reg_NO_SHIFT_REG <= rnode_300to301_right_lower_0_ph6_0_NO_SHIFT_REG;
			lvb_temp_index_0_ph7_be_0_reg_NO_SHIFT_REG <= rnode_300to301_temp_index_0_ph7_be_0_NO_SHIFT_REG;
			lvb_bb8_left_lower_0_ph_be_0_reg_NO_SHIFT_REG <= local_bb8_left_lower_0_ph_be;
			lvb_input_acl_hw_wg_id_0_reg_NO_SHIFT_REG <= rnode_300to301_input_acl_hw_wg_id_0_NO_SHIFT_REG;
			branch_compare_result_NO_SHIFT_REG <= rnode_300to301_bb8_var__u18_0_NO_SHIFT_REG;
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
		input [63:0] 		input_mul,
		input [63:0] 		input_sub,
		input 		input_var_,
		input [31:0] 		input_acl_hw_wg_id,
		output 		valid_out,
		input 		stall_in,
		output [63:0] 		lvb_mul,
		output [63:0] 		lvb_sub,
		output 		lvb_var_,
		output 		lvb_bb9_cmp493,
		output 		lvb_bb9_cmp_phi_decision120_xor_or,
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
 reg [63:0] input_mul_staging_reg_NO_SHIFT_REG;
 reg [63:0] input_sub_staging_reg_NO_SHIFT_REG;
 reg input_var__staging_reg_NO_SHIFT_REG;
 reg [31:0] input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
 reg [63:0] local_lvm_mul_NO_SHIFT_REG;
 reg [63:0] local_lvm_sub_NO_SHIFT_REG;
 reg local_lvm_var__NO_SHIFT_REG;
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
		input_mul_staging_reg_NO_SHIFT_REG <= 'x;
		input_sub_staging_reg_NO_SHIFT_REG <= 'x;
		input_var__staging_reg_NO_SHIFT_REG <= 'x;
		input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG <= 'x;
		merge_node_valid_in_staging_reg_NO_SHIFT_REG <= 1'b0;
	end
	else
	begin
		if (((merge_block_selector_NO_SHIFT_REG != 1'b0) | merge_stalled_by_successors))
		begin
			if (~(merge_node_valid_in_staging_reg_NO_SHIFT_REG))
			begin
				input_mul_staging_reg_NO_SHIFT_REG <= input_mul;
				input_sub_staging_reg_NO_SHIFT_REG <= input_sub;
				input_var__staging_reg_NO_SHIFT_REG <= input_var_;
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
					local_lvm_mul_NO_SHIFT_REG <= input_mul_staging_reg_NO_SHIFT_REG;
					local_lvm_sub_NO_SHIFT_REG <= input_sub_staging_reg_NO_SHIFT_REG;
					local_lvm_var__NO_SHIFT_REG <= input_var__staging_reg_NO_SHIFT_REG;
					local_lvm_input_acl_hw_wg_id_NO_SHIFT_REG <= input_acl_hw_wg_id_staging_reg_NO_SHIFT_REG;
				end
				else
				begin
					local_lvm_mul_NO_SHIFT_REG <= input_mul;
					local_lvm_sub_NO_SHIFT_REG <= input_sub;
					local_lvm_var__NO_SHIFT_REG <= input_var_;
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
wire local_bb9_cmp493_valid_out;
wire local_bb9_cmp493_stall_in;
wire local_bb9_cmp493_inputs_ready;
wire local_bb9_cmp493_stall_local;
wire local_bb9_cmp493;

assign local_bb9_cmp493_inputs_ready = merge_node_valid_out_0_NO_SHIFT_REG;
assign local_bb9_cmp493 = (local_lvm_mul_NO_SHIFT_REG > local_lvm_sub_NO_SHIFT_REG);
assign local_bb9_cmp493_valid_out = local_bb9_cmp493_inputs_ready;
assign local_bb9_cmp493_stall_local = local_bb9_cmp493_stall_in;
assign merge_node_stall_in_0 = (|local_bb9_cmp493_stall_local);

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_var__0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_var__0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_var__0_NO_SHIFT_REG;
 logic rnode_1to2_var__0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_var__0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_var__1_NO_SHIFT_REG;
 logic rnode_1to2_var__0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_var__0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_var__0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_var__0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_var__0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_var__0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_var__0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_var__0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_var__0_valid_out_0_NO_SHIFT_REG, rnode_1to2_var__0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_var__0_stall_in_0_NO_SHIFT_REG, rnode_1to2_var__0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_var__0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_var__0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_var__0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_var__0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_var__0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_var__0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_var__0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_var__NO_SHIFT_REG),
	.data_out(rnode_1to2_var__0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_var__0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_var__0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_var__0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_var__0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_var__0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_1_NO_SHIFT_REG;
assign merge_node_stall_in_1 = rnode_1to2_var__0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_var__0_NO_SHIFT_REG = rnode_1to2_var__0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_var__1_NO_SHIFT_REG = rnode_1to2_var__0_reg_2_NO_SHIFT_REG_fa;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_mul_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_mul_0_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_mul_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_mul_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_mul_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_mul_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_mul_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_mul_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_mul_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_mul_NO_SHIFT_REG),
	.data_out(rnode_1to2_mul_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_mul_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_mul_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_mul_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_mul_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_mul_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_2_NO_SHIFT_REG;
assign merge_node_stall_in_2 = rnode_1to2_mul_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_mul_0_NO_SHIFT_REG = rnode_1to2_mul_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_mul_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_mul_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_mul_0_valid_out_NO_SHIFT_REG = rnode_1to2_mul_0_valid_out_reg_2_NO_SHIFT_REG;

// Register node:
//  * latency = 1
//  * capacity = 1
 logic rnode_1to2_sub_0_valid_out_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_stall_in_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_sub_0_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic [63:0] rnode_1to2_sub_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_valid_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_stall_in_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_sub_0_stall_out_reg_2_NO_SHIFT_REG;

acl_data_fifo rnode_1to2_sub_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_sub_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_sub_0_stall_in_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_sub_0_valid_out_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_sub_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_lvm_sub_NO_SHIFT_REG),
	.data_out(rnode_1to2_sub_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_sub_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_sub_0_reg_2_fifo.DATA_WIDTH = 64;
defparam rnode_1to2_sub_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_sub_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_sub_0_reg_2_inputs_ready_NO_SHIFT_REG = merge_node_valid_out_3_NO_SHIFT_REG;
assign merge_node_stall_in_3 = rnode_1to2_sub_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_sub_0_NO_SHIFT_REG = rnode_1to2_sub_0_reg_2_NO_SHIFT_REG;
assign rnode_1to2_sub_0_stall_in_reg_2_NO_SHIFT_REG = rnode_1to2_sub_0_stall_in_NO_SHIFT_REG;
assign rnode_1to2_sub_0_valid_out_NO_SHIFT_REG = rnode_1to2_sub_0_valid_out_reg_2_NO_SHIFT_REG;

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
 logic rnode_1to2_bb9_cmp493_0_valid_out_0_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_stall_in_0_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_valid_out_1_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_stall_in_1_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_1_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_reg_2_inputs_ready_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_valid_out_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_stall_in_0_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_stall_out_reg_2_NO_SHIFT_REG;
 logic rnode_1to2_bb9_cmp493_0_reg_2_NO_SHIFT_REG_fa;

acl_multi_fanout_adaptor rnode_1to2_bb9_cmp493_0_reg_2_fanout_adaptor (
	.clock(clock),
	.resetn(resetn),
	.data_in(rnode_1to2_bb9_cmp493_0_reg_2_NO_SHIFT_REG),
	.valid_in(rnode_1to2_bb9_cmp493_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb9_cmp493_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.data_out(rnode_1to2_bb9_cmp493_0_reg_2_NO_SHIFT_REG_fa),
	.valid_out({rnode_1to2_bb9_cmp493_0_valid_out_0_NO_SHIFT_REG, rnode_1to2_bb9_cmp493_0_valid_out_1_NO_SHIFT_REG}),
	.stall_in({rnode_1to2_bb9_cmp493_0_stall_in_0_NO_SHIFT_REG, rnode_1to2_bb9_cmp493_0_stall_in_1_NO_SHIFT_REG})
);

defparam rnode_1to2_bb9_cmp493_0_reg_2_fanout_adaptor.DATA_WIDTH = 1;
defparam rnode_1to2_bb9_cmp493_0_reg_2_fanout_adaptor.NUM_FANOUTS = 2;

acl_data_fifo rnode_1to2_bb9_cmp493_0_reg_2_fifo (
	.clock(clock),
	.resetn(resetn),
	.valid_in(rnode_1to2_bb9_cmp493_0_reg_2_inputs_ready_NO_SHIFT_REG),
	.stall_in(rnode_1to2_bb9_cmp493_0_stall_in_0_reg_2_NO_SHIFT_REG),
	.valid_out(rnode_1to2_bb9_cmp493_0_valid_out_0_reg_2_NO_SHIFT_REG),
	.stall_out(rnode_1to2_bb9_cmp493_0_stall_out_reg_2_NO_SHIFT_REG),
	.data_in(local_bb9_cmp493),
	.data_out(rnode_1to2_bb9_cmp493_0_reg_2_NO_SHIFT_REG)
);

defparam rnode_1to2_bb9_cmp493_0_reg_2_fifo.DEPTH = 2;
defparam rnode_1to2_bb9_cmp493_0_reg_2_fifo.DATA_WIDTH = 1;
defparam rnode_1to2_bb9_cmp493_0_reg_2_fifo.ALLOW_FULL_WRITE = 0;
defparam rnode_1to2_bb9_cmp493_0_reg_2_fifo.IMPL = "ll_reg";

assign rnode_1to2_bb9_cmp493_0_reg_2_inputs_ready_NO_SHIFT_REG = local_bb9_cmp493_valid_out;
assign local_bb9_cmp493_stall_in = rnode_1to2_bb9_cmp493_0_stall_out_reg_2_NO_SHIFT_REG;
assign rnode_1to2_bb9_cmp493_0_NO_SHIFT_REG = rnode_1to2_bb9_cmp493_0_reg_2_NO_SHIFT_REG_fa;
assign rnode_1to2_bb9_cmp493_1_NO_SHIFT_REG = rnode_1to2_bb9_cmp493_0_reg_2_NO_SHIFT_REG_fa;

// This section implements an unregistered operation.
// 
wire local_bb9_cmp_phi_decision120_xor_or_valid_out;
wire local_bb9_cmp_phi_decision120_xor_or_stall_in;
wire local_bb9_cmp_phi_decision120_xor_or_inputs_ready;
wire local_bb9_cmp_phi_decision120_xor_or_stall_local;
wire local_bb9_cmp_phi_decision120_xor_or;

assign local_bb9_cmp_phi_decision120_xor_or_inputs_ready = (rnode_1to2_bb9_cmp493_0_valid_out_0_NO_SHIFT_REG & rnode_1to2_var__0_valid_out_0_NO_SHIFT_REG);
assign local_bb9_cmp_phi_decision120_xor_or = (rnode_1to2_bb9_cmp493_0_NO_SHIFT_REG | rnode_1to2_var__0_NO_SHIFT_REG);
assign local_bb9_cmp_phi_decision120_xor_or_valid_out = local_bb9_cmp_phi_decision120_xor_or_inputs_ready;
assign local_bb9_cmp_phi_decision120_xor_or_stall_local = local_bb9_cmp_phi_decision120_xor_or_stall_in;
assign rnode_1to2_bb9_cmp493_0_stall_in_0_NO_SHIFT_REG = (local_bb9_cmp_phi_decision120_xor_or_stall_local | ~(local_bb9_cmp_phi_decision120_xor_or_inputs_ready));
assign rnode_1to2_var__0_stall_in_0_NO_SHIFT_REG = (local_bb9_cmp_phi_decision120_xor_or_stall_local | ~(local_bb9_cmp_phi_decision120_xor_or_inputs_ready));

// This section describes the behaviour of the BRANCH node.
wire branch_var__inputs_ready;
 reg branch_node_valid_out_NO_SHIFT_REG;
wire branch_var__output_regs_ready;
wire combined_branch_stall_in_signal;
 reg [63:0] lvb_mul_reg_NO_SHIFT_REG;
 reg [63:0] lvb_sub_reg_NO_SHIFT_REG;
 reg lvb_var__reg_NO_SHIFT_REG;
 reg lvb_bb9_cmp493_reg_NO_SHIFT_REG;
 reg lvb_bb9_cmp_phi_decision120_xor_or_reg_NO_SHIFT_REG;
 reg [31:0] lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;

assign branch_var__inputs_ready = (local_bb9_cmp_phi_decision120_xor_or_valid_out & rnode_1to2_mul_0_valid_out_NO_SHIFT_REG & rnode_1to2_sub_0_valid_out_NO_SHIFT_REG & rnode_1to2_var__0_valid_out_1_NO_SHIFT_REG & rnode_1to2_bb9_cmp493_0_valid_out_1_NO_SHIFT_REG & rnode_1to2_input_acl_hw_wg_id_0_valid_out_NO_SHIFT_REG);
assign branch_var__output_regs_ready = (~(stall_in) | ~(branch_node_valid_out_NO_SHIFT_REG));
assign local_bb9_cmp_phi_decision120_xor_or_stall_in = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_mul_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_sub_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_var__0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_bb9_cmp493_0_stall_in_1_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign rnode_1to2_input_acl_hw_wg_id_0_stall_in_NO_SHIFT_REG = (~(branch_var__output_regs_ready) | ~(branch_var__inputs_ready));
assign lvb_mul = lvb_mul_reg_NO_SHIFT_REG;
assign lvb_sub = lvb_sub_reg_NO_SHIFT_REG;
assign lvb_var_ = lvb_var__reg_NO_SHIFT_REG;
assign lvb_bb9_cmp493 = lvb_bb9_cmp493_reg_NO_SHIFT_REG;
assign lvb_bb9_cmp_phi_decision120_xor_or = lvb_bb9_cmp_phi_decision120_xor_or_reg_NO_SHIFT_REG;
assign lvb_input_acl_hw_wg_id = lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG;
assign valid_out = branch_node_valid_out_NO_SHIFT_REG;
assign combined_branch_stall_in_signal = stall_in;

always @(posedge clock or negedge resetn)
begin
	if (~(resetn))
	begin
		branch_node_valid_out_NO_SHIFT_REG <= 1'b0;
		lvb_mul_reg_NO_SHIFT_REG <= 'x;
		lvb_sub_reg_NO_SHIFT_REG <= 'x;
		lvb_var__reg_NO_SHIFT_REG <= 'x;
		lvb_bb9_cmp493_reg_NO_SHIFT_REG <= 'x;
		lvb_bb9_cmp_phi_decision120_xor_or_reg_NO_SHIFT_REG <= 'x;
		lvb_input_acl_hw_wg_id_reg_NO_SHIFT_REG <= 'x;
	end
	else
	begin
		if (branch_var__output_regs_ready)
		begin
			branch_node_valid_out_NO_SHIFT_REG <= branch_var__inputs_ready;
			lvb_mul_reg_NO_SHIFT_REG <= rnode_1to2_mul_0_NO_SHIFT_REG;
			lvb_sub_reg_NO_SHIFT_REG <= rnode_1to2_sub_0_NO_SHIFT_REG;
			lvb_var__reg_NO_SHIFT_REG <= rnode_1to2_var__1_NO_SHIFT_REG;
			lvb_bb9_cmp493_reg_NO_SHIFT_REG <= rnode_1to2_bb9_cmp493_1_NO_SHIFT_REG;
			lvb_bb9_cmp_phi_decision120_xor_or_reg_NO_SHIFT_REG <= local_bb9_cmp_phi_decision120_xor_or;
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
		input [255:0] 		avm_local_bb3_ld__u2_readdata,
		input 		avm_local_bb3_ld__u2_readdatavalid,
		input 		avm_local_bb3_ld__u2_waitrequest,
		output [29:0] 		avm_local_bb3_ld__u2_address,
		output 		avm_local_bb3_ld__u2_read,
		output 		avm_local_bb3_ld__u2_write,
		input 		avm_local_bb3_ld__u2_writeack,
		output [255:0] 		avm_local_bb3_ld__u2_writedata,
		output [31:0] 		avm_local_bb3_ld__u2_byteenable,
		output [4:0] 		avm_local_bb3_ld__u2_burstcount,
		input [255:0] 		avm_local_bb3_ld__readdata,
		input 		avm_local_bb3_ld__readdatavalid,
		input 		avm_local_bb3_ld__waitrequest,
		output [29:0] 		avm_local_bb3_ld__address,
		output 		avm_local_bb3_ld__read,
		output 		avm_local_bb3_ld__write,
		input 		avm_local_bb3_ld__writeack,
		output [255:0] 		avm_local_bb3_ld__writedata,
		output [31:0] 		avm_local_bb3_ld__byteenable,
		output [4:0] 		avm_local_bb3_ld__burstcount,
		input [255:0] 		avm_local_bb5_ld__readdata,
		input 		avm_local_bb5_ld__readdatavalid,
		input 		avm_local_bb5_ld__waitrequest,
		output [29:0] 		avm_local_bb5_ld__address,
		output 		avm_local_bb5_ld__read,
		output 		avm_local_bb5_ld__write,
		input 		avm_local_bb5_ld__writeack,
		output [255:0] 		avm_local_bb5_ld__writedata,
		output [31:0] 		avm_local_bb5_ld__byteenable,
		output [4:0] 		avm_local_bb5_ld__burstcount,
		input [255:0] 		avm_local_bb5_st__109_readdata,
		input 		avm_local_bb5_st__109_readdatavalid,
		input 		avm_local_bb5_st__109_waitrequest,
		output [29:0] 		avm_local_bb5_st__109_address,
		output 		avm_local_bb5_st__109_read,
		output 		avm_local_bb5_st__109_write,
		input 		avm_local_bb5_st__109_writeack,
		output [255:0] 		avm_local_bb5_st__109_writedata,
		output [31:0] 		avm_local_bb5_st__109_byteenable,
		output [4:0] 		avm_local_bb5_st__109_burstcount,
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
		input [255:0] 		avm_local_bb8_ld__readdata,
		input 		avm_local_bb8_ld__readdatavalid,
		input 		avm_local_bb8_ld__waitrequest,
		output [29:0] 		avm_local_bb8_ld__address,
		output 		avm_local_bb8_ld__read,
		output 		avm_local_bb8_ld__write,
		input 		avm_local_bb8_ld__writeack,
		output [255:0] 		avm_local_bb8_ld__writedata,
		output [31:0] 		avm_local_bb8_ld__byteenable,
		output [4:0] 		avm_local_bb8_ld__burstcount,
		input [255:0] 		avm_local_bb8_st__52_readdata,
		input 		avm_local_bb8_st__52_readdatavalid,
		input 		avm_local_bb8_st__52_waitrequest,
		output [29:0] 		avm_local_bb8_st__52_address,
		output 		avm_local_bb8_st__52_read,
		output 		avm_local_bb8_st__52_write,
		input 		avm_local_bb8_st__52_writeack,
		output [255:0] 		avm_local_bb8_st__52_writedata,
		output [31:0] 		avm_local_bb8_st__52_byteenable,
		output [4:0] 		avm_local_bb8_st__52_burstcount,
		input 		start,
		input [31:0] 		input_subarr_size,
		input [31:0] 		input_num_of_elements,
		input [63:0] 		input_data,
		input 		clock2x,
		input [63:0] 		input_temp,
		output reg 		has_a_write_pending,
		output reg 		has_a_lsu_active
	);


wire [31:0] cur_cycle;
wire bb_0_stall_out;
wire bb_0_valid_out;
wire [63:0] bb_0_lvb_bb0_conv;
wire [63:0] bb_0_lvb_bb0_conv1;
wire [63:0] bb_0_lvb_bb0_add;
wire [31:0] bb_0_lvb_input_global_id_0;
wire [31:0] bb_0_lvb_input_acl_hw_wg_id;
wire bb_1_stall_out;
wire bb_1_valid_out;
wire [63:0] bb_1_lvb_bb1_mul;
wire bb_1_lvb_bb1_cmp;
wire [63:0] bb_1_lvb_bb1_sub;
wire [63:0] bb_1_lvb_bb1_div;
wire [63:0] bb_1_lvb_bb1_add5;
wire bb_1_lvb_bb1_var_;
wire [31:0] bb_1_lvb_input_acl_hw_wg_id;
wire bb_2_stall_out_0;
wire bb_2_stall_out_1;
wire bb_2_valid_out;
wire [63:0] bb_2_lvb_mul;
wire bb_2_lvb_cmp;
wire [63:0] bb_2_lvb_sub;
wire [63:0] bb_2_lvb_div;
wire bb_2_lvb_var_;
wire [63:0] bb_2_lvb_left_lower_0_ph;
wire [63:0] bb_2_lvb_right_lower_0_ph;
wire [63:0] bb_2_lvb_temp_index_0_ph;
wire bb_2_lvb_bb2_cmp6;
wire [63:0] bb_2_lvb_bb2_arrayidx24;
wire bb_2_lvb_bb2_not_cmp6;
wire bb_2_lvb_bb2_var_;
wire [31:0] bb_2_lvb_input_acl_hw_wg_id;
wire bb_3_stall_out_0;
wire bb_3_stall_out_1;
wire bb_3_valid_out;
wire [63:0] bb_3_lvb_mul;
wire bb_3_lvb_cmp;
wire [63:0] bb_3_lvb_sub;
wire [63:0] bb_3_lvb_div;
wire bb_3_lvb_var_;
wire [63:0] bb_3_lvb_left_lower_0_ph;
wire bb_3_lvb_cmp6;
wire [63:0] bb_3_lvb_arrayidx24;
wire bb_3_lvb_not_cmp6;
wire bb_3_lvb_var__u0;
wire [63:0] bb_3_lvb_right_lower_0_ph6;
wire [63:0] bb_3_lvb_temp_index_0_ph7;
wire bb_3_lvb_bb3_cmp8;
wire bb_3_lvb_bb3_or_cond;
wire [63:0] bb_3_lvb_bb3_arrayidx23;
wire bb_3_lvb_bb3_var_;
wire bb_3_lvb_bb3_var__u1;
wire [31:0] bb_3_lvb_bb3_ld_;
wire [31:0] bb_3_lvb_bb3_ld__u2;
wire bb_3_lvb_bb3_cmp25;
wire bb_3_lvb_bb3_var__u3;
wire bb_3_lvb_bb3_var__u4;
wire [31:0] bb_3_lvb_input_acl_hw_wg_id;
wire bb_3_local_bb3_ld__u2_active;
wire bb_3_local_bb3_ld__active;
wire bb_4_stall_out_0;
wire bb_4_stall_out_1;
wire bb_4_valid_out_0;
wire [63:0] bb_4_lvb_mul_0;
wire bb_4_lvb_cmp_0;
wire [63:0] bb_4_lvb_sub_0;
wire [63:0] bb_4_lvb_div_0;
wire bb_4_lvb_var__0;
wire [63:0] bb_4_lvb_left_lower_0_ph_0;
wire bb_4_lvb_cmp6_0;
wire [63:0] bb_4_lvb_arrayidx24_0;
wire bb_4_lvb_not_cmp6_0;
wire bb_4_lvb_var__u6_0;
wire [63:0] bb_4_lvb_right_lower_0_ph6_0;
wire [63:0] bb_4_lvb_temp_index_0_ph7_0;
wire bb_4_lvb_cmp8_0;
wire bb_4_lvb_or_cond_0;
wire [63:0] bb_4_lvb_arrayidx23_0;
wire bb_4_lvb_var__u7_0;
wire bb_4_lvb_var__u8_0;
wire [31:0] bb_4_lvb_ld__0;
wire [31:0] bb_4_lvb_ld__u9_0;
wire bb_4_lvb_cmp25_0;
wire bb_4_lvb_var__u10_0;
wire bb_4_lvb_var__u11_0;
wire [31:0] bb_4_lvb_input_acl_hw_wg_id_0;
wire bb_4_valid_out_1;
wire [63:0] bb_4_lvb_mul_1;
wire bb_4_lvb_cmp_1;
wire [63:0] bb_4_lvb_sub_1;
wire [63:0] bb_4_lvb_div_1;
wire bb_4_lvb_var__1;
wire [63:0] bb_4_lvb_left_lower_0_ph_1;
wire bb_4_lvb_cmp6_1;
wire [63:0] bb_4_lvb_arrayidx24_1;
wire bb_4_lvb_not_cmp6_1;
wire bb_4_lvb_var__u6_1;
wire [63:0] bb_4_lvb_right_lower_0_ph6_1;
wire [63:0] bb_4_lvb_temp_index_0_ph7_1;
wire bb_4_lvb_cmp8_1;
wire bb_4_lvb_or_cond_1;
wire [63:0] bb_4_lvb_arrayidx23_1;
wire bb_4_lvb_var__u7_1;
wire bb_4_lvb_var__u8_1;
wire [31:0] bb_4_lvb_ld__1;
wire [31:0] bb_4_lvb_ld__u9_1;
wire bb_4_lvb_cmp25_1;
wire bb_4_lvb_var__u10_1;
wire bb_4_lvb_var__u11_1;
wire [31:0] bb_4_lvb_input_acl_hw_wg_id_1;
wire bb_5_stall_out;
wire bb_5_valid_out_0;
wire [63:0] bb_5_lvb_mul_0;
wire bb_5_lvb_cmp_0;
wire [63:0] bb_5_lvb_sub_0;
wire [63:0] bb_5_lvb_div_0;
wire bb_5_lvb_var__0;
wire [63:0] bb_5_lvb_left_lower_0_ph_0;
wire bb_5_lvb_cmp6_0;
wire [63:0] bb_5_lvb_arrayidx24_0;
wire bb_5_lvb_not_cmp6_0;
wire bb_5_lvb_var__u12_0;
wire [63:0] bb_5_lvb_right_lower_0_ph6_0;
wire [31:0] bb_5_lvb_ld__u15_0;
wire [31:0] bb_5_lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0;
wire [63:0] bb_5_lvb_bb5_arrayidx31_0;
wire [63:0] bb_5_lvb_bb5_temp_index_0_ph7_be_0;
wire [63:0] bb_5_lvb_bb5_right_lower_0_ph6_be_0;
wire [31:0] bb_5_lvb_input_acl_hw_wg_id_0;
wire bb_5_valid_out_1;
wire [63:0] bb_5_lvb_mul_1;
wire bb_5_lvb_cmp_1;
wire [63:0] bb_5_lvb_sub_1;
wire [63:0] bb_5_lvb_div_1;
wire bb_5_lvb_var__1;
wire [63:0] bb_5_lvb_left_lower_0_ph_1;
wire bb_5_lvb_cmp6_1;
wire [63:0] bb_5_lvb_arrayidx24_1;
wire bb_5_lvb_not_cmp6_1;
wire bb_5_lvb_var__u12_1;
wire [63:0] bb_5_lvb_right_lower_0_ph6_1;
wire [31:0] bb_5_lvb_ld__u15_1;
wire [31:0] bb_5_lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_1;
wire [63:0] bb_5_lvb_bb5_arrayidx31_1;
wire [63:0] bb_5_lvb_bb5_temp_index_0_ph7_be_1;
wire [63:0] bb_5_lvb_bb5_right_lower_0_ph6_be_1;
wire [31:0] bb_5_lvb_input_acl_hw_wg_id_1;
wire bb_5_local_bb5_ld__active;
wire bb_5_local_bb5_st__109_active;
wire bb_6_stall_out_0;
wire bb_6_stall_out_1;
wire bb_6_valid_out_0;
wire [63:0] bb_6_lvb_sub_0;
wire bb_6_lvb_var__0;
wire [63:0] bb_6_lvb_bb6_inc53_0;
wire bb_6_lvb_cmp493_0;
wire bb_6_lvb_cmp_phi_decision120_xor_or_0;
wire [31:0] bb_6_lvb_input_acl_hw_wg_id_0;
wire bb_6_valid_out_1;
wire [63:0] bb_6_lvb_sub_1;
wire bb_6_lvb_var__1;
wire [63:0] bb_6_lvb_bb6_inc53_1;
wire bb_6_lvb_cmp493_1;
wire bb_6_lvb_cmp_phi_decision120_xor_or_1;
wire [31:0] bb_6_lvb_input_acl_hw_wg_id_1;
wire bb_6_local_bb6_ld__active;
wire bb_6_local_bb6_st__active;
wire bb_7_stall_out;
wire bb_7_valid_out;
wire [31:0] bb_7_lvb_input_acl_hw_wg_id;
wire bb_8_stall_out;
wire bb_8_valid_out_0;
wire [63:0] bb_8_lvb_mul_0;
wire bb_8_lvb_cmp_0;
wire [63:0] bb_8_lvb_sub_0;
wire [63:0] bb_8_lvb_div_0;
wire bb_8_lvb_var__0;
wire [63:0] bb_8_lvb_right_lower_0_ph6_0;
wire [63:0] bb_8_lvb_temp_index_0_ph7_be_0;
wire [63:0] bb_8_lvb_bb8_left_lower_0_ph_be_0;
wire [31:0] bb_8_lvb_input_acl_hw_wg_id_0;
wire bb_8_valid_out_1;
wire [63:0] bb_8_lvb_mul_1;
wire bb_8_lvb_cmp_1;
wire [63:0] bb_8_lvb_sub_1;
wire [63:0] bb_8_lvb_div_1;
wire bb_8_lvb_var__1;
wire [63:0] bb_8_lvb_right_lower_0_ph6_1;
wire [63:0] bb_8_lvb_temp_index_0_ph7_be_1;
wire [63:0] bb_8_lvb_bb8_left_lower_0_ph_be_1;
wire [31:0] bb_8_lvb_input_acl_hw_wg_id_1;
wire bb_8_local_bb8_ld__active;
wire bb_8_local_bb8_st__52_active;
wire bb_9_stall_out;
wire bb_9_valid_out;
wire [63:0] bb_9_lvb_mul;
wire [63:0] bb_9_lvb_sub;
wire bb_9_lvb_var_;
wire bb_9_lvb_bb9_cmp493;
wire bb_9_lvb_bb9_cmp_phi_decision120_xor_or;
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
wire [7:0] lsus_active;

fpgasort_basic_block_0 fpgasort_basic_block_0 (
	.clock(clock),
	.resetn(resetn),
	.start(start),
	.input_subarr_size(input_subarr_size),
	.input_num_of_elements(input_num_of_elements),
	.valid_in(valid_in),
	.stall_out(bb_0_stall_out),
	.input_global_id_0(input_global_id_0),
	.input_acl_hw_wg_id(input_acl_hw_wg_id),
	.valid_out(bb_0_valid_out),
	.stall_in(bb_1_stall_out),
	.lvb_bb0_conv(bb_0_lvb_bb0_conv),
	.lvb_bb0_conv1(bb_0_lvb_bb0_conv1),
	.lvb_bb0_add(bb_0_lvb_bb0_add),
	.lvb_input_global_id_0(bb_0_lvb_input_global_id_0),
	.lvb_input_acl_hw_wg_id(bb_0_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size)
);


fpgasort_basic_block_1 fpgasort_basic_block_1 (
	.clock(clock),
	.resetn(resetn),
	.input_wii_conv(bb_0_lvb_bb0_conv),
	.input_wii_conv1(bb_0_lvb_bb0_conv1),
	.input_wii_add(bb_0_lvb_bb0_add),
	.valid_in(bb_0_valid_out),
	.stall_out(bb_1_stall_out),
	.input_global_id_0(bb_0_lvb_input_global_id_0),
	.input_acl_hw_wg_id(bb_0_lvb_input_acl_hw_wg_id),
	.valid_out(bb_1_valid_out),
	.stall_in(loop_limiter_0_stall_out),
	.lvb_bb1_mul(bb_1_lvb_bb1_mul),
	.lvb_bb1_cmp(bb_1_lvb_bb1_cmp),
	.lvb_bb1_sub(bb_1_lvb_bb1_sub),
	.lvb_bb1_div(bb_1_lvb_bb1_div),
	.lvb_bb1_add5(bb_1_lvb_bb1_add5),
	.lvb_bb1_var_(bb_1_lvb_bb1_var_),
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
	.input_mul_0(bb_8_lvb_mul_0),
	.input_cmp_0(bb_8_lvb_cmp_0),
	.input_sub_0(bb_8_lvb_sub_0),
	.input_div_0(bb_8_lvb_div_0),
	.input_var__0(bb_8_lvb_var__0),
	.input_left_lower_0_ph_0(bb_8_lvb_bb8_left_lower_0_ph_be_0),
	.input_right_lower_0_ph_0(bb_8_lvb_right_lower_0_ph6_0),
	.input_temp_index_0_ph_0(bb_8_lvb_temp_index_0_ph7_be_0),
	.input_acl_hw_wg_id_0(bb_8_lvb_input_acl_hw_wg_id_0),
	.valid_in_1(loop_limiter_0_valid_out),
	.stall_out_1(bb_2_stall_out_1),
	.input_mul_1(bb_1_lvb_bb1_mul),
	.input_cmp_1(bb_1_lvb_bb1_cmp),
	.input_sub_1(bb_1_lvb_bb1_sub),
	.input_div_1(bb_1_lvb_bb1_div),
	.input_var__1(bb_1_lvb_bb1_var_),
	.input_left_lower_0_ph_1(bb_1_lvb_bb1_mul),
	.input_right_lower_0_ph_1(bb_1_lvb_bb1_add5),
	.input_temp_index_0_ph_1(bb_1_lvb_bb1_mul),
	.input_acl_hw_wg_id_1(bb_1_lvb_input_acl_hw_wg_id),
	.valid_out(bb_2_valid_out),
	.stall_in(loop_limiter_2_stall_out),
	.lvb_mul(bb_2_lvb_mul),
	.lvb_cmp(bb_2_lvb_cmp),
	.lvb_sub(bb_2_lvb_sub),
	.lvb_div(bb_2_lvb_div),
	.lvb_var_(bb_2_lvb_var_),
	.lvb_left_lower_0_ph(bb_2_lvb_left_lower_0_ph),
	.lvb_right_lower_0_ph(bb_2_lvb_right_lower_0_ph),
	.lvb_temp_index_0_ph(bb_2_lvb_temp_index_0_ph),
	.lvb_bb2_cmp6(bb_2_lvb_bb2_cmp6),
	.lvb_bb2_arrayidx24(bb_2_lvb_bb2_arrayidx24),
	.lvb_bb2_not_cmp6(bb_2_lvb_bb2_not_cmp6),
	.lvb_bb2_var_(bb_2_lvb_bb2_var_),
	.lvb_input_acl_hw_wg_id(bb_2_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size),
	.start(start)
);


fpgasort_basic_block_3 fpgasort_basic_block_3 (
	.clock(clock),
	.resetn(resetn),
	.input_data(input_data),
	.valid_in_0(bb_5_valid_out_0),
	.stall_out_0(bb_3_stall_out_0),
	.input_mul_0(bb_5_lvb_mul_0),
	.input_cmp_0(bb_5_lvb_cmp_0),
	.input_sub_0(bb_5_lvb_sub_0),
	.input_div_0(bb_5_lvb_div_0),
	.input_var__0(bb_5_lvb_var__0),
	.input_left_lower_0_ph_0(bb_5_lvb_left_lower_0_ph_0),
	.input_cmp6_0(bb_5_lvb_cmp6_0),
	.input_arrayidx24_0(bb_5_lvb_arrayidx24_0),
	.input_not_cmp6_0(bb_5_lvb_not_cmp6_0),
	.input_var__u0_0(bb_5_lvb_var__u12_0),
	.input_right_lower_0_ph6_0(bb_5_lvb_bb5_right_lower_0_ph6_be_0),
	.input_temp_index_0_ph7_0(bb_5_lvb_bb5_temp_index_0_ph7_be_0),
	.input_acl_hw_wg_id_0(bb_5_lvb_input_acl_hw_wg_id_0),
	.valid_in_1(loop_limiter_2_valid_out),
	.stall_out_1(bb_3_stall_out_1),
	.input_mul_1(bb_2_lvb_mul),
	.input_cmp_1(bb_2_lvb_cmp),
	.input_sub_1(bb_2_lvb_sub),
	.input_div_1(bb_2_lvb_div),
	.input_var__1(bb_2_lvb_var_),
	.input_left_lower_0_ph_1(bb_2_lvb_left_lower_0_ph),
	.input_cmp6_1(bb_2_lvb_bb2_cmp6),
	.input_arrayidx24_1(bb_2_lvb_bb2_arrayidx24),
	.input_not_cmp6_1(bb_2_lvb_bb2_not_cmp6),
	.input_var__u0_1(bb_2_lvb_bb2_var_),
	.input_right_lower_0_ph6_1(bb_2_lvb_right_lower_0_ph),
	.input_temp_index_0_ph7_1(bb_2_lvb_temp_index_0_ph),
	.input_acl_hw_wg_id_1(bb_2_lvb_input_acl_hw_wg_id),
	.valid_out(bb_3_valid_out),
	.stall_in(loop_limiter_3_stall_out),
	.lvb_mul(bb_3_lvb_mul),
	.lvb_cmp(bb_3_lvb_cmp),
	.lvb_sub(bb_3_lvb_sub),
	.lvb_div(bb_3_lvb_div),
	.lvb_var_(bb_3_lvb_var_),
	.lvb_left_lower_0_ph(bb_3_lvb_left_lower_0_ph),
	.lvb_cmp6(bb_3_lvb_cmp6),
	.lvb_arrayidx24(bb_3_lvb_arrayidx24),
	.lvb_not_cmp6(bb_3_lvb_not_cmp6),
	.lvb_var__u0(bb_3_lvb_var__u0),
	.lvb_right_lower_0_ph6(bb_3_lvb_right_lower_0_ph6),
	.lvb_temp_index_0_ph7(bb_3_lvb_temp_index_0_ph7),
	.lvb_bb3_cmp8(bb_3_lvb_bb3_cmp8),
	.lvb_bb3_or_cond(bb_3_lvb_bb3_or_cond),
	.lvb_bb3_arrayidx23(bb_3_lvb_bb3_arrayidx23),
	.lvb_bb3_var_(bb_3_lvb_bb3_var_),
	.lvb_bb3_var__u1(bb_3_lvb_bb3_var__u1),
	.lvb_bb3_ld_(bb_3_lvb_bb3_ld_),
	.lvb_bb3_ld__u2(bb_3_lvb_bb3_ld__u2),
	.lvb_bb3_cmp25(bb_3_lvb_bb3_cmp25),
	.lvb_bb3_var__u3(bb_3_lvb_bb3_var__u3),
	.lvb_bb3_var__u4(bb_3_lvb_bb3_var__u4),
	.lvb_input_acl_hw_wg_id(bb_3_lvb_input_acl_hw_wg_id),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb3_ld__u2_readdata(avm_local_bb3_ld__u2_readdata),
	.avm_local_bb3_ld__u2_readdatavalid(avm_local_bb3_ld__u2_readdatavalid),
	.avm_local_bb3_ld__u2_waitrequest(avm_local_bb3_ld__u2_waitrequest),
	.avm_local_bb3_ld__u2_address(avm_local_bb3_ld__u2_address),
	.avm_local_bb3_ld__u2_read(avm_local_bb3_ld__u2_read),
	.avm_local_bb3_ld__u2_write(avm_local_bb3_ld__u2_write),
	.avm_local_bb3_ld__u2_writeack(avm_local_bb3_ld__u2_writeack),
	.avm_local_bb3_ld__u2_writedata(avm_local_bb3_ld__u2_writedata),
	.avm_local_bb3_ld__u2_byteenable(avm_local_bb3_ld__u2_byteenable),
	.avm_local_bb3_ld__u2_burstcount(avm_local_bb3_ld__u2_burstcount),
	.local_bb3_ld__u2_active(bb_3_local_bb3_ld__u2_active),
	.clock2x(clock2x),
	.avm_local_bb3_ld__readdata(avm_local_bb3_ld__readdata),
	.avm_local_bb3_ld__readdatavalid(avm_local_bb3_ld__readdatavalid),
	.avm_local_bb3_ld__waitrequest(avm_local_bb3_ld__waitrequest),
	.avm_local_bb3_ld__address(avm_local_bb3_ld__address),
	.avm_local_bb3_ld__read(avm_local_bb3_ld__read),
	.avm_local_bb3_ld__write(avm_local_bb3_ld__write),
	.avm_local_bb3_ld__writeack(avm_local_bb3_ld__writeack),
	.avm_local_bb3_ld__writedata(avm_local_bb3_ld__writedata),
	.avm_local_bb3_ld__byteenable(avm_local_bb3_ld__byteenable),
	.avm_local_bb3_ld__burstcount(avm_local_bb3_ld__burstcount),
	.local_bb3_ld__active(bb_3_local_bb3_ld__active)
);


fpgasort_basic_block_4 fpgasort_basic_block_4 (
	.clock(clock),
	.resetn(resetn),
	.valid_in_0(bb_4_valid_out_0),
	.stall_out_0(bb_4_stall_out_0),
	.input_mul_0(bb_4_lvb_mul_0),
	.input_cmp_0(bb_4_lvb_cmp_0),
	.input_sub_0(bb_4_lvb_sub_0),
	.input_div_0(bb_4_lvb_div_0),
	.input_var__0(bb_4_lvb_var__0),
	.input_left_lower_0_ph_0(bb_4_lvb_left_lower_0_ph_0),
	.input_cmp6_0(bb_4_lvb_cmp6_0),
	.input_arrayidx24_0(bb_4_lvb_arrayidx24_0),
	.input_not_cmp6_0(bb_4_lvb_not_cmp6_0),
	.input_var__u6_0(bb_4_lvb_var__u6_0),
	.input_right_lower_0_ph6_0(bb_4_lvb_right_lower_0_ph6_0),
	.input_temp_index_0_ph7_0(bb_4_lvb_temp_index_0_ph7_0),
	.input_cmp8_0(bb_4_lvb_cmp8_0),
	.input_or_cond_0(bb_4_lvb_or_cond_0),
	.input_arrayidx23_0(bb_4_lvb_arrayidx23_0),
	.input_var__u7_0(bb_4_lvb_var__u7_0),
	.input_var__u8_0(bb_4_lvb_var__u8_0),
	.input_ld__0(bb_4_lvb_ld__0),
	.input_ld__u9_0(bb_4_lvb_ld__u9_0),
	.input_cmp25_0(bb_4_lvb_cmp25_0),
	.input_var__u10_0(bb_4_lvb_var__u10_0),
	.input_var__u11_0(bb_4_lvb_var__u11_0),
	.input_acl_hw_wg_id_0(bb_4_lvb_input_acl_hw_wg_id_0),
	.valid_in_1(loop_limiter_3_valid_out),
	.stall_out_1(bb_4_stall_out_1),
	.input_mul_1(bb_3_lvb_mul),
	.input_cmp_1(bb_3_lvb_cmp),
	.input_sub_1(bb_3_lvb_sub),
	.input_div_1(bb_3_lvb_div),
	.input_var__1(bb_3_lvb_var_),
	.input_left_lower_0_ph_1(bb_3_lvb_left_lower_0_ph),
	.input_cmp6_1(bb_3_lvb_cmp6),
	.input_arrayidx24_1(bb_3_lvb_arrayidx24),
	.input_not_cmp6_1(bb_3_lvb_not_cmp6),
	.input_var__u6_1(bb_3_lvb_var__u0),
	.input_right_lower_0_ph6_1(bb_3_lvb_right_lower_0_ph6),
	.input_temp_index_0_ph7_1(bb_3_lvb_temp_index_0_ph7),
	.input_cmp8_1(bb_3_lvb_bb3_cmp8),
	.input_or_cond_1(bb_3_lvb_bb3_or_cond),
	.input_arrayidx23_1(bb_3_lvb_bb3_arrayidx23),
	.input_var__u7_1(bb_3_lvb_bb3_var_),
	.input_var__u8_1(bb_3_lvb_bb3_var__u1),
	.input_ld__1(bb_3_lvb_bb3_ld_),
	.input_ld__u9_1(bb_3_lvb_bb3_ld__u2),
	.input_cmp25_1(bb_3_lvb_bb3_cmp25),
	.input_var__u10_1(bb_3_lvb_bb3_var__u3),
	.input_var__u11_1(bb_3_lvb_bb3_var__u4),
	.input_acl_hw_wg_id_1(bb_3_lvb_input_acl_hw_wg_id),
	.valid_out_0(bb_4_valid_out_0),
	.stall_in_0(bb_4_stall_out_0),
	.lvb_mul_0(bb_4_lvb_mul_0),
	.lvb_cmp_0(bb_4_lvb_cmp_0),
	.lvb_sub_0(bb_4_lvb_sub_0),
	.lvb_div_0(bb_4_lvb_div_0),
	.lvb_var__0(bb_4_lvb_var__0),
	.lvb_left_lower_0_ph_0(bb_4_lvb_left_lower_0_ph_0),
	.lvb_cmp6_0(bb_4_lvb_cmp6_0),
	.lvb_arrayidx24_0(bb_4_lvb_arrayidx24_0),
	.lvb_not_cmp6_0(bb_4_lvb_not_cmp6_0),
	.lvb_var__u6_0(bb_4_lvb_var__u6_0),
	.lvb_right_lower_0_ph6_0(bb_4_lvb_right_lower_0_ph6_0),
	.lvb_temp_index_0_ph7_0(bb_4_lvb_temp_index_0_ph7_0),
	.lvb_cmp8_0(bb_4_lvb_cmp8_0),
	.lvb_or_cond_0(bb_4_lvb_or_cond_0),
	.lvb_arrayidx23_0(bb_4_lvb_arrayidx23_0),
	.lvb_var__u7_0(bb_4_lvb_var__u7_0),
	.lvb_var__u8_0(bb_4_lvb_var__u8_0),
	.lvb_ld__0(bb_4_lvb_ld__0),
	.lvb_ld__u9_0(bb_4_lvb_ld__u9_0),
	.lvb_cmp25_0(bb_4_lvb_cmp25_0),
	.lvb_var__u10_0(bb_4_lvb_var__u10_0),
	.lvb_var__u11_0(bb_4_lvb_var__u11_0),
	.lvb_input_acl_hw_wg_id_0(bb_4_lvb_input_acl_hw_wg_id_0),
	.valid_out_1(bb_4_valid_out_1),
	.stall_in_1(bb_5_stall_out),
	.lvb_mul_1(bb_4_lvb_mul_1),
	.lvb_cmp_1(bb_4_lvb_cmp_1),
	.lvb_sub_1(bb_4_lvb_sub_1),
	.lvb_div_1(bb_4_lvb_div_1),
	.lvb_var__1(bb_4_lvb_var__1),
	.lvb_left_lower_0_ph_1(bb_4_lvb_left_lower_0_ph_1),
	.lvb_cmp6_1(bb_4_lvb_cmp6_1),
	.lvb_arrayidx24_1(bb_4_lvb_arrayidx24_1),
	.lvb_not_cmp6_1(bb_4_lvb_not_cmp6_1),
	.lvb_var__u6_1(bb_4_lvb_var__u6_1),
	.lvb_right_lower_0_ph6_1(bb_4_lvb_right_lower_0_ph6_1),
	.lvb_temp_index_0_ph7_1(bb_4_lvb_temp_index_0_ph7_1),
	.lvb_cmp8_1(bb_4_lvb_cmp8_1),
	.lvb_or_cond_1(bb_4_lvb_or_cond_1),
	.lvb_arrayidx23_1(bb_4_lvb_arrayidx23_1),
	.lvb_var__u7_1(bb_4_lvb_var__u7_1),
	.lvb_var__u8_1(bb_4_lvb_var__u8_1),
	.lvb_ld__1(bb_4_lvb_ld__1),
	.lvb_ld__u9_1(bb_4_lvb_ld__u9_1),
	.lvb_cmp25_1(bb_4_lvb_cmp25_1),
	.lvb_var__u10_1(bb_4_lvb_var__u10_1),
	.lvb_var__u11_1(bb_4_lvb_var__u11_1),
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
	.input_mul(bb_4_lvb_mul_1),
	.input_cmp(bb_4_lvb_cmp_1),
	.input_sub(bb_4_lvb_sub_1),
	.input_div(bb_4_lvb_div_1),
	.input_var_(bb_4_lvb_var__1),
	.input_left_lower_0_ph(bb_4_lvb_left_lower_0_ph_1),
	.input_cmp6(bb_4_lvb_cmp6_1),
	.input_arrayidx24(bb_4_lvb_arrayidx24_1),
	.input_not_cmp6(bb_4_lvb_not_cmp6_1),
	.input_var__u12(bb_4_lvb_var__u6_1),
	.input_right_lower_0_ph6(bb_4_lvb_right_lower_0_ph6_1),
	.input_temp_index_0_ph7(bb_4_lvb_temp_index_0_ph7_1),
	.input_cmp8(bb_4_lvb_cmp8_1),
	.input_or_cond(bb_4_lvb_or_cond_1),
	.input_arrayidx23(bb_4_lvb_arrayidx23_1),
	.input_var__u13(bb_4_lvb_var__u7_1),
	.input_var__u14(bb_4_lvb_var__u8_1),
	.input_ld_(bb_4_lvb_ld__1),
	.input_ld__u15(bb_4_lvb_ld__u9_1),
	.input_cmp25(bb_4_lvb_cmp25_1),
	.input_var__u16(bb_4_lvb_var__u10_1),
	.input_acl_hw_wg_id(bb_4_lvb_input_acl_hw_wg_id_1),
	.valid_out_0(bb_5_valid_out_0),
	.stall_in_0(bb_3_stall_out_0),
	.lvb_mul_0(bb_5_lvb_mul_0),
	.lvb_cmp_0(bb_5_lvb_cmp_0),
	.lvb_sub_0(bb_5_lvb_sub_0),
	.lvb_div_0(bb_5_lvb_div_0),
	.lvb_var__0(bb_5_lvb_var__0),
	.lvb_left_lower_0_ph_0(bb_5_lvb_left_lower_0_ph_0),
	.lvb_cmp6_0(bb_5_lvb_cmp6_0),
	.lvb_arrayidx24_0(bb_5_lvb_arrayidx24_0),
	.lvb_not_cmp6_0(bb_5_lvb_not_cmp6_0),
	.lvb_var__u12_0(bb_5_lvb_var__u12_0),
	.lvb_right_lower_0_ph6_0(bb_5_lvb_right_lower_0_ph6_0),
	.lvb_ld__u15_0(bb_5_lvb_ld__u15_0),
	.lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0(bb_5_lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_0),
	.lvb_bb5_arrayidx31_0(bb_5_lvb_bb5_arrayidx31_0),
	.lvb_bb5_temp_index_0_ph7_be_0(bb_5_lvb_bb5_temp_index_0_ph7_be_0),
	.lvb_bb5_right_lower_0_ph6_be_0(bb_5_lvb_bb5_right_lower_0_ph6_be_0),
	.lvb_input_acl_hw_wg_id_0(bb_5_lvb_input_acl_hw_wg_id_0),
	.valid_out_1(bb_5_valid_out_1),
	.stall_in_1(bb_8_stall_out),
	.lvb_mul_1(bb_5_lvb_mul_1),
	.lvb_cmp_1(bb_5_lvb_cmp_1),
	.lvb_sub_1(bb_5_lvb_sub_1),
	.lvb_div_1(bb_5_lvb_div_1),
	.lvb_var__1(bb_5_lvb_var__1),
	.lvb_left_lower_0_ph_1(bb_5_lvb_left_lower_0_ph_1),
	.lvb_cmp6_1(bb_5_lvb_cmp6_1),
	.lvb_arrayidx24_1(bb_5_lvb_arrayidx24_1),
	.lvb_not_cmp6_1(bb_5_lvb_not_cmp6_1),
	.lvb_var__u12_1(bb_5_lvb_var__u12_1),
	.lvb_right_lower_0_ph6_1(bb_5_lvb_right_lower_0_ph6_1),
	.lvb_ld__u15_1(bb_5_lvb_ld__u15_1),
	.lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_1(bb_5_lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_1),
	.lvb_bb5_arrayidx31_1(bb_5_lvb_bb5_arrayidx31_1),
	.lvb_bb5_temp_index_0_ph7_be_1(bb_5_lvb_bb5_temp_index_0_ph7_be_1),
	.lvb_bb5_right_lower_0_ph6_be_1(bb_5_lvb_bb5_right_lower_0_ph6_be_1),
	.lvb_input_acl_hw_wg_id_1(bb_5_lvb_input_acl_hw_wg_id_1),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb5_ld__readdata(avm_local_bb5_ld__readdata),
	.avm_local_bb5_ld__readdatavalid(avm_local_bb5_ld__readdatavalid),
	.avm_local_bb5_ld__waitrequest(avm_local_bb5_ld__waitrequest),
	.avm_local_bb5_ld__address(avm_local_bb5_ld__address),
	.avm_local_bb5_ld__read(avm_local_bb5_ld__read),
	.avm_local_bb5_ld__write(avm_local_bb5_ld__write),
	.avm_local_bb5_ld__writeack(avm_local_bb5_ld__writeack),
	.avm_local_bb5_ld__writedata(avm_local_bb5_ld__writedata),
	.avm_local_bb5_ld__byteenable(avm_local_bb5_ld__byteenable),
	.avm_local_bb5_ld__burstcount(avm_local_bb5_ld__burstcount),
	.local_bb5_ld__active(bb_5_local_bb5_ld__active),
	.clock2x(clock2x),
	.avm_local_bb5_st__109_readdata(avm_local_bb5_st__109_readdata),
	.avm_local_bb5_st__109_readdatavalid(avm_local_bb5_st__109_readdatavalid),
	.avm_local_bb5_st__109_waitrequest(avm_local_bb5_st__109_waitrequest),
	.avm_local_bb5_st__109_address(avm_local_bb5_st__109_address),
	.avm_local_bb5_st__109_read(avm_local_bb5_st__109_read),
	.avm_local_bb5_st__109_write(avm_local_bb5_st__109_write),
	.avm_local_bb5_st__109_writeack(avm_local_bb5_st__109_writeack),
	.avm_local_bb5_st__109_writedata(avm_local_bb5_st__109_writedata),
	.avm_local_bb5_st__109_byteenable(avm_local_bb5_st__109_byteenable),
	.avm_local_bb5_st__109_burstcount(avm_local_bb5_st__109_burstcount),
	.local_bb5_st__109_active(bb_5_local_bb5_st__109_active)
);


fpgasort_basic_block_6 fpgasort_basic_block_6 (
	.clock(clock),
	.resetn(resetn),
	.input_temp(input_temp),
	.input_data(input_data),
	.valid_in_0(bb_6_valid_out_1),
	.stall_out_0(bb_6_stall_out_0),
	.input_sub_0(bb_6_lvb_sub_1),
	.input_var__0(bb_6_lvb_var__1),
	.input_index_04_0(bb_6_lvb_bb6_inc53_1),
	.input_cmp493_0(bb_6_lvb_cmp493_1),
	.input_cmp_phi_decision120_xor_or_0(bb_6_lvb_cmp_phi_decision120_xor_or_1),
	.input_acl_hw_wg_id_0(bb_6_lvb_input_acl_hw_wg_id_1),
	.valid_in_1(loop_limiter_1_valid_out),
	.stall_out_1(bb_6_stall_out_1),
	.input_sub_1(bb_9_lvb_sub),
	.input_var__1(bb_9_lvb_var_),
	.input_index_04_1(bb_9_lvb_mul),
	.input_cmp493_1(bb_9_lvb_bb9_cmp493),
	.input_cmp_phi_decision120_xor_or_1(bb_9_lvb_bb9_cmp_phi_decision120_xor_or),
	.input_acl_hw_wg_id_1(bb_9_lvb_input_acl_hw_wg_id),
	.valid_out_0(bb_6_valid_out_0),
	.stall_in_0(bb_7_stall_out),
	.lvb_sub_0(bb_6_lvb_sub_0),
	.lvb_var__0(bb_6_lvb_var__0),
	.lvb_bb6_inc53_0(bb_6_lvb_bb6_inc53_0),
	.lvb_cmp493_0(bb_6_lvb_cmp493_0),
	.lvb_cmp_phi_decision120_xor_or_0(bb_6_lvb_cmp_phi_decision120_xor_or_0),
	.lvb_input_acl_hw_wg_id_0(bb_6_lvb_input_acl_hw_wg_id_0),
	.valid_out_1(bb_6_valid_out_1),
	.stall_in_1(bb_6_stall_out_0),
	.lvb_sub_1(bb_6_lvb_sub_1),
	.lvb_var__1(bb_6_lvb_var__1),
	.lvb_bb6_inc53_1(bb_6_lvb_bb6_inc53_1),
	.lvb_cmp493_1(bb_6_lvb_cmp493_1),
	.lvb_cmp_phi_decision120_xor_or_1(bb_6_lvb_cmp_phi_decision120_xor_or_1),
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
	.valid_in(bb_5_valid_out_1),
	.stall_out(bb_8_stall_out),
	.input_mul(bb_5_lvb_mul_1),
	.input_cmp(bb_5_lvb_cmp_1),
	.input_sub(bb_5_lvb_sub_1),
	.input_div(bb_5_lvb_div_1),
	.input_var_(bb_5_lvb_var__1),
	.input_left_lower_0_ph(bb_5_lvb_left_lower_0_ph_1),
	.input_arrayidx24(bb_5_lvb_arrayidx24_1),
	.input_right_lower_0_ph6(bb_5_lvb_right_lower_0_ph6_1),
	.input_ld_(bb_5_lvb_ld__u15_1),
	.input_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select(bb_5_lvb_bb5_do_directly_while_cond_outer5_UnifiedLatchBlock_loopexit_select_1),
	.input_arrayidx31(bb_5_lvb_bb5_arrayidx31_1),
	.input_temp_index_0_ph7_be(bb_5_lvb_bb5_temp_index_0_ph7_be_1),
	.input_acl_hw_wg_id(bb_5_lvb_input_acl_hw_wg_id_1),
	.valid_out_0(bb_8_valid_out_0),
	.stall_in_0(bb_2_stall_out_0),
	.lvb_mul_0(bb_8_lvb_mul_0),
	.lvb_cmp_0(bb_8_lvb_cmp_0),
	.lvb_sub_0(bb_8_lvb_sub_0),
	.lvb_div_0(bb_8_lvb_div_0),
	.lvb_var__0(bb_8_lvb_var__0),
	.lvb_right_lower_0_ph6_0(bb_8_lvb_right_lower_0_ph6_0),
	.lvb_temp_index_0_ph7_be_0(bb_8_lvb_temp_index_0_ph7_be_0),
	.lvb_bb8_left_lower_0_ph_be_0(bb_8_lvb_bb8_left_lower_0_ph_be_0),
	.lvb_input_acl_hw_wg_id_0(bb_8_lvb_input_acl_hw_wg_id_0),
	.valid_out_1(bb_8_valid_out_1),
	.stall_in_1(bb_9_stall_out),
	.lvb_mul_1(bb_8_lvb_mul_1),
	.lvb_cmp_1(bb_8_lvb_cmp_1),
	.lvb_sub_1(bb_8_lvb_sub_1),
	.lvb_div_1(bb_8_lvb_div_1),
	.lvb_var__1(bb_8_lvb_var__1),
	.lvb_right_lower_0_ph6_1(bb_8_lvb_right_lower_0_ph6_1),
	.lvb_temp_index_0_ph7_be_1(bb_8_lvb_temp_index_0_ph7_be_1),
	.lvb_bb8_left_lower_0_ph_be_1(bb_8_lvb_bb8_left_lower_0_ph_be_1),
	.lvb_input_acl_hw_wg_id_1(bb_8_lvb_input_acl_hw_wg_id_1),
	.workgroup_size(workgroup_size),
	.start(start),
	.avm_local_bb8_ld__readdata(avm_local_bb8_ld__readdata),
	.avm_local_bb8_ld__readdatavalid(avm_local_bb8_ld__readdatavalid),
	.avm_local_bb8_ld__waitrequest(avm_local_bb8_ld__waitrequest),
	.avm_local_bb8_ld__address(avm_local_bb8_ld__address),
	.avm_local_bb8_ld__read(avm_local_bb8_ld__read),
	.avm_local_bb8_ld__write(avm_local_bb8_ld__write),
	.avm_local_bb8_ld__writeack(avm_local_bb8_ld__writeack),
	.avm_local_bb8_ld__writedata(avm_local_bb8_ld__writedata),
	.avm_local_bb8_ld__byteenable(avm_local_bb8_ld__byteenable),
	.avm_local_bb8_ld__burstcount(avm_local_bb8_ld__burstcount),
	.local_bb8_ld__active(bb_8_local_bb8_ld__active),
	.clock2x(clock2x),
	.avm_local_bb8_st__52_readdata(avm_local_bb8_st__52_readdata),
	.avm_local_bb8_st__52_readdatavalid(avm_local_bb8_st__52_readdatavalid),
	.avm_local_bb8_st__52_waitrequest(avm_local_bb8_st__52_waitrequest),
	.avm_local_bb8_st__52_address(avm_local_bb8_st__52_address),
	.avm_local_bb8_st__52_read(avm_local_bb8_st__52_read),
	.avm_local_bb8_st__52_write(avm_local_bb8_st__52_write),
	.avm_local_bb8_st__52_writeack(avm_local_bb8_st__52_writeack),
	.avm_local_bb8_st__52_writedata(avm_local_bb8_st__52_writedata),
	.avm_local_bb8_st__52_byteenable(avm_local_bb8_st__52_byteenable),
	.avm_local_bb8_st__52_burstcount(avm_local_bb8_st__52_burstcount),
	.local_bb8_st__52_active(bb_8_local_bb8_st__52_active)
);


fpgasort_basic_block_9 fpgasort_basic_block_9 (
	.clock(clock),
	.resetn(resetn),
	.valid_in(bb_8_valid_out_1),
	.stall_out(bb_9_stall_out),
	.input_mul(bb_8_lvb_mul_1),
	.input_sub(bb_8_lvb_sub_1),
	.input_var_(bb_8_lvb_var__1),
	.input_acl_hw_wg_id(bb_8_lvb_input_acl_hw_wg_id_1),
	.valid_out(bb_9_valid_out),
	.stall_in(loop_limiter_1_stall_out),
	.lvb_mul(bb_9_lvb_mul),
	.lvb_sub(bb_9_lvb_sub),
	.lvb_var_(bb_9_lvb_var_),
	.lvb_bb9_cmp493(bb_9_lvb_bb9_cmp493),
	.lvb_bb9_cmp_phi_decision120_xor_or(bb_9_lvb_bb9_cmp_phi_decision120_xor_or),
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
defparam loop_limiter_0.THRESHOLD = 775;

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
defparam loop_limiter_2.THRESHOLD = 470;

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
assign writes_pending[0] = bb_5_local_bb5_st__109_active;
assign writes_pending[1] = bb_6_local_bb6_st__active;
assign writes_pending[2] = bb_8_local_bb8_st__52_active;
assign lsus_active[0] = bb_3_local_bb3_ld__u2_active;
assign lsus_active[1] = bb_3_local_bb3_ld__active;
assign lsus_active[2] = bb_5_local_bb5_ld__active;
assign lsus_active[3] = bb_5_local_bb5_st__109_active;
assign lsus_active[4] = bb_6_local_bb6_ld__active;
assign lsus_active[5] = bb_6_local_bb6_st__active;
assign lsus_active[6] = bb_8_local_bb8_ld__active;
assign lsus_active[7] = bb_8_local_bb8_st__52_active;

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
		input [255:0] 		avm_local_bb3_ld__u2_inst0_readdata,
		input 		avm_local_bb3_ld__u2_inst0_readdatavalid,
		input 		avm_local_bb3_ld__u2_inst0_waitrequest,
		output [29:0] 		avm_local_bb3_ld__u2_inst0_address,
		output 		avm_local_bb3_ld__u2_inst0_read,
		output 		avm_local_bb3_ld__u2_inst0_write,
		input 		avm_local_bb3_ld__u2_inst0_writeack,
		output [255:0] 		avm_local_bb3_ld__u2_inst0_writedata,
		output [31:0] 		avm_local_bb3_ld__u2_inst0_byteenable,
		output [4:0] 		avm_local_bb3_ld__u2_inst0_burstcount,
		input [255:0] 		avm_local_bb3_ld__inst0_readdata,
		input 		avm_local_bb3_ld__inst0_readdatavalid,
		input 		avm_local_bb3_ld__inst0_waitrequest,
		output [29:0] 		avm_local_bb3_ld__inst0_address,
		output 		avm_local_bb3_ld__inst0_read,
		output 		avm_local_bb3_ld__inst0_write,
		input 		avm_local_bb3_ld__inst0_writeack,
		output [255:0] 		avm_local_bb3_ld__inst0_writedata,
		output [31:0] 		avm_local_bb3_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb3_ld__inst0_burstcount,
		input [255:0] 		avm_local_bb5_ld__inst0_readdata,
		input 		avm_local_bb5_ld__inst0_readdatavalid,
		input 		avm_local_bb5_ld__inst0_waitrequest,
		output [29:0] 		avm_local_bb5_ld__inst0_address,
		output 		avm_local_bb5_ld__inst0_read,
		output 		avm_local_bb5_ld__inst0_write,
		input 		avm_local_bb5_ld__inst0_writeack,
		output [255:0] 		avm_local_bb5_ld__inst0_writedata,
		output [31:0] 		avm_local_bb5_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb5_ld__inst0_burstcount,
		input [255:0] 		avm_local_bb5_st__109_inst0_readdata,
		input 		avm_local_bb5_st__109_inst0_readdatavalid,
		input 		avm_local_bb5_st__109_inst0_waitrequest,
		output [29:0] 		avm_local_bb5_st__109_inst0_address,
		output 		avm_local_bb5_st__109_inst0_read,
		output 		avm_local_bb5_st__109_inst0_write,
		input 		avm_local_bb5_st__109_inst0_writeack,
		output [255:0] 		avm_local_bb5_st__109_inst0_writedata,
		output [31:0] 		avm_local_bb5_st__109_inst0_byteenable,
		output [4:0] 		avm_local_bb5_st__109_inst0_burstcount,
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
		input [255:0] 		avm_local_bb8_ld__inst0_readdata,
		input 		avm_local_bb8_ld__inst0_readdatavalid,
		input 		avm_local_bb8_ld__inst0_waitrequest,
		output [29:0] 		avm_local_bb8_ld__inst0_address,
		output 		avm_local_bb8_ld__inst0_read,
		output 		avm_local_bb8_ld__inst0_write,
		input 		avm_local_bb8_ld__inst0_writeack,
		output [255:0] 		avm_local_bb8_ld__inst0_writedata,
		output [31:0] 		avm_local_bb8_ld__inst0_byteenable,
		output [4:0] 		avm_local_bb8_ld__inst0_burstcount,
		input [255:0] 		avm_local_bb8_st__52_inst0_readdata,
		input 		avm_local_bb8_st__52_inst0_readdatavalid,
		input 		avm_local_bb8_st__52_inst0_waitrequest,
		output [29:0] 		avm_local_bb8_st__52_inst0_address,
		output 		avm_local_bb8_st__52_inst0_read,
		output 		avm_local_bb8_st__52_inst0_write,
		input 		avm_local_bb8_st__52_inst0_writeack,
		output [255:0] 		avm_local_bb8_st__52_inst0_writedata,
		output [31:0] 		avm_local_bb8_st__52_inst0_byteenable,
		output [4:0] 		avm_local_bb8_st__52_inst0_burstcount
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
	.avm_local_bb3_ld__u2_readdata(avm_local_bb3_ld__u2_inst0_readdata),
	.avm_local_bb3_ld__u2_readdatavalid(avm_local_bb3_ld__u2_inst0_readdatavalid),
	.avm_local_bb3_ld__u2_waitrequest(avm_local_bb3_ld__u2_inst0_waitrequest),
	.avm_local_bb3_ld__u2_address(avm_local_bb3_ld__u2_inst0_address),
	.avm_local_bb3_ld__u2_read(avm_local_bb3_ld__u2_inst0_read),
	.avm_local_bb3_ld__u2_write(avm_local_bb3_ld__u2_inst0_write),
	.avm_local_bb3_ld__u2_writeack(avm_local_bb3_ld__u2_inst0_writeack),
	.avm_local_bb3_ld__u2_writedata(avm_local_bb3_ld__u2_inst0_writedata),
	.avm_local_bb3_ld__u2_byteenable(avm_local_bb3_ld__u2_inst0_byteenable),
	.avm_local_bb3_ld__u2_burstcount(avm_local_bb3_ld__u2_inst0_burstcount),
	.avm_local_bb3_ld__readdata(avm_local_bb3_ld__inst0_readdata),
	.avm_local_bb3_ld__readdatavalid(avm_local_bb3_ld__inst0_readdatavalid),
	.avm_local_bb3_ld__waitrequest(avm_local_bb3_ld__inst0_waitrequest),
	.avm_local_bb3_ld__address(avm_local_bb3_ld__inst0_address),
	.avm_local_bb3_ld__read(avm_local_bb3_ld__inst0_read),
	.avm_local_bb3_ld__write(avm_local_bb3_ld__inst0_write),
	.avm_local_bb3_ld__writeack(avm_local_bb3_ld__inst0_writeack),
	.avm_local_bb3_ld__writedata(avm_local_bb3_ld__inst0_writedata),
	.avm_local_bb3_ld__byteenable(avm_local_bb3_ld__inst0_byteenable),
	.avm_local_bb3_ld__burstcount(avm_local_bb3_ld__inst0_burstcount),
	.avm_local_bb5_ld__readdata(avm_local_bb5_ld__inst0_readdata),
	.avm_local_bb5_ld__readdatavalid(avm_local_bb5_ld__inst0_readdatavalid),
	.avm_local_bb5_ld__waitrequest(avm_local_bb5_ld__inst0_waitrequest),
	.avm_local_bb5_ld__address(avm_local_bb5_ld__inst0_address),
	.avm_local_bb5_ld__read(avm_local_bb5_ld__inst0_read),
	.avm_local_bb5_ld__write(avm_local_bb5_ld__inst0_write),
	.avm_local_bb5_ld__writeack(avm_local_bb5_ld__inst0_writeack),
	.avm_local_bb5_ld__writedata(avm_local_bb5_ld__inst0_writedata),
	.avm_local_bb5_ld__byteenable(avm_local_bb5_ld__inst0_byteenable),
	.avm_local_bb5_ld__burstcount(avm_local_bb5_ld__inst0_burstcount),
	.avm_local_bb5_st__109_readdata(avm_local_bb5_st__109_inst0_readdata),
	.avm_local_bb5_st__109_readdatavalid(avm_local_bb5_st__109_inst0_readdatavalid),
	.avm_local_bb5_st__109_waitrequest(avm_local_bb5_st__109_inst0_waitrequest),
	.avm_local_bb5_st__109_address(avm_local_bb5_st__109_inst0_address),
	.avm_local_bb5_st__109_read(avm_local_bb5_st__109_inst0_read),
	.avm_local_bb5_st__109_write(avm_local_bb5_st__109_inst0_write),
	.avm_local_bb5_st__109_writeack(avm_local_bb5_st__109_inst0_writeack),
	.avm_local_bb5_st__109_writedata(avm_local_bb5_st__109_inst0_writedata),
	.avm_local_bb5_st__109_byteenable(avm_local_bb5_st__109_inst0_byteenable),
	.avm_local_bb5_st__109_burstcount(avm_local_bb5_st__109_inst0_burstcount),
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
	.avm_local_bb8_ld__readdata(avm_local_bb8_ld__inst0_readdata),
	.avm_local_bb8_ld__readdatavalid(avm_local_bb8_ld__inst0_readdatavalid),
	.avm_local_bb8_ld__waitrequest(avm_local_bb8_ld__inst0_waitrequest),
	.avm_local_bb8_ld__address(avm_local_bb8_ld__inst0_address),
	.avm_local_bb8_ld__read(avm_local_bb8_ld__inst0_read),
	.avm_local_bb8_ld__write(avm_local_bb8_ld__inst0_write),
	.avm_local_bb8_ld__writeack(avm_local_bb8_ld__inst0_writeack),
	.avm_local_bb8_ld__writedata(avm_local_bb8_ld__inst0_writedata),
	.avm_local_bb8_ld__byteenable(avm_local_bb8_ld__inst0_byteenable),
	.avm_local_bb8_ld__burstcount(avm_local_bb8_ld__inst0_burstcount),
	.avm_local_bb8_st__52_readdata(avm_local_bb8_st__52_inst0_readdata),
	.avm_local_bb8_st__52_readdatavalid(avm_local_bb8_st__52_inst0_readdatavalid),
	.avm_local_bb8_st__52_waitrequest(avm_local_bb8_st__52_inst0_waitrequest),
	.avm_local_bb8_st__52_address(avm_local_bb8_st__52_inst0_address),
	.avm_local_bb8_st__52_read(avm_local_bb8_st__52_inst0_read),
	.avm_local_bb8_st__52_write(avm_local_bb8_st__52_inst0_write),
	.avm_local_bb8_st__52_writeack(avm_local_bb8_st__52_inst0_writeack),
	.avm_local_bb8_st__52_writedata(avm_local_bb8_st__52_inst0_writedata),
	.avm_local_bb8_st__52_byteenable(avm_local_bb8_st__52_inst0_byteenable),
	.avm_local_bb8_st__52_burstcount(avm_local_bb8_st__52_inst0_burstcount),
	.start(start_out),
	.input_subarr_size(kernel_arguments_NO_SHIFT_REG[191:160]),
	.input_num_of_elements(kernel_arguments_NO_SHIFT_REG[159:128]),
	.input_data(kernel_arguments_NO_SHIFT_REG[63:0]),
	.clock2x(clock2x),
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

