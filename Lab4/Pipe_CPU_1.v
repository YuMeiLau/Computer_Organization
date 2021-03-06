//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
        clk_i,
		rst_i
		);
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/
wire [31:0] pc_source;
wire [31:0] pc;
wire [31:0] pc_next_if;
wire [31:0] if_instr;

/**** ID stage ****/
wire [31:0] id_instr;
wire [31:0] pc_next_id;
wire [5:0]  instr_op;  assign instr_op = id_instr[31:26];

wire [4:0]  RSaddr_id; assign RSaddr_id = id_instr[25:21];
wire [4:0]  RTaddr_id; assign RTaddr_id = id_instr[20:16];
wire [4:0]  RDaddr_id; assign RDaddr_id = id_instr[15:11];

wire [15:0] imme_id;   assign imme_id = id_instr[15:0];
wire [31:0] sign_extend_id; 
wire [31:0]  RSdata_id; 
wire [31:0]  RTdata_id;

//control signal
//EX stage;
wire RegDst_id;
wire [2:0] ALUOp_id;
wire ALUSrc_id;

//MEM stage;
wire Branch_id;
wire MemWrite_id;
wire MemRead_id;

//WB stage;
wire RegWrite_id;
wire MemtoReg_id;


/**** EX stage ****/
wire [31:0] ex_instr;
wire [31:0] pc_next_ex;
wire [31:0] sign_extend_ex;
wire [31:0] RSdata_ex;
wire [31:0] RTdata_ex;
wire [5:0]  funct; assign funct = ex_instr[5:0];

wire [4:0]  RTaddr_ex;
wire [4:0]  RDaddr_ex;

//wire [31:0] RTdata_ex_advanced;
wire [31:0] operand_2;
wire [4:0]  shamt;   assign shamt = ex_instr[10:6];
wire [31:0] result_ex;
wire [4:0]  WriteReg_ex;

wire [31:0] branch_offset;
wire [31:0] branch_address_ex;

//control signal
//EX stage;
wire RegDst_ex;
wire [2:0] ALUOp_ex;
wire ALUSrc_ex;

wire [3:0] ALUCtrl;
wire zero_ex;

//MEM stage;
wire Branch_ex;
wire MemWrite_ex;
wire MemRead_ex;

//WB stage;
wire RegWrite_ex;
wire MemtoReg_ex;



/**** MEM stage ****/
wire [31:0] branch_address_mem;
wire [31:0] result_mem;
wire [31:0] RTdata_mem;
wire [4:0]  WriteReg_mem;
wire [31:0] Readdata_mem;

//control signal
//MEM stage;
wire Branch_mem;
wire MemWrite_mem;
wire MemRead_mem;

wire zero_mem;
wire PCSrc;		assign PCSrc = Branch_mem & zero_mem;

//WB stage;
wire RegWrite_mem;
wire MemtoReg_mem;


/**** WB stage ****/
wire [31:0] Readdata_wb;
wire [31:0] result_wb;
wire [4:0]  WriteReg_wb;
wire [31:0] RDdata_wb;

//control signal
//WB stage;
wire RegWrite_wb;
wire MemtoReg_wb;

/**********Forwarding_unit***************/
wire [1:0] Forward_A;
wire [1:0] Forward_B;
wire [31:0] RSdata_ex_advanced;
wire [31:0] RTdata_ex_advanced;

/**********hazard detection****/
wire data_hazard;
wire control_hazard; assign control_hazard = PCSrc;
wire PCWrite; assign PCWrite = ~(data_hazard);
wire if_id_write; assign if_id_write = ~data_hazard;
/*************ID flush*************/
//EX stage;
wire RegDst_id_i;
wire [2:0] ALUOp_id_i;
wire ALUSrc_id_i;

//MEM stage;
wire Branch_id_i;
wire MemWrite_id_i;
wire MemRead_id_i;

//WB stage;
wire RegWrite_id_i;
wire MemtoReg_id_i;

/***********EX flush**************/
//MEM stage;
wire Branch_ex_i;
wire MemWrite_ex_i;
wire MemRead_ex_i;

