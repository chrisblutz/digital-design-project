// This module implements player input logic
module player_input(clk, rst, ps2_clk, ps2_data, p1_input, p2_input);
  // Clock and reset signals
  input clk, rst;
  // PS/2 clock and data signals
  input ps2_clk, ps2_data;
  // Player 1 and 2 input buses
  output reg [4:0] p1_input, p2_input;

  // ======================
  //  KEYBOARD DEFINITIONS
  // ======================

  // Keyboard controller
  wire [7:0] keyboard_code;
  wire keyboard_flag, keyboard_mb;
  keyboard_press_driver keyboard_controller(clk, keyboard_flag, keyboard_mb, keyboard_code, ps2_data, ps2_clk, ~rst);

  // ====================
  //  PLAYER INPUT LOGIC
  // ====================

  // Player 1 input logic (WASD, E)
  wire w_down, a_down, s_down, d_down, e_down;
  key_watcher key_w(clk, rst, keyboard_flag, keyboard_mb, 8'h1D, keyboard_code, w_down);
  key_watcher key_a(clk, rst, keyboard_flag, keyboard_mb, 8'h1C, keyboard_code, a_down);
  key_watcher key_s(clk, rst, keyboard_flag, keyboard_mb, 8'h1B, keyboard_code, s_down);
  key_watcher key_d(clk, rst, keyboard_flag, keyboard_mb, 8'h23, keyboard_code, d_down);
  key_watcher key_e(clk, rst, keyboard_flag, keyboard_mb, 8'h24, keyboard_code, e_down);

  // Player 2 input logic (IJKL, O)
  wire i_down, j_down, k_down, l_down, o_down;
  key_watcher key_i(clk, rst, keyboard_flag, keyboard_mb, 8'h43, keyboard_code, i_down);
  key_watcher key_j(clk, rst, keyboard_flag, keyboard_mb, 8'h3B, keyboard_code, j_down);
  key_watcher key_k(clk, rst, keyboard_flag, keyboard_mb, 8'h42, keyboard_code, k_down);
  key_watcher key_l(clk, rst, keyboard_flag, keyboard_mb, 8'h4B, keyboard_code, l_down);
  key_watcher key_o(clk, rst, keyboard_flag, keyboard_mb, 8'h44, keyboard_code, o_down);

  // This block builds the 'p1_input' and 'p2_input' outputs
  always @ (*)
  begin
    p1_input = {w_down, a_down, s_down, d_down, e_down};
    p2_input = {i_down, j_down, k_down, l_down, o_down};
  end
endmodule
