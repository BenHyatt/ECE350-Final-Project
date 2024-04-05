module rightShifter(res, A, amount);
    input [31:0] A;
    input [4:0] amount;

    output [31:0] res;

    wire [31:0] w16, w8, w4, w2, w1;
    wire [31:0] w16res, w8res, w4res, w2res, w1res;

    sixteenRightShift shift0(w16res, A);
    

    assign w16 = amount[4] ? w16res : A;
    eightRightShift shift1(w8res, w16);

    assign w8 = amount[3] ? w8res : w16;
    fourRightShift shift2(w4res, w8);

    assign w4 = amount[2] ? w4res : w8;
    twoRightShift shift3(w2res, w4);

    assign w2 = amount[1] ? w2res: w4;
    oneRightShift shift4(w1res, w2);

    assign res = amount[0] ? w1res: w2;  
endmodule