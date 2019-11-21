// *** THIS IS AN AUTO-GENERATED MODULE ***

/*
 * Source image: assets/test-4.png
 * Image size: 200 x 200
 * Color depth: 8 bits
 * Expected coordinate size: 10 bits
 *
 * Generated on November 20, 2019 at 8:57:17 PM
 */

/*
 * Inputs/Outputs
 *  - [INPUT]  x_pos: 10-bit X-coordinate
 *  - [INPUT]  y_pos: 10-bit Y-coordinate
 *  - [OUTPUT] r:     8-bit red channel value
 *  - [OUTPUT] g:     8-bit green channel value
 *  - [OUTPUT] b:     8-bit blue channel value
 *  - [OUTPUT] a:     1-bit alpha channel flag (1 if solid, 0 if transparent)
 */
module image_test_4(x_pos, y_pos, r, g, b, a, width, height);
	input [9:0] x_pos, y_pos;
	output reg [7:0] r;
	output reg [7:0] g;
	output reg [7:0] b;
	// Alpha channel is single-bit flag
	output reg a;
	output [9:0] width, height;

	// Coordinates are combined x-y coordinates
	wire [19:0] coordinate;
	assign coordinate = {x_pos, y_pos};

	// Width/height outputs for graphics logic
	assign width = 10'h0C8;
	assign height = 10'h0C8;

	always @ (*)
	begin

		// =====================================
		// RED COLOR CHANNEL - 1 TOTAL VALUE(S)
		// =====================================

		// Value 0x0 for entire image
		r = 8'h00;

		// =======================================
		// GREEN COLOR CHANNEL - 1 TOTAL VALUE(S)
		// =======================================

		// Value 0xFF for entire image
		g = 8'hFF;

		// =======================================
		//  BLUE COLOR CHANNEL - 1 TOTAL VALUE(S)
		// =======================================

		// Value 0xBF for entire image
		b = 8'hBF;

		// ==================
		//  ALPHA COLOR FLAG
		// ==================

		// Value 0x1 for entire image
		a = 1'h1;
	end
endmodule
