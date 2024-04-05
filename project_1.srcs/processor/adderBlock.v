module adderBlock(S, POut, GOut, A, B, CIn);
    input [7:0] A, B;
    input CIn;
    output [7:0] S;
    output POut, GOut; 
    
    wire p0, g0, p1, g1, p2, g2, p3, g3, p4, g4, p5, g5, p6, g6, p7, g7;
    wire c1, c2, c3, c4, c5, c6, c7;
    

    wire cw10;
    and gate10(cw10, CIn, p0);
    or gate12(c1, cw10, g0);

    wire cw20, cw21;
    and gate20(cw20, CIn, p0, p1);
    and gate21(cw21, g0, p1);
    or gate22(c2, cw20, cw21, g1);

    wire cw30, cw31, cw32;
    and gate30(cw30, CIn, p0, p1, p2);
    and gate31(cw31, g0, p1, p2);
    and gate32(cw32, g1, p2);
    or gate33(c3,cw30, cw31, cw32, g2);

    wire cw40, cw41, cw42, cw43;
    and gate40(cw40, CIn, p0, p1, p2, p3);
    and gate41(cw41, g0, p1, p2, p3);
    and gate42(cw42, g1, p2, p3);
    and gate43(cw43,g2, p3);
    or gate44(c4, cw40, cw41, cw42, cw43, g3);

    wire cw50, cw51, cw52, cw53, cw54;
    and gate50(cw50, CIn, p0, p1, p2, p3, p4);
    and gate51(cw51, g0, p1, p2, p3, p4);
    and gate52(cw52, g1, p2, p3, p4);
    and gate53(cw53, g2, p3, p4);
    and gate54(cw54, g3, p4 );
    or gate55(c5, cw50, cw51, cw52, cw53, cw53, cw54, g4);

    wire cw60, cw61, cw62, cw63, cw64, cw65;
    and gate60(cw60, CIn, p0, p1, p2, p3, p4, p5);
    and gate61(cw61, g0, p1, p2, p3, p4, p5);
    and gate62(cw62, g1, p2, p3, p4, p5);
    and gate63(cw63, g2, p3, p4, p5);
    and gate64(cw64, g3, p4, p5);
    and gate65(cw65, g4, p5);
    or gate66(c6,cw60, cw61, cw62, cw63, cw64, cw65, g5);

    wire cw70, cw71, cw72, cw73, cw74, cw75, cw76;
    and gate70(cw70, CIn, p0, p1, p2, p3, p4, p5, p6);
    and gate71(cw71, g0, p1, p2, p3, p4, p5, p6);
    and gate72(cw72, g1, p2, p3, p4, p5, p6);
    and gate73(cw73, g2, p3, p4, p5, p6);
    and gate74(cw74, g3, p4, p5, p6);
    and gate75(cw75, g4, p5, p6);
    and gate76(cw76, g5, p6);
    or gate77(c7, cw70, cw71, cw72, cw73, cw74, cw75, cw76, g6);

    adderOne addr0(S[0], p0, g0, A[0], B[0], CIn);
    adderOne addr1(S[1], p1, g1, A[1], B[1], c1);
    adderOne addr2(S[2], p2, g2, A[2], B[2], c2);
    adderOne addr3(S[3], p3, g3, A[3], B[3], c3);
    adderOne addr4(S[4], p4, g4, A[4], B[4], c4);
    adderOne addr5(S[5], p5, g5, A[5], B[5], c5);
    adderOne addr6(S[6], p6, g6, A[6], B[6], c6);
    adderOne addr7(S[7], p7, g7, A[7], B[7], c7);

    and pOutGate(POut,p7, p6, p5, p4, p3, p2, p1, p0);

    wire G0, G1, G2, G3, G4, G5, G6;
    and gateG0(G0, g0, p1, p2, p3, p4, p5, p6, p7);
    and gateG1(G1, g1, p2, p3, p4, p5, p6, p7);
    and gateG2(G2, g2, p3, p4, p5, p6, p7);
    and gateG3(G3, g3, p4, p5, p6, p7);
    and gateG4(G4, g4, p5, p6, p7);
    and gateG5(G5, g5, p6, p7);
    and gateG6(G6, g6, p7);
    or gOutGate(GOut, G0, G1, G2, G3, G4, G5, G6, g7); 
endmodule
module adderOne(S, pOut, gOut, A, B, CIn);
    input A, B, CIn;
    output S, pOut, gOut;
    
    xor Sresult(S, A, B, CIn);
    
    and gGate(gOut, A, B);
    or pGate(pOut, A,B);

endmodule