`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2024 11:39:07 AM
// Design Name: 
// Module Name: blending
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

module sequential_matrix_blend #(
    parameter integer ROWS = 512, 
    parameter integer COLS = 512  
)(
    input logic clk,
    input logic reset,
    input logic enable, 
    input logic [7:0] original_matrix[ROWS][COLS], 
    input logic [7:0] sharpened_matrix[ROWS][COLS], 
    output logic [7:0] blended_matrix[ROWS][COLS], 
    output logic done 
);

    integer row_index = 0, col_index = 0;
    integer sum_pixel;
    // Perform blending operations at each clock cycle
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            row_index <= 0;
            col_index <= 0;
            done <= 0;
        end else if (enable && !done) begin
            // Calculate sum with overflow protection
            sum_pixel = {2'b00,original_matrix[row_index][col_index]} + {2'b00,sharpened_matrix[row_index][col_index]};
            blended_matrix[row_index][col_index] <= sum_pixel > 255 ? 8'd255 : sum_pixel[7:0];

            // Increment indexes for next pixel
            col_index <= col_index + 1;
            if (col_index == COLS-1) begin
                col_index <= 0;
                row_index <= row_index + 1;

                if (row_index == ROWS-1) begin
                    done <= 1; // Indicate completion
                    row_index <= 0; 
                end
            end
        end
    end

endmodule

