module tri_state(in, oe, out);
    input in, oe;
    output out;
    assign out = oe ? in : 1'bz;
endmodule

module ts32(in, oe, out);
    input [31:0] in;
    output [31:0] out;
    input oe;
    assign out = oe ? in : 32'bz;
endmodule

// module tri_state_32(Q, D, clk, en, clr);
//     input [31:0] D;
//     input clk, en, clr;
//     output [31:0] Q;

//     dffe_ref trs_0(Q[0], D[0], D[0]);
//     dffe_ref trs_1(Q[1], D[1], clk, en, clr);
//     dffe_ref trs_2(Q[2], D[2],clk, en, clr);
//     dffe_ref trs_3(Q[3], D[3],clk, en, clr);
//     dffe_ref trs_4(Q[4], D[4],clk, en, clr);
//     dffe_ref trs_5(Q[5], D[5],clk, en, clr);
//     dffe_ref trs_6(Q[6], D[6],clk, en, clr);
//     dffe_ref trs_7(Q[7], D[7],clk, en, clr);
//     dffe_ref trs_8(Q[8], D[8],clk, en, clr);
//     tri_state trs_9(Q[9], D[9],clk, en, clr);
//     dffe_ref trs_10(Q[10], D[10],clk, en, clr);
//     tri_state trs_11(Q[11], D[11],clk, en, clr);
//     tri_state trs_12(Q[12], D[12],clk, en, clr);
//     tri_state trs_13(Q[13], D[13],clk, en, clr);
//     tri_state trs_14(Q[14], D[14],clk, en, clr);
//     tri_state trs_15(Q[15], D[15],clk, en, clr);
//     tri_state trs_16(Q[16], D[16],clk, en, clr);
//     tri_state trs_17(Q[17], D[17],clk, en, clr);
//     tri_state trs_18(Q[18], D[18],clk, en, clr);
//     tri_state trs_19(Q[19], D[19],clk, en, clr);
//     tri_state trs_20(Q[20], D[20],clk, en, clr);
//     tri_state trs_21(Q[21], D[21],clk, en, clr);
//     tri_state trs_22(Q[22], D[22],clk, en, clr);
//     tri_state trs_23(Q[23], D[23],clk, en, clr);
//     tri_state trs_24(Q[24], D[24],clk, en, clr);
//     tri_state trs_25(Q[25], D[25],clk, en, clr);
//     tri_state trs_26(Q[26], D[26],clk, en, clr);
//     tri_state trs_27(Q[27], D[27],clk, en, clr);
//     tri_state trs_28(Q[28], D[28],clk, en, clr);
//     tri_state trs_29(Q[29], D[29],clk, en, clr);
//     tri_state trs_30(Q[30], D[30],clk, en, clr);
//     tri_state trs_31(Q[31], D[31],clk, en, clr);

//     and andGate0(Q[0], QTmp[0], outEnable);
//     and andGate1(Q[1], QTmp[1], outEnable);
//     and andGate2(Q[2], QTmp[2], outEnable);
//     and andGate3(Q[3], QTmp[3], outEnable);
//     and andGate4(Q[4], QTmp[4], outEnable);
//     and andGate5(Q[5], QTmp[5], outEnable);
//     and andGate6(Q[6], QTmp[6], outEnable);
//     and andGate7(Q[7], QTmp[7], outEnable);
//     and andGate8(Q[8], QTmp[8], outEnable);
//     and andGate9(Q[9], QTmp[9], outEnable);
//     and andGate10(Q[10], QTmp[10], outEnable);
//     and andGate11(Q[11], QTmp[11], outEnable);
//     and andGate12(Q[12], QTmp[12], outEnable);
//     and andGate13(Q[13], QTmp[13], outEnable);
//     and andGate14(Q[14], QTmp[14], outEnable);
//     and andGate15(Q[15], QTmp[15], outEnable);
//     and andGate16(Q[16], QTmp[16], outEnable);
//     and andGate17(Q[17], QTmp[17], outEnable);
//     and andGate18(Q[18], QTmp[18], outEnable);
//     and andGate19(Q[19], QTmp[19], outEnable);
//     and andGate20(Q[20], QTmp[20], outEnable);
//     and andGate21(Q[21], QTmp[21], outEnable);
//     and andGate22(Q[22], QTmp[22], outEnable);
//     and andGate23(Q[23], QTmp[23], outEnable);
//     and andGate24(Q[24], QTmp[24], outEnable);
//     and andGate25(Q[25], QTmp[25], outEnable);
//     and andGate26(Q[26], QTmp[26], outEnable);
//     and andGate27(Q[27], QTmp[27], outEnable);
//     and andGate28(Q[28], QTmp[28], outEnable);
//     and andGate29(Q[29], QTmp[29], outEnable);
//     and andGate30(Q[30], QTmp[30], outEnable);
//     and andGate31(Q[31], QTmp[31], outEnable);   
// endmodule

module decoder32(out, select, enable);
    input [4:0] select;
    input enable;
    output [31:0] out;
    assign out = enable << select;
endmodule