// *** THIS IS AN AUTO-GENERATED MODULE ***

/*
 * Source image: assets/test-2.png
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
module image_test_2(x_pos, y_pos, r, g, b, a, width, height);
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

		// ======================================
		// RED COLOR CHANNEL - 37 TOTAL VALUE(S)
		// ======================================

		case (coordinate)
			// Value 0xFF, 1 total pixels
			20'h00000: r = 8'hFF;

			// Value 0xF3, 1 total pixels
			20'h00400: r = 8'hF3;

			// Value 0xE6, 3 total pixels
			20'h00800, 20'h00401, 20'h00002: r = 8'hE6;

			// Value 0xD9, 3 total pixels
			20'h00C00, 20'h00801, 20'h00402: r = 8'hD9;

			// Value 0xCD, 1 total pixels
			20'h01000: r = 8'hCD;

			// Value 0xBF, 4 total pixels
			20'h01400, 20'h01001, 20'h00803, 
			20'h00404: r = 8'hBF;

			// Value 0xB1, 2 total pixels
			20'h01800, 20'h00804: r = 8'hB1;

			// Value 0xA5, 6 total pixels
			20'h01C00, 20'h01402, 20'h01003, 
			20'h00C04, 20'h00406, 20'h00007: r = 8'hA5;

			// Value 0x99, 5 total pixels
			20'h02000, 20'h01802, 20'h01004, 
			20'h00806, 20'h00407: r = 8'h99;

			// Value 0x8B, 4 total pixels
			20'h02400, 20'h02001, 20'h01005, 
			20'h00408: r = 8'h8B;

			// Value 0xF2, 1 total pixels
			20'h00001: r = 8'hF2;

			// Value 0xCB, 2 total pixels
			20'h00C01, 20'h00004: r = 8'hCB;

			// Value 0xB3, 1 total pixels
			20'h01401: r = 8'hB3;

			// Value 0xA6, 2 total pixels
			20'h01801, 20'h00805: r = 8'hA6;

			// Value 0x98, 4 total pixels
			20'h01C01, 20'h01403, 20'h00C05, 
			20'h00008: r = 8'h98;

			// Value 0x7F, 5 total pixels
			20'h02401, 20'h02002, 20'h01006, 
			20'h00C07, 20'h00409: r = 8'h7F;

			// Value 0xCC, 2 total pixels
			20'h00802, 20'h00403: r = 8'hCC;

			// Value 0xC0, 1 total pixels
			20'h00C02: r = 8'hC0;

			// Value 0xB2, 4 total pixels
			20'h01002, 20'h00C03, 20'h00405, 
			20'h00006: r = 8'hB2;

			// Value 0x8C, 6 total pixels
			20'h01C02, 20'h01803, 20'h01404, 
			20'h00C06, 20'h00807, 20'h00009: r = 8'h8C;

			// Value 0x72, 5 total pixels
			20'h02402, 20'h02003, 20'h01C04, 
			20'h01406, 20'h01007: r = 8'h72;

			// Value 0xD8, 1 total pixels
			20'h00003: r = 8'hD8;

			// Value 0x7E, 4 total pixels
			20'h01C03, 20'h01804, 20'h01405, 
			20'h00808: r = 8'h7E;

			// Value 0x65, 6 total pixels
			20'h02403, 20'h01C05, 20'h01806, 
			20'h01407, 20'h01008, 20'h00C09: r = 8'h65;

			// Value 0x66, 1 total pixels
			20'h02004: r = 8'h66;

			// Value 0x59, 3 total pixels
			20'h02404, 20'h02005, 20'h01C06: r = 8'h59;

			// Value 0xBE, 1 total pixels
			20'h00005: r = 8'hBE;

			// Value 0x71, 3 total pixels
			20'h01805, 20'h00C08, 20'h00809: r = 8'h71;

			// Value 0x4B, 5 total pixels
			20'h02405, 20'h02006, 20'h01C07, 
			20'h01808, 20'h01409: r = 8'h4B;

			// Value 0x3F, 1 total pixels
			20'h02406: r = 8'h3F;

			// Value 0x57, 2 total pixels
			20'h01807, 20'h01408: r = 8'h57;

			// Value 0x3E, 3 total pixels
			20'h02007, 20'h01C08, 20'h01809: r = 8'h3E;

			// Value 0x31, 2 total pixels
			20'h02407, 20'h02008: r = 8'h31;

			// Value 0x25, 2 total pixels
			20'h02408, 20'h02009: r = 8'h25;

			// Value 0x58, 1 total pixels
			20'h01009: r = 8'h58;

			// Value 0x32, 1 total pixels
			20'h01C09: r = 8'h32;

			// Value 0x18, 1 total pixels
			20'h02409: r = 8'h18;

			default: r = 8'h00;
		endcase

		// ========================================
		// GREEN COLOR CHANNEL - 30 TOTAL VALUE(S)
		// ========================================

		case (coordinate)
			// Value 0x0, 1 total pixels
			20'h00000: g = 8'h00;

			// Value 0x5, 2 total pixels
			20'h00400, 20'h00001: g = 8'h05;

			// Value 0xB, 1 total pixels
			20'h00800: g = 8'h0B;

			// Value 0x10, 4 total pixels
			20'h00C00, 20'h00801, 20'h00402, 
			20'h00003: g = 8'h10;

			// Value 0x15, 5 total pixels
			20'h01000, 20'h00C01, 20'h00802, 
			20'h00403, 20'h00004: g = 8'h15;

			// Value 0x1B, 4 total pixels
			20'h01400, 20'h01001, 20'h00404, 
			20'h00005: g = 8'h1B;

			// Value 0x20, 7 total pixels
			20'h01800, 20'h01401, 20'h01002, 
			20'h00C03, 20'h00804, 20'h00405, 
			20'h00006: g = 8'h20;

			// Value 0x25, 5 total pixels
			20'h01C00, 20'h01801, 20'h01003, 
			20'h00C04, 20'h00805: g = 8'h25;

			// Value 0x2A, 5 total pixels
			20'h02000, 20'h01802, 20'h01004, 
			20'h00C05, 20'h00806: g = 8'h2A;

			// Value 0x30, 8 total pixels
			20'h02400, 20'h02001, 20'h01C02, 
			20'h01803, 20'h01005, 20'h00C06, 
			20'h00807, 20'h00009: g = 8'h30;

			// Value 0xA, 2 total pixels
			20'h00401, 20'h00002: g = 8'h0A;

			// Value 0x2B, 4 total pixels
			20'h01C01, 20'h01403, 20'h00407, 
			20'h00008: g = 8'h2B;

			// Value 0x35, 7 total pixels
			20'h02401, 20'h02002, 20'h01804, 
			20'h01006, 20'h00C07, 20'h00808, 
			20'h00409: g = 8'h35;

			// Value 0x1A, 2 total pixels
			20'h00C02, 20'h00803: g = 8'h1A;

			// Value 0x26, 3 total pixels
			20'h01402, 20'h00406, 20'h00007: g = 8'h26;

			// Value 0x3B, 8 total pixels
			20'h02402, 20'h02003, 20'h01C04, 
			20'h01805, 20'h01406, 20'h01007, 
			20'h00C08, 20'h00809: g = 8'h3B;

			// Value 0x36, 2 total pixels
			20'h01C03, 20'h01405: g = 8'h36;

			// Value 0x40, 6 total pixels
			20'h02403, 20'h02004, 20'h01C05, 
			20'h01806, 20'h01407, 20'h00C09: g = 8'h40;

			// Value 0x2F, 1 total pixels
			20'h01404: g = 8'h2F;

			// Value 0x45, 5 total pixels
			20'h02404, 20'h02005, 20'h01C06, 
			20'h01807, 20'h01009: g = 8'h45;

			// Value 0x4B, 5 total pixels
			20'h02405, 20'h02006, 20'h01C07, 
			20'h01808, 20'h01409: g = 8'h4B;

			// Value 0x51, 2 total pixels
			20'h02406, 20'h01C08: g = 8'h51;

			// Value 0x50, 2 total pixels
			20'h02007, 20'h01809: g = 8'h50;

			// Value 0x56, 1 total pixels
			20'h02407: g = 8'h56;

			// Value 0x31, 1 total pixels
			20'h00408: g = 8'h31;

			// Value 0x3F, 1 total pixels
			20'h01008: g = 8'h3F;

			// Value 0x46, 1 total pixels
			20'h01408: g = 8'h46;

			// Value 0x55, 2 total pixels
			20'h02008, 20'h01C09: g = 8'h55;

			// Value 0x5B, 2 total pixels
			20'h02408, 20'h02009: g = 8'h5B;

			// Value 0x60, 1 total pixels
			20'h02409: g = 8'h60;

			default: g = 8'h00;
		endcase

		// ========================================
		//  BLUE COLOR CHANNEL - 36 TOTAL VALUE(S)
		// ========================================

		case (coordinate)
			// Value 0xC, 1 total pixels
			20'h00000: b = 8'h0C;

			// Value 0x18, 1 total pixels
			20'h00400: b = 8'h18;

			// Value 0x24, 2 total pixels
			20'h00800, 20'h00401: b = 8'h24;

			// Value 0x30, 2 total pixels
			20'h00C00, 20'h00801: b = 8'h30;

			// Value 0x3D, 5 total pixels
			20'h01000, 20'h00C01, 20'h00802, 
			20'h00403, 20'h00004: b = 8'h3D;

			// Value 0x49, 6 total pixels
			20'h01400, 20'h01001, 20'h00C02, 
			20'h00803, 20'h00404, 20'h00005: b = 8'h49;

			// Value 0x55, 4 total pixels
			20'h01800, 20'h01401, 20'h00804, 
			20'h00405: b = 8'h55;

			// Value 0x61, 3 total pixels
			20'h01C00, 20'h01402, 20'h00C04: b = 8'h61;

			// Value 0x6E, 5 total pixels
			20'h02000, 20'h01C01, 20'h01004, 
			20'h00C05, 20'h00806: b = 8'h6E;

			// Value 0x79, 1 total pixels
			20'h02400: b = 8'h79;

			// Value 0x19, 1 total pixels
			20'h00001: b = 8'h19;

			// Value 0x62, 5 total pixels
			20'h01801, 20'h01003, 20'h00805, 
			20'h00406, 20'h00007: b = 8'h62;

			// Value 0x7A, 7 total pixels
			20'h02001, 20'h01C02, 20'h01803, 
			20'h01404, 20'h00C06, 20'h00408, 
			20'h00009: b = 8'h7A;

			// Value 0x86, 6 total pixels
			20'h02401, 20'h02002, 20'h01C03, 
			20'h01804, 20'h01006, 20'h00C07: b = 8'h86;

			// Value 0x25, 1 total pixels
			20'h00002: b = 8'h25;

			// Value 0x31, 2 total pixels
			20'h00402, 20'h00003: b = 8'h31;

			// Value 0x56, 3 total pixels
			20'h01002, 20'h00C03, 20'h00006: b = 8'h56;

			// Value 0x6D, 3 total pixels
			20'h01802, 20'h01403, 20'h00008: b = 8'h6D;

			// Value 0x92, 5 total pixels
			20'h02402, 20'h02003, 20'h01C04, 
			20'h01805, 20'h01007: b = 8'h92;

			// Value 0x9E, 3 total pixels
			20'h02403, 20'h02004, 20'h01C05: b = 8'h9E;

			// Value 0xAB, 4 total pixels
			20'h02404, 20'h02005, 20'h01C06, 
			20'h01408: b = 8'hAB;

			// Value 0x7B, 2 total pixels
			20'h01005, 20'h00807: b = 8'h7B;

			// Value 0x87, 3 total pixels
			20'h01405, 20'h00808, 20'h00409: b = 8'h87;

			// Value 0xB8, 3 total pixels
			20'h02405, 20'h01808, 20'h01409: b = 8'hB8;

			// Value 0x93, 3 total pixels
			20'h01406, 20'h00C08, 20'h00809: b = 8'h93;

			// Value 0x9F, 2 total pixels
			20'h01806, 20'h00C09: b = 8'h9F;

			// Value 0xB7, 2 total pixels
			20'h02006, 20'h01C07: b = 8'hB7;

			// Value 0xC4, 3 total pixels
			20'h02406, 20'h02007, 20'h01809: b = 8'hC4;

			// Value 0x6F, 1 total pixels
			20'h00407: b = 8'h6F;

			// Value 0xA0, 2 total pixels
			20'h01407, 20'h01008: b = 8'hA0;

			// Value 0xAC, 2 total pixels
			20'h01807, 20'h01009: b = 8'hAC;

			// Value 0xCF, 1 total pixels
			20'h02407: b = 8'hCF;

			// Value 0xC3, 1 total pixels
			20'h01C08: b = 8'hC3;

			// Value 0xD0, 2 total pixels
			20'h02008, 20'h01C09: b = 8'hD0;

			// Value 0xDC, 2 total pixels
			20'h02408, 20'h02009: b = 8'hDC;

			// Value 0xE8, 1 total pixels
			20'h02409: b = 8'hE8;

			default: b = 8'h00;
		endcase

		// ==================
		//  ALPHA COLOR FLAG
		// ==================

		// Value 0x1 for entire image
		a = 1'h1;
	end
endmodule
