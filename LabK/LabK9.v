module labK;
reg a, b, cin, flag;
reg [1:0] expect;
wire z, cout;
integer i, j, k;

xor xorOne(xorOneOut, b, a);
and andOne(andOneOut, b, a);
xor xorTwo(z, cin, xorTwoIn);
and andTwo(andTwoOut, cin, andTwoIn);
or (cout, orInUpper, orInLower);
assign xorTwoIn=xorOneOut;
assign andTwoIn = xorOneOut;
assign orInUpper=andTwoOut;
assign orInLower=andOneOut;

initial
begin
for (i = 0; i < 2; i = i + 1)
	begin
	for (j = 0; j < 2; j = j + 1)
		begin
		for (k=0; k<2; k = k+1)
			begin
			a = i; b = j; cin=k;
			expect = a+b+cin;
			#1;

			if (expect[0] === z && expect[1] ===cout)
			 	#1 $display("PASS: a=%b b=%b cin=%b z=%b, cout=%b", a, b, cin, z, cout);
			else
			 	#1 $display("FAIL: a=%b b=%b c=%b z=%b, cout=%b", a, b, cin, z, cout);
			
			end
	 	 end


	 end

	//a = 1; b = 0; c = 0;
	/*flag = $value$plusargs("a=%b", a);
	flag = $value$plusargs("b=%b", b);
	flag = $value$plusargs("c=%b", c);
	if (flag === "x")
		$display("argument missing");
		//$finish;
 	#1 $display("a=%b b=%b c=%b z=%b", a, b, c, z);
	*/
	$finish;
end

endmodule


