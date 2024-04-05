/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */
	/* END CODE */
    
    // FETCH STAGE
    wire [31:0] pcRegOut, pcRegIn, pcPlusOne;
    
    wire stall;

    wire D_readsRS, D_readsRT, D_readsRDasB;

    readsRS D_readsRSG(D_readsRS, D_IR);
    readsRT D_readsRTG(D_readsRT, D_IR);
    readsRDasB D_readsRDasBG(D_readsRDasB, D_IR);

    // (D/X.IR.OP == LOAD) && ((F/D.IR.RS1 == D/X.IR.RD) || ((F/D.IR.RS2 == D/X.IR.RD) && (F/D.IR.OP != STORE)))
    assign stall = (X_IR[26:22] != 5'b0) & X_isLoadWord & (
    (D_readsRS & (D_IR[21:17] == X_IR[26:22]))
    | (D_readsRT & (D_IR[16:12] == X_IR[26:22])) 
    | (D_readsRDasB & (D_IR[26:22] == X_IR[26:22]))
    );
    
    assign pcRegIn = X_changePC ? X_PC_Out : pcPlusOne;
    register_module programCounterRegister(pcRegOut, pcRegIn, ~clock, ~stall, reset);
    adderFull PCPlusOne(pcPlusOne, , pcRegOut, 32'b0, 1'b1);
    assign address_imem = pcRegOut;

    // FETCH / DECODE
    wire [31:0] D_PC, D_IR;
    register_module FD_PC(D_PC, pcPlusOne, ~clock, ~stall, reset);
    register_module FD_IR(D_IR, X_changePC ? 32'b0 : q_imem ,~clock, ~stall, reset);

    // DECODE STAGE

    wire isSW_BNE_BLT_JR, isBex, D_isStore;
    assign isBex = (D_IR[31:27] == 5'b10110);
    assign isSW_BNE_BLT_JR = (D_IR[31:27] == 5'b00111) | (D_IR[31:27] == 5'b00100)
                | (~D_IR[31] & ~D_IR[30] & D_IR[28] & ~D_IR[27]);              
    assign D_isStore = (D_IR[31:27] == 5'b00111);
    
    wire [4:0] ctrl_readRegB_almost;
    assign ctrl_readRegB_almost = isSW_BNE_BLT_JR ? D_IR[26:22] : D_IR[16:12];
    assign ctrl_readRegB = isBex ? 5'b11110 : ctrl_readRegB_almost;
    assign ctrl_readRegA = D_IR[21:17];



    // DECODE / EXECUTE LATCH
    wire [31:0] X_PC, X_IR, X_A, X_B;
    register_module DX_PC(X_PC, D_PC, ~clock, 1'b1, reset);
    register_module DX_IR(X_IR, stall ? 32'b0 : (X_changePC ? 32'b0 : D_IR), ~clock, 1'b1, reset);
    register_module DX_A(X_A, data_readRegA, ~clock, 1'b1, reset);
    register_module DX_B(X_B, data_readRegB, ~clock, 1'b1, reset);

    // EXECUTE
    wire isImmediate, X_isBLT, X_isBNE, X_isJ, X_isJR, X_isJAL, X_isMult, X_isDiv, X_isSetX, X_isBex, X_isLoadWord;
    assign isImmediate = (~X_IR[31] & ~X_IR[30] & X_IR[29] & X_IR[27])
                | (~X_IR[31] & X_IR[30] & ~X_IR[29] & ~X_IR[28] & ~X_IR[27])
                | (~X_IR[31] & ~X_IR[30] & X_IR[28] & ~X_IR[27]);
    assign X_isBLT = (~X_IR[31] & ~X_IR[30] & X_IR[29] &  X_IR[28] & ~X_IR[27]);
    assign X_isBNE = ~X_IR[31] & ~X_IR[30] & ~X_IR[29] & X_IR[28] & ~X_IR[27];
    assign X_isJ = ~X_IR[31] & ~X_IR[30] & ~X_IR[29] & ~X_IR[28] & X_IR[27];
    assign X_isJR = ~X_IR[31] & ~X_IR[30] & X_IR[29] & ~X_IR[28] & ~X_IR[27];
    assign X_isJAL = ~X_IR[31] & ~X_IR[30] & ~X_IR[29] & X_IR[28] & X_IR[27];
    assign X_isMult = ~X_IR[31] & ~X_IR[30] & ~X_IR[29] &  ~X_IR[28] & ~X_IR[27] & ~X_IR[6] & ~X_IR[5] & X_IR[4] & X_IR[3] & ~X_IR[2];
    assign X_isDiv =  ~X_IR[31] & ~X_IR[30] & ~X_IR[29] &  ~X_IR[28] & ~X_IR[27] & ~X_IR[6] & ~X_IR[5] & X_IR[4] & X_IR[3] & X_IR[2];
    assign X_isSetX = X_IR[31] & ~X_IR[30] & X_IR[29] & ~X_IR[28] & X_IR[27];
    assign X_isBex = X_IR[31] & ~X_IR[30] & X_IR[29] & X_IR[28] & ~X_IR[27];
    assign X_isLoadWord = ~X_IR[31] & X_IR[30] & ~X_IR[29] & ~X_IR[28] & ~X_IR[27];
    wire X_isAdd, X_isAddi, X_isSub;
    assign X_isAdd = ~X_IR[31] & ~X_IR[30] & ~X_IR[29] & ~X_IR[28] & ~X_IR[27] & ~X_IR[6] & ~X_IR[5] & ~X_IR[4] & ~X_IR[3] & ~X_IR[2];
    assign X_isAddi = ~X_IR[31] & ~X_IR[30] & X_IR[29] & ~X_IR[28] & X_IR[27];
    assign X_isSub = ~X_IR[31] & ~X_IR[30] & ~X_IR[29] & ~X_IR[28] & ~X_IR[27] & ~X_IR[6] & ~X_IR[5] & ~X_IR[4] & ~X_IR[3] & X_IR[2];


    //ALU opcode
    wire [4:0] aluopcodeTmp, aluopcode;
    assign aluopcodeTmp = isImmediate ? 5'b0 : X_IR[6:2];  // set ALU to add if it's immediate
    assign aluopcode = (X_isBLT | X_isBNE) ?  5'b00001 : aluopcodeTmp; // subtract if BLT or BNE

    // BY PASS:
        wire [31:0] X_ALU_A_Bypass_1, X_ALU_A_Bypass;
        //by pass A
        wire M_writesToRD,X_readsRS, X_readsRDasB, X_readsRT;
        readsRS X_readsRSQ(X_readsRS, X_IR);
        writesToRD M_writesToRd(M_writesToRD, M_IR);
        readsRT X_readsRTGate(X_readsRT, X_IR);
        readsRDasB X_readsRDasBGate(X_readsRDasB, X_IR);

        wire X_ALU_A_Bypass_One_Bool, X_ALU_B_Bypass_One_Bool, X_ALU_A_BypassTwo_Bo;
        assign X_ALU_A_Bypass_One_Bool = M_writesToRD & (X_readsRS) & (X_IR[21:17] == M_IR[26:22])
                                        & (X_IR[21:17] != 5'b0);
        assign X_ALU_A_Bypass_1 =  X_ALU_A_Bypass_One_Bool ? M_ALUOUT : X_A; 
        
        assign X_ALU_A_BypassTwo_Bo =  ~X_ALU_A_Bypass_One_Bool & X_readsRS & ctrl_writeEnable & (X_IR[21:17] == ctrl_writeReg); // can also check if 0, but don't need, as ctrl_writeEnable supercedes
        assign X_ALU_A_Bypass = X_ALU_A_BypassTwo_Bo ? data_writeReg : X_ALU_A_Bypass_1;



        wire [31:0] X_ALU_B_Bypass_1, X_ALU_B_Bypass;
        assign X_ALU_B_Bypass_One_Bool = (M_IR[26:22] !=5'b0) & M_writesToRD & (
        (X_readsRT & (X_IR[16:12] == M_IR[26:22])) 
        | (X_readsRDasB & (X_IR[26:22] == M_IR[26:22]))
        );
        assign X_ALU_B_Bypass_1 =  X_ALU_B_Bypass_One_Bool ? M_ALUOUT : X_B;
        assign X_ALU_B_Bypass = ~X_ALU_B_Bypass_One_Bool & ctrl_writeEnable & (
        (X_readsRT & (X_IR[16:12] == ctrl_writeReg)) 
        | (X_readsRDasB & (X_IR[26:22] == ctrl_writeReg))
        ) ? data_writeReg : X_ALU_B_Bypass_1;


    // use sign extended immediate as B
    wire [31:0] signExtOut, X_B_Proper;
    signExtender signExtender(signExtOut, X_IR[16:0]);
    assign X_B_Proper = (isImmediate & ~X_isBLT & ~X_isBNE) ? signExtOut : X_ALU_B_Bypass; 




    wire [31:0] alu_res, multdivRes, X_res;
    wire X_isNotEqual, X_isLessThan, X_ALU_OVERFLOW, X_multDivOver;
    alu theALU(X_ALU_A_Bypass, X_B_Proper, aluopcode, X_IR[11:7], alu_res, X_isNotEqual, X_isLessThan , X_ALU_OVERFLOW );

    multdiv theMultDiv(X_ALU_A_Bypass, X_ALU_B_Bypass, X_isMult, X_isDiv, clock, multdivRes, X_multDivOver,);
    assign X_res = (X_isMult | X_isDiv) ? multdivRes : alu_res;

    //branch sum
    wire [31:0] X_PCExtended, X_branchSum, X_PC_Out, X_J_Out, X_resActual;
    signExtenderJ signExtenderJ(X_PCExtended, X_IR[26:0]);

    // define two options for new PC. 
    assign X_J_Out = X_isJR ? X_ALU_B_Bypass : X_PCExtended; // if it's JR, then $rd
    adderFull X_adderFull(X_branchSum, , X_PC, signExtOut, 1'b0); 

    assign X_resActual = X_isSetX ? X_PCExtended : X_res;

    wire isNotZero;
    isNotEqual isNotEqualBex(isNotZero, X_B, 32'b0);
    wire X_changePC;
    assign X_changePC = (X_isBex & isNotZero)
        | (X_isNotEqual & X_isBNE)
        | (X_isBLT & X_isNotEqual & ~X_isLessThan) | (X_isJ) | X_isJAL | X_isJR;
    assign X_PC_Out = (X_isBLT | X_isBNE) ? X_branchSum : X_J_Out;

    // exception logic

    wire [31:0] X_statusWire;
    wire X_isException;
    assign X_isException = ((X_isAdd | X_isAddi | X_isSub) & X_ALU_OVERFLOW) | ((X_isMult | X_isDiv) & X_multDivOver);

    ts32 X_tsAdd(32'b00000000000000000000000000000001, X_isAdd, X_statusWire);
    ts32 X_tsAddi(32'b00000000000000000000000000000010, X_isAddi, X_statusWire);
    ts32 X_tsSub(32'b00000000000000000000000000000011, X_isSub, X_statusWire);
    ts32 X_tsMul(32'b00000000000000000000000000000100, X_isMult, X_statusWire);
    ts32 X_tsDiv(32'b00000000000000000000000000000101, X_isDiv, X_statusWire);
    
    wire [31:0] X_resActualActual;
    assign X_resActualActual = X_isException ? X_statusWire : X_resActual;
    wire [31:0] X_IR_Out;
    assign X_IR_Out[21:0] = X_IR[21:0];
    assign X_IR_Out[31:27] = X_IR[31:27];
    assign X_IR_Out[26:22] = X_isException ? 5'b11110 : X_IR[26:22];

    // EXECUTE / MODIFY LATCH
    
    wire [31:0] M_IR, M_ALUOUT, M_B;
    //wire M_ALU_overflow;
    register_module XM_IR(M_IR, X_IR_Out ,~clock, 1'b1, reset);
    register_module XM_ALUOUT(M_ALUOUT, X_isJAL ? X_PC : X_resActualActual, ~clock, 1'b1, reset);
    register_module XM_B(M_B, X_ALU_B_Bypass ,~clock, 1'b1, reset);





    // MODIFY

    // add/sub/whatever and then store
    wire [31:0] M_dataBypass;
    wire M_doBypass;
    assign M_doBypass = M_isStoreWord & ctrl_writeEnable & (ctrl_writeReg == M_IR[26:22]);
    assign data = M_doBypass ? data_writeReg : M_B;


    wire M_isStoreWord, M_isLoadWord;
    assign M_isStoreWord = (M_IR[31:27] == 5'b00111);
    assign M_isLoadWord = (M_IR[31:27] == 5'b01000);
    assign address_dmem = M_ALUOUT;
    assign wren = M_isStoreWord; // if it's a store word


    // mem bypassing
    wire M_DoMemBypass;
    wire [31:0] M_dataRes;
    assign M_DoMemBypass = M_isLoadWord & W_isStoreWord & (M_ALUOUT == W_ALUOUT); // we are loading a word just stored
    assign M_dataRes = M_DoMemBypass ? W_BHack : q_dmem;



    

    // MODIFY / WRITE-BACK
    wire [31:0] W_IR, W_ALUOUT, W_Data, W_BHack;
            //wire W_ALU_overflow;
    register_module MW_IR(W_IR, M_IR ,~clock, 1'b1, reset);
    register_module MW_ALUOUT(W_ALUOUT, M_ALUOUT, ~clock, 1'b1, reset);
    register_module MW_DataOut(W_Data, M_dataRes ,~clock, 1'b1, reset); // should be data result instead
    register_module MW_Bhack(W_BHack, data, ~clock, 1'b1, reset); // get the appropriate data
    // WRITE-BACK
    

    wire W_storeWord_BNE_BLT, W_isJ, W_isJR, W_isJAL, W_isSetX, W_isBex, W_isStoreWord, W_isLoadWord;
    assign W_isLoadWord = ~W_IR[31] & W_IR[30] & ~W_IR[29] & ~W_IR[28] & ~W_IR[27]; // if Load word
    assign W_storeWord_BNE_BLT = (~W_IR[31] & ~W_IR[30] & W_IR[29] & W_IR[28]) | (~W_IR[31] & ~W_IR[30] & W_IR[28] & ~W_IR[27]);  
    assign W_isJ = ~W_IR[31] & ~W_IR[30] & ~W_IR[29] & ~W_IR[28] & W_IR[27];
    assign W_isJR = ~W_IR[31] & ~W_IR[30] & W_IR[29] & ~W_IR[28] & ~W_IR[27];
    assign W_isJAL = ~W_IR[31] & ~W_IR[30] & ~W_IR[29] & W_IR[28] & W_IR[27];
    assign W_isSetX = W_IR[31] & ~W_IR[30] & W_IR[29] & ~W_IR[28] & W_IR[27];
    assign W_isBex = W_IR[31] & ~W_IR[30] & W_IR[29] & W_IR[28] & ~W_IR[27];
    assign W_isStoreWord = ~W_IR[31] & ~W_IR[30] & W_IR[29] & W_IR[28] & W_IR[27];
    
    
    assign data_writeReg = W_isLoadWord ? W_Data : W_ALUOUT;

    wire [4:0] pre_ctrl_writeReg;
    assign pre_ctrl_writeReg = W_isJAL ? 5'b11111 : W_IR[26:22]; //if we edit PC reg
    assign ctrl_writeReg = W_isSetX ? 5'b11110 : pre_ctrl_writeReg;
    assign ctrl_writeEnable = ~W_storeWord_BNE_BLT & ~W_isJ & ~W_isJR & ~W_isBex & (ctrl_writeReg != 5'b0);

endmodule
