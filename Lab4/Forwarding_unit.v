`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:42:00 06/08/2015 
// Design Name: 
// Module Name:    Forwarding_unit 
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
module Forwarding_unit(
	 id_ex_rs,
	 id_ex_rt,
	 ex_mem_rd,
	 mem_wb_rd,
	 ex_mem_regwrite,
	 mem_wb_regwrite,
	 forward_A, //rs
	 forward_B  //rt
    );

input [4:0] id_ex_rs;
input [4:0] id_ex_rt;
input [4:0] ex_mem_rd;
input [4:0] mem_wb_rd;
input   	   ex_mem_regwrite;
input   	   mem_wb_regwrite;
output [1:0]	   forward_A; //rs
output [1:0]	   forward_B;  //rt

reg [1:0]	   forward_A; //rs
reg [1:0]	   forward_B;  //rt

//EX hazard;
always @ (*)
begin
	if(ex_mem_regwrite && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rs)) 
		forward_A <= 2'b01;
	else if(ex_mem_regwrite && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rt)) 
		forward_B <= 2'b01;
	else if(mem_wb_regwrite && (mem_wb_rd != 0) && (mem_wb_rd == id_ex_rs))
		forward_A <= 2'b10;
	else if(mem_wb_regwrite && (mem_wb_rd != 0) && (mem_wb_rd == id_ex_rt))
		forward_B <= 2'b10;
	else
		begin
		forward_A <= 2'b00;
		forward_B <= 2'b00;
		end
end

endmodule
