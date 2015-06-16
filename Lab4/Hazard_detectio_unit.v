`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:18:00 06/09/2015 
// Design Name: 
// Module Name:    Hazard_detectio_unit 
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
module Hazard_detection_unit(
	 id_ex_rt,
	 if_id_rs,
	 if_id_rt,
	 id_ex_memread,
//	 branch_hazard,
	 hazard
    );
	 
input [4:0] id_ex_rt;
input [4:0] if_id_rs;
input [4:0] if_id_rt;
input id_ex_memread;
output hazard;

reg hazard;

always @ (*)
begin
	if(id_ex_memread && ((id_ex_rt == if_id_rs) || (id_ex_rt == if_id_rt))) //|| branch_hazard	
		hazard <= 1'b1;
	else hazard <= 1'b0;
end


endmodule
