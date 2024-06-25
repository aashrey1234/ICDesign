`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: Processor
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

module Processor(clock,reset,enable_ex,src1,src2,imm,control_in,memory_data_read_in,mem_data_write_out,mem_write_en,aluout,carry);

    input logic clock;
    input logic reset;
    input logic enable_ex;
    input logic [`N-1:0] src1,src2;
    input logic [`N-1:0] imm;
    input logic [`C-1:0] control_in;
    input logic [`N-1:0] memory_data_read_in;
    
    output [`N-1:0]mem_data_write_out;
    output mem_write_en;
    output logic [`N-1:0]aluout;
    output logic carry; 
    
    logic [`N-1:0]aluin1,aluin2;
    logic [`O-1:0]operation_out,opselect_out;
    logic [`S-1:0]shift_number;
    logic enable_arith,enable_shift;
    
    Stage1_Execute S1(clock,reset,enable_ex,src1,src2,imm,control_in,memory_data_read_in,
        mem_data_write_out,mem_write_en,aluin1,aluin2,operation_out,opselect_out,shift_number,enable_arith,enable_shift
        ); 
    Stage2_ALU S2(clock, reset, aluin1, aluin2, operation_out, opselect_out,shift_number, enable_arith,enable_shift, aluout,carry);

endmodule
