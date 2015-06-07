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
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o,
	);
     
//I/O ports
input  [6-1:0] instr_op_i;


output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output	      MemRead_o;
output	      MemWrite_o;
output 		   MemtoReg_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg	      	MemRead_o;
reg	     	   MemWrite_o;
reg    	MemtoReg_o;


//Parameter
parameter RFormat = 'h0;
parameter addi    = 'h8;
parameter slti    = 'ha;
parameter beq     = 'h4;
parameter lw      = 6'b100011;
parameter sw      = 6'b101011;


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
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 1'b0;
					end
		addi:    begin
						ALU_op_o <= 3'b000; // to add; (lw / sw) 
						ALUSrc_o <= 1'b1; 
						RegWrite_o <= 1'b1; 
						RegDst_o <= 1'b0; 
						Branch_o <= 1'b0;
					
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 1'b0;
						
					end
		slti:    begin
						ALU_op_o <= 3'b011; // to slt; 
						ALUSrc_o <= 1'b1; 
						RegWrite_o <= 1'b1; 
						RegDst_o <= 1'b0; 
						Branch_o <= 1'b0;
						
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 1'b0;
					end
		beq:     begin
						ALU_op_o <= 3'b001; // to sub;
						ALUSrc_o <= 1'b0; 
						RegWrite_o <= 1'b0; 
						RegDst_o <= 1'b0; // gaozutai? 
						Branch_o <= 1'b1;
						
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 1'b0;
						
					end
		lw:		begin
						ALU_op_o <= 3'b000; // to add;
						ALUSrc_o <= 1'b1; 
						RegWrite_o <= 1'b1;  
						RegDst_o <= 1'b0; 
						Branch_o <= 1'b0;
						
						MemRead_o <= 1'b1;
						MemWrite_o <= 1'b0;
						MemtoReg_o <= 1'b1;
						
					end
		sw:		begin
						ALU_op_o <= 3'b000; // to add;
						ALUSrc_o <= 1'b1; 
						RegWrite_o <= 1'b0;  
						RegDst_o <= 1'b0; // X
						Branch_o <= 1'b0;
					
						MemRead_o <= 1'b0;
						MemWrite_o <= 1'b1;
						MemtoReg_o <= 1'b0; // X
						
					end	
	endcase
end
endmodule

