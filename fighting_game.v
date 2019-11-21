// This is the root module, which combines the graphics, input, and game logic modules
module fighting_game(clk, rst, vga_clock, vga_blank, vga_sync, vga_hsync, vga_vsync, vga_r, vga_g, vga_b);
  input clk, rst;
  output vga_clock;
  output reg vga_hsync, vga_vsync, vga_blank, vga_sync;
  output reg [7:0] vga_r, vga_g, vga_b;

  wire [9:0] p1_x, p1_y, p2_x, p2_y;
  wire [1:0] p1_state, p2_state;

  // For testing of VGA module
  assign p1_x = 10'd20;
  assign p1_y = 10'd20;
  assign p2_x = 10'd70;
  assign p2_y = 10'd70;
  assign p1_state = 2'd0;
  assign p2_state = 2'd0;

  wire [3:0] vga_state;
  wire [23:0] vga_colors;
  graphics graphics_controller(clk, rst, p1_x, p1_y, p1_state, p2_x, p2_y, p2_state, vga_clock, vga_state, vga_colors);

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
