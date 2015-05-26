`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:34:21 04/30/2015
// Design Name:   Shift_Left_Two_32
// Module Name:   D:/IISSEE/Workspace/Project_2/test_Shifter.v
// Project Name:  Project_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Shift_Left_Two_32
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_Shifter;

	// Inputs
	reg [31:0] data_i;

	// Outputs
	wire [31:0] data_o;

	// Instantiate the Unit Under Test (UUT)
	Shift_Left_Two_32 uut (
		.data_i(data_i), 
		.data_o(data_o)
	);

	initial begin
		// Initialize Inputs
		data_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		data_i = 'd4;
		
		#100;
		data_i = 'd16;

	end
      
endmodule

