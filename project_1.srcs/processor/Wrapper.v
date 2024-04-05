`timescale 1ns / 1ps
/**
 * 
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor, 
 * RegFile and Memory elements together.
 *
 * This file will be used to generate the bitstream to upload to the FPGA.
 * We have provided a sibling file, Wrapper_tb.v so that you can test your processor's functionality.
 * 
 * We will be using our own separate Wrapper_tb.v to test your code. You are allowed to make changes to the Wrapper files 
 * for your own individual testing, but we expect your final processor.v and memory modules to work with the 
 * provided Wrapper interface.
 * 
 * Refer to Lab 5 documents for detailed instructions on how to interface 
 * with the memory elements. Each imem and dmem modules will take 12-bit 
 * addresses and will allow for storing of 32-bit values at each address. 
 * Each memory module should receive a single clock. At which edges, is 
 * purely a design choice (and thereby up to you). 
 * 
 * You must change line 36 to add the memory file of the test you created using the assembler
 * For example, you would add sample inside of the quotes on line 38 after assembling sample.s
 *
 **/

module Wrapper (input CLK100MHZ, input BTNR, output [4:1] JB, output [15:0] LED, input [4:1] JC);
//	divide the 100MHZ clock;
	reg clockdiv_reg;
    reg[31:0] count;
    always @(posedge CLK100MHZ) begin
        count <= count + 1;
        if (count == 31'd100) begin
            count <= 0;
            clockdiv_reg <= ~clockdiv_reg;
        end
    end
    wire clock;
    assign clock = clockdiv_reg;
	wire reset;
	assign reset = BTNR;

	wire rwe, mwe;
	wire[4:0] rd, rs1, rs2;
	wire[31:0] instAddr, instData, 
		rData, regA, regB,
		memAddr, memAddrMotorA, memDataIn, memDataOut, memDataOutMotorA, memAddrSensorA;


	// ADD YOUR MEMORY FILE HERE
	localparam INSTR_FILE = "hall_basic";
	
	// Main Processing Unit
	processor CPU(.clock(clock), .reset(reset), 
								
		// ROM
		.address_imem(instAddr), .q_imem(instData),
									
		// Regfile
		.ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB),
									
		// RAM
		.wren(mwe), .address_dmem(memAddr), 
		.data(memDataIn), .q_dmem(memDataOut)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({INSTR_FILE, ".mem"}))
	InstMem(.clk(clock), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));
	
	
	
	// Register File
	regfile RegisterFile(.clock(clock), 
		.ctrl_writeEnable(rwe), .ctrl_reset(reset), 
		.ctrl_writeReg(rd),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB));
	
	assign memAddrMotorA = 32'd4009;
	assign memAddrSensorA = 32'd4008;
						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clock), 
		.wEn(mwe), 
		.addr(memAddr[11:0]),
		.addrMotorA(memAddrMotorA[11:0]), 
		.addrSensorA(memAddrSensorA[11:0]),
		.dataInSensorA(~JC[1]),
		.dataIn(memDataIn), 
		.dataOut(memDataOut),
		.dataOutMotorA(memDataOutMotorA)
		);

    assign LED [14:0] = memDataOutMotorA[14:0];
    assign LED [15:15] = JC[1];
    servo_ctrl servo_control(CLK100MHZ, BTNR, memDataOutMotorA[6:0],JB);

//    servo_ctrl servo_control(CLK100MHZ, reset, 7'd60,JB);

endmodule
