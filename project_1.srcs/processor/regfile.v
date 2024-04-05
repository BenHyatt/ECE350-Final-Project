module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;


	wire [31:0] CtrlWriteReg_OneHot;
	decoder32 decoder32C(CtrlWriteReg_OneHot, ctrl_writeReg, ctrl_writeEnable);
	wire [31:0] readRegA_oneHot;
	decoder32 decoder32D(readRegA_oneHot, ctrl_readRegA, 1'b1);
	wire [31:0] readRegB_oneHot;
	decoder32 decoder32E(readRegB_oneHot, ctrl_readRegB, 1'b1);

	wire [31:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9,reg10,reg11,reg12,reg13,reg14,reg15,reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31 ;
	wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31;
	// and and0(w0, CtrlWriteReg_OneHot[0], ctrl_writeEnable);
	// and and1(w1, CtrlWriteReg_OneHot[1], ctrl_writeEnable);
	// and and2(w2, CtrlWriteReg_OneHot[2], ctrl_writeEnable);
	// and and3(w3, CtrlWriteReg_OneHot[3], ctrl_writeEnable);
	// and and4(w4, CtrlWriteReg_OneHot[4], ctrl_writeEnable);
	// and and5(w5, CtrlWriteReg_OneHot[5], ctrl_writeEnable);
	// and and6(w6, CtrlWriteReg_OneHot[6], ctrl_writeEnable);
	// and and7(w7, CtrlWriteReg_OneHot[7], ctrl_writeEnable);
	// and and8(w8, CtrlWriteReg_OneHot[8], ctrl_writeEnable);
	// and and9(w9, CtrlWriteReg_OneHot[9], ctrl_writeEnable);
	// and and10(w10, CtrlWriteReg_OneHot[10], ctrl_writeEnable);
	// and and11(w11, CtrlWriteReg_OneHot[11], ctrl_writeEnable);
	// and and12(w12, CtrlWriteReg_OneHot[12], ctrl_writeEnable);
	// and and13(w13, CtrlWriteReg_OneHot[13], ctrl_writeEnable);
	// and and14(w14, CtrlWriteReg_OneHot[14], ctrl_writeEnable);
	// and and15(w15, CtrlWriteReg_OneHot[15], ctrl_writeEnable);
	// and and16(w16, CtrlWriteReg_OneHot[16], ctrl_writeEnable);
	// and and17(w17, CtrlWriteReg_OneHot[17], ctrl_writeEnable);
	// and and18(w18, CtrlWriteReg_OneHot[18], ctrl_writeEnable);
	// and and19(w19, CtrlWriteReg_OneHot[19], ctrl_writeEnable);
	// and and20(w20, CtrlWriteReg_OneHot[20], ctrl_writeEnable);
	// and and21(w21, CtrlWriteReg_OneHot[21], ctrl_writeEnable);
	// and and22(w22, CtrlWriteReg_OneHot[22], ctrl_writeEnable);
	// and and23(w23, CtrlWriteReg_OneHot[23], ctrl_writeEnable);
	// and and24(w24, CtrlWriteReg_OneHot[24], ctrl_writeEnable);
	// and and25(w25, CtrlWriteReg_OneHot[25], ctrl_writeEnable);
	// and and26(w26, CtrlWriteReg_OneHot[26], ctrl_writeEnable);
	// and and27(w27, CtrlWriteReg_OneHot[27], ctrl_writeEnable);
	// and and28(w28, CtrlWriteReg_OneHot[28], ctrl_writeEnable);
	// and and29(w29, CtrlWriteReg_OneHot[29], ctrl_writeEnable);
	// and and30(w30, CtrlWriteReg_OneHot[30], ctrl_writeEnable);
	// and and31(w31, CtrlWriteReg_OneHot[31], ctrl_writeEnable);

	register_moduleZero regMod0(reg0, data_writeReg, clock, CtrlWriteReg_OneHot[0], ctrl_reset);
	register_module regMod1(reg1, data_writeReg, clock, CtrlWriteReg_OneHot[1], ctrl_reset);
	register_module regMod2(reg2, data_writeReg, clock, CtrlWriteReg_OneHot[2], ctrl_reset);
	register_module regMod3(reg3, data_writeReg, clock, CtrlWriteReg_OneHot[3], ctrl_reset);
	register_module regMod4(reg4, data_writeReg, clock, CtrlWriteReg_OneHot[4], ctrl_reset);
	register_module regMod5(reg5, data_writeReg, clock, CtrlWriteReg_OneHot[5], ctrl_reset);
	register_module regMod6(reg6, data_writeReg, clock, CtrlWriteReg_OneHot[6], ctrl_reset);
	register_module regMod7(reg7, data_writeReg, clock, CtrlWriteReg_OneHot[7], ctrl_reset);
	register_module regMod8(reg8, data_writeReg, clock, CtrlWriteReg_OneHot[8], ctrl_reset);
	register_module regMod9(reg9, data_writeReg, clock, CtrlWriteReg_OneHot[9], ctrl_reset);
	register_module regMod10(reg10, data_writeReg, clock, CtrlWriteReg_OneHot[10], ctrl_reset);
	register_module regMod11(reg11, data_writeReg, clock, CtrlWriteReg_OneHot[11], ctrl_reset);
	register_module regMod12(reg12, data_writeReg, clock, CtrlWriteReg_OneHot[12], ctrl_reset);
	register_module regMod13(reg13, data_writeReg, clock, CtrlWriteReg_OneHot[13], ctrl_reset);
	register_module regMod14(reg14, data_writeReg, clock, CtrlWriteReg_OneHot[14], ctrl_reset);
	register_module regMod15(reg15, data_writeReg, clock, CtrlWriteReg_OneHot[15], ctrl_reset);
	register_module regMod16(reg16, data_writeReg, clock, CtrlWriteReg_OneHot[16], ctrl_reset);
	register_module regMod17(reg17, data_writeReg, clock, CtrlWriteReg_OneHot[17], ctrl_reset);
	register_module regMod18(reg18, data_writeReg, clock, CtrlWriteReg_OneHot[18], ctrl_reset);
	register_module regMod19(reg19, data_writeReg, clock, CtrlWriteReg_OneHot[19], ctrl_reset);
	register_module regMod20(reg20, data_writeReg, clock, CtrlWriteReg_OneHot[20], ctrl_reset);
	register_module regMod21(reg21, data_writeReg, clock, CtrlWriteReg_OneHot[21], ctrl_reset);
	register_module regMod22(reg22, data_writeReg, clock, CtrlWriteReg_OneHot[22], ctrl_reset);
	register_module regMod23(reg23, data_writeReg, clock, CtrlWriteReg_OneHot[23], ctrl_reset);
	register_module regMod24(reg24, data_writeReg, clock, CtrlWriteReg_OneHot[24], ctrl_reset);
	register_module regMod25(reg25, data_writeReg, clock, CtrlWriteReg_OneHot[25], ctrl_reset);
	register_module regMod26(reg26, data_writeReg, clock, CtrlWriteReg_OneHot[26], ctrl_reset);
	register_module regMod27(reg27, data_writeReg, clock, CtrlWriteReg_OneHot[27], ctrl_reset);
	register_module regMod28(reg28, data_writeReg, clock, CtrlWriteReg_OneHot[28], ctrl_reset);
	register_module regMod29(reg29, data_writeReg, clock, CtrlWriteReg_OneHot[29], ctrl_reset);
	register_module regMod30(reg30, data_writeReg, clock, CtrlWriteReg_OneHot[30], ctrl_reset);
	register_module regMod31(reg31, data_writeReg, clock, CtrlWriteReg_OneHot[31], ctrl_reset);

	ts32 ts32_0(reg0, readRegA_oneHot[0], data_readRegA);
ts32 ts32_1(reg1, readRegA_oneHot[1], data_readRegA);   
ts32 ts32_2(reg2, readRegA_oneHot[2], data_readRegA);   
ts32 ts32_3(reg3, readRegA_oneHot[3], data_readRegA);   
ts32 ts32_4(reg4, readRegA_oneHot[4], data_readRegA);   
ts32 ts32_5(reg5, readRegA_oneHot[5], data_readRegA);   
ts32 ts32_6(reg6, readRegA_oneHot[6], data_readRegA);   
ts32 ts32_7(reg7, readRegA_oneHot[7], data_readRegA);   
ts32 ts32_8(reg8, readRegA_oneHot[8], data_readRegA);   
ts32 ts32_9(reg9, readRegA_oneHot[9], data_readRegA);   
ts32 ts32_10(reg10, readRegA_oneHot[10], data_readRegA);
ts32 ts32_11(reg11, readRegA_oneHot[11], data_readRegA);
ts32 ts32_12(reg12, readRegA_oneHot[12], data_readRegA);
ts32 ts32_13(reg13, readRegA_oneHot[13], data_readRegA);
ts32 ts32_14(reg14, readRegA_oneHot[14], data_readRegA);
ts32 ts32_15(reg15, readRegA_oneHot[15], data_readRegA);
ts32 ts32_16(reg16, readRegA_oneHot[16], data_readRegA);
ts32 ts32_17(reg17, readRegA_oneHot[17], data_readRegA);
ts32 ts32_18(reg18, readRegA_oneHot[18], data_readRegA);
ts32 ts32_19(reg19, readRegA_oneHot[19], data_readRegA);
ts32 ts32_20(reg20, readRegA_oneHot[20], data_readRegA);
ts32 ts32_21(reg21, readRegA_oneHot[21], data_readRegA);
ts32 ts32_22(reg22, readRegA_oneHot[22], data_readRegA);
ts32 ts32_23(reg23, readRegA_oneHot[23], data_readRegA);
ts32 ts32_24(reg24, readRegA_oneHot[24], data_readRegA);
ts32 ts32_25(reg25, readRegA_oneHot[25], data_readRegA);
ts32 ts32_26(reg26, readRegA_oneHot[26], data_readRegA);
ts32 ts32_27(reg27, readRegA_oneHot[27], data_readRegA);
ts32 ts32_28(reg28, readRegA_oneHot[28], data_readRegA);
ts32 ts32_29(reg29, readRegA_oneHot[29], data_readRegA);
ts32 ts32_30(reg30, readRegA_oneHot[30], data_readRegA);
ts32 ts32_31(reg31, readRegA_oneHot[31], data_readRegA);


ts32 ts32_B0(reg0, readRegB_oneHot[0], data_readRegB);
ts32 ts32_B1(reg1, readRegB_oneHot[1], data_readRegB);
ts32 ts32_B2(reg2, readRegB_oneHot[2], data_readRegB);
ts32 ts32_B3(reg3, readRegB_oneHot[3], data_readRegB);
ts32 ts32_B4(reg4, readRegB_oneHot[4], data_readRegB);
ts32 ts32_B5(reg5, readRegB_oneHot[5], data_readRegB);
ts32 ts32_B6(reg6, readRegB_oneHot[6], data_readRegB);
ts32 ts32_B7(reg7, readRegB_oneHot[7], data_readRegB);
ts32 ts32_B8(reg8, readRegB_oneHot[8], data_readRegB);
ts32 ts32_B9(reg9, readRegB_oneHot[9], data_readRegB);
ts32 ts32_B10(reg10, readRegB_oneHot[10], data_readRegB);
ts32 ts32_B11(reg11, readRegB_oneHot[11], data_readRegB);
ts32 ts32_B12(reg12, readRegB_oneHot[12], data_readRegB);
ts32 ts32_B13(reg13, readRegB_oneHot[13], data_readRegB);
ts32 ts32_B14(reg14, readRegB_oneHot[14], data_readRegB);
ts32 ts32_B15(reg15, readRegB_oneHot[15], data_readRegB);
ts32 ts32_B16(reg16, readRegB_oneHot[16], data_readRegB);
ts32 ts32_B17(reg17, readRegB_oneHot[17], data_readRegB);
ts32 ts32_B18(reg18, readRegB_oneHot[18], data_readRegB);
ts32 ts32_B19(reg19, readRegB_oneHot[19], data_readRegB);
ts32 ts32_B20(reg20, readRegB_oneHot[20], data_readRegB);
ts32 ts32_B21(reg21, readRegB_oneHot[21], data_readRegB);
ts32 ts32_B22(reg22, readRegB_oneHot[22], data_readRegB);
ts32 ts32_B23(reg23, readRegB_oneHot[23], data_readRegB);
ts32 ts32_B24(reg24, readRegB_oneHot[24], data_readRegB);
ts32 ts32_B25(reg25, readRegB_oneHot[25], data_readRegB);
ts32 ts32_B26(reg26, readRegB_oneHot[26], data_readRegB);
ts32 ts32_B27(reg27, readRegB_oneHot[27], data_readRegB);
ts32 ts32_B28(reg28, readRegB_oneHot[28], data_readRegB);
ts32 ts32_B29(reg29, readRegB_oneHot[29], data_readRegB);
ts32 ts32_B30(reg30, readRegB_oneHot[30], data_readRegB);
ts32 ts32_B31(reg31, readRegB_oneHot[31], data_readRegB);


endmodule
