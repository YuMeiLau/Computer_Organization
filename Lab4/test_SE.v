`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:31:19 04/30/2015
// Design Name:   Sign_Extend
// Module Name:   D:/IISSEE/Workspace/Project_2/test_SE.v
// Project Name:  Project_2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Sign_Extend
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_SE;

	// Inputs
	reg [15:0] data_i;

	// Outputs
	wire [31:0] data_o;

	// Instantiate the Unit Under Test (UUT)
	Sign_Extend uut (
		.data_i(data_i), 
		.data_o(data_o)
	);

	initial begin
		// Initialize Inputs
		data_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		data_i = 16'b0000_0000_0000_0101;
		
		#200;
		data_i = 16'b1000_0000_0000_0101;

	end
      
endmodule

