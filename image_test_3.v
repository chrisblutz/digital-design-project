// *** THIS IS AN AUTO-GENERATED MODULE ***

/*
 * Source image: assets/test-3.png
 * Image size: 10 x 10
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
module image_test_3(x_pos, y_pos, r, g, b, a, width, height);
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
	assign width = 10'h00A;
	assign height = 10'h00A;

	always @ (*)
	begin

		// =====================================
		// RED COLOR CHANNEL - 1 TOTAL VALUE(S)
		// =====================================

		// Value 0xFF for entire image
		r = 8'hFF;

		// =======================================
		// GREEN COLOR CHANNEL - 1 TOTAL VALUE(S)
		// =======================================

		// Value 0xFF for entire image
		g = 8'hFF;

		// =======================================
		//  BLUE COLOR CHANNEL - 1 TOTAL VALUE(S)
		// =======================================

		// Value 0xFF for entire image
		b = 8'hFF;

		// ==================
		//  ALPHA COLOR FLAG
		// ==================

		case (coordinate)
			// Value 0x1, 45 total pixels
			20'h00000, 20'h00400, 20'h00800, 
			20'h00C00, 20'h01000, 20'h01400, 
			20'h01800, 20'h01C00, 20'h02000, 
			20'h00001, 20'h00401, 20'h00801, 
			20'h00C01, 20'h01001, 20'h01401, 
			20'h01801, 20'h01C01, 20'h00002, 
			20'h00402, 20'h00802, 20'h00C02, 
			20'h01002, 20'h01402, 20'h01802, 
			20'h00003, 20'h00403, 20'h00803, 
			20'h00C03, 20'h01003, 20'h01403, 
			20'h00004, 20'h00404, 20'h00804, 
			20'h00C04, 20'h01004, 20'h00005, 
			20'h00405, 20'h00805, 20'h00C05, 
			20'h00006, 20'h00406, 20'h00806, 
			20'h00007, 20'h00407, 20'h00008: a = 1'h1;

			// Value 0x0, 55 total pixels
			20'h02400, 20'h02001, 20'h02401, 
			20'h01C02, 20'h02002, 20'h02402, 
			20'h01803, 20'h01C03, 20'h02003, 
			20'h02403, 20'h01404, 20'h01804, 
			20'h01C04, 20'h02004, 20'h02404, 
			20'h01005, 20'h01405, 20'h01805, 
			20'h01C05, 20'h02005, 20'h02405, 
			20'h00C06, 20'h01006, 20'h01406, 
			20'h01806, 20'h01C06, 20'h02006, 
			20'h02406, 20'h00807, 20'h00C07, 
			20'h01007, 20'h01407, 20'h01807, 
			20'h01C07, 20'h02007, 20'h02407, 
			20'h00408, 20'h00808, 20'h00C08, 
			20'h01008, 20'h01408, 20'h01808, 
			20'h01C08, 20'h02008, 20'h02408, 
			20'h00009, 20'h00409, 20'h00809, 
			20'h00C09, 20'h01009, 20'h01409, 
			20'h01809, 20'h01C09, 20'h02009, 
			20'h02409: a = 1'h0;

			default: a = 1'h0;
		endcase
	end
endmodule
