`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2011 
// Design Name: 
// Module Name:    alu_top 

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

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
					equal
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;
output 		  equal;

reg           result;
reg           cout;
reg 			  tmp1, tmp2;
reg 			  equal;


always@( * )
begin
	if(A_invert) tmp1 = ~src1;
	else tmp1 = src1;
	if(B_invert) tmp2 = ~src2;
	else tmp2 = src2;
	case(operation)
		2'b00: begin
					result = tmp1 & tmp2; 
					cout = 1'b0;
					equal = 1'b1;
				 end
		2'b01: begin
					result = tmp1 | tmp2; 
					cout = 1'b0;
					equal = 1'b1;
				 end
		2'b10: begin
					result = tmp1 ^ tmp2 ^ cin;
					cout = (tmp1 & tmp2) | (tmp1 & cin) | (tmp2 & cin);
					equal = 1'b1;
				 end
		3'b11: begin
					if(less) result = 1'b1;
					else result = 1'b0;
					cout = (tmp1 & tmp2) | (tmp1 & cin) | (tmp2 & cin);
					if(tmp1 ^ tmp2 ^ cin == 1'b0) equal = 1'b0;
					else equal = 1'b1;
				 end
	endcase
end

endmodule
