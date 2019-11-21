// This module implements PS/2 keyboard logic
module keyboard(ps2_clk, ps2_data, code, flag);
  // PS/2 clock and data signals
  input ps2_clk, ps2_data;
  // PS/2 output code (single byte)
  output reg [7:0] code;
  // Update flag for 'code'
  output reg flag;

  // ======================
  //  FINITE STATE MACHINE
  // ======================

  // FSM state registers
  reg [3:0] s, ns;
  reg [7:0] code_temp;

  // FSM states
  parameter START  = 4'h0,
            D0     = 4'h1,
            D1     = 4'h2,
            D2     = 4'h3,
            D3     = 4'h4,
            D4     = 4'h5,
            D5     = 4'h6,
            D6     = 4'h7,
            D7     = 4'h8,
            PARITY = 4'h9,
            STOP   = 4'hA,
            ERROR  = 4'hF;

  // FSM state logic
  always @ (negedge ps2_clk)
    s <= ns;

  // FSM next-state logic
  // On a low data signal, capture the next
  // 8 bits as the 'code' and then repeat.
  always @ (*)
    case (s)
      START:   if (ps2_data == 1'b0)
                 ns = D0;
               else
                 ns = START;
      D0:      ns = D1;
      D1:      ns = D2;
      D2:      ns = D3;
      D3:      ns = D4;
      D4:      ns = D5;
      D5:      ns = D6;
      D6:      ns = D7;
      D7:      ns = PARITY;
      PARITY:  ns = STOP;
      STOP:    ns = START;
      default: ns = ERROR;
    endcase

  // FSM 'code' construction logic
  // Reset on START, then build 0-7
  always @ (*)
    case (s)
      START: code_temp = 8'd0;
      D0:    code_temp[0] = ps2_data;
      D1:    code_temp[1] = ps2_data;
      D2:    code_temp[2] = ps2_data;
      D3:    code_temp[3] = ps2_data;
      D4:    code_temp[4] = ps2_data;
      D5:    code_temp[5] = ps2_data;
      D6:    code_temp[6] = ps2_data;
      D7:    code_temp[7] = ps2_data;
    endcase

  // FSM output logic
  // On PARITY state, set 'code'
  // On STOP, set update flag for 'key_watcher' modules
  always @ (*)
    case (s)
      PARITY:  begin
                 code = code_temp;
                 flag = 1'b0;
               end
      STOP:    flag = 1'b1;
      default: flag = 1'b0;
    endcase
endmodule
