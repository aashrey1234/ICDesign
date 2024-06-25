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


//module input_image #(
    
//    parameter integer ROWS = 512, 
//    parameter integer COLS = 512  
//)(
//    input logic clk,
//    input logic enable, 
//    input logic [7:0] image[ROWS][COLS], 
//    output logic [7:0] out_image[3][3], 
//    output logic done, 
//    output logic image_done 
//);
//int i = 0, j = 0, m = 0, n = 0;

//    always_ff @(posedge clk) begin
//    if(enable) begin
//        if(i<3) begin
//            if(j<3) begin
//            out_image[i][j] = image[i+m][j+n];
//            j = j + 1;
//            end
//            else begin 
//            j = 0;
//            i = i + 1;
//            //out_image[i][j] = image[i+m][j+n];
//            end
//            if(i==2 && j == 2)
//                done = 1;
//            else
//                done = 0;
//            end
//        else begin    
//            i = 0;
//            j = 0; 
//            //image_done = 1;
//            n = n + 1;
//                if((n == (COLS - 1)) && m < ROWS) begin
//                    n = 0;
//                    m = m + 1;
//                    end
//                    else if (m == (ROWS - 1))
//                        image_done = 1;
//                        else
//                        image_done = 0;
//            end
//    end
// end                    
    
//endmodule

//module input_image #(
//    parameter integer ROWS = 512, // Number of rows in the full image
//    parameter integer COLS = 512  // Number of columns in the full image
//)(
//    input logic clk,              // Clock signal
//    input logic enable,           // Module enable signal
//    input logic [7:0] image[ROWS][COLS], // Input image array
//    output logic [7:0] out_image[3][3],  // Output 3x3 image matrix
//    output logic done,            // Signal to indicate 3x3 matrix output is ready
//    output logic image_done       // Signal to indicate entire image has been processed
//);

//    int i = 0, j = 0; // Indices for the output matrix
//    int m = 0, n = 0; // Indices for the top-left corner of the current 3x3 matrix in the input image

//    always_ff @(posedge clk) begin
//        if (enable) begin
//            if (m <= ROWS - 3 && n <= COLS - 3) begin // Ensure indices are within the valid range
//                if (i < 3) begin
//                    if (j < 3) begin
//                        out_image[i][j] = image[m+i][n+j]; // Assign values to the output matrix
//                        j = j + 1; // Move to the next column in the 3x3 matrix
//                    end
//                    if (j == 3) begin
//                        j = 0; // Reset column index after filling one row of the 3x3 matrix
//                        i = i + 1; // Move to the next row in the 3x3 matrix
//                    end
//                end
//                if (i == 3) begin
//                    done = 1; // Indicate that the 3x3 matrix is ready
//                    i = 0; // Reset the 3x3 matrix row index for the next matrix
//                    n = n + 1; // Move the top-left corner of the 3x3 matrix to the next column in the input image
//                    if (n == COLS - 2) begin // Check if it is time to move to the next row in the input image
//                        n = 0; // Reset column index for the top-left corner of the 3x3 matrix
//                        m = m + 1; // Move the top-left corner of the 3x3 matrix down
//                        if (m == ROWS - 2) begin
//                            image_done = 1; // Indicate that the entire image has been processed
//                        end
//                    end
//                end
//            end else begin
//                done = 0;
//                image_done = 1; // Indicate that processing is complete if indices go out of range
//            end
//        end else begin
//            done = 0;
//            image_done = 0; // Clear done signals if module is not enabled
//        end
//    end
//endmodule

//module input_image #(
//    parameter integer ROWS = 512, // Number of rows in the full image
//    parameter integer COLS = 512  // Number of columns in the full image
//)(
//    input logic clk,              // Clock signal
//    input logic enable,           // Module enable signal
//    input logic [7:0] image[ROWS][COLS], // Input image array
//    output logic [7:0] out_image[3][3],  // Output 3x3 image matrix
//    output logic done,            // Signal to indicate 3x3 matrix output is ready
//    output logic image_done       // Signal to indicate entire image has been processed
//);

//    int i = 0, j = 0; // Indices for the output matrix
//    int m = 0, n = 0; // Indices for the top-left corner of the current 3x3 matrix in the input image

