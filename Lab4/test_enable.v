`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:40:31 06/09/2015
// Design Name:   Pipe_Reg
// Module Name:   D:/IISSEE/Workspace/Project_4/test_enable.v
// Project Name:  Project_4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Pipe_Reg
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_enable;

	// Inputs
	reg clk_i;
	reg rst_i;
	reg enable_i;
	reg data_i;

	// Outputs
	wire data_o;

	// Instantiate the Unit Under Test (UUT)
	Pipe_Reg uut (
		.clk_i(clk_i), 
		.rst_i(rst_i), 
		.enable_i(enable_i), 
		.data_i(data_i), 
		.data_o(data_o)
	);

	initial begin
		// Initialize Inputs
		clk_i = 0;
		rst_i = 0;
		enable_i = 0;
		data_i = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst_i = 1;
		
		#10;
		data_i = 2'b10;
		
		#50;
		enable_i = 1'b1;
		data_i = 2'b01;
        
		// Add stimulus here
		
		

	end
   always #5 clk_i = ~clk_i;   
endmodule

