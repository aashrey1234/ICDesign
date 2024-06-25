`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Design Name: 
// Module Name: Stage1_Execute
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

`define CLK_PERIOD 10
`define REGISTER_WIDTH 32
`define INSTR_WIDTH 32
`define IMMEDIATE_WIDTH 16
`define MEM_READ 3'b101
`define MEM_WRITE 3'b100
`define ARITH_LOGIC 3'b001
`define SHIFT_REG 3'b000


module Stage1_Execute(clock,reset,enable_ex,src1,src2,imm,control_in,memory_data_read_in,
    mem_data_write_out,mem_write_en,aluin1,aluin2,operation_out,opselect_out,shift_number,enable_arith,enable_shift
    );

    input logic clock;
    input logic reset;
    input logic enable_ex;
    input logic [`N-1:0] src1,src2;
    input logic [`N-1:0] imm;
    input logic [`C-1:0] control_in;
    input logic [`N-1:0] memory_data_read_in;
    
    output [`N-1:0]mem_data_write_out;
    output mem_write_en;
    output logic [`N-1:0]aluin1,aluin2;
    output logic [`O-1:0]operation_out,opselect_out;
    output logic [`S-1:0]shift_number;
    output logic enable_arith,enable_shift;
    
    logic immp_regn_op;
    logic [2:0]opselect,operation;
    
    assign immp_regn_op = control_in[3];
    assign opselect = control_in[2:0];
    assign operation = control_in[6:4];
    assign mem_data_write_out = src2;
    assign mem_write_en = (opselect == `MEM_WRITE) && (immp_regn_op == 1);
    
    always@(posedge clock)
    begin
        if(reset)
            aluin1 <= 0;
        else
        begin
            aluin1 <= enable_ex? src1:aluin1;
        end
    end
 
    always@(posedge clock)
    begin
        if(reset)
            aluin2 <= 0;
        else
        begin
            case({enable_ex,opselect,immp_regn_op})
                5'b0????: aluin2 <= aluin2;
                {1'b1,`ARITH_LOGIC,1'b0}: aluin2 <= src2;
                {1'b1,`ARITH_LOGIC,1'b1}: aluin2 <= imm;
                {1'b1,`MEM_READ,1'b0}: aluin2 <= aluin2;
                {1'b1,`MEM_READ,1'b1}: aluin2 <= memory_data_read_in;
                default: aluin2 <= aluin2;
            endcase
        end
    end   
    
    always@(posedge clock)
    begin
        if(reset)
            operation_out <= 0;
        else
        begin
            operation_out <= enable_ex? operation: operation_out;
        end
    end
 
    always@(posedge clock)
    begin
        if(reset)
            opselect_out <= 0;
        else
        begin
            opselect_out <= enable_ex? opselect: opselect_out;
        end
    end 
 
    always@(posedge clock)
    begin
        if(reset)
            shift_number <= 0;
        else
        begin
            case({enable_ex,opselect,imm[2]})
                5'b0????: shift_number <= 0;
                {1'b1,`SHIFT_REG,1'b0}: shift_number <= imm[10:6];
                {1'b1,`SHIFT_REG,1'b1}: shift_number <= src2[4:0];
                default: shift_number <= 0;
            endcase
        end
    end  
    
    always@(posedge clock)
    begin
        if(reset)
            enable_arith <= 0;
        else
        begin
            case({enable_ex,opselect,immp_regn_op})
                5'b0????: enable_arith <= 0;
                {1'b1,`ARITH_LOGIC,1'b0}: enable_arith <= 1;
                {1'b1,`ARITH_LOGIC,1'b1}: enable_arith <= 1;
                {1'b1,`MEM_READ,1'b0}: enable_arith <= 0;
                {1'b1,`MEM_READ,1'b1}: enable_arith <= 1;
                default: enable_arith <= 0;
            endcase
        end
    end       

    always@(posedge clock)
    begin
        if(reset)
            enable_shift <= 0;
        else
        begin
            case({enable_ex,opselect})
                4'b0????: enable_shift <= 0;
                {1'b1,`SHIFT_REG}: enable_shift <= 1;
                default: enable_shift <= 0;
            endcase
        end
    end  
        
endmodule
