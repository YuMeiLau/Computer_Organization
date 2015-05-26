`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:34:32 04/30/2015 
// Design Name: 
// Module Name:    ALU_P1 
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
module ALU_P1(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

reg Ainvert, Binvert; // The input signals of 32 alu units.
reg cin; // The carryin signal for the 1st alu.
reg set; // The input signal "less" for the 1st alu.
reg [2-1:0] operation; 
wire [32-1:0] carry; // The 32-bit carry, combined by the carry from each bit operation.
wire [32-1:0] rresult; // The output signals of result.
wire [32-1:0] equal; // if (1b'c - 1b'd == 0),equal will be zero. So if 32-bit A equals 32-bit B, equal should be 32-bit 0.

//32 ALU units;
alu_top alu0(src1[0], src2[0], set, Ainvert, Binvert, 	  cin, operation, rresult[0], carry[0], equal[0]);
alu_top alu1(src1[1], src2[1], 	0, Ainvert, Binvert, carry[0], operation, rresult[1], carry[1], equal[1]);
alu_top alu2(src1[2], src2[2], 	0, Ainvert, Binvert, carry[1], operation, rresult[2], carry[2], equal[2]);
alu_top alu3(src1[3], src2[3], 	0, Ainvert, Binvert, carry[2], operation, rresult[3], carry[3], equal[3]);

alu_top alu4(src1[4], src2[4], 0, Ainvert, Binvert, carry[3], operation, rresult[4], carry[4], equal[4]);
alu_top alu5(src1[5], src2[5], 0, Ainvert, Binvert, carry[4], operation, rresult[5], carry[5], equal[5]);
alu_top alu6(src1[6], src2[6], 0, Ainvert, Binvert, carry[5], operation, rresult[6], carry[6], equal[6]);
alu_top alu7(src1[7], src2[7], 0, Ainvert, Binvert, carry[6], operation, rresult[7], carry[7], equal[7]);

alu_top  alu8( src1[8],  src2[8], 0, Ainvert, Binvert,  carry[7], operation,  rresult[8],  carry[8],  equal[8]);
alu_top  alu9( src1[9],  src2[9], 0, Ainvert, Binvert,  carry[8], operation,  rresult[9],  carry[9],  equal[9]);
alu_top alu10(src1[10], src2[10], 0, Ainvert, Binvert,  carry[9], operation, rresult[10], carry[10], equal[10]);
alu_top alu11(src1[11], src2[11], 0, Ainvert, Binvert, carry[10], operation, rresult[11], carry[11], equal[11]);

alu_top alu12(src1[12], src2[12], 0, Ainvert, Binvert, carry[11], operation, rresult[12], carry[12], equal[12]);
alu_top alu13(src1[13], src2[13], 0, Ainvert, Binvert, carry[12], operation, rresult[13], carry[13], equal[13]);
alu_top alu14(src1[14], src2[14], 0, Ainvert, Binvert, carry[13], operation, rresult[14], carry[14], equal[14]);
alu_top alu15(src1[15], src2[15], 0, Ainvert, Binvert, carry[14], operation, rresult[15], carry[15], equal[15]);

alu_top alu16(src1[16], src2[16], 0, Ainvert, Binvert, carry[15], operation, rresult[16], carry[16], equal[16]);
alu_top alu17(src1[17], src2[17], 0, Ainvert, Binvert, carry[16], operation, rresult[17], carry[17], equal[17]);
alu_top alu18(src1[18], src2[18], 0, Ainvert, Binvert, carry[17], operation, rresult[18], carry[18], equal[18]);
alu_top alu19(src1[19], src2[19], 0, Ainvert, Binvert, carry[18], operation, rresult[19], carry[19], equal[19]);

alu_top alu20(src1[20], src2[20], 0, Ainvert, Binvert, carry[19], operation, rresult[20], carry[20], equal[20]);
alu_top alu21(src1[21], src2[21], 0, Ainvert, Binvert, carry[20], operation, rresult[21], carry[21], equal[21]);
alu_top alu22(src1[22], src2[22], 0, Ainvert, Binvert, carry[21], operation, rresult[22], carry[22], equal[22]);
alu_top alu23(src1[23], src2[23], 0, Ainvert, Binvert, carry[22], operation, rresult[23], carry[23], equal[23]);

alu_top alu24(src1[24], src2[24], 0, Ainvert, Binvert, carry[23], operation, rresult[24], carry[24], equal[24]);
alu_top alu25(src1[25], src2[25], 0, Ainvert, Binvert, carry[24], operation, rresult[25], carry[25], equal[25]);
alu_top alu26(src1[26], src2[26], 0, Ainvert, Binvert, carry[25], operation, rresult[26], carry[26], equal[26]);
alu_top alu27(src1[27], src2[27], 0, Ainvert, Binvert, carry[26], operation, rresult[27], carry[27], equal[27]);

alu_top alu28(src1[28], src2[28], 0, Ainvert, Binvert, carry[27], operation, rresult[28], carry[28], equal[28]);
alu_top alu29(src1[29], src2[29], 0, Ainvert, Binvert, carry[28], operation, rresult[29], carry[29], equal[29]);
alu_top alu30(src1[30], src2[30], 0, Ainvert, Binvert, carry[29], operation, rresult[30], carry[30], equal[30]);
alu_top alu31(src1[31], src2[31], 0, Ainvert, Binvert, carry[30], operation, rresult[31], carry[31], equal[31]);

always @ (*) //result, zero, carryout, overflow
begin
	result <= rresult;
	if(rresult == 32'b0) zero <= 1'b1; else zero <= 1'b0;
	if(carry[31] == 1'b1) 
	begin
		if(ALU_control != 4'b0111) cout <= 1'b1; // except the slt since the cout doesn't matter.
		else cout <= 1'b0;
	end
	else cout <= 1'b0;
	case(ALU_control)
		4'b0010: // +
		begin
			if(src1[31] == 1'b0 && src2[31] == 1'b0 && rresult[31] == 1'b1) // (+ve) + (+ve)
				overflow <= 1'b1;
			else if(src1[31] == 1'b1 && src2[31] == 1'b1 && rresult[31] == 1'b0) // (-ve) + (-ve)
				overflow <= 1'b1;
			else 
				overflow <= 1'b0;
		end		
		4'b0110: // -
		begin
			if(src1[31] == 1'b0 && src2[31] == 1'b1 && rresult[31] == 1'b1) //(+ve) - (-ve)
				overflow <= 1'b1;
			else if(src1[31] == 1'b1 && src2[31] == 1'b0 && rresult[31] == 1'b0) // (-ve) - (+ve)
				overflow <= 1'b1;
			else 
				overflow <= 1'b0;			
		end		
		default: overflow <= 1'b0;
	endcase
	if(ALU_control == 4'b0111) // (src1[31] ^ (~src2[31]) ^ carry[30]) is result[31], the sign bit.
	begin
		case(bonus_control)
		3'b000: // slt
		begin
			if(src1[31] ^ (~src2[31]) ^ carry[30] == 1'b1) set <= 1'b1;
			else set <= 1'b0;
		end
		3'b001: // sgt
		begin
			if(src1[31] ^ (~src2[31]) ^ carry[30] == 1'b0 && equal != 32'b0) set <= 1'b1;
			else set <= 1'b0;
		end
		3'b010: // sle
			if(src1[31] ^ (~src2[31]) ^ carry[30] == 1'b1 || equal == 32'b0) set <= 1'b1;
			else set <= 1'b0;
		3'b011: // sge
			if(src1[31] ^ (~src2[31]) ^ carry[30] == 1'b0) set <= 1'b1;
			else set <= 1'b0;
		3'b110: // seq
			if(equal == 32'b0) set <= 1'b1;
			else set <= 1'b0;
		3'b100: // sne
			if(equal != 32'b0) set <= 1'b1;
			else set <= 1'b0;
		default: set <= 1'b0;
		endcase
	end
	else set <= 1'b0;
end

always @ (*)
begin
if(rst_n == 1'b1)
	begin
	case(ALU_control)
	4'b0000: // And
		begin
			Ainvert <= 1'b0;
			Binvert <= 1'b0;
			cin <= 1'b0;
			operation <= 2'b00;
		end
	4'b0001: // Or
		begin
			Ainvert <= 1'b0;
			Binvert <= 1'b0;
			cin <= 1'b0;
			operation <= 2'b01;
		end
	4'b0010: // Add
		begin
			Ainvert <= 1'b0;
			Binvert <= 1'b0;
			cin <= 1'b0;
			operation <= 2'b10;
		end
	4'b0110: // Sub
		begin
			Ainvert <= 1'b0;
			Binvert <= 1'b1;
			cin <= 1'b1;
			operation <= 2'b10;
		end
	4'b1100: // Nor
		begin
			Ainvert <= 1'b1;
			Binvert <= 1'b1;
			cin <= 1'b0;
			operation <= 2'b00;
		end
	4'b1101: // Nand
		begin
			Ainvert <= 1'b1;
			Binvert <= 1'b1;
			cin <= 1'b0;
			operation <= 2'b01;	
		end
	4'b0111: // Slt && ..
		begin
			Ainvert <= 1'b0;
			Binvert <= 1'b1;
			cin <= 1'b1;
			operation <= 2'b11;
		end
	endcase
end
end

endmodule
