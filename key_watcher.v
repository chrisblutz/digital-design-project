// This module implements key-listening logic for a single key
module key_watcher(flag, rst, watch_value, data, status);
  // Code change flag and reset signals
  input flag, rst;
  // Expected value and data signals
  input [7:0] watch_value, data;
  // Status output (1 - down, 0 - up)
  output reg status;

  // ======================
  //  FINITE STATE MACHINE
  // ======================

  // FSM state registers
  reg [1:0] s, ns;

  // FSM states
  parameter UP    = 2'd0,
            DOWN  = 2'd1,
            BREAK = 2'd2,
            ERROR = 2'd3;

  // FSM state logic
  always @ (posedge flag or negedge rst)
    if (rst == 1'b0)
      s <= UP;
    else
      s <= ns;

  // FSM next-state logic
  // Wait for expected key value, then wait for the break
  // code, which is 0xF0 followed by the key value again.
  always @ (*)
    case (s)
      UP:      if (data == watch_value)
                 ns = DOWN;
               else
                 ns = UP;
      DOWN:    if (data == 8'hF0)
                 ns = BREAK;
               else
                 ns = DOWN;
      BREAK:   if (data == watch_value)
                 ns = UP;
               else if (data == 8'hF0)
                 ns = BREAK;
               else
                 ns = DOWN;
      default: ns = ERROR;
    endcase

  // FSM output logic
  // 'status' is 1 if the state is DOWN or BREAK, and 0 otherwise
  always @ (*)
    case (s)
      DOWN, BREAK: status = 1'b1;
      default:     status = 1'b0;
    endcase
endmodule
