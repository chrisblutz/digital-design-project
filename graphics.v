// This module implements a VGA controller and graphics rendering logic
module graphics(clk, rst, p1_x, p1_y, p1_state, p1_health, p2_x, p2_y, p2_state, p2_health, vga_clock, vga_state, vga_colors, sprdim, winstate);
  input clk, rst;
  input [9:0] p1_x, p1_y, p2_x, p2_y;
  input [3:0] p1_state, p2_state;
  input [3:0] p1_health, p2_health;
  output vga_clock;
  output [3:0] vga_state;
  output reg [23:0] vga_colors;
  output [39:0] sprdim;
  input [1:0] winstate;

  parameter STATE_STANDING = 4'b0000;
  parameter STATE_STANDING_ATTACK = 4'b1000;
  parameter STATE_JUMPING = 4'b0010;
  parameter STATE_JUMPING_ATTACK = 4'b1010;

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

  parameter P1_STAND_WIDTH = 125;
  parameter P1_STAND_HEIGHT = 10'd180;
  parameter P1_STAND_ATTACK_WIDTH = 10'd115;
  parameter P1_STAND_ATTACK_HEIGHT = 10'd180;
  parameter P1_JUMP_ATTACK_WIDTH = 10'd187;
  parameter P1_JUMP_ATTACK_HEIGHT = 10'd140;
  reg [9:0] p1_sprite_x, p1_sprite_y;
  reg [15:0] p1_sprite_coordinate;
  wire [20:0] p1_sprite_color;
  p1_sprites p1_sprites(p1_sprite_coordinate, clk, p1_sprite_color);

  parameter P2_STAND_WIDTH = 10'd173;
  parameter P2_STAND_HEIGHT = 10'd180;
  parameter P2_STAND_ATTACK_WIDTH = 10'd237;
  parameter P2_STAND_ATTACK_HEIGHT = 10'd180;
  parameter P2_JUMP_ATTACK_WIDTH = 10'd175;
  parameter P2_JUMP_ATTACK_HEIGHT = 10'd231;
  reg [9:0] p2_sprite_x, p2_sprite_y;
  reg [15:0] p2_sprite_coordinate;
  wire [20:0] p2_sprite_color;
  p2_sprites p2_sprites(p2_sprite_coordinate, clk, p2_sprite_color);

  always @ (*)
  begin
		p1_sprite_x = xpos - p1_x;
		p1_sprite_y = ypos - p1_y;
		p2_sprite_x = xpos - p2_x;
		p2_sprite_y = ypos - p2_y;
  end

  assign sprdim = {P1_STAND_WIDTH, P1_STAND_HEIGHT, P2_STAND_WIDTH, P2_STAND_HEIGHT};

  // Pass values into image logic
  always @ (*)
  begin
    p1_sprite_coordinate = {p1_sprite_x[7:0], p1_sprite_y[7:0]};
    p2_sprite_coordinate = {p2_sprite_x[7:0], p2_sprite_y[7:0]};
  end

  // Graphics/color logic
  always @ (*)
  begin
	 if (winstate != 2'b0)
		 if (winstate == 2'b10 && ((xpos > (10'd320 - 10'd15) && xpos <= (10'd320 + 10'd15) && ypos > (10'd240 - 10'd60) && ypos <= (10'd240 + 10'd60))
				|| (xpos > (10'd320 - 10'd30) && xpos <= (10'd320) && ypos > (10'd240 - 10'd60) && ypos <= (10'd240 - 10'd30))
				|| (xpos > (10'd320 - 10'd30) && xpos <= (10'd320 + 10'd30) && ypos > (10'd240 + 10'd30) && ypos <= (10'd240 + 10'd60))))
				vga_colors = 24'hFFFFFF;
		 else if (winstate == 2'b01 && ((xpos > (10'd320 - 10'd30) && xpos <= (10'd320 + 10'd30) && ypos > (10'd240 - 10'd60) && ypos <= (10'd240 - 10'd30))
				|| (xpos > (10'd320 - 10'd30) && xpos <= (10'd320 + 10'd30) && ypos > (10'd240 + 10'd30) && ypos <= (10'd240 + 10'd60))
				|| (xpos > (10'd320) && xpos <= (10'd320 + 10'd30) && ypos > (10'd240 - 10'd60) && ypos <= (10'd240))
				|| (xpos > (10'd320 - 10'd30) && xpos <= (10'd320) && ypos > (10'd240) && ypos <= (10'd240 + 10'd60))
				|| (xpos > (10'd320 - 10'd15) && xpos <= (10'd320 + 10'd15) && ypos > (10'd240 - 10'd15) && ypos <= (10'd240 + 10'd15))))
				vga_colors = 24'hFFFFFF;
		 else if ((xpos > (10'd320 - 10'd85) && xpos <= (10'd320 - 10'd77) && ypos > (10'd340) && ypos <= (10'd340 + 10'd53))
				|| (xpos > (10'd320 - 10'd76) && xpos <= (10'd320 - 10'd64) && ypos > (10'd340 + 10'd54) && ypos <= (10'd340 + 10'd60))
				|| (xpos > (10'd320 - 10'd63) && xpos <= (10'd320 - 10'd55) && ypos > (10'd340 + 10'd8) && ypos <= (10'd340 + 53))
				|| (xpos > (10'd320 - 10'd54) && xpos <= (10'd320 - 10'd42) && ypos > (10'd340 + 10'd54) && ypos <= (10'd340 + 10'd60))
				|| (xpos > (10'd320 - 10'd41) && xpos <= (10'd320 - 10'd36) && ypos > (10'd340) && ypos <= (10'd340 + 10'd53)))
				vga_colors = 24'hFFFFFF;
		 else if ((xpos > (10'd320 - 10'd28) && xpos <= (10'd320 - 10'd20) && ypos > (10'd340) && ypos <= (10'd340 + 10'd60)))
				vga_colors = 24'hFFFFFF;
		 else if ((xpos > (10'd320 - 10'd14) && xpos <= (10'd320 - 10'd6) && ypos > (10'd340) && ypos <= (10'd340 + 10'd60))
				|| (xpos > (10'd320 - 10'd5) && xpos <= (10'd320 + 10'd3) && ypos > (10'd340) && ypos <= (10'd340 + 10'd8))
				|| (xpos > (10'd320 - 10'd1) && xpos <= (10'd320 + 10'd7) && ypos > (10'd340 + 10'd8) && ypos <= (10'd340 + 10'd16))
				|| (xpos > (10'd320 + 10'd3) && xpos <= (10'd320 + 10'd11) && ypos > (10'd340 + 10'd16) && ypos <= (10'd340 + 10'd24))
				|| (xpos > (10'd320 + 10'd7) && xpos <= (10'd320 + 10'd15) && ypos > (10'd340 + 10'd24) && ypos <= (10'd340 + 10'd32))
				|| (xpos > (10'd320 + 10'd11) && xpos <= (10'd320 + 10'd19) && ypos > (10'd340 + 10'd32) && ypos <= (10'd340 + 10'd40))
				|| (xpos > (10'd320 + 10'd15) && xpos <= (10'd320 + 10'd23) && ypos > (10'd340 + 10'd40) && ypos <= (10'd340 + 10'd48))
				|| (xpos > (10'd320 + 10'd19) && xpos <= (10'd320 + 10'd27) && ypos > (10'd340 + 10'd48) && ypos <= (10'd340 + 10'd56))
				|| (xpos > (10'd320 + 10'd23) && xpos <= (10'd320 + 10'd31) && ypos > (10'd340) && ypos <= (10'd340 + 10'd60)))
				vga_colors = 24'hFFFFFF;
		 else if ((xpos > (10'd320 + 10'd39) && xpos <= (10'd320 + 10'd47) && ypos > (10'd340 + 10'd8) && ypos <= (10'd340 + 10'd23))
				|| (xpos > (10'd320 + 10'd47) && xpos <= (10'd320 + 10'd74) && ypos > (10'd340) && ypos <= (10'd340 + 10'd8))
				|| (xpos > (10'd320 + 10'd47) && xpos <= (10'd320 + 10'd74) && ypos > (10'd340 + 10'd24) && ypos <= (10'd340 + 10'd32))
				|| (xpos > (10'd320 + 10'd47) && xpos <= (10'd320 + 10'd74) && ypos > (10'd340 + 10'd54) && ypos <= (10'd340 + 10'd60))
				|| (xpos > (10'd320 + 10'd74) && xpos <= (10'd320 + 10'd82) && ypos > (10'd340 + 10'd32) && ypos <= (10'd340 + 10'd54)))
				vga_colors = 24'hFFFFFF;
		 else
				vga_colors = 24'h0;
	 else
		if (p1_health > 0 && (xpos >= 10 && xpos < 40) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p1_health > 1 && (xpos >= 40 && xpos < 70) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p1_health > 2 && (xpos >= 70 && xpos < 100) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p1_health > 3 && (xpos >= 100 && xpos < 130) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p1_health > 4 && (xpos >= 130 && xpos < 160) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p1_health > 5 && (xpos >= 160 && xpos < 190) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p1_health > 6 && (xpos >= 190 && xpos < 210) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p1_health > 7 && (xpos >= 210 && xpos < 240) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p2_health > 0 && (xpos >= 600 && xpos < 630) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p2_health > 1 && (xpos >= 570 && xpos < 600) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p2_health > 2 && (xpos >= 540 && xpos < 570) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p2_health > 3 && (xpos >= 510 && xpos < 540) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p2_health > 4 && (xpos >= 480 && xpos < 510) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p2_health > 5 && (xpos >= 450 && xpos < 480) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p2_health > 6 && (xpos >= 420 && xpos < 450) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if (p2_health > 7 && (xpos >= 390 && xpos < 420) && (ypos >= 10 && ypos < 30))
				vga_colors = { 8'hFC, 8'hC2, 8'h03 };
			 else if ((p1_state == STATE_STANDING || p1_state == STATE_JUMPING) && xpos >= p1_x && xpos < (p1_x + P1_STAND_WIDTH)
				  && ypos >= p1_y && ypos < (p1_y + P1_STAND_HEIGHT) && p1_sprite_color[14] != 1'b0)
				vga_colors = {p1_sprite_color[20:19], {6{p1_sprite_color[19]}},
									    p1_sprite_color[18:17], {6{p1_sprite_color[17]}},
									    p1_sprite_color[16:15], {6{p1_sprite_color[15]}}};
			 else if (p1_state == STATE_STANDING_ATTACK && xpos >= p1_x && xpos < (p1_x + P1_STAND_ATTACK_WIDTH)
				  && ypos >= p1_y && ypos < (p1_y + P1_STAND_ATTACK_HEIGHT) && p1_sprite_color[7] != 1'b0)
				vga_colors = {p1_sprite_color[13:12], {6{p1_sprite_color[12]}},
                      p1_sprite_color[11:10], {6{p1_sprite_color[10]}},
									    p1_sprite_color[9:8], {6{p1_sprite_color[8]}}};
			 else if (p1_state == STATE_JUMPING_ATTACK && xpos >= p1_x && xpos < (p1_x + P1_JUMP_ATTACK_WIDTH)
				  && ypos >= p1_y && ypos < (p1_y + P1_JUMP_ATTACK_HEIGHT) && p1_sprite_color[0] != 1'b0)
				vga_colors = {p1_sprite_color[6:5], {6{p1_sprite_color[5]}},
									    p1_sprite_color[4:3], {6{p1_sprite_color[3]}},
									    p1_sprite_color[2:1], {6{p1_sprite_color[1]}}};
			 else if ((p2_state == STATE_STANDING || p2_state == STATE_JUMPING) && xpos >= p2_x && xpos < (p2_x + P2_STAND_WIDTH)
				  && ypos >= p2_y && ypos < (p2_y + P2_STAND_HEIGHT) && p2_sprite_color[14] != 1'b0)
				vga_colors = {p2_sprite_color[20:19], {6{p2_sprite_color[19]}},
									    p2_sprite_color[18:17], {6{p2_sprite_color[17]}},
									    p2_sprite_color[16:15], {6{p2_sprite_color[15]}}};
			 else if (p2_state == STATE_STANDING_ATTACK && xpos >= p2_x && xpos < (p2_x + P2_STAND_ATTACK_WIDTH)
				  && ypos >= p2_y && ypos < (p2_y + P2_STAND_ATTACK_HEIGHT) && p2_sprite_color[7] != 1'b0)
				vga_colors = {p2_sprite_color[13:12], {6{p2_sprite_color[12]}},
									    p2_sprite_color[11:10], {6{p2_sprite_color[10]}},
									    p2_sprite_color[9:8], {6{p2_sprite_color[8]}}};
			 else if (p2_state == STATE_JUMPING_ATTACK && xpos >= p2_x && xpos < (p2_x + P1_JUMP_ATTACK_WIDTH)
				  && ypos >= p2_y && ypos < (p2_y + P2_JUMP_ATTACK_HEIGHT) && p2_sprite_color[0] != 1'b0)
				vga_colors = {p2_sprite_color[6:5], {6{p2_sprite_color[5]}},
									    p2_sprite_color[4:3], {6{p2_sprite_color[3]}},
									    p2_sprite_color[2:1], {6{p2_sprite_color[1]}}};
			 else if(ypos >= (10'd220 + P1_STAND_HEIGHT) - 8)
				vga_colors = 24'h4F2E00;
			 else
				vga_colors = 24'hC2FEFF;
  end


  // Strobe logic (strobe every two ticks)
  reg [15:0] count;
  always @ (posedge clk or negedge rst)
	if (rst == 1'b0)
		count <= 16'd0;
	else
		{strobe, count} <= count + 16'h8000;

  // Tie the VGA clock signal to the strobe
  assign vga_clock = strobe;
endmodule
