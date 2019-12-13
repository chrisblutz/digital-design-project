module key_watcher(clk, rst, valid, mb, watch, code, out);
	input clk, rst;
	input [7:0] watch, code;
	input mb, valid;
	output reg out;

	initial out = 1'b0;

	always @ (posedge clk)
		if (valid && mb && code == watch)
			out <= 1'b1;
		else if (valid && !mb && code == watch)
			out <= 1'b0;
endmodule
