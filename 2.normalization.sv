`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2024 02:02:48 AM
// Design Name: 
// Module Name: normalization
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

module matrix_pixel_normalizer
#(
    parameter int DATA_WIDTH = 8, 
    parameter int ROWS = 128,     
    parameter int COLS = 128      
)
(
    input  logic clk,
    input  logic reset,
    input  logic [DATA_WIDTH-1:0] min_val, 
    input  logic [DATA_WIDTH-1:0] max_val, 
    input  logic [DATA_WIDTH-1:0] input_matrix[ROWS][COLS],
    output logic done,                     
    output logic [DATA_WIDTH-1:0] normalized_matrix[ROWS][COLS] = '{default: '0} 
);


int current_row = 0;
int current_col = 0;


always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        current_row <= 0;
        current_col <= 0;
        done <= 0;
    end
    else if (!done) begin
        // Normalize the current pixel
        if (max_val != min_val) begin
            normalized_matrix[current_row][current_col] <= 
                (input_matrix[current_row][current_col] - min_val) * ((1 << DATA_WIDTH) - 1) / (max_val - min_val);
        end
        else begin
            normalized_matrix[current_row][current_col] <= 0; 
        end
        
        // Move to the next pixel
        if (current_col < COLS - 1) begin
            current_col <= current_col + 1;
        end
        else if (current_row < ROWS - 1) begin
            current_row <= current_row + 1;
            current_col <= 0;
        end
        else begin
            done <= 1; 
        end
    end
end

endmodule

//* ((1 << DATA_WIDTH) - 1)

