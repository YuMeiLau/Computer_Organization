`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:17:26 04/30/2015 
// Design Name: 
// Module Name:    Shift_Cal 
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
module Shift_Cal(
	 src1, 
	 src2, 
	 ctrl, 
	 shamt, 
	 result
    );

input [31:0] src1;
input [31:0] src2;
input [3:0]  ctrl;
input [4:0]  shamt;
output [31:0] result;

reg [31:0] result;

always @ (*)
case(ctrl)
  4'b0011: result = src2 >> shamt;
  4'b0100: result = src2 >> src1;
  4'b0101: result = 1 << 16;
endcase
endmodule
