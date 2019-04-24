module labL10;
reg signed [31:0] a, b;
reg  [31:0] expect;
reg [2:0] op;
wire ex;
wire  [31:0] z;
reg ok, flag, zero, tmp;

yAlu mine(z, ex, a, b, op);

initial
begin
 repeat (10)
 begin
	 a = $random;
	 b = $random;
	tmp = $random % 2;
	if (tmp === 0)
		b=a;

	 flag = $value$plusargs("op=%d", op);

	 // The oracle: compute "expect" based on "op"
	 if (op === 0)
	 	expect = a&b;
	else if (op === 1)
		expect = a | b;
	else if (op === 2)
		expect = a+b;
	else if (op === 6)
		expect = a-b;
	else if (op === 7)
		expect = (a < b) ? 1 : 0;
	ok = (expect === z)? 1:0;
	zero = (expect === 0) ? 1:0;	

	 #1;

	 // Compare the circuit's output with "expect"
	 // and set "ok" accordingly
	if (z === expect)
		ok=1;
	else
		ok=0;

	 // Display ok and the various signals
	#1 $display("OK:%b A:%b B:%b OP:%b Z:%b zero:%b", ok, a, b, op, z, zero);
	
end
 //$finish;
end
endmodule 
