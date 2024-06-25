`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 01:38:01 PM
// Design Name: 
// Module Name: input_image
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

module input_image #(
    parameter integer ROWS = 512, // Number of rows in the full image
    parameter integer COLS = 512  // Number of columns in the full image
)(
    input logic clk,              // Clock signal
    input logic enable,           // Module enable signal
    input logic [7:0] image[ROWS][COLS], // Input image array
    output logic [7:0] out_image[3][3],  // Output 3x3 image matrix
    output logic done,            // Signal to indicate 3x3 matrix output is ready
    output logic image_done       // Signal to indicate entire image has been processed
);

    int i = 0, j = 0; // Indices for the output matrix
    int m = 0, n = 0; // Indices for the top-left corner of the current 3x3 matrix in the padded image

    always_ff @(posedge clk) begin
        if (enable) begin
            done = 0; // Default the done signal to 0 at the beginning of each cycle
            if (m <= ROWS && n <= COLS) begin // Iterate through each pixel in the original image dimensions
                if (i < 3) begin
                    if (j < 3) begin
                        // Check bounds and assign zero if out of bounds of the original image, otherwise assign actual image pixel
                        out_image[i][j] = (m+i-1 < 0 || n+j-1 < 0 || m+i-1 >= ROWS || n+j-1 >= COLS) ? 8'd0 : image[m+i-1][n+j-1];
                        j = j + 1; // Increment the column index for the output matrix
                    end
                    if (j == 3) begin
                        j = 0; // Reset the column index of the output matrix after filling a row
                        i = i + 1; // Increment the row index of the output matrix
                    end
                end
                if (i == 3) begin
                    done = 1; // Assert the done signal once a full 3x3 matrix is output
                    i = 0; // Reset the row index for the next output matrix
                    n = n + 1; // Move to the next column for the top-left corner of the next 3x3 matrix
                    if (n > COLS) begin
                        n = 0; // Reset column index after the last valid matrix in a row
                        m = m + 1; // Move the top-left corner down to the next row
                        if (m > ROWS) begin
                            image_done = 1; // Assert the image_done signal when all matrices have been processed
                        end
                    end
                end
            end
        end else begin
            done = 0; // Ensure done is 0 when the module is disabled
            image_done = 0; // Reset image_done when the module is not enabled
        end
    end
endmodule


