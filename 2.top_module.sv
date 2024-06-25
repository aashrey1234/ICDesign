`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 10:01:50 PM
// Design Name: 
// Module Name: top_smooth
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

module top_module(
    input logic clk,
    input logic reset,
    input logic enable,
    input logic [7:0] full_image[512][512],
    output logic [7:0] blurred_image[3][3],       // Output 3x3 blurred image
    output logic [7:0] sharped_image[512][512],
    output logic image_processed
);

    logic [7:0] current_3x3_matrix[3][3];
    logic [7:0] buffer_blur_3x3[3][3];
    logic [7:0] zero_padded_buffer[513][513];
    
    logic matrix_ready;
    logic buffer_blur_full;
    logic blur_done;
    logic sharpen_done;
    logic extract_enable;
    
    integer buffer_x = 1, buffer_y = 1; // Initial position for storing blurred images in zero_padded_buffer
    integer x = 1, y = 1; // Initial position for reading from zero_padded_buffer for sharpening

    // Instantiate modules
    input_image #(.ROWS(512), .COLS(512)) extractor(
        .clk(clk),
        .enable(extract_enable),
        .image(full_image),
        .out_image(current_3x3_matrix),
        .done(matrix_ready),
        .image_done(image_processed)
    );

    gaussian_blur blurrer(
        .clk(clk),
        .reset(reset),
        .enable(buffer_blur_full),
        .in_image(buffer_blur_3x3),
        .out_matrix(blurred_image),
        .done(blur_done)
    );

    sharpening sharp(
        .clk(clk),
        .reset(reset),
        .enable(blur_done), 
        .in_image(zero_padded_buffer),
        .out_matrix(sharped_image),
        .done(sharpen_done)
    );

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize the 513x513 buffer to zero
            for (int i = 0; i < 513; i++) begin
                for (int j = 0; j < 513; j++) begin
                    zero_padded_buffer[i][j] <= 8'd0;
                end
            end
            buffer_x <= 1;
            buffer_y <= 1;
            x <= 1;
            y <= 1;
            buffer_blur_full <= 1'b0;
            sharpen_done <= 1'b0;
            extract_enable <= 1'b1;
        end else if (enable) begin
            if (matrix_ready && !buffer_blur_full) begin
                buffer_blur_3x3 <= current_3x3_matrix;
                buffer_blur_full <= 1'b1;
                extract_enable <= 1'b0;
            end
            if (blur_done) begin
                // Store the 3x3 blurred output correctly without overlapping
                for (int dx = 0; dx < 3; dx = dx + 1) begin
                    for (int dy = 0; dy < 3; dy = dy + 1) begin
                        zero_padded_buffer[buffer_x + dx][buffer_y + dy] <= blurred_image[dx][dy];
                    end
                end
               
                buffer_y += 3;
                if (buffer_y >= 511) begin 
                    buffer_y <= 1;
                    buffer_x += 3;
                    if (buffer_x >= 511) begin
                        buffer_x <= 1;
                    end
                end
                buffer_blur_full <= 1'b0;
                extract_enable <= 1'b1; 
                blur_done <= 1'b0;
            end
            if (sharpen_done) begin
                sharpen_done <= 1'b0;
            end
        end else begin
            extract_enable <= 1'b0;
            buffer_blur_full <= 1'b0;
        end
    end
endmodule