//    always_ff @(posedge clk) begin
//        if (enable) begin
//            done = 0; // Default the done signal to 0 at the beginning of each cycle
//            if (m < ROWS-2 && n < COLS-2) begin // Ensure the 3x3 matrix fits within the image dimensions
//                if (i < 3) begin
//                    if (j < 3) begin
//                        out_image[i][j] = image[m+i][n+j]; // Assign pixel values to the 3x3 output matrix
//                        j = j + 1; // Increment the column index for the output matrix
//                    end
//                    if (j == 3) begin
//                        j = 0; // Reset the column index of the output matrix after filling a row
//                        i = i + 1; // Increment the row index of the output matrix
//                    end
//                end
//                if (i == 3) begin
//                    done = 1; // Assert the done signal once a full 3x3 matrix is output
//                    i = 0; // Reset the row index for the next output matrix
//                    n = n + 1; // Move to the next column for the top-left corner of the next 3x3 matrix
//                    if (n == COLS - 2) begin
//                        n = 0; // Reset the top-left corner column to the first column after the last valid matrix in a row
//                        m = m + 1; // Move the top-left corner down to the next row
//                        if (m == ROWS - 2) begin
//                            image_done = 1; // Assert the image_done signal when the bottom-right matrix is reached
//                        end
//                    end
//                end
//            end
//        end else begin
//            done = 0; // Ensure done is 0 when the module is disabled
//            image_done = 0; // Reset image_done when the module is not enabled
//        end
//    end
//endmodule

//module input_image #(
//    parameter integer ROWS = 512, // Number of rows in the full image
//    parameter integer COLS = 512  // Number of columns in the full image
//)(
//    input logic clk,              // Clock signal
//    input logic enable,           // Module enable signal
//    input logic [7:0] image[ROWS][COLS], // Input image array
//    output logic [7:0] out_image[3][3],  // Output 3x3 image matrix
//    output logic done,            // Signal to indicate 3x3 matrix output is ready
//    output logic image_done       // Signal to indicate entire image has been processed
//);

//    int i = 0, j = 0; // Indices for the output matrix
//    int m = 0, n = 0; // Indices for the top-left corner of the current 3x3 matrix in the input image, starting from -1 due to padding
//    logic [7:0] padded_image[ROWS+2][COLS+2]; // Padded image array

//    // Initialize the padded image with zero padding
//    initial begin
//        for (int x = 0; x < ROWS+2; x++) begin
//            for (int y = 0; y < COLS+2; y++) begin
//                if (x == 0 || y == 0 || x == ROWS+1 || y == COLS+1)
//                    padded_image[x][y] = 8'd0; // Zero padding
//                else
//                    padded_image[x+1][y+1] = image[x][y]; // Copy original image into the center
//            end
//        end
//    end

//    always_ff @(posedge clk) begin
//        if (enable) begin
//            done = 0; // Default the done signal to 0 at the beginning of each cycle
//            if (m <= ROWS && n <= COLS) begin // Adjusted for zero-padded indices
//                if (i < 3) begin
//                    if (j < 3) begin
//                        out_image[i][j] = padded_image[m+i][n+j]; // Use padded_image for output
//                        j = j + 1; // Increment the column index for the output matrix
//                    end
//                    if (j == 3) begin
//                        j = 0; // Reset the column index of the output matrix after filling a row
//                        i = i + 1; // Increment the row index of the output matrix
//                    end
//                end
//                if (i == 3) begin
//                    done = 1; // Assert the done signal once a full 3x3 matrix is output
//                    i = 0; // Reset the row index for the next output matrix
//                    n = n + 1; // Move to the next column for the top-left corner of the next 3x3 matrix
//                    if (n == COLS + 1) begin
//                        n = 0; // Reset column index after the last valid matrix in a row
//                        m = m + 1; // Move the top-left corner down to the next row
//                        if (m == ROWS + 1) begin
//                            image_done = 1; // Assert the image_done signal when all matrices have been processed
//                        end
//                    end
//                end
//            end
//        end else begin
//            done = 0; // Ensure done is 0 when the module is disabled
//            image_done = 0; // Reset image_done when the module is not enabled
//        end
//    end
//endmodule

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


