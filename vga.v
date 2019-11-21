// This module implements VGA timings and sync signals
module vga(clk, strobe, rst, hsync, vsync, blank, active, xpos, ypos);
  // Clock, clock strobe, reset signals
  input clk, strobe, rst;
  // Output for sync pins on VGA connector
  output hsync, vsync;
  // Status outputs (blanking phase vs drawing phase)
  output blank, active;
  // Current pixel X coordinate
  output [9:0] xpos;
  // Current pixel Y coordinate
  output [9:0] ypos;

  // ===================
  //  TIMINGS (640x480)
  // ===================

  // Horizontal sync start
  parameter HSYNC_START = 10'd16;
  // Horizontal sync end
  parameter HSYNC_END = HSYNC_START + 10'd96;
  // Horizontal active region start
  parameter H_START = HSYNC_END + 10'd48;

  // Vertical active region end
  parameter V_END = 10'd480;
  // Vertical sync start
  parameter VSYNC_START = V_END + 10'd10;
  // Vertical sync end
  parameter VSYNC_END = VSYNC_START + 10'd2;

  // Total horizontal width
  parameter H_WIDTH = 10'd800;
  // Total vertical width
  parameter V_WIDTH = 10'd525;

  // ==========
  //  POSITION
  // ==========

  reg [9:0] hpos, vpos;

  // ===================
  //  SIGNAL GENERATION
  // ===================

  // Horizontal/vertical sync signals
  assign hsync = ~((hpos >= HSYNC_START) & (hpos < HSYNC_END));
  assign vsync = ~((vpos >= VSYNC_START) & (vpos < VSYNC_END));

  // X/Y position signals (bounded within 0-639 for X and 0-479 for Y)
  assign xpos = (hpos < H_START) ? 10'd0 : (hpos - H_START);
  assign ypos = (vpos >= V_END) ? (V_END - 10'd1) : vpos;

  // Blanking/active signals
  assign blank = ((hpos < H_START) | (vpos >= V_END));
  assign active = ~blank;

  // ====================
  //  SEQUENTIAL LOOPING
  // ====================

  always @ (posedge clk or negedge rst)
    if (rst == 1'b0)
    begin
      hpos <= 10'd0;
      vpos <= 10'd0;
    end
    else
    begin
      if (strobe == 1'b1)
      begin
        // If at end of line, reset and move down one.
        // Otherwise, go right one.
        if (hpos == H_WIDTH)
        begin
          hpos <= 10'd0;
          vpos <= vpos + 10'd1;
        end
        else
          hpos <= hpos + 10'd1;

        // If at the bottom of the screen, reset to the top
        if (vpos == V_WIDTH)
          vpos <= 10'd0;
      end
    end
endmodule
