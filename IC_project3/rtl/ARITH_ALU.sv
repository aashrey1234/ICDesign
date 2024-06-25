`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: ARITH_ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define N 32
`define C 7
`define O 3
`define S 5

`define MEM_READ 3'b101
`define MEM_WRITE 3'b100
`define ARITH_LOGIC 3'b001
`define SHIFT_REG 3'b000

// ARITHMETIC
`define ADD 3'b000
`define HADD 3'b001
`define SUB 3'b010
`define NOT 3'b011
`define AND 3'b100
`define OR 3'b101
`define XOR 3'b110
`define LHG 3'b111

// DATA TRANSFER
`define LOADBYTE 3'b000
`define LOADBYTEU 3'b100
`define LOADHALF 3'b001
`define LOADHALFU 3'b101
`define LOADWORD 3'b011

module ARITH_ALU(clock, reset, aluin1, aluin2, aluoperation, aluopselect, enable, aluout, enable_arith_out);

    input logic clock;
    input logic reset;
    input logic signed [`N-1:0]aluin1,aluin2;
    input logic [`O-1:0]aluoperation, aluopselect;
    input logic enable;
    
    output logic signed [`N:0]aluout;
    output logic enable_arith_out;
    
    always_ff@(posedge clock)
    begin
        if(reset)
            aluout <= 0;
        else
        begin
            case({enable,aluopselect,aluoperation})
                7'b0????: aluout <= aluout;
                {1'b1,`ARITH_LOGIC, `ADD}: aluout <= aluin1 + aluin2;
                {1'b1,`ARITH_LOGIC, `HADD}: aluout <= $signed(aluin1[15:0] + aluin2[15:0]);
                {1'b1,`ARITH_LOGIC, `SUB}: aluout <= aluin1 - aluin2;
                {1'b1,`ARITH_LOGIC, `NOT}: begin aluout[32]<= 0; aluout[31:0] <= ~aluin2[31:0]; end
                {1'b1,`ARITH_LOGIC, `AND}: aluout <= aluin1 & aluin2;
                {1'b1,`ARITH_LOGIC, `OR}: aluout <= aluin1 | aluin2;
                {1'b1,`ARITH_LOGIC, `XOR}: aluout <= aluin1 ^ aluin2;
                {1'b1,`ARITH_LOGIC, `LHG}: aluout <= {1'b0,aluin2[15:0],16'b0};
                {1'b1,`MEM_READ, `LOADBYTE}: aluout <= {1'b0,{24{aluin2[7]}}, aluin2[7:0]};
                {1'b1,`MEM_READ, `LOADBYTEU}: aluout <= {1'b0,24'b0, aluin2[7:0]};
                {1'b1,`MEM_READ, `LOADHALF}: aluout <= {1'b0,{16{aluin2[15]}}, aluin2[15:0]};
                {1'b1,`MEM_READ, `LOADHALFU}: aluout <= {1'b0,16'b0, aluin2[15:0]};
                {1'b1,`MEM_READ, `LOADWORD}: aluout <= {1'b0, aluin2[31:0]};
                {1'b1,`MEM_READ, 3'b???}: aluout <= {1'b0, aluin2[31:0]};
                default: aluout <= aluout;
            endcase
            
            enable_arith_out = enable;
        end
    end  
    
endmodule
