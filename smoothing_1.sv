`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2024 01:53:46 PM
// Design Name: 
// Module Name: smoothing_1
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



//module gaussian_blur #(
//    parameter integer ROWS = 512, 
//    parameter integer COLS = 512  
//)(
//    input logic clk,
//    input logic reset,
//    input logic enable, 
//    input logic [7:0] image[ROWS][COLS], 
//    output logic [7:0] blurred_image[ROWS][COLS], 
//    output logic done 
//);

    
//    localparam integer P_ROWS = ROWS + 2;
//    localparam integer P_COLS = COLS + 2;

    
//    logic [7:0] padded_image[P_ROWS-1:0][P_COLS-1:0];

//    integer i, j, sum; 
//    logic processing; 

//    // Gaussian blur operation
//    always_ff @(posedge clk or posedge reset) begin
//        if (reset) begin
//            i <= 1; 
//            j <= 1;
//            done <= 0;
//            processing <= 0;
//        end else if (enable && !processing) begin
//            processing <= 1;
//            done <= 0;
//            // Initialize padded image, including zero padding
//            for (int m = 0; m < P_ROWS; m++) begin
//                for (int n = 0; n < P_COLS; n++) begin
//                    // zero padding at borders and coping image into center
//                    if (m == 0 || n == 0 || m == P_ROWS-1 || n == P_COLS-1)
//                        padded_image[m][n] = 0;
//                    else
//                        padded_image[m][n] = image[m-1][n-1];
//                end
//            end
//        end else if (processing) begin
//            // Performs Gaussian convolution on padded image
//            sum = 
//                padded_image[i-1][j-1] + 2*padded_image[i-1][j] + padded_image[i-1][j+1] +
//                2*padded_image[i][j-1]   + 4*padded_image[i][j]   + 2*padded_image[i][j+1] +
//                padded_image[i+1][j-1] + 2*padded_image[i+1][j] + padded_image[i+1][j+1];

//            // Normalize and assign to blurred_image
//            blurred_image[i-1][j-1] <= sum >> 4; 

//            if (j == COLS) begin
//                j <= 1;
//                i <= i + 1;
//            end else begin
//                j <= j + 1;
//            end

//            // Check for completion
//            if (i == ROWS + 1) begin
//                done <= 1;
//                processing <= 0;
//            end
//        end
//    end

//endmodule

//module gaussian_blur(
//    input logic clk,                 // Clock signal
//    input logic reset,               // Reset signal
//    input logic enable,              // Enable signal for processing
//    input logic [7:0] in_image[3][3], // Input 3x3 image matrix
//    output reg [7:0] out_pixel,       // Output pixel after Gaussian blur
//    output reg done                  // Signal to indicate processing is complete
//);

//    // Gaussian kernel
//    parameter [3:0] kernel[0:2][0:2] = '{
//        {1, 2, 1},
//        {2, 4, 2},
//        {1, 2, 1}
//    };

//    reg [15:0] sum;                // Sum of products for the blur calculation
//    reg [1:0] i, j;                // Indices to access elements of the image and kernel
//    reg [3:0] product;             // Current product of image pixel and kernel value

//    always @(posedge clk or posedge reset) begin
//        if (reset) begin
//            sum <= 0;
//            i <= 0;
//            j <= 0;
//            done <= 0;
//        end else if (enable) begin
//            if (i < 3) begin
//                if (j < 3) begin
//                    // Calculate product of current image pixel and kernel coefficient
//                    product = in_image[i][j] * kernel[i][j];
//                    sum = sum + product;  // Accumulate the product
//                    j = j + 1;  // Move to the next column
//                end
//                if (j == 3) begin
//                    j = 0;  // Reset column index after finishing a row
//                    i = i + 1;  // Move to the next row
//                end
//            end
//            if (i == 3) begin
//                out_pixel = sum >> 4; // Normalize the accumulated sum to get the final pixel value
//                done = 1;  // Indicate that the computation is complete
//                // Reset indices and sum to be ready for another operation if needed
//                i = 0;
//                sum = 0;
//            end else begin
//                done = 0;  // Ensure done is low while processing is ongoing
//            end
//        end
//    end
//endmodule

module gaussian_blur(
    input logic clk,                // Clock signal
    input logic reset,              // Reset signal
    input logic enable,             // Enable signal for processing
    input logic [7:0] in_image[3][3], // Input 3x3 image matrix
    output logic [7:0] out_matrix[3][3], // Output matrix to store 3x3 convoluted results
    output reg done                 // Signal to indicate all outputs are stored
);

    int sum;                
    int i, j;               
    int out_row, out_col;    
    wire [7:0] current_output;     

    // Gaussian kernel
    parameter [3:0] kernel[0:2][0:2] = '{
        {1, 2, 1},
        {2, 4, 2},
        {1, 2, 1}
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
                    sum <= sum + in_image[i][j] * kernel[i][j];  // Accumulate the product
                    j <= j + 1;  // Increment column index
                end
                if (j == 3) begin
                    j <= 0;
                    i <= i + 1;  // Increment row index after finishing one row
                end
            end

            if (i == 3) begin
                out_matrix[out_row][out_col] <= sum >> 4;  
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
            end 
            else begin
                done <= 0;  
            end
        end
    end

    assign current_output = sum >> 4;

endmodule

