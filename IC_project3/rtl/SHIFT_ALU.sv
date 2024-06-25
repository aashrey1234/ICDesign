`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: SHIFT_ALU
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


// SHIFTING
`define SHLEFTLOG 3'b000
`define SHLEFTART 3'b001
`define SHRGHTLOG 3'b010
`define SHRGHTART 3'b011


module SHIFT_ALU(clock, reset, in, shift, shift_operation, enable, aluout,enable_shift_out);

    input logic clock;
    input logic reset;
    input logic signed [`N-1:0]in;
    input logic [`O-1:0] shift_operation;
    input logic [`S-1:0] shift; 
    input logic enable;
    
    output logic signed [`N:0]aluout;
    output logic enable_shift_out;
    
    always@(posedge clock)
    begin
        if(reset)
            aluout <= 0;
        else
        begin
            case({enable,1'b0,shift_operation[1:0]})
                4'b0????: aluout <= aluout;
                {1'b1,`SHLEFTLOG}: aluout <= {1'b0,in << shift};
                {1'b1,`SHLEFTART}: aluout <= {in[`N-1],in << shift};
                {1'b1,`SHRGHTLOG}: aluout <= {1'b0,in >> shift};
                {1'b1,`SHRGHTART}: aluout <= {1'b0,in >>> shift};
                default: aluout = aluout;
            endcase
        end
        
        enable_shift_out = enable;
        
    end       

endmodule
