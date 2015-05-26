`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:45:07 04/16/2015 
// Design Name: 
// Module Name:    Simple_Single_CPU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles


//Greate componentes
wire [31:0] pc_in_i;
wire [31:0] pc_out_o;
//assign pc_in_i = pc_source;
wire [31:0] pc_next;	
wire [31:0] instr;	
wire [4:0] WriteReg;
wire [31:0] RSdata;
wire [31:0] RTdata;		
wire [4:0]  RSaddr;
wire [4:0]  RTaddr;
wire [4:0]  RDaddr;
assign RSaddr = instr[25:21];
assign RTaddr = instr[20:16];
assign RDaddr = instr[15:11];
wire ALUSrc;
wire branch;
wire RegWrite;
wire RegDst;
wire [2:0] ALUop;	
wire [3:0] ALUCtrl;
wire [5:0] funct;
assign funct = instr[5:0];
wire [15:0] imme;
wire [31:0] sign_extend;
assign imme = instr[15:0];	
wire [31:0] operand_2;
wire zero;	
wire [31:0] result;
wire [31:0] branch_offset;	
wire [31:0] branch_address;	
wire [31:0] pc_source;
wire pc_source_ctrl;
assign pc_source_ctrl = (branch & branch_result); //////////////advanced set2;
wire [5:0] instr_op;
assign instr_op = instr[31:26];
wire [4:0] shamt;
assign shamt = instr[10:6];

////////////////////////////////////////
wire [1:0] jump; //////////advanced set 1;
wire mem_read;
wire mem_write;
wire [1:0] mem_to_reg;
wire [25:0] jump_source;
assign jump_source = instr[25:0];
wire [3:0]  jump_partial_1;
assign jump_partial_1 = instr[31:28];
wire [27:0] jump_partial_2;
wire [31:0] jump_address;
assign jump_address = {jump_partial_1, jump_partial_2};
wire [31:0] RDdata;
wire [31:0] Readdata;

////////////////////////////////////////
wire is_jal;
wire [5-1:0] WriteReg_Advanced;
wire [31:0]  RDdata_Advanced;

///////////////////////////////////////
wire [1:0] branch_type;
wire branch_result;

ProgramCounter PC(
       .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in_i) ,   
	    .pc_out_o(pc_out_o) 
	    );


Adder Adder1(
        .src1_i(32'd4),     
	     .src2_i(pc_out_o),     
	     .sum_o(pc_next)    
	    );


Instr_Memory IM(
        .addr_i(pc_out_o),  
	     .instr_o(instr)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(RTaddr),
        .data1_i(RDaddr),
        .select_i(RegDst),
        .data_o(WriteReg)
        );	

MUX_2to1 #(.size(5)) Mux_Write_Reg_Advanced( // for jal;
        .data0_i(WriteReg),
        .data1_i(5'b1_1111),
        .select_i(is_jal),
        .data_o(WriteReg_Advanced)
        );	
		  
Reg_File RF(
        .clk_i(clk_i),      
	     .rst_i(rst_i) ,     
        .RSaddr_i(RSaddr) ,  
        .RTaddr_i(RTaddr) ,  
        .RDaddr_i(WriteReg_Advanced) ,  
        .RDdata_i(RDdata_Advanced)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)   
        );

Decoder Decoder(
        .instr_op_i(instr_op), 
		  .funct_i(funct),
	     .RegWrite_o(RegWrite), 
	     .ALU_op_o(ALUop),   
	     .ALUSrc_o(ALUSrc),   
	     .RegDst_o(RegDst),   
		  .Branch_o(branch),
		  .Jump_o(jump),
		  .is_jal(is_jal),
		  .MemRead_o(mem_read),
		  .MemWrite_o(mem_write),
		  .MemtoReg_o(mem_to_reg),
		  .branch_type(branch_type)
	    );

ALU_Ctrl AC(
        .funct_i(funct),   
        .ALUOp_i(ALUop),   
        .ALUCtrl_o(ALUCtrl) 
        );

Sign_Extend SE(
        .data_i(imme),
        .data_o(sign_extend)
        );


MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RTdata),
        .data1_i(sign_extend),
        .select_i(ALUSrc),
        .data_o(operand_2)
        );	

ALU ALU(
        .src1_i(RSdata),
	     .src2_i(operand_2),
	     .ctrl_i(ALUCtrl),
		  .shamt(shamt),
	     .result_o(result),
		  .zero_o(zero)
	    );

Adder Adder2(
        .src1_i(pc_next),     
	     .src2_i(branch_offset),     
	     .sum_o(branch_address)      
	    );

		
Shift_Left_Two_32 #(.size(32)) Shifter_1(
        .data_i(sign_extend),
        .data_o(branch_offset)
        ); 		

Shift_Left_Two_32 #(.size(28)) Shifter_2(
        .data_i(jump_source),
        .data_o(jump_partial_2)
        ); 	

MUX_4to1 #(.size(1)) Branch_Result(
		  .data0_i(zero),
		  .data1_i(!(zero || !result[31])),
		  .data2_i(!result[31]),
		  .data3_i(!zero),
		  .select_i(branch_type),
		  .data_o(branch_result)
        );				
		  
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_next),
        .data1_i(branch_address),
        .select_i(pc_source_ctrl),
        .data_o(pc_source)
        );	

MUX_3to1 #(.size(32)) Mux_PC_Source_Advanced( // for jr
        .data0_i(pc_source),
        .data1_i(jump_address),
		  .data2_i(RSdata), // jr operation;
        .select_i(jump),
        .data_o(pc_in_i)
        );	

MUX_3to1 #(.size(32)) Mux_RDdata_Source(
		  .data0_i(result),
        .data1_i(Readdata),
		  .data2_i(sign_extend),
        .select_i(mem_to_reg),
        .data_o(RDdata)
		  );
		  
MUX_2to1 #(.size(32)) Mux_RDdata_Source_Advanced( // for jal;
        .data0_i(RDdata),
        .data1_i(pc_next),
        .select_i(is_jal),
        .data_o(RDdata_Advanced)
        );	
		  
Data_Memory Data_Memory(
		  .clk_i(clk_i),
		  .addr_i(result),
		  .data_i(RTdata),
		  .MemRead_i(mem_read),
		  .MemWrite_i(mem_write),
		  .data_o(Readdata)
		  );
endmodule
		  


