`timescale 1ns / 1ps
module RAM #( parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 12, DEPTH = 4096) (
    input wire                     clk,
    input wire                     wEn,
    input wire [ADDRESS_WIDTH-1:0] addr,
    input wire [ADDRESS_WIDTH-1:0] addrMotorA,
    input wire [ADDRESS_WIDTH-1:0] addrMotorB,
    input wire [ADDRESS_WIDTH-1:0] addrSensorA,
    input wire [DATA_WIDTH-1:0]    dataIn,
    input wire [DATA_WIDTH-1:0]    dataInSensorA,
    output reg [DATA_WIDTH-1:0]    dataOut = 0,
    output reg [DATA_WIDTH-1:0]    dataOutMotorA = 0,
    output reg [DATA_WIDTH-1:0]    dataOutMotorB = 0    
    );
    
    reg[DATA_WIDTH-1:0] MemoryArray[0:DEPTH-1];
    
    integer i;
    initial begin
        for (i = 0; i < DEPTH; i = i + 1) begin
            MemoryArray[i] <= 0;
        end
        // if(MEMFILE > 0) begin
        //     $readmemh(MEMFILE, MemoryArray);
        // end
    end
    
    always @(posedge clk) begin
        if(wEn) begin
            MemoryArray[addr] <= dataIn;
        end else begin
            MemoryArray[addrSensorA] <= dataInSensorA;
            dataOut <= MemoryArray[addr];
            dataOutMotorA <= MemoryArray[addrMotorA];
            dataOutMotorB <= MemoryArray[addrMotorB];
        end
    end
endmodule
