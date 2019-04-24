module labL;
reg [31:0] a, b;
reg [31:0] expect;
reg [2:0] op;
wire ex;
wire [31:0] z;
reg ok, flag;

yAlu mine(z, ex, a, b, op);

initial
begin
 repeat (10)
 begin
	 a = $random;
	 b = $random;
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
	//else if (op = 7)
		//expect = slt;
	
	 #1;

	 // Compare the circuit's output with "expect"
	 // and set "ok" accordingly
	if (z === expect)
		ok=1;
	else
		ok=0;

	 // Display ok and the various signals
	#1 $display("OK:%b A:%b B:%b OP:%b Z:%b", ok, a, b, op, z);
	
end
 //$finish;
end
endmodule 
