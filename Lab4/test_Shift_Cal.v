`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:33:49 04/30/2015
// Design Name:   Shift_Cal
// Module Name:   D:/IISSEE/Workspace/Project_2_Plus/test_Shift_Cal.v
// Project Name:  Project_2_Plus
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Shift_Cal
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_Shift_Cal;

	// Inputs
	reg [31:0] src1;
	reg [31:0] src2;
	reg [3:0] ctrl;
	reg [4:0] shamt;

	// Outputs
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	Shift_Cal uut (
		.src1(src1), 
		.src2(src2), 
		.ctrl(ctrl), 
		.shamt(shamt), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		src1 = 0;
		src2 = 0;
		ctrl = 0;
		shamt = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		src1 = 0;
		src2 = 32'b3;
		ctrl = 0;
		shamt = 0;

	end
      
endmodule

