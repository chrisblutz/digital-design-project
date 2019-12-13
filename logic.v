module logic(clk, rst, p1_state, p1_health, p1_x, p1_y, p2_state, p2_health, p2_x, p2_y, p1_input, p2_input, sprdim);
  input clk, rst;
  output reg [9:0] p1_x, p2_x;
  output [9:0] p1_y, p2_y;
  output reg [3:0] p1_state, p2_state;
  output [3:0] p1_health, p2_health;
  input [4:0] p1_input, p2_input;
  input [39:0] sprdim;

  parameter DEF_P1_X = 10'd20;
  parameter DEF_P2_X = 10'd470;

  initial
  begin
    p1_x = DEF_P1_X;
    p2_x = DEF_P2_X;
    p1_state = 4'd0;
    p2_state = 4'd0;
  end

  wire tick, tickj;
  game_loop loop(clk, rst, tick, 20'h3FFFF);
  game_loop loopj(clk, rst, tickj, 20'hDFFFF);

  y_loop p1_y_loop(clk, rst, tickj, p1_y, p1_state);
  y_loop p2_y_loop(clk, rst, tickj, p2_y, p2_state);

  attacker p1_attack(clk, rst, tick, p2_health, p2_x - p1_x, p1_state, p2_state);
  attacker p2_attack(clk, rst, tick, p1_health, p2_x - p1_x, p2_state, p1_state);

  always @ (*)
  begin
	p1_state = {p1_input[0], 1'b0, p1_input[4], 1'b0};
	p2_state = {p2_input[0], 1'b0, p2_input[4], 1'b0};
  end

  always @ (posedge clk or negedge rst)
  begin
	 if (rst == 1'b0)
	 begin
		 p1_x <= DEF_P1_X;
		 p2_x <= DEF_P2_X;
	 end
    else if (tick)
    begin
      if (p1_input[3] == 1'b0 && p1_input[1] == 1'b1 && p1_x < (10'd640 - sprdim[39:30]) && (p1_x + sprdim[39:30]) < p2_x)
        p1_x = p1_x + 1'b1;
      else if (p1_input[3] == 1'b1 && p1_input[1] == 1'b0 && p1_x > 10'b0)
        p1_x = p1_x - 1'b1;

      if (p2_input[3] == 1'b0 && p2_input[1] == 1'b1 && p2_x < (10'd640 - sprdim[19:10]))
        p2_x = p2_x + 1'b1;
      else if (p2_input[3] == 1'b1 && p2_input[1] == 1'b0 && p2_x > 10'b0 && p2_x > p1_x + sprdim[39:30])
        p2_x = p2_x - 1'b1;
    end
  end
endmodule

module attacker(clk, rst, tick, health, x_diff, state, other_state);
	input clk, rst, tick;
	output reg [3:0] health;
	input [9:0] x_diff;
	input [3:0] state, other_state;

	parameter SETUP = 3'd0,
				    IDLE = 3'd1,
				    HIT = 3'd2,
				    COOLDOWN_S = 3'd3,
				    COOLDOWN = 3'd4,
				    ERROR = 3'hF;

	reg [2:0] s, ns;
	reg [31:0] cooldown;

	always @ (posedge clk or negedge rst)
		if (rst == 1'b0)
			s <= SETUP;
		else
			s <= ns;

	always @ (*)
		case (s)
			SETUP: ns = IDLE;
			IDLE: if (state[3] == 1'b1)
						ns = HIT;
					else
						ns = IDLE;
			HIT: if (tick == 1'b1)
						ns = COOLDOWN_S;
					else
						ns = HIT;
			COOLDOWN_S: ns = COOLDOWN;
			COOLDOWN: if (cooldown == 32'd50_000_000)
							ns = IDLE;
						else
							ns = COOLDOWN;
			default: ns = ERROR;
		endcase

	always @ (posedge clk)
		case (s)
			SETUP:
				begin
					health <= 4'd8;
					cooldown <= 32'd0;
				end
			HIT:
				if (tick == 1'b1 && x_diff < 175)
				begin
					case (state[2:1])
						2'b00:
							if (other_state[2:1] == 2'b00)
								health <= health - 4'b1;
						2'b01:
							if (other_state[2:1] != 2'b10)
								health <= health - 4'b1;
						2'b10:
							if (other_state[2:1] == 2'b01)
								health <= health - 4'b1;
					endcase
				end
			COOLDOWN_S:
				cooldown <= 32'd0;
			COOLDOWN:
				cooldown <= cooldown + 32'd1;
		endcase
endmodule

module y_loop(clk, rst, tick, y, state);
	input clk, rst, tick;
	output reg [9:0] y;
	input [1:0] state;

	parameter INITIAL = 10'd220;
	initial y = INITIAL;

	wire [9:0] vel;
	reg start;
	wire done;
	velocity velocity(clk, rst, tick, vel, start, done);

	always @ (*)
	begin
		 start = (y == INITIAL) && (state[1] == 1'b1);
	end

	always @ (posedge clk or negedge rst)
		if (rst == 1'b0)
			y = INITIAL;
		else if (tick == 1'b1)
			if (done == 1'b0)
				y = y + vel;
endmodule

module velocity(clk, rst, tick, vel, start, done);
	input clk, rst, tick;
	input start;
	output reg [9:0] vel;
	output reg done;

	parameter START = 10'd15;

	parameter WAIT = 2'd0,
				    SET = 2'd1,
				    ADD = 2'd2,
				    ERROR = 2'd3;

	reg [1:0] s, ns;

	always @ (posedge clk or negedge rst)
		if (rst == 1'b0)
			s <= WAIT;
		else
			s <= ns;

	always @ (*)
		case (s)
			WAIT: if (start == 1'b1)
						ns = SET;
					else
						ns = WAIT;
			SET:  ns = ADD;
			ADD:  if (vel > START && vel[9] == 1'b0)
						ns = WAIT;
					else
						ns = ADD;
			default: ns = ERROR;
		endcase

	always @ (*)
		case (s)
			SET, ADD: done = 1'b0;
			default: done = 1'b1;
		endcase

	always @ (posedge clk)
		case (s)
			SET: vel <= 10'b0 - START;
			ADD:
				if (tick == 1'b1)
					vel <= vel + 10'b1;
			default:
				if (tick == 1'b1)
					vel <= 10'b0;
		endcase
endmodule

module game_loop(clk, rst, tick, th);
  input clk, rst;
  output reg tick;
  input [19:0] th;

  reg [19:0] counter;

  always @ (posedge clk or negedge rst)
    if (rst == 1'b0)
    begin
      counter <= 20'b0;
      tick <= 1'b0;
    end
    else if (counter != th)
    begin
      counter <= counter + 20'b1;
      tick <= 1'b0;
    end
    else
    begin
      counter <= 20'b0;
      tick <= 1'b1;
    end
endmodule
