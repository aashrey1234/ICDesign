`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2024 11:16:27 AM
// Design Name: 
// Module Name: sharpening_1
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


module sharpening(
    input logic clk,                // Clock signal
    input logic reset,              // Reset signal
    input logic enable,             // Enable signal for processing
    input logic [7:0] in_image[3][3], // Input 3x3 image matrix
    output logic [7:0] out_matrix[512][512], // Output matrix to store 3x3 convoluted results
    output reg done                 // Signal to indicate all outputs are stored
);

    int sum;                
    int i, j;               
    int out_row, out_col;    
    wire [7:0] current_output;     

    // Gaussian kernel
    parameter [3:0] kernel[0:2][0:2] = '{
        {0, -1, 0},
        {-1, 5, -1},
        {0, -1, 0}
    };

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sum <= 0;
            i <= 0;
            j <= 0;
            out_row <= 0;
            out_col <= 0;
            done <= 0;
        end else if (enable) begin
            if (i < 3) begin
                if (j < 3) begin
                    sum <= $signed(sum) + $signed(in_image[i][j]) * $signed(kernel[i][j]);  // Accumulate the product
                    j <= j + 1;  // Increment column index
                end
                if (j == 3) begin
                    j <= 0;
                    i <= i + 1;  // Increment row index after finishing one row
                end
            end

            if (i == 3) begin
                out_matrix[out_row][out_col] <= sum;  
                sum <= 0;  
                i <= 0;
                done <= 1; 
                // Move to the next position in the output matrix
                out_col <= out_col + 1;
                if (out_col == 512) begin
                    out_col <= 0;
                    out_row <= out_row + 1;
                end
                if (out_row == 512) begin
        
                    out_row <= 0;  
                end
            end else begin
                done <= 0;  
            end
        end
    end

    
    assign current_output = sum;

endmodule