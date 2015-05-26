`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:46:08 04/16/2015 
// Design Name: 
// Module Name:    ALU_Ctrl 
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
module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
// funct_i parameter; of RFormat;
parameter add     = 'h20;
parameter sub     = 'h22;
parameter and_    = 'h24;
parameter or_     = 'h25;
parameter slt_    = 'h42;
parameter sr_     = 'h2;
parameter srv_    = 'h6;
parameter jr      = 6'b001000;
parameter mul     = 'd24;

// ALUop_i parameter; of IFormat
parameter RFormat = 3'b010;
parameter addop   = 3'b000;
parameter subop   = 3'b001;
parameter sltop   = 3'b011; 
parameter lui     = 3'b100;
parameter ori     = 3'b101;
parameter mul_    = 3'b110;
//parameter bne     = 3'b110;

     
//Select exact operation
always @ (*)
begin
	case(ALUOp_i)
		RFormat: begin
						case(funct_i)
							add:  ALUCtrl_o <= 4'b0010;
							sub:  ALUCtrl_o <= 4'b0110;
							and_: ALUCtrl_o <= 4'b0000;
							or_:  ALUCtrl_o <= 4'b0001;
							slt_: ALUCtrl_o <= 4'b0111;
							sr_:  ALUCtrl_o <= 4'b0011;
							srv_: ALUCtrl_o <= 4'b0100;
							jr:   ALUCtrl_o <= 4'b0000;
							mul:  ALUCtrl_o <= 4'b1001;
							default: ALUCtrl_o <= 4'b0000;
						endcase
					end
		addop:   ALUCtrl_o <= 4'b0010;
		subop:   ALUCtrl_o <= 4'b0110;
		sltop:   ALUCtrl_o <= 4'b0111;
		lui:     ALUCtrl_o <= 4'b0101;
		ori:     ALUCtrl_o <= 4'b0001; // do or;
		mul_:    ALUCtrl_o <= 4'b1001;
//		bne:     ALUCtrl_o <= 4'b1001;
		default: ALUCtrl_o <= 4'b0000;
	endcase
end

endmodule     