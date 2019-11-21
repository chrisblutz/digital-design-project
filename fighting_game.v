// This is the root module, which combines the graphics, input, and game logic modules
module fighting_game(clk, rst, ps2_clk, ps2_data, vga_clock, vga_blank, vga_sync, vga_hsync, vga_vsync, vga_r, vga_g, vga_b);
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

  // For testing of VGA module
  wire [9:0] p1_x, p1_y, p2_x, p2_y;
  wire [1:0] p1_state, p2_state;
  assign p1_x = 10'd20;
  assign p1_y = 10'd20;
  assign p2_x = 10'd70;
  assign p2_y = 10'd70;
  assign p1_state = 2'd0;
  assign p2_state = 2'd0;

  // =====================
  //  GRAPHICS CONTROLLER
  // =====================

  wire [3:0] vga_state;
  wire [23:0] vga_colors;
  graphics graphics_controller(clk, rst, p1_x, p1_y, p1_state, p2_x, p2_y, p2_state, vga_clock, vga_state, vga_colors);

  // ==================
  //  INPUT CONTROLLER
  // ==================

  wire [4:0] p1_input, p2_input;
  player_input input_controller(clk, rst, ps2_clk, ps2_data, p1_input, p2_input);

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
endmodule
