`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:47:33 04/16/2015 
// Design Name: 
// Module Name:    Decoder 
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
module Decoder(
    instr_op_i,
	 funct_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	Jump_o,
	is_jal,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o,
	branch_type
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
input  [6-1:0] funct_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output [2-1:0]	Jump_o;
output         is_jal;
output	      MemRead_o;
output	      MemWrite_o;
output [1:0]   MemtoReg_o;
output [1:0]   branch_type;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg   [2-1:0]	Jump_o;
reg            is_jal;
reg	      	MemRead_o;
reg	     	   MemWrite_o;
reg [1:0]   	MemtoReg_o;
reg [1:0]      branch_type;

//Parameter
parameter RFormat = 'h0;
parameter addi    = 'h8;
parameter slti    = 'ha;
parameter beq     = 'h4;
parameter lui     = 'hf;
parameter ori     = 'hd;
parameter bne     = 'h5;
parameter lw      = 6'b100011;
parameter sw      = 6'b101011;
parameter jump    = 6'b000010;
parameter jal     = 6'b000011;
parameter blt     = 'd6;
parameter bnez    = 'd5;
parameter bgez    = 'd1;

parameter jr      = 6'b001000;

//Main function
always @(*)
begin
	case(instr_op_i)
		RFormat: begin
						ALU_op_o <= 3'b010; // RFormat, depending on functions;
						ALUSrc_o <= 1'b0; 
						RegWrite_o <= 1'b1; 
						RegDst_o <= 1'b1; 
						Branch_o <= 1'b0;
						//Jump_o   <= 1'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						if(funct_i == jr) Jump_o <= 2'b10;
						else Jump_o <= 2'b00;
						is_jal <= 1'b0;
						branch_type <= 2'b00; // don't care;
					end
		addi:    begin
						ALU_op_o <= 3'b000; // to add; (lw / sw) 
						ALUSrc_o <= 1'b1; 
						RegWrite_o <= 1'b1; 
						RegDst_o <= 1'b0; 
						Branch_o <= 1'b0;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						is_jal <= 1'b0;
						branch_type <= 2'b00; // don't care;
					end
		slti:    begin
						ALU_op_o <= 3'b011; // to slt; 
						ALUSrc_o <= 1'b1; 
						RegWrite_o <= 1'b1; 
						RegDst_o <= 1'b0; 
						Branch_o <= 1'b0;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						is_jal <= 1'b0;
						branch_type <= 2'b00; // don't care;
					end
		beq:     begin
						ALU_op_o <= 3'b001; // to sub;
						ALUSrc_o <= 1'b0; 
						RegWrite_o <= 1'b0; 
						RegDst_o <= 1'b0; // gaozutai? 
						Branch_o <= 1'b1;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						is_jal <= 1'b0;
						branch_type <= 2'b00; 
					end
		lui:     begin
						ALU_op_o <= 3'b100; // to shiftleft by 16bit;
						ALUSrc_o <= 1'b1; // immediate;
						RegWrite_o <= 1'b1; 
						RegDst_o <= 1'b0; // rt;
						Branch_o <= 1'b0;
												Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						is_jal <= 1'b0;
						branch_type <= 2'b00; // don't care;
					end
		ori:     begin
						ALU_op_o <= 3'b101; // to get or;
						ALUSrc_o <= 1'b1; // immediate;
						RegWrite_o <= 1'b1;  
						RegDst_o <= 1'b0; // rt;
						Branch_o <= 1'b0;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						is_jal <= 1'b0;
						branch_type <= 2'b00; // don't care;
					end
		bne:     begin
						ALU_op_o <= 3'b001; // to sub;
						ALUSrc_o <= 1'b0; // readdata2;
						RegWrite_o <= 1'b0;  
						RegDst_o <= 1'b0; // gaozutai?
						Branch_o <= 1'b1;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						is_jal <= 1'b0;
						branch_type <= 2'b11;
					end
		lw:		begin
						ALU_op_o <= 3'b000; // to add;
						ALUSrc_o <= 1'b1; 
						RegWrite_o <= 1'b1;  
						RegDst_o <= 1'b0; 
						Branch_o <= 1'b0;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b1;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b01;
						is_jal <= 1'b0;
						branch_type <= 2'b00; // don't care;
					end
		sw:		begin
						ALU_op_o <= 3'b000; // to add;
						ALUSrc_o <= 1'b1; 
						RegWrite_o <= 1'b0;  
						RegDst_o <= 1'b0; // X
						Branch_o <= 1'b0;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b1;
						MemtoReg_o <= 2'b0; // X
						is_jal <= 1'b0;
						branch_type <= 2'b00; // don't care;
					end	
		jump:		begin
						ALU_op_o <= 3'b000; // X;
						ALUSrc_o <= 1'b0; // X
						RegWrite_o <= 1'b0;  
						RegDst_o <= 1'b0; // X
						Branch_o <= 1'b0;
						Jump_o   <= 2'b01;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b00; // X
						is_jal <= 1'b0;
						branch_type <= 2'b00; // don't care;
					end
      jal:		begin
						ALU_op_o <= 3'b000; // X;
						ALUSrc_o <= 1'b0; // X
						RegWrite_o <= 1'b1; // reg[31]; 
						RegDst_o <= 1'b0; // X
						Branch_o <= 1'b0;
						Jump_o   <= 2'b01; // jump to the corresponding address.
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b00; // X
						is_jal <= 1'b1;
						branch_type <= 2'b00; // don't care;
					end
		blt:     begin
						ALU_op_o <= 3'b001; // to sub;
						ALUSrc_o <= 1'b0; 
						RegWrite_o <= 1'b0; 
						RegDst_o <= 1'b0; // don't care;
						Branch_o <= 1'b1;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						is_jal <= 1'b0;
						branch_type <= 2'b01; 
					end 
		bnez:    begin
						ALU_op_o <= 3'b001; // to sub;
						ALUSrc_o <= 1'b0; 
						RegWrite_o <= 1'b0; 
						RegDst_o <= 1'b0; // don't care;
						Branch_o <= 1'b1;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						is_jal <= 1'b0;
						branch_type <= 2'b11; // same as bne;
					end 
		bgez:    begin
						ALU_op_o <= 3'b001; // to sub;
						ALUSrc_o <= 1'b0; 
						RegWrite_o <= 1'b0; 
						RegDst_o <= 1'b0; // don't care;
						Branch_o <= 1'b1;
						Jump_o   <= 2'b0;
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 2'b0;
						is_jal <= 1'b0;
						branch_type <= 2'b10; // same as bne;
					end 
	endcase
end
endmodule

