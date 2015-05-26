`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:11:02 04/30/2015
// Design Name:   ALU
// Module Name:   D:/IISSEE/Workspace/Project_2/test_ALU.v
// Project Name:  Project_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_ALU;

	// Inputs
	reg [31:0] src1_i;
	reg [31:0] src2_i;
	reg [3:0] ctrl_i;

	// Outputs
	wire [31:0] result_o;
	wire zero_o;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.src1_i(src1_i), 
		.src2_i(src2_i), 
		.ctrl_i(ctrl_i), 
		.result_o(result_o), 
		.zero_o(zero_o)
	);

	initial begin
		// Initialize Inputs
		src1_i = 0;
		src2_i = 0;
		ctrl_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		src1_i = 'd32;
		src2_i = 'd45;
		ctrl_i = 4'b0010;

	end
      
endmodule

