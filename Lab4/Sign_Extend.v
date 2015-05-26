`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:54:34 04/16/2015 
// Design Name: 
// Module Name:    Sign_Extend 
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
module Sign_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended
always @ (*)
begin
	if(data_i[15])
		data_o <= {16'b1111_1111_1111_1111, data_i};
	else
		data_o <= {16'b0000_0000_0000_0000, data_i};
end          
endmodule      
     