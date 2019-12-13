// This module implements an 8-bit counter
module counter_8(clk, rst, en, so, out);
  input clk, rst;
  input en, so;
  output reg [7:0] out;

  always @ (posedge clk or negedge rst)
    if (rst == 1'b0)
      out <= 8'd0;
    else if (en == 1'b1)
      out <= out + 8'd1;
    else if (so == 1'b1)
      out <= 8'd0;
endmodule