//WB stage;
wire RegWrite_ex_i;
wire MemtoReg_ex_i;

/*********IF flush*****************/
wire [31:0] pc_next_if_i;
wire [31:0] if_instr_i;


/****************************************
Instnatiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_next_if),
        .data1_i(branch_address_mem),
        .select_i(PCSrc),
        .data_o(pc_source)
        );	

ProgramCounter PC(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.enable_i(PCWrite),
		.pc_in_i(pc_source),
		.pc_out_o(pc)
        );

Instr_Memory IM(
		.addr_i(pc),
		.instr_o(if_instr)

	    );
			
Adder Add_pc(
		.src1_i(32'd4),
		.src2_i(pc),
		.sum_o(pc_next_if)

		);

MUX_2to1 #(.size(64)) NopOnIF(
		.data0_i({pc_next_if_i, if_instr_i}),
		.data1_i(64'b0),
		.select_i(control_hazard),
		.data_o({pc_next_if, if_instr})
		);
		
Pipe_Reg #(.size(64)) IF_ID(       //N is the total length of input/output
		.clk_i(clk_i),
		.rst_i(rst_i),
		.enable_i(if_id_write),
		.data_i({pc_next_if, if_instr}),
		.data_o({pc_next_id, id_instr})

		);
		
//Instantiate the components in ID stage
Reg_File RF(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.RSaddr_i(RSaddr_id),
		.RTaddr_i(RTaddr_id),
		.RDaddr_i(WriteReg_wb),
		.RDdata_i(RDdata_wb),
		.RegWrite_i(RegWrite_wb),
		.RSdata_o(RSdata_id),
		.RTdata_o(RTdata_id)

		);

Decoder Control(
		.instr_op_i(instr_op),
		.RegWrite_o(RegWrite_id_i),
		.ALU_op_o(ALUOp_id_i),
		.ALUSrc_o(ALUSrc_id_i),
		.RegDst_o(RegDst_id_i),
		.Branch_o(Branch_id_i),
		.MemRead_o(MemRead_id_i),
		.MemWrite_o(MemWrite_id_i),
		.MemtoReg_o(MemtoReg_id_i)
		);

MUX_2to1 #(.size(10)) NopOnIDControl(
		.data0_i({RegDst_id_i, ALUOp_id_i, ALUSrc_id_i, Branch_id_i, MemRead_id_i, MemWrite_id_i, RegWrite_id_i, MemtoReg_id_i}),
		.data1_i(10'b0),
		.select_i(data_hazard || control_hazard),
		.data_o({RegDst_id, ALUOp_id, ALUSrc_id, Branch_id, MemRead_id, MemWrite_id, RegWrite_id, MemtoReg_id})
		);

Sign_Extend Sign_Extend(
		.data_i(imme_id),
		.data_o(sign_extend_id)

		);	

Pipe_Reg #(.size(234)) ID_EX(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.enable_i(1),
		.data_i({pc_next_id, RSdata_id, RTdata_id, sign_extend_id, RTaddr_id, RDaddr_id, id_instr, 
				RegDst_id, ALUOp_id, ALUSrc_id, Branch_id, MemRead_id, MemWrite_id, RegWrite_id, MemtoReg_id}),
		.data_o({pc_next_ex, RSdata_ex, RTdata_ex, sign_extend_ex, RTaddr_ex, RDaddr_ex, ex_instr,
				RegDst_ex, ALUOp_ex, ALUSrc_ex, Branch_ex_i, MemRead_ex_i, MemWrite_ex_i, RegWrite_ex_i, MemtoReg_ex_i})

		);
		
//Instantiate the components in EX stage	   
ALU ALU(
		.src1_i(RSdata_ex_advanced),
		.src2_i(operand_2),
		.ctrl_i(ALUCtrl),
		.shamt(shamt),
		.result_o(result_ex),
		.zero_o(zero_ex)

		);
		
ALU_Ctrl ALU_Control(
		.funct_i(funct),
		.ALUOp_i(ALUOp_ex),
		.ALUCtrl_o(ALUCtrl)

		);

MUX_2to1 #(.size(32)) Mux1(
		.data0_i(RTdata_ex_advanced),
		.data1_i(sign_extend_ex),
		.select_i(ALUSrc_ex),
		.data_o(operand_2)

        );
		
MUX_2to1 #(.size(5)) Mux2(
		.data0_i(RTaddr_ex),
		.data1_i(RDaddr_ex),
		.select_i(RegDst_ex),
		.data_o(WriteReg_ex)

        );

Shift_Left_Two_32 #(.size(32)) Shifter_1(
        .data_i(sign_extend_ex),
        .data_o(branch_offset)
		
        ); 		
		
Adder  Add_branch(
		.src1_i(pc_next_ex),
		.src2_i(branch_offset),
		.sum_o(branch_address_ex)
		
		);
MUX_2to1 #(.size(5)) NopOnEXControl(
		.data0_i({Branch_ex_i, MemRead_ex_i, MemWrite_ex_i, RegWrite_ex_i, MemtoReg_ex_i}),
		.data1_i(5'b0),
		.select_i(control_hazard),
		.data_o({Branch_ex, MemRead_ex, MemWrite_ex, RegWrite_ex, MemtoReg_ex})
		);
		
Pipe_Reg #(.size(107)) EX_MEM(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.enable_i(1),
		.data_i({branch_address_ex, result_ex, RTdata_ex, WriteReg_ex, 
				zero_ex, Branch_ex, MemRead_ex, MemWrite_ex, RegWrite_ex, MemtoReg_ex}),
		.data_o({branch_address_mem, result_mem, RTdata_mem, WriteReg_mem,
				zero_mem, Branch_mem, MemRead_mem, MemWrite_mem, RegWrite_mem, MemtoReg_mem})

		);

		   
//Instantiate the components in MEM stage
Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(result_mem),
		.data_i(RTdata_mem),
		.MemRead_i(MemRead_mem),
		.MemWrite_i(MemWrite_mem),
		.data_o(Readdata_mem)

	    );

Pipe_Reg #(.size(71)) MEM_WB(
		.clk_i(clk_i),
		.rst_i(rst_i),
		.enable_i(1),
		.data_i({Readdata_mem, result_mem, WriteReg_mem,
				RegWrite_mem, MemtoReg_mem}),
		.data_o({Readdata_wb, result_wb, WriteReg_wb,
				RegWrite_wb, MemtoReg_wb})
        
		);

//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(
		.data0_i(result_wb),
		.data1_i(Readdata_wb),
		.select_i(MemtoReg_wb),
		.data_o(RDdata_wb)

        );

Forwarding_unit Forwarding(
		.id_ex_rs(ex_instr[25:21]),
		.id_ex_rt(RTaddr_ex),
		.ex_mem_rd(WriteReg_mem),
		.mem_wb_rd(WriteReg_wb),
		.ex_mem_regwrite(RegWrite_mem),
		.mem_wb_regwrite(RegWrite_wb),
		.forward_A(Forward_A),
		.forward_B(Forward_B)
		
		);
		
MUX_3to1 #(.size(32)) Forward_unit_A(
		.data0_i(RSdata_ex),
		.data1_i(result_mem), //???
		.data2_i(RDdata_wb),  //???
		.select_i(Forward_A),
		.data_o(RSdata_ex_advanced)
		);
		
MUX_3to1 #(.size(32)) Forward_unit_B(
		.data0_i(RTdata_ex),
		.data1_i(result_mem), //??
		.data2_i(RDdata_wb),  //??
		.select_i(Forward_B),
		.data_o(RTdata_ex_advanced)
		);

Hazard_detection_unit Hazard_detecting(
		.id_ex_rt(RTaddr_ex),
		.if_id_rs(RSaddr_id),
		.if_id_rt(RTaddr_id),
		.id_ex_memread(MemRead_ex),
//		.branch_hazard(control_hazard),
		.hazard(data_hazard)
		);
/****************************************
signal assignment
****************************************/	
endmodule

