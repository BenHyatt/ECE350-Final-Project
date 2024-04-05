module adderFull(S, COut, A, B, CIn);

    input [31:0] A, B;
    input CIn;
    output [31:0] S;
    output COut; 
    
    wire P0, G0, P1, G1, P2, G2, P3, G3;
    adderBlock adderBlock0(S[7:0], P0, G0, A[7:0], B[7:0], CIn);
    adderBlock adderBlock1(S[15:8], P1, G1, A[15:8], B[15:8], c8);
    adderBlock adderBlock2(S[23:16], P2, G2, A[23:16], B[23:16], c16);
    adderBlock adderBlock3(S[31:24], P3, G3, A[31:24], B[31:24], c24);

    wire c8, c16, c24;

    wire cw80;
    and gate10(cw80, CIn, P0);
    or gate12(c8, cw80, G0);

    wire cw160, cw161;
    and gate160(cw160, CIn, P0, P1);
    and gate161(cw161, P1, G0);
    or gate162(c16, cw160, cw161, G1);


    wire cw240, cw241, cw242;
    and gate240(cw240, CIn, P0, P1, P2);
    and gate241(cw241, P2, P1, G0);
    and gate242(cw242, P2, G1);
    or gate243(c24, cw240, cw241, cw242, G2);

    wire cw320, cw321, cw322, cw323;
    and gate320(cw320, CIn, P0, P1, P2, P3);
    and gate321(cw321, P3, P2, P1, G0);
    and gate322(cw322, P3, P2, G1);
    and gate323(cw323, P3, G2);
    or gate324(COut, cw320, cw321, cw322, cw323, G3);


endmodule
