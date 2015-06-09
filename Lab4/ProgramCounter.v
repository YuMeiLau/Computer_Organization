`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:50:06 04/16/2015 
// Design Name: 
// Module Name:    ProgramCounter 
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
module ProgramCounter(
    clk_i,
	rst_i,
	enable_i,
	pc_in_i,
	pc_out_o
	);
     
//I/O ports
input           clk_i;
input	        rst_i;
input         enable_i;
input  [32-1:0] pc_in_i;
output [32-1:0] pc_out_o;
 
//Internal Signals
reg    [32-1:0] pc_out_o;
 
//Parameter

    
//Main function
always @(posedge clk_i) begin
    if(~rst_i)
	    pc_out_o <= 0;
	else
		begin
		if(enable_i)
	    pc_out_o <= pc_in_i;
		else 
		 pc_out_o <= pc_out_o;
		end
end

endmodule
