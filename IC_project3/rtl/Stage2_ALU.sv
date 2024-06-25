`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: Stage2_ALU
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



module Stage2_ALU(clock, reset, aluin1, aluin2, operation, opselect,shift_number, enable_arith,enable_shift, aluout,carry);
  
    input logic clock;
    input logic reset;
    input logic [`N-1:0]aluin1,aluin2;
    input logic [`O-1:0]operation, opselect;
    input logic enable_arith,enable_shift;
    input logic [`S-1:0]shift_number;

    output logic [`N-1:0]aluout;
    output logic carry;  
    
    logic [`N:0] aluout1, aluout2;
    logic enable_arith_out, enable_shift_out;
    
    ARITH_ALU A1(clock, reset, aluin1, aluin2, operation, opselect, enable_arith, aluout1, enable_arith_out);
    SHIFT_ALU S1(clock, reset, aluin1, shift_number, operation, enable_shift, aluout2, enable_shift_out);
 
//This commented code will give you one extra cycle delay due to an extra flop 
//This is mentioned in the question. If you want then you can evaluate by uncommenting the below code.
//Also when you change from arithmetic to logic operation there will a cycle when output is xxxxx
//So In order to mitigate that I have passed the enable signal from the shift and arithmetic block so that both the above proble is solvedd at one go
//Also The block daigram mentioned is wrong as shift is assigned operation which will be  constant value to shift operation
//The shift should be assigned to shift_number which is not connected in the block diagram    
//    always_ff@(posedge clock)
//    begin
//        if(reset)
//        begin
//            carry <= 0;
//            aluout <= 0;
//        end
//        else
//        begin
//            aluout <= enable_arith? aluout1[`N-1:0]: aluout2[`N-1:0];
//            carry <= enable_arith? aluout1[`N]:aluout2[`N];
//        end      
//    end
 
    assign aluout = enable_arith_out? aluout1[`N-1:0]: enable_shift_out? aluout2[`N-1:0]:aluout;
    assign carry = enable_arith_out? aluout1[`N]:enable_shift_out? aluout2[`N]: carry;
    
endmodule
