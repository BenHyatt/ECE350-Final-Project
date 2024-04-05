module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    //add your code here:
    wire [31:0] bIn, notB;
    notGate notGate0(notB,data_operandB);
    assign bIn = ctrl_ALUopcode[0] ? notB : data_operandB;

    wire carryIn;
    assign carryIn = ctrl_ALUopcode[0] ? 1 : 0;

    isNotEqual INEGate(isNotEqual, data_operandA, data_operandB);
    
    wire over;
    wire [31:0] adderOut;
    adderFull adderUnit(adderOut, over,data_operandA, bIn, carryIn);

    // IS LESS THAN GATES
    wire altLT0, altLT1, LT0, LT1, LT2, LT3, LT4, LT5, LT6;
    // xor altLTGate0(altLT0, data_operandA[31], data_operandB[31]); //if they're signs
    // and altLTGate1(altLT1, altLT0,data_operandA[31]); //and the result one is negative

    wire secondNotPos;
    not NotPositive(secondNotPos, data_operandA[31] ); // A positive
    and LTAndGate(LT2, secondNotPos,data_operandB[31] ); //B is negative
    not BadSituation(LT3, LT2);

    not LTNot1(LT5, data_operandB[31]);  // B is positive
    and LTAnd1(LT6, LT5, data_operandA[31]); // A is negative 
    wire isLessThanAlmost;
    or isLessThanFinalOr(isLessThanAlmost, LT6, adderOut[31] );

    and isLessThanFialIThink(isLessThan, isLessThanAlmost,LT3 );

    //assign isLessThan = data_result[31];

    wire xnorWire, overSub, overflowAlmost, overFlowCond, isAdd, xnorWire2;
    xnor xnorGate1(xnorWire, data_operandA[31], bIn[31]); //if they have same sign
    xor xorGate0(xnorWire2, data_operandA[31], data_result[31]); //A differs from result
    and andGate(overflowAlmost, xnorWire, xnorWire2); // A and B have same sign, yet result is different

    not isAddition(isAdd, ctrl_ALUopcode[0]);
    and bothPositiveAndNeg(overFlowCond,LT5,secondNotPos,data_result[31], isAdd);
    or orOverFlow(overflow, overflowAlmost, overFlowCond);

    //assign overflow = ctrl_ALUopcode[0] ? overSub : over;
    wire [31:0] andOut;
    andGate bigAnd(andOut, data_operandA, data_operandB);
    wire [31:0] orOut;
    orGate bigOr(orOut,data_operandA , data_operandB);
    wire [31:0] leftShiftOut;
    leftShifter leftShifter0(leftShiftOut,data_operandA, ctrl_shiftamt);
    wire [31:0] rightShiftOut;
    rightShifter rightShifter0(rightShiftOut,data_operandA, ctrl_shiftamt);

    wire [31:0] t;
    assign t = 32'b0;
    mux_32 muxThing(data_result, ctrl_ALUopcode, adderOut, adderOut, andOut, orOut,leftShiftOut , rightShiftOut, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t, t);

endmodule
