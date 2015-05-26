`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:49 04/16/2015 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	shamt,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]  src2_i;
input  [4:0]     shamt;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
reg             zero_o;

wire    zero;
wire    [31:0] result_cal;
wire    [31:0] result_shift;


wire cout;
wire overflow;

reg  [32-1:0]  src1;
reg  [32-1:0]	 src2;
reg [4-1:0]   ctrl;
//Parameter

//Main function
always @ (*)
begin 
  src1 <= src1_i;
  src2 <= src2_i;
  ctrl <= ctrl_i;
end

ALU_P1 ALU_P1_I(1'b1, src1, src2, ctrl, 3'b000, result_cal, zero, cout, overflow);
Shift_Cal Shifter_1(src1, src2, ctrl, shamt, result_shift);

always @ (*)
case (ctrl_i)
	4'b0011: begin result_o <= result_shift;        zero_o <= zero;  end
	4'b0100: begin result_o <= result_shift;        zero_o <= zero;  end
	4'b0101: begin result_o <= result_shift * src2; zero_o <= zero;  end
//	4'b1001: begin result_o <= result_cal;          zero_o <= ~zero; end
   4'b1001: begin result_o <= $signed(src1) * $signed(src2); zero_o <= zero; end
	default: begin result_o <= result_cal;          zero_o <= zero;  end
endcase

endmodule