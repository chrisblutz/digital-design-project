// This is the root module, which combines the graphics, input, and game logic modules
module fighting_game(clk, rst, ps2_clk, ps2_data, vga_clock, vga_blank, vga_sync, vga_hsync, vga_vsync, vga_r, vga_g, vga_b, p1_input, p2_input);
  // Clock and reset signals
  input clk, rst;
  // PS/2 clock and data signals
  input ps2_clk, ps2_data;
  // VGA clock signal
  output vga_clock;
  // VGA horizontal/vertical sync, blanking, and syncing signals
  output reg vga_hsync, vga_vsync, vga_blank, vga_sync;
  // VGA RGB buses
  output reg [7:0] vga_r, vga_g, vga_b;

  // =======================
  //  GAME LOGIC CONTROLLER
  // =======================

  wire tick;
  game_loop loop(clk, rst, tick);

  // =====================
  //  GRAPHICS CONTROLLER
  // =====================

  wire [3:0] vga_state;
  wire [23:0] vga_colors;
  wire [39:0] sprdim;
  reg [1:0] winstate;
  graphics graphics_controller(clk, rst, p1_x, p1_y, p1_state, p1_health, p2_x, p2_y, p2_state, p2_health, vga_clock, vga_state, vga_colors, sprdim, winstate);

  // ==================
  //  INPUT CONTROLLER
  // ==================

  output [4:0] p1_input, p2_input;
  player_input input_controller(clk, rst, ps2_clk, ps2_data, p1_input, p2_input);

  // ============
  //  GAME LOGIC
  // ============

  wire [9:0] p1_x, p1_y, p2_x, p2_y;
  wire [3:0] p1_state, p2_state;
  wire [3:0] p1_health, p2_health;
  logic logic(clk, rst, p1_state, p1_health, p1_x, p1_y, p2_state, p2_health, p2_x, p2_y, p1_input, p2_input, sprdim);

  // Set VGA sync signals
  // Convert 24-bit color channel to three separate 8-bit color channels
  always @ (*)
  begin
    vga_hsync = vga_state[3];
    vga_vsync = vga_state[2];
	  vga_blank = vga_state[1];
	  vga_sync = vga_state[0];
	  vga_r = vga_colors[23:16];
    vga_g = vga_colors[15:8];
    vga_b = vga_colors[7:0];
  end

  // =====================================
  //  GAME STATE MACHINE (FOR WIN STATES)
  // =====================================

  parameter GAME = 2'd0,
				    P1_WIN = 2'd1,
				    P2_WIN = 2'd2,
				    ERROR = 2'd3;
  reg [1:0] s, ns;

  always @ (posedge clk or negedge rst)
	if (rst == 1'b0)
		s <= GAME;
	else
		s <= ns;

  always @ (*)
	case (s)
		GAME:
			if (p1_health == 4'b0)
				ns = P2_WIN;
			else if (p2_health == 4'b0)
				ns = P1_WIN;
			else
				ns = GAME;
		P1_WIN: ns = P1_WIN;
		P2_WIN: ns = P2_WIN;
		default: ns = ERROR;
	endcase
  always @ (*)
	case (s)
		P1_WIN: winstate = 2'b10;
		P2_WIN: winstate = 2'b01;
		default: winstate = 2'b0;
	endcase
endmodule
