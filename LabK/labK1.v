module labK;
reg [31:0] x; // a 32-bit register
reg [32] one;
reg [34:33] two;
reg [37:35] three;

initial
begin
	$display("time = %5d, x = %b", $time, x);
	x = 32'hffff0000;


	$display("time = %5d, x = %b", $time, x);
	x = x + 2;
	$display("time = %5d, x = %b", $time, x);

	one = &x;
	two = x[1:0];
	three = {one, two};


	$display("one = %5b", one);
	$display("two = %5b", two);
	$display("three = %5b", three);

	$finish;
end

endmodule 
