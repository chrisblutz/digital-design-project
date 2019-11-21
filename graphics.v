// This module implements a VGA controller and graphics rendering logic
module graphics(clk, rst, p1_x, p1_y, p1_state, p2_x, p2_y, p2_state, vga_state, vga_colors);
  input clk, rst;
  input [9:0] p1_x, p1_y, p2_x, p2_y;
  input [3:0] p1_state, p2_state;
  output [3:0] vga_state;
  output reg [23:0] vga_colors;

  parameter STATE_STANDING = 2'd0;
  parameter STATE_JUMP = 2'd1;

  // ============================
  //  VGA CONTROLLER DEFINITIONS
  // ============================

  // Strobe counter (for effective 25MHz signal to VGA)
  reg strobe_en, strobe_so;
  wire strobe_out;
  counter_8 strobe_counter(clk, rst, strobe_en, strobe_so, strobe_out);

  // VGA controller itself
  reg strobe;
  wire [9:0] xpos, ypos;
  vga vga_controller(clk, strobe, rst, vga_state[3], vga_state[2], vga_state[1], vga_state[0], xpos, ypos);

  // ==========================
  //  IMAGE MODULE DEFINITIONS
  // ==========================

  // Player 1 - Standing State
  wire [9:0] bg_width, bg_height;
  wire [7:0] bg_r, bg_g, bg_b;
  wire bg_a;
  image_test_4 background(xpos, ypos, bg_r, bg_g, bg_b, bg_a, bg_width, bg_height);

  // Player 1 - Standing State
  reg [9:0] p1_stand_x, p1_stand_y;
  wire [9:0] p1_stand_width, p1_stand_height;
  wire [7:0] p1_stand_r, p1_stand_g, p1_stand_b;
  wire p1_stand_a;
  image_test_1 player_1_stand(p1_stand_x, p1_stand_y, p1_stand_r, p1_stand_g, p1_stand_b, p1_stand_a, p1_stand_width, p1_stand_height);

  // Player 2 - Standing State
  reg [9:0] p2_stand_x, p2_stand_y;
  wire [9:0] p2_stand_width, p2_stand_height;
  wire [7:0] p2_stand_r, p2_stand_g, p2_stand_b;
  wire p2_stand_a;
  image_test_2 player_2_stand(p2_stand_x, p2_stand_y, p2_stand_r, p2_stand_g, p2_stand_b, p2_stand_a, p2_stand_width, p2_stand_height);

  // Pass values into image logic
  always @ (*)
  begin
    p1_stand_x = xpos - p1_x;
    p1_stand_y = ypos - p1_y;
    p2_stand_x = xpos - p2_x;
    p2_stand_y = ypos - p2_y;
  end

  // Graphics/color logic
  always @ (*)
    if (p1_state == STATE_STANDING && xpos >= p1_x && xpos < (p1_x + p1_stand_width)
        && ypos >= p1_y && ypos < (p1_y + p1_stand_height) && p1_stand_a == 1'b1)
    begin
      vga_colors[23:16] = p1_stand_r;
      vga_colors[15:8] = p1_stand_g;
      vga_colors[7:0] = p1_stand_b;
    end
    else if (p2_state == STATE_STANDING && xpos >= p2_x && xpos < (p2_x + p2_stand_width)
             && ypos >= p2_y && ypos < (p2_y + p2_stand_height) && p2_stand_a == 1'b1)
    begin
      vga_colors[23:16] = p2_stand_r;
      vga_colors[15:8] = p2_stand_g;
      vga_colors[7:0] = p2_stand_b;
    end
    else
    begin
      vga_colors[23:16] = bg_r;
      vga_colors[15:8] = bg_g;
      vga_colors[7:0] = bg_b;
    end

  // Strobe logic (50MHz core clock, strobe every
  // two cycles for 25MHz effective VGA clock)
  always @ (*)
    if (strobe_out == 8'd1)
    begin
      strobe_en = 1'b0;
      strobe_so = 1'b1;
      strobe = 1'b1;
    end
    else
    begin
      strobe_en = 1'b1;
      strobe_so = 1'b0;
      strobe = 1'b0;
    end
endmodule
